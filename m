From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Tue, 6 Dec 2016 14:00:50 +0800
Message-ID: <CANeU7Qn4ATFNP=tsUXPtxk2CuTGcp-PyLGT6UW8zxYfxiODaBg@mail.gmail.com>
References: <87lh75jh9l.fsf@gmail.com> <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
 <20161123040528.GA74337@macpro.local> <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
 <87a8cqlhcy.fsf@gmail.com> <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
 <87polm5eqq.fsf@gmail.com> <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
 <87lgwa59nm.fsf@gmail.com> <CANeU7Qm21LCu2GgdTLbcDERBbgdYWoX_wp4DTKaFdi=G1ZcqAQ@mail.gmail.com>
 <87h96x5hzv.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35580 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbcLFGBM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 6 Dec 2016 01:01:12 -0500
Received: by mail-io0-f195.google.com with SMTP id h133so19273560ioe.2
        for <linux-sparse@vger.kernel.org>; Mon, 05 Dec 2016 22:00:51 -0800 (PST)
In-Reply-To: <87h96x5hzv.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

Hi Nicolai,

I finally finish up my more serious review of your patch series.
So this email is going to be long. Sorry for the long delay.

Over all pretty good.

One thing has been puzzling me when I first read the patches,
is about how the bits are used. Why there are some many bits
need to be set when the expression is a very simple integer constant.
Now I understand, the series basically treat each condition
(is it a int constant, is it a constant expression) as a bit. So when
you modify the int constant, the bits for other personality
(int expression, arithmetic expression) has to be set as well.
All this is for the optimization when you merge the binary operation
when left and right expression.

I still see the multiple personality for constant expression (it can be
both int constant and int expression etc) is a bit more complicate
than it needs to, at least I now understand why you did it that way.

The detail review follows:

1)  name of constexpr_flags is too long.

 struct expression {
        enum expression_type type:8;
-       unsigned flags:8;
+       unsigned constexpr_flags:8;

I actually thing that the more generic name "flags" are fine
without changing. If we need to add other flags not related to
constant, we will need to rename it all over again.

If you still feel strongly about the flags being too generic.
I suggest some thing shorter like "constant". The member
is in an expression struct, so the "expr" is not needed.

2) CONSTEXPR_FLAG_XXX are being too long.
+       CONSTEXPR_FLAG_INT_CONST = (1 << 0),
+       CONSTEXPR_FLAG_FP_CONST = (1 << 1),
+       CONSTEXPR_FLAG_ENUM_CONST = (1 << 2),
+       CONSTEXPR_FLAG_CHAR_CONST = (1 << 3),
+
+       /*
+        * A constant expression in the sense of [6.6]:
+        * - integer constant expression [6.6(6)]
+        * - arithmetic constant expression [6.6(8)]
+        * - address constant [6.6(9)]
+        */
+       CONSTEXPR_FLAG_INT_CONST_EXPR = (1 << 4),
+       CONSTEXPR_FLAG_ARITH_CONST_EXPR = (1 << 5),
+       CONSTEXPR_FLAG_ADDR_CONST = (1 << 6),

This is really nick pick. Look at this defines,  they all contain
"CONSTEXPR_FLAG" and "_CONST", The only different is
a very short word "INT", "FP", "CHAR" etc. The signal ratio
is pretty low.

I found it harder to read compare to the original enum value:

-enum {
-       Int_const_expr = 1,
-       Float_literal = 2,
-}; /* for expr->flags */


3) I think this is a typo, in the 01/21 patch
+/*
+ * Remove any "Constant" [6.4.4] flag, but retain the "constant
+ * expression" [6.6] flags.
+ */
+#define CONSTEXPR_FLAG_DECAY_CONSTS_MASK                               \
+       (CONSTEXPR_FLAG_INT_CONST | CONSTEXPR_FLAG_INT_CONST |          \
+               CONSTEXPR_FLAG_FP_CONST | CONSTEXPR_FLAG_CHAR_CONST)

Did any one spot there are *two* duplicate CONSTEXPR_FLAG_INT_CONST there?

This is the point I try to make in 2), the very verbose long name actually hurt
the readability. The eye need to move between long capital words try to extract
the key difference. The key difference here is "INT" vs "FP" vs "CHAR".

I think if it was written as:

              (Int_literal | Int_literal |
                   Float_literal | Char_literal)

 The bug maybe would be easier to spot?


4) in patch 12:
 static struct symbol *evaluate_ptr_add(struct expression *expr,
struct symbol *itype)
 {
        struct expression *index = expr->right;
        struct symbol *ctype, *base;
        int multiply;

        classify_type(degenerate(expr->left), &ctype);
        base = examine_pointer_target(ctype);

+       /*
+        * An address constant +/- an integer constant expression
+        * yields an address constant again [6.6(7)].
+        */
+       if ((expr->left->constexpr_flags & CONSTEXPR_FLAG_ADDR_CONST) &&
+               (expr->right->constexpr_flags & CONSTEXPR_FLAG_INT_CONST_EXPR))
+               expr->constexpr_flags = CONSTEXPR_FLAG_ADDR_CONST;
+
The constant flags should be set regardless. Otherwise it is not consistent
with the rest of the code.

Also I found that code hard to read. Because the expression is really long, it
break into a few lines.

I suggest move this code into a function:
           expr->const = evaluate_const_ptr_add(expr->right, expr->left);

Then inside  evaluate_const_ptr_add() you can use early return to make
the code does not need to use that long expression.

int evaluate_const_ptr_add(struct expression *left, struct expression *right)
{
          if (!(left->constant & Addr_const))
                   return 0;
          if (!(right->constant & Int_const_expr))
                   return 0;
          return Addr_const;
}

The same pattern can apply to a lot of the constant expression evaluation.
A lot of them share the same function e.g. convert into constant int expression.


5) in Patch 1,4,8, a few patch combine into this result.
 static struct symbol *evaluate_logical(struct expression *expr)
 {
        if (!evaluate_conditional(expr->left, 0))
                return NULL;
        if (!evaluate_conditional(expr->right, 0))
                return NULL;

        /* the result is int [6.5.13(3), 6.5.14(3)] */
        expr->ctype = &int_ctype;
-       if (expr->flags) {
-               if (!(expr->left->flags & expr->right->flags & Int_const_expr))
-                       expr->flags = 0;
-       }
+       expr->constexpr_flags = expr->left->constexpr_flags &
+               expr->right->constexpr_flags &
+               ~CONSTEXPR_FLAG_DECAY_CONSTS_MASK &
+               ~CONSTEXPR_FLAG_ADDR_CONST;
        return &int_ctype;
 }

Again, with this complaxity and lone line, I suggest move into a function
evaluate_const_int_expr(expr->left, expr->right)

Also this evaluate_const_int_expr() will be share by many similar caller.
e.g. evaluate_compare etc.

6) In evaluate_conditional_expression cover by patch 3,8,11,18
+       /*
+        * A conditional operator yields a particular constant
+        * expression type only if all of its three subexpressions are
+        * of that type [6.6(6), 6.6(8)].
+        * As an extension, relax this restriction by allowing any
+        * constant expression type for the condition expression.
+        *
+        * A conditional operator never yields an address constant
+        * [6.6(9)].
+        * However, as an extension, if the condition is any constant
+        * expression, and the true and false expressions are both
+        * address constants, mark the result as an address constant.
+        */
+       if (expr->conditional->constexpr_flags &
+               (CONSTEXPR_FLAG_ARITH_CONST_EXPR | CONSTEXPR_FLAG_ADDR_CONST))
+               expr->constexpr_flags = (*true)->constexpr_flags &
+                       expr->cond_false->constexpr_flags &
+                       ~CONSTEXPR_FLAG_DECAY_CONSTS_MASK;

This is another place hard to read. I also suggest always set the
expr->constant flag. Also us3 a small function to wrap the complicate condition.
The long expression really hurts here.

Chris
