From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 01:35:48 +0200
Message-ID: <CAExDi1TjLH+tiDj-WgsWGaKMr3Uy8Z+PuyCLrC_LxQHh+rCJ2A@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
 <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com>
 <CAExDi1SS9VWX=G5nQ5uOjZAzh_PHOOovbzGZQs_izAXk4aYv-w@mail.gmail.com>
 <CACXZuxcmg1Q=cmrtpaiEkdNzL=jJCY48J37NrqTP7T6-w0m-0A@mail.gmail.com>
 <CAExDi1SiExepjbRiFbVaPz70DVoFv0=8pgDSiCqJEPaV4HHEpg@mail.gmail.com>
 <CACXZuxe-Q-5J38K-iu38FXFeOm3cQpwhVercFV3iPq+amJKw+A@mail.gmail.com>
 <CAExDi1QjkWAU7u8JVDTQZ9Q8YtVkqTF60qDZ+361Z4zGzJPd+A@mail.gmail.com> <CACXZuxeUWJitGjcb_yjD-KisrodWj-S8RL4pd1KOY3oKnq_8zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36758 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbdHMXft (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 19:35:49 -0400
Received: by mail-oi0-f50.google.com with SMTP id g131so71219105oic.3
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 16:35:49 -0700 (PDT)
In-Reply-To: <CACXZuxeUWJitGjcb_yjD-KisrodWj-S8RL4pd1KOY3oKnq_8zg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 14, 2017 at 1:25 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I was wondering if you get the same Sparse IR error I got - i.e.
> pseudo that is VOID. You should be able to see this without going to
> LLVM.

No but I'm not surprised as I have no idea of what exactly you have for changes

-rc5 crash with an assert because of missing FPCAST but well, master
has none of the needed patches for LLVM.

So I use the link I gave you previously (sssa-next) which has all
LLVM fixes I made, all floating-point related patches I made,
a few more fixes and optimizations and the SSA on top.

I'm pretty pleased by the results so far but I'm not surprised
at all that some more bugs still live in sparse-llvm.

-- Luc
