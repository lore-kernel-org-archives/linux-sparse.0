From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 17:07:26 +0200
Message-ID: <CAExDi1S3BhCLWrXhziKHB9XGApLo+54ZFMSbUbNyCkJAAk8DUA@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CAExDi1Qaa4+km-B-KHpBJ1dH5EOnOCzyU18yP8Y67ETfgbqagA@mail.gmail.com>
 <CACXZuxeR4eWwxCA0-oNfY_zBR7VGWixVuUzQr5ydvYsMFwvB1Q@mail.gmail.com>
 <CAExDi1TftYYi=CS09_yUdMP0xni3zwq-ZJoRz3hEWgykiybLpQ@mail.gmail.com>
 <CAExDi1R_6W3wysxR5bNPZ5PYDhgwo+Q=tJdL1QaV9dOXwyM27w@mail.gmail.com> <CACXZuxduTCs1=4Tx7wjaKG_br-Tos2n7p3MJJF20kQqvOnYBKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34433 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdHMPH1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 11:07:27 -0400
Received: by mail-oi0-f53.google.com with SMTP id x3so66788064oia.1
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 08:07:27 -0700 (PDT)
In-Reply-To: <CACXZuxduTCs1=4Tx7wjaKG_br-Tos2n7p3MJJF20kQqvOnYBKA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Sun, Aug 13, 2017 at 4:26 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>>
>> It's also interesting to note that with the new SSA construction, there is no
>> slowdown (0.064s here but too small to be measured accurately).
>> This confirms me that the single-store shortcut was very much needed for
>> performance (not simply because it's faster than the general case but that
>> it creates much less intermediate code) but it created bad code ...
>>
>
> I wonder if it is worth doing these changes - instead we should
> probably look at your new SSA construction approach.

It was of course what I was thinking when I wrote this note.

I've put together the minimal changes for having this on top
of the current master:
    git://github.com/lucvoo/sparse.git sssa-mini

Since yesterday I already gave it a good more testing and
everything good so far.

-- Luc
