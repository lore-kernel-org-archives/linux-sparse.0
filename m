From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 23:16:52 +0200
Message-ID: <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com> <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33220 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbdHMVQx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 17:16:53 -0400
Received: by mail-oi0-f49.google.com with SMTP id f11so70027092oic.0
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 14:16:53 -0700 (PDT)
In-Reply-To: <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Sun, Aug 13, 2017 at 10:20 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>>> I have to disable simplifications anyway to get correct IR in some
>>> cases.
>>
>> Care to send some examples you have problems with?
>>
>
> Sure - you already know this one:
>
> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/simplifybug.c

When I'm using all LLVM fixes I've ever submitted and my SSA patches on top
available at:
    git://github.com/lucvoo/sparse.git sssa-next

This simplifybug.c doesn't seem to have problems with sparse-LLVM.
I'm less sure about the generated code, of course.

> Additionally following fails if simplifications are turned on. I have
> not analysed the reason yet.
>
> https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/minilua/minilua.c

This 8000 lines file has a lot of header file dependencies, I'm willing to
take a look at the preprocessed output if you send it.

> Note also that I have a couple of workarounds in my repository:
>
> http://marc.info/?l=linux-sparse&m=148953605610758&w=2

Only half of the function is there. Care to send to full version?

> http://marc.info/?l=linux-sparse&m=148993825216454&w=2

A floating-point test program while sparse has very very poor
fp support ... hmmm and with a header file dependencies.
Care to send the preprocessed output?

Regards,
-- Luc
