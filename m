From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Thu, 24 Nov 2016 10:45:08 +0100
Message-ID: <87h96x5hzv.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
        <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
        <20161123040528.GA74337@macpro.local>
        <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
        <87a8cqlhcy.fsf@gmail.com>
        <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
        <87polm5eqq.fsf@gmail.com>
        <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
        <87lgwa59nm.fsf@gmail.com>
        <CANeU7Qm21LCu2GgdTLbcDERBbgdYWoX_wp4DTKaFdi=G1ZcqAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33956 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934194AbcKXJpM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 04:45:12 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so4460632wme.1
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 01:45:11 -0800 (PST)
In-Reply-To: <CANeU7Qm21LCu2GgdTLbcDERBbgdYWoX_wp4DTKaFdi=G1ZcqAQ@mail.gmail.com>
        (Christopher Li's message of "Thu, 24 Nov 2016 09:18:20 +0800")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

Christopher Li <sparse@chrisli.org> writes:

> On Thu, Nov 24, 2016 at 2:33 AM, Nicolai Stange <nicstange@gmail.com> wrote:
>>
>> While doing this, I recognized that sparse's current constant expression
>> tagging scheme was quite limited and I had to touch everything related
>> to it anyway. So I asked on this list on whether it would be a good
>> thing to let sparse be more strict than gcc in this regard and the
>> feedback was that it certainly would (at user option).
>
> Good. Thanks for reminding of that. So ideally this is under a more
> strict options.

As it stands, [09/21] ("evaluate: check static storage duration objects'
intializers' constness"), introduces the opt-in -Wconstexpr-not-const.
This affects only initializers for objects of static storage duration.

So, there is currently no way to opt out from the stricter integer
constant expression checks etc. introduced with this series.

I ran sparse with this series applied on the kernel back then and if I
remember correctly, there was no spectacular difference though.

If these stricter semantics nevertheless became a problem, this would be
easily "fixable" by further relaxing them at user option, I think.


> No, please don't send the series again. I have a script system to
> process the patches now. So no patch will be missed from now on.

Alright. May I further ask whether you've got all these precious
Reviewed-by tags from Luc carried over? He did a great amount of review
work on this series and it would be quite sad if these got lost.
I still have them, so just tell me if you need a list. If not:
nevermind.


>>> Integer constant expression can be tested as:
>>>
>>> !(flags & ( Addr | Float) ) && flag
>>>
>>> Arithmetic constant expression can be tested as:
>>>
>>> !(flags & Addr) ) && flag
>>>
>>> Do you see any problem with this internal representation?
>>
>> (int)0.0 is an integer constant expression.
>>
>> In your scheme, it would have "composite op" and "float" set?
>> The integer constant expression test you proposed above would
>> fail in this case.
>>
>
> (int) 0.0 will express as "Composite op" and "Int const" set.
> Cast is a special operation it will strip the "float" and convert it
> to "int". After all that is what cast does.

Ah ok, i mistook you in the semantics of the composite op flag.


> It will not change your patch behavior and warning etc, it is just
> a internal representation difference. How the constant expression
> bits are store and interpreted.

Yes, yes got that. Don't get me wrong, I'm not defending my particular
choice of flags. If yours leads to cleaner/less code, I will be very
happy.

That being said, here's the next "corner case":

  0 + 'a'

Which flags would be set for this binary expression? All of "composite
op", "integer const", "char const"?

That would work with your test for integer constant expressions.

I think, it wouldn't be enough to just set "composite op" flag w/o
anything else since the above integer constant expression needs to get
distinguished from

  0 + 0.0

which is an arithmetic constant expression only. Thus, considering your
tests for integer vs. arithmetic constant expressions, this would need
to have at least its "float constant" flag set?


Thank you,

Nicolai
