From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Wed, 23 Nov 2016 19:33:01 +0100
Message-ID: <87lgwa59nm.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
        <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
        <20161123040528.GA74337@macpro.local>
        <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
        <87a8cqlhcy.fsf@gmail.com>
        <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
        <87polm5eqq.fsf@gmail.com>
        <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35790 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755459AbcKWSdF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 13:33:05 -0500
Received: by mail-wm0-f66.google.com with SMTP id a20so2812002wme.2
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 10:33:03 -0800 (PST)
In-Reply-To: <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
        (Christopher Li's message of "Thu, 24 Nov 2016 01:38:45 +0800")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

Christopher Li <sparse@chrisli.org> writes:

> On Thu, Nov 24, 2016 at 12:43 AM, Nicolai Stange <nicstange@gmail.com> wrote:
>>
>> I don't think that this would qualify as a constant expression of any
>> type.
>>
>>> How about (void*)(0 + 'a') and (void*)0 + 'a', are they address constant
>>> or not?
>>
>> Strictly speaking, neither of them is.
>>
>> Despite of this, we would (hopefully) mark the second case as an address
>> constant though.
>>
>> Reason: this series flags address constants as such because they may be
>> used as a "constant expression in an initializer", i.e. as initializers
>> for static storage duration variables.
>
> That is good info. Thanks for the clarify.
>
> BTW, gcc does not seem to complain about const integer issue on,
>          [(int)(float)0] = 0,    // KO
>          [(int)(void*)0] = 0,    // KO
> gcc seems does what make snese rather than stick to the book.

To give you some background: when I started this, my initial intent was
to move the constness inspection from the expression building stage in
expression.c to their evaluation in evaluation.c. This would be needed
in order to decide whether the outcome of __builtin_choose_expr() is a
constant expression, for example.

While doing this, I recognized that sparse's current constant expression
tagging scheme was quite limited and I had to touch everything related
to it anyway. So I asked on this list on whether it would be a good
thing to let sparse be more strict than gcc in this regard and the
feedback was that it certainly would (at user option).


> In your patch:

Can you tell which one? If not, would resending this series help?

> static struct token *builtin_types_compatible_p_expr(struct token *token,
>                                                      struct expression **tree)
>  {
>         struct expression *expr = alloc_expression(
>                 token->pos, EXPR_COMPARE);
> -       expr->flags = Int_const_expr;
>         expr->op = SPECIAL_EQUAL;
>         token = token->next;
>         if (!match_op(token, '('))
>
> I think __builtin_xxx function expand similar to the processor
> macro. In that sense, we might want to the consider this expression
> as integer constant express as if the __builtin_xxx call is either 0 or 1.
>
> Again, gcc does not complain about:
>        [__builtin_types_compatible_p(typeof(1), int)] = 0,   // KO
>
> This makes sense, but not according the "strict" rules.

After [21/21] ("evaluation: treat comparsions between types as integer
constexpr"), sparse should treat __builtin_types_compatible_p() as an
integer constant expression, just as gcc does.

After all, the standard doesn't say anything about
__builtin_types_compatible_p()...

So, if the above testcase really fails after this series, it's either a
bug or an artifact of having this typeof() in there (or both), I
think.


>>>
>>> Basically, there are six bits as basic element. One bit per element.
>>> Integer constant, enum constant, char constant, float constant,
>>> address constant,
>>> arithmetic constant.
>>
>> + integer constant *expression*
>>
>> Take 0 + 0, for example: this is not an integer constant, but an integer
>> constant *expression* (and an arithmetic constant expression as well).
>
> Ah, I see. I change my plan according this. The six basic element define as:
> Integer constant, enum constant, char constant, float constant,
> address constant, composite op.
>
> The composite op bit get set after binary operation or uniop.
> The flags can have more than one bit set for the expression.
>
> Integer constant expression can be tested as:
>
> !(flags & ( Addr | Float) ) && flag
>
> Arithmetic constant expression can be tested as:
>
> !(flags & Addr) ) && flag
>
> Do you see any problem with this internal representation?

(int)0.0 is an integer constant expression.

In your scheme, it would have "composite op" and "float" set?
The integer constant expression test you proposed above would
fail in this case.


Thanks,

Nicolai
