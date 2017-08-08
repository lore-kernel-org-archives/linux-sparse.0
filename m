From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 6/8] transform (A & M) >> S to (A >> S) & (M >> S)
Date: Tue, 8 Aug 2017 03:38:16 +0200
Message-ID: <CAExDi1REftOgTgRFOa-94tWoxBMm5+7ph7bBmBm8dkbpPzC7Zw@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-7-luc.vanoostenryck@gmail.com>
 <CANeU7Q=VSGSTLweWegU1RxZO9_iV9UT0p9L5xe95rC6-vMuntA@mail.gmail.com> <CA+55aFyw=CN=RoEAVMFXc6qk=Y-hbuDvgN=thmyZTj1tSRxkhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34899 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdHHBiR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 21:38:17 -0400
Received: by mail-qk0-f194.google.com with SMTP id a77so2047220qkb.2
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 18:38:17 -0700 (PDT)
In-Reply-To: <CA+55aFyw=CN=RoEAVMFXc6qk=Y-hbuDvgN=thmyZTj1tSRxkhQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 8, 2017 at 3:00 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> It *might* result in further simplifications just because the final
> 'and' might be simpler, and even the "A >> S" might now be something
> you can simplify (for example "A >> 16" could be turned into a 16-bit
> load if the source of A is a 32-bit load).
>
> But even in the absence of such further simplification, the smaller
> constant thing likely makes it worth it. Almost all architectures have
> an easier time with smaller constants, and doing
>
>    (a >> 24) & 255;
>
> is often noticeably more efficient than
>
>    (a & 0xff000000) >> 24;
>
> just because of the constant issue.

In truth, my real motivation is only apparent when looking at this patch
and the following. The original complete pattern was:
   ((X << S) & (M' << S)) >> S
with A = (X << S) and M = (M' << S)
which now give:
   ((X << S) >> S) & M'
and with the next patch will give
   (X & M'') & M'
which will simplify to
   X & M'''

But yes, these optimizations are worthwhile by themselves too
because they create small(er) masks.

-- Luc

(A & M) >> S to

(A >> S) & (M >> S)
