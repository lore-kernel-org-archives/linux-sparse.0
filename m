From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Thu, 24 Nov 2016 01:38:45 +0800
Message-ID: <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
References: <87lh75jh9l.fsf@gmail.com> <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
 <20161123040528.GA74337@macpro.local> <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
 <87a8cqlhcy.fsf@gmail.com> <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
 <87polm5eqq.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:34377 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755398AbcKWRir (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 12:38:47 -0500
Received: by mail-io0-f195.google.com with SMTP id r94so2399510ioe.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 09:38:47 -0800 (PST)
In-Reply-To: <87polm5eqq.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Thu, Nov 24, 2016 at 12:43 AM, Nicolai Stange <nicstange@gmail.com> wrote:
>
> I don't think that this would qualify as a constant expression of any
> type.
>
>> How about (void*)(0 + 'a') and (void*)0 + 'a', are they address constant
>> or not?
>
> Strictly speaking, neither of them is.
>
> Despite of this, we would (hopefully) mark the second case as an address
> constant though.
>
> Reason: this series flags address constants as such because they may be
> used as a "constant expression in an initializer", i.e. as initializers
> for static storage duration variables.

That is good info. Thanks for the clarify.

BTW, gcc does not seem to complain about const integer issue on,
         [(int)(float)0] = 0,    // KO
         [(int)(void*)0] = 0,    // KO
gcc seems does what make snese rather than stick to the book.


In your patch:

static struct token *builtin_types_compatible_p_expr(struct token *token,
                                                     struct expression **tree)
 {
        struct expression *expr = alloc_expression(
                token->pos, EXPR_COMPARE);
-       expr->flags = Int_const_expr;
        expr->op = SPECIAL_EQUAL;
        token = token->next;
        if (!match_op(token, '('))

I think __builtin_xxx function expand similar to the processor
macro. In that sense, we might want to the consider this expression
as integer constant express as if the __builtin_xxx call is either 0 or 1.

Again, gcc does not complain about:
       [__builtin_types_compatible_p(typeof(1), int)] = 0,   // KO

This makes sense, but not according the "strict" rules.

>>
>> Basically, there are six bits as basic element. One bit per element.
>> Integer constant, enum constant, char constant, float constant,
>> address constant,
>> arithmetic constant.
>
> + integer constant *expression*
>
> Take 0 + 0, for example: this is not an integer constant, but an integer
> constant *expression* (and an arithmetic constant expression as well).

Ah, I see. I change my plan according this. The six basic element define as:
Integer constant, enum constant, char constant, float constant,
address constant, composite op.

The composite op bit get set after binary operation or uniop.
The flags can have more than one bit set for the expression.

Integer constant expression can be tested as:

!(flags & ( Addr | Float) ) && flag

Arithmetic constant expression can be tested as:

!(flags & Addr) ) && flag

Do you see any problem with this internal representation?

Chris
