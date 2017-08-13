From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 15:26:46 +0100
Message-ID: <CACXZuxduTCs1=4Tx7wjaKG_br-Tos2n7p3MJJF20kQqvOnYBKA@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CAExDi1Qaa4+km-B-KHpBJ1dH5EOnOCzyU18yP8Y67ETfgbqagA@mail.gmail.com>
 <CACXZuxeR4eWwxCA0-oNfY_zBR7VGWixVuUzQr5ydvYsMFwvB1Q@mail.gmail.com>
 <CAExDi1TftYYi=CS09_yUdMP0xni3zwq-ZJoRz3hEWgykiybLpQ@mail.gmail.com> <CAExDi1R_6W3wysxR5bNPZ5PYDhgwo+Q=tJdL1QaV9dOXwyM27w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:38728 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdHMO0s (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 10:26:48 -0400
Received: by mail-ua0-f171.google.com with SMTP id w45so29158021uac.5
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 07:26:48 -0700 (PDT)
In-Reply-To: <CAExDi1R_6W3wysxR5bNPZ5PYDhgwo+Q=tJdL1QaV9dOXwyM27w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

Hi Luc,

On 13 August 2017 at 15:25, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> OTOH with -rc4, it takes only 0.05s !
>>
>> The situation is really weird, it's an interaction between the patches:
>> - remove single-store shortcut (first slowdown to 0.8s)
>> - fix ptrlist corruption while killing unreachable BBs (second slowdown to 2.9s)
>> - mark pseudo users as deleted instead of removing them (third slowdown to 5.5s)
>>
>> All three patches were expected to create *some* slowdown,
>> the first one very obviously and much more than the others.
>>
>> It's interesting to note that without the 'remove single shortcut' patch, the
>> two others ones don't seem to have a significative effect on the time.
>>
>> My guess here is that indeed, with this input, the single-store shortcut
>> is a huge optimization and without it much much more code is created
>> (phi-nodes, I suppose) and this impact very negatively the two other fixes.
>>
>> I'll see what can be done.
>
> It's also interesting to note that with the new SSA construction, there is no
> slowdown (0.064s here but too small to be measured accurately).
> This confirms me that the single-store shortcut was very much needed for
> performance (not simply because it's faster than the general case but that
> it creates much less intermediate code) but it created bad code ...
>

I wonder if it is worth doing these changes - instead we should
probably look at your new SSA construction approach.

Regards
Dibyendu
