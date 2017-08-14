From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 20:30:40 -0400
Message-ID: <CANeU7Q=-vw1=HgVqs7B-4gHj+Ysr6CVQvr+FpvW7ZNgsf7c=Vg@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com> <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:34707 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbdHNAal (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 20:30:41 -0400
Received: by mail-yw0-f177.google.com with SMTP id s143so46995007ywg.1
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 17:30:41 -0700 (PDT)
In-Reply-To: <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Sun, Aug 13, 2017 at 6:12 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:

> Simplified with single store shortcut switched OFF:
> https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/minilua/minilua_opt.lin
>

I haven't go through every thing yet. This above output is definitely
*not* RC5 output. It has push instruction. When you integrate
so much new code, it is hard to say where the slow down come
from.

Chris
