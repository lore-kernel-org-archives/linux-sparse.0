From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Wed, 23 Nov 2016 17:43:09 +0100
Message-ID: <87polm5eqq.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
        <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
        <20161123040528.GA74337@macpro.local>
        <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
        <87a8cqlhcy.fsf@gmail.com>
        <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34431 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935087AbcKWQnM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 11:43:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id g23so2521210wme.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 08:43:11 -0800 (PST)
In-Reply-To: <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
        (Christopher Li's message of "Wed, 23 Nov 2016 23:36:02 +0800")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

Christopher Li <sparse@chrisli.org> writes:

> On Wed, Nov 23, 2016 at 4:39 PM, Nicolai Stange <nicstange@gmail.com> wrote:
>> (void*)'a' doesn't qualify as an address constant, (void *)0 does.
>>
>> So while we certainly won't need to distinguish enum and char constants
>> (literals), we have to do so for integer constants (literals) vs
>> enum/char constants (literals).
>
> Good. That is exactly the corner case condition I am looking for.
> (void*)'a' is not an address constant, is it still consider constant expression?

I don't think that this would qualify as a constant expression of any
type.

> How about (void*)(0 + 'a') and (void*)0 + 'a', are they address constant
> or not?

Strictly speaking, neither of them is.

Despite of this, we would (hopefully) mark the second case as an address
constant though.

Reason: this series flags address constants as such because they may be
used as a "constant expression in an initializer", i.e. as initializers
for static storage duration variables.

C.f. 6.6(7).

This paragraphs says that "an address constant for an object type plus
or minus an integer constant expression" is allowed as a constant
expression in an initializer.

Thus, after this series, sparse would tag (void*)0 + 'a' as being an
address constant although it's really an address constant plus/minus an
integer constant expression.


> So I assume (void*) Enum_member is not address constant either,
> right?

Right. The rule reads as "integer constant cast to pointer type", not
"integer constant *expression* cast to pointer type".

For the same reason, (void*)(0 + 'a') isn't an address constant either.


>
>>> The way I see it, there are three basic type of const elements.
>>> Int ( including enum/char), Float, Address.
>>>
>>> Either of which does not has any overlap with each other.
>>>
>>> Then each of the matching requirement is just a sets consist of the
>>> above element.
>>
>> Sorry, I don't understand that last sentence. "Set" in the mathematical
>> sense? How would that look like?
>
> Yes, "Set" in the mathematical sense. Maybe it is easier to show the code.
> I will try to explain here.
>
> Basically, there are six bits as basic element. One bit per element.
> Integer constant, enum constant, char constant, float constant,
> address constant,
> arithmetic constant.

+ integer constant *expression*

Take 0 + 0, for example: this is not an integer constant, but an integer
constant *expression* (and an arithmetic constant expression as well).


>
> The integer const expression can be test as a function, which use set
> operation base on the previous six bits. e.g.
> is_int_const_expr(flag) (flag & (Int | Enum | Char)) && !(flag &
> (Float | Addr | Arith)))
>
> In other words, the is_int_const_expr() can be deduce from the six element
> bits. It does not need to maintain and propagate as a separate bit in
> the expr->flags.
> We can calculate that result when it is needed.
>
> Maintain and propagate the six const bits become easier because it
> does not need to
> re-adjust the CONSTEXPR_FLAG_INT_CONST_EXPR  bit all the time. At least
> that is what I am hoping for. We will see if this can work out or not.
>
>>
>>
>>> I am not sure there is need to distinguish integer const expression vs arthritic
>>> const expression. (Example please?) If it does, add one more bit as
>>> arthritic operations.
>>
>> An example would be initialization with designators as shown in the
>> testcase you quoted above. C.f. 6.7.8(6): only integer constant
>> expressions are allowed there, but not arithmetic ones.
>
> Good, another corner case condition. That meas the arithmetic bits is here
> to stay. BTW, your test case is very good.

Thanks :)


Nicolai
