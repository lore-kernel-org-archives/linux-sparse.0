From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 21:20:45 +0100
Message-ID: <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com> <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33522 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdHMUUq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 16:20:46 -0400
Received: by mail-vk0-f47.google.com with SMTP id j189so26472833vka.0
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 13:20:46 -0700 (PDT)
In-Reply-To: <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

Hi Luc,

On 13 August 2017 at 21:09, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Aug 13, 2017 at 9:10 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> I have to disable simplifications anyway to get correct IR in some
>> cases.
>
> Care to send some examples you have problems with?
>

Sure - you already know this one:

https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/simplifybug.c

Additionally following fails if simplifications are turned on. I have
not analysed the reason yet.

https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/minilua/minilua.c

Note also that I have a couple of workarounds in my repository:

http://marc.info/?l=linux-sparse&m=148953605610758&w=2

http://marc.info/?l=linux-sparse&m=148993825216454&w=2

Regards
Dibyendu
