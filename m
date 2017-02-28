From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Tue, 28 Feb 2017 16:09:58 +0100
Message-ID: <20170228150956.moyfiyd5zf7tbeze@macbook.local>
References: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:37595 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752547AbdB1PKM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Feb 2017 10:10:12 -0500
Received: by mail-wm0-f52.google.com with SMTP id v77so14115139wmv.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Feb 2017 07:10:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxdav6y9uRC9mavNkVZS173k0ftw-8FpPanKLsoF-ws0Sw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: linux-sparse@vger.kernel.org

On Tue, Feb 28, 2017 at 06:20:43AM +0000, Dibyendu Majumdar wrote:
> I am trying to debug a failure in sparse-llvm when compiling following:
> 
> struct mytype {
>  int *foo;
> };
> extern void init_mytype(struct mytype *mt);
> void init_mytype(struct mytype *mt) {
>  mt->foo = (void *)0;
> }
> 
> I am new to sparse so do not fully understand how it works, hence my
> explanation below could be wrong.
> 
> As far as I understand, an integer constant 0 is converted to a value
> pseudo in linearize_expression(). As a value pseudo only has a value
> and no type the LLVM IR generator does not have enough information to
> ensure that the correct type is used when it encounters the value
> pseudo.

In some cases, yes.
It would be useful to list and somehow detail those cases.
Even better would be to have test cases.

> While trying to work out how to resolve this issue, I also found
> following potential additional issues.
> 
> When handling (void*) 0, in the function evaluate_cast() in
> evaluate.c, the expression type is changed to NULL type. However this
> changed type is not returned.
> 
>  if (!(t1->ctype.modifiers & MOD_PTRINHERIT) && class1 == TYPE_PTR &&
>      !as1 && (target->flags & Int_const_expr)) {
>   if (t1->ctype.base_type == &C->S->void_ctype) {
>    if (is_zero_constant(C, target)) {
>     /* NULL */
>     expr->type = EXPR_VALUE;
>     expr->ctype = &C->S->null_ctype;
>     expr->value = 0;
>     return ctype;
>    }
>   }
>  }
> 
> Should this be instead:
> 
>  if (!(t1->ctype.modifiers & MOD_PTRINHERIT) && class1 == TYPE_PTR &&
>      !as1 && (target->flags & Int_const_expr)) {
>   if (t1->ctype.base_type == &C->S->void_ctype) {
>    if (is_zero_constant(C, target)) {
>     /* NULL */
>     expr->type = EXPR_VALUE;
>     expr->ctype = &C->S->null_ctype;
>     expr->value = 0;
>     return expr->ctype;
>    }
>   }
>  }

Most probably, yes.
Do you have something that can show it make a difference?

> A related question is around the expansion of cast expressions in
> cast_value() function in expand.c. The code snippet I was looking at
> is this:
> 
>  if (old_size == new_size) {
>   expr->value = old->value;
>   return;
>  }
> 
> Should this be changed to:
> 
>  if (old_size == new_size) {
>   expr->value = old->value;
>   expr->ctype = oldtype;
>   return;
>  }

I don't think so.
At first sight, it look as if doing so is equivalent to dropping the cast
completly (for what concerns the types).

> The two changes above appear to help ensure that a VALUE expression's
> type shows correctly that the expression is a NULL pointer.

I don't think so. There is a difference between 'a null pointer' and
'the NULL pointer'. 'NULL' (at least how we want it here) is of type
'void *' while a 'null pointer' can be any pointer type.

> Assuming
> this is correct then in value_pseudo() function in lineariez.c, it
> would be possible to distinguish between integer constants and a NULL
> pointer.

This shouldn't be needed. The linearization should produce a cast of
the typeless value '0' to a pointer type/a void pointer.

But it's also very possible that this cast is later optimized away ...

> My question is this: should a value pseudo have type information also?

I don't think so.

> This seems like a necessity for LLVM backend.

There is indeed some problems regarding this, we looked a bit at this
some weeks ago. However I firmly believe that the information about
the type belong to the operations and not the values. But this,
indeed, leave unanswered the question "what is the type of a pseudo
which is not the result of an operation, the constant values?".

There is also several issues regarding type in casts. One of them is
solved and is in master now: (9cc8f6624 "fix cast's target type info").
I'm not sure it will help you but it's related to losing some type
info in casts.

I think that the best you can do for us to be able to help you is to create
test case showing concretely the issues you have.


Luc
