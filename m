From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Thu, 24 Nov 2016 19:24:51 +0800
Message-ID: <CANeU7Q=xDWBYSWsb8NXfWYy=LDLufp4QZ+qjdn3DHBpcVZh4oQ@mail.gmail.com>
References: <87lh75jh9l.fsf@gmail.com> <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
 <20161123040528.GA74337@macpro.local> <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
 <87a8cqlhcy.fsf@gmail.com> <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
 <87polm5eqq.fsf@gmail.com> <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
 <87lgwa59nm.fsf@gmail.com> <CANeU7Qm21LCu2GgdTLbcDERBbgdYWoX_wp4DTKaFdi=G1ZcqAQ@mail.gmail.com>
 <87h96x5hzv.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36692 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964981AbcKXLYx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 24 Nov 2016 06:24:53 -0500
Received: by mail-io0-f193.google.com with SMTP id k19so4660754iod.3
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2016 03:24:53 -0800 (PST)
In-Reply-To: <87h96x5hzv.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Thu, Nov 24, 2016 at 5:45 PM, Nicolai Stange <nicstange@gmail.com> wrote:
> As it stands, [09/21] ("evaluate: check static storage duration objects'
> intializers' constness"), introduces the opt-in -Wconstexpr-not-const.
> This affects only initializers for objects of static storage duration.
>
> So, there is currently no way to opt out from the stricter integer
> constant expression checks etc. introduced with this series.
>
> I ran sparse with this series applied on the kernel back then and if I
> remember correctly, there was no spectacular difference though.
>
> If these stricter semantics nevertheless became a problem, this would be
> easily "fixable" by further relaxing them at user option, I think.

That is fine for now. We can always add the option later.

> Alright. May I further ask whether you've got all these precious
> Reviewed-by tags from Luc carried over? He did a great amount of review
> work on this series and it would be quite sad if these got lost.
> I still have them, so just tell me if you need a list. If not:
> nevermind.

Luc's review tag should be apply when it is accepted.The script does
not add review tags by itself.  I usually add it by hand.

If yo want to add the tags in the patch, you are welcome resend the patch
with the new review tags. I just said don't need to send they if they are
exactly the same.

In this case, it is likely to have new around of patches series. We can
hold it off a bit.
>
> Yes, yes got that. Don't get me wrong, I'm not defending my particular
> choice of flags. If yours leads to cleaner/less code, I will be very
> happy.
>
> That being said, here's the next "corner case":
>
>   0 + 'a'
>
> Which flags would be set for this binary expression? All of "composite
> op", "integer const", "char const"?
>
> That would work with your test for integer constant expressions.
Yes. That is right.

For binary op, most of the case it just need to do:
new flags = left flags | right flags;

Then check if the combined result has invalid result.

> I think, it wouldn't be enough to just set "composite op" flag w/o
> anything else since the above integer constant expression needs to get
> distinguished from
>
>   0 + 0.0
>
> which is an arithmetic constant expression only. Thus, considering your
> tests for integer vs. arithmetic constant expressions, this would need
> to have at least its "float constant" flag set?

Yes, it would need to have "float constant" set on the final flag.

First of all, I think sparse will do implicit cast operation which will
add the "float constant" flag. It is the case for non-constant operations.
I need to dig deeper for constant case.

Even if there is no implicit cast operations, on the left hand you have "Int",
on the right hand you have "Float". So the combination will have "Int", "Float",
"composite op".

Base on my previous define for the arithmetic constant expressions:

>>> Integer constant expression can be tested as:
>>>
>>> !(flags & ( Addr | Float) ) && flag

The result has "Float" so it is not a integer constant expression.

>>>
>>> Arithmetic constant expression can be tested as:
>>>
>>> !(flags & Addr) ) && flag
>>>

The result does not have "Addr" so it is an arithmetic constant
expression. Your example does not break my representation.

We can still adjust the final result as needed. For most of the case
it does not need to adjust.

Other creative corner case are very welcome.

Chris
