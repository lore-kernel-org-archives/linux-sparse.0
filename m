From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Interaction between bitfields and casts
Date: Wed, 9 Aug 2017 15:44:02 -0700
Message-ID: <CA+55aFyKPG265hBvvo7rYmzKkeOD+-o-Xr6UNzcJzKhxDYyy7w@mail.gmail.com>
References: <CACXZuxfUC1DostLzrB2nk9eOvDox1oxG-HjHm+nrWqtyRWEGVQ@mail.gmail.com>
 <CA+55aFw6PfWeEFcRPQg5DQOU_8Xzc48N-5Hr2F_e4=BYgqzdDg@mail.gmail.com> <CAMHZB6GwFtiXzKKRS79srkWH-Cq_mH5TmQJmro4qR3gto-WLqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:34431 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbdHIWoD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 18:44:03 -0400
Received: by mail-oi0-f53.google.com with SMTP id x3so75172990oia.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 15:44:02 -0700 (PDT)
In-Reply-To: <CAMHZB6GwFtiXzKKRS79srkWH-Cq_mH5TmQJmro4qR3gto-WLqA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 3:06 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I have but I never posted it yet.
> Basically, I have specialized them:
> - TRUNC, ZEXT & SEXT: truncate (may be not neede), zero & sign extend
> for integers

Makes sense.

And yes, I think we could skip TRUNC (casting to a smaller type is one
of those questionable things we do now).

Our IR doesn't really have any well-defined form for upper bits anyway
(ie there's no guarantee that values are zero-extended or
sign-extended to the full register width in the IR), so "TRUNC"
doesn't really have any sane semantics.

> - PTRU & UPTR: conversion pointer from/to unsigned integer (not sure
> it's needed)

So this is a separate thing that doesn't take a size?

So a "int to ptr" conversion on a 64-bit architecture would be a
combination of SEXT.64 and a UPTR?

If so, then yes, I think that's the right thing to do (and then in
basically all cases the PTRU/UPTR just goes away).

Or, like TRUNC, just say that pointers simply *are* the same thing as
an integer of the same size, and PTRU/UPTR just doesn't exist at all.

> - FCVTU & FCVTS: convert float to unsigned/signed integers
> - UCVTF & SCVTF: convert int to float
> - FCVTF: float to float convert (maybe even better/simpler with FTRUNC
> & FEXT ?=C3=A0)
>
> The main objective being to make things more explicit a avoid to have
> to test the orig-type at each time.

Yes. I think what you describe is the right thing to do. The current
casting is just wrong and nasty, and has too much implicit stuff.

                    Linus
