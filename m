From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 23:55:55 +0100
Message-ID: <CACXZuxcmg1Q=cmrtpaiEkdNzL=jJCY48J37NrqTP7T6-w0m-0A@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
 <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com> <CAExDi1SS9VWX=G5nQ5uOjZAzh_PHOOovbzGZQs_izAXk4aYv-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:37644 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdHMWz6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 18:55:58 -0400
Received: by mail-ua0-f172.google.com with SMTP id f9so31054453uaf.4
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 15:55:57 -0700 (PDT)
In-Reply-To: <CAExDi1SS9VWX=G5nQ5uOjZAzh_PHOOovbzGZQs_izAXk4aYv-w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

Hi Luc,

On 13 August 2017 at 23:36, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Not really, I was expecting the result of the preprocessing to avoid
> header dependencies and use the code as you're using it.
> For example, sparse doesn't know about the __DMR_C__ macro,
> we're not using the same header files, not even the same platform.
>

Here it is:

https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/minilua/minilua_preprocessed.c

Regards
Dibyendu
