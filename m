From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 19:48:30 +0100
Message-ID: <CACXZuxfHu8M1Lxpjmtj6=HS8T0o5dvDzmSryEqkKn6iG7MAxTw@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
 <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com> <CANeU7Q=-vw1=HgVqs7B-4gHj+Ysr6CVQvr+FpvW7ZNgsf7c=Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:37554 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbdHNSsc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 14:48:32 -0400
Received: by mail-ua0-f179.google.com with SMTP id f9so40014104uaf.4
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 11:48:32 -0700 (PDT)
In-Reply-To: <CANeU7Q=-vw1=HgVqs7B-4gHj+Ysr6CVQvr+FpvW7ZNgsf7c=Vg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

Hi Chris,

On 14 August 2017 at 01:30, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Aug 13, 2017 at 6:12 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>
>> Simplified with single store shortcut switched OFF:
>> https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/minilua/minilua_opt.lin
>>
>
> I haven't go through every thing yet. This above output is definitely
> *not* RC5 output. It has push instruction. When you integrate
> so much new code, it is hard to say where the slow down come
> from.
>

In my tests the removal of single store shortcut makes the time
increase from .2 to 8.2 seconds.
I am compiling following:

https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/lcc/cq.c


Regards
