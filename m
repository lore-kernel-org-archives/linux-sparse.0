From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 00/21] improve constexpr handling
Date: Thu, 24 Nov 2016 09:18:20 +0800
Message-ID: <CANeU7Qm21LCu2GgdTLbcDERBbgdYWoX_wp4DTKaFdi=G1ZcqAQ@mail.gmail.com>
References: <87lh75jh9l.fsf@gmail.com> <CANeU7QnzjJ5g+nGik21qsFAZ_5La3GOKVcTAx6=NOhVrVmrEQA@mail.gmail.com>
 <20161123040528.GA74337@macpro.local> <CANeU7Qm9FLZUexqu92mUSEojzrbi9SpsYrDMCP7J8qmskHcBFA@mail.gmail.com>
 <87a8cqlhcy.fsf@gmail.com> <CANeU7QkzefYMpkNgemsJ8WPUsj7fg8zUgKN8kth-0x7c85bK3w@mail.gmail.com>
 <87polm5eqq.fsf@gmail.com> <CANeU7QmsdVoccP0pN9RKkKC+-0mPSbfB59wQ5ngC3qEi4EY1+g@mail.gmail.com>
 <87lgwa59nm.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:33828 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934630AbcKXBTA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 20:19:00 -0500
Received: by mail-io0-f196.google.com with SMTP id r94so3505831ioe.1
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 17:18:21 -0800 (PST)
In-Reply-To: <87lgwa59nm.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Thu, Nov 24, 2016 at 2:33 AM, Nicolai Stange <nicstange@gmail.com> wrote:
>
> While doing this, I recognized that sparse's current constant expression
> tagging scheme was quite limited and I had to touch everything related
> to it anyway. So I asked on this list on whether it would be a good
> thing to let sparse be more strict than gcc in this regard and the
> feedback was that it certainly would (at user option).

Good. Thanks for reminding of that. So ideally this is under a more
strict options.

>
> Can you tell which one? If not, would resending this series help?
>
Yes, I can. But never mind that point as I reply in previous email.
I figure you do the same work in the evaluation stage now.

No, please don't send the series again. I have a script system to
process the patches now. So no patch will be missed from now on.


> So, if the above testcase really fails after this series, it's either a
> bug or an artifact of having this typeof() in there (or both), I
> think.

Never mind that.

>> Integer constant expression can be tested as:
>>
>> !(flags & ( Addr | Float) ) && flag
>>
>> Arithmetic constant expression can be tested as:
>>
>> !(flags & Addr) ) && flag
>>
>> Do you see any problem with this internal representation?
>
> (int)0.0 is an integer constant expression.
>
> In your scheme, it would have "composite op" and "float" set?
> The integer constant expression test you proposed above would
> fail in this case.
>

(int) 0.0 will express as "Composite op" and "Int const" set.
Cast is a special operation it will strip the "float" and convert it
to "int". After all that is what cast does.

It will not change your patch behavior and warning etc, it is just
a internal representation difference. How the constant expression
bits are store and interpreted.

Chris
