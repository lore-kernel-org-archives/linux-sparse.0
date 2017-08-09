From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Interaction between bitfields and casts
Date: Thu, 10 Aug 2017 00:56:45 +0200
Message-ID: <CAExDi1TaNMKp2UjF+3k5dimUjB27LT_cy=cSSQv7G5sJa0p0_A@mail.gmail.com>
References: <CACXZuxfUC1DostLzrB2nk9eOvDox1oxG-HjHm+nrWqtyRWEGVQ@mail.gmail.com>
 <CA+55aFw6PfWeEFcRPQg5DQOU_8Xzc48N-5Hr2F_e4=BYgqzdDg@mail.gmail.com>
 <CAMHZB6GwFtiXzKKRS79srkWH-Cq_mH5TmQJmro4qR3gto-WLqA@mail.gmail.com> <CA+55aFyKPG265hBvvo7rYmzKkeOD+-o-Xr6UNzcJzKhxDYyy7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34782 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbdHIW4q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 18:56:46 -0400
Received: by mail-oi0-f41.google.com with SMTP id x3so75379248oia.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 15:56:46 -0700 (PDT)
In-Reply-To: <CA+55aFyKPG265hBvvo7rYmzKkeOD+-o-Xr6UNzcJzKhxDYyy7w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 12:44 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Aug 9, 2017 at 3:06 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> I have but I never posted it yet.
>> Basically, I have specialized them:
>> - TRUNC, ZEXT & SEXT: truncate (may be not neede), zero & sign extend
>> for integers
>
> Makes sense.
>
> And yes, I think we could skip TRUNC (casting to a smaller type is one
> of those questionable things we do now).

Maybe it can be useful for a short time after linearization, if we do some
type analysis or so, I'm not sure.
But after a while, they must be simplified away or converted to an AND mask=
.

> Our IR doesn't really have any well-defined form for upper bits anyway
> (ie there's no guarantee that values are zero-extended or
> sign-extended to the full register width in the IR), so "TRUNC"
> doesn't really have any sane semantics.
>
>> - PTRU & UPTR: conversion pointer from/to unsigned integer (not sure
>> it's needed)
>
> So this is a separate thing that doesn't take a size?
>
> So a "int to ptr" conversion on a 64-bit architecture would be a
> combination of SEXT.64 and a UPTR?

Yes, it's the idea. Basically a no-op.

> If so, then yes, I think that's the right thing to do (and then in
> basically all cases the PTRU/UPTR just goes away).
>
> Or, like TRUNC, just say that pointers simply *are* the same thing as
> an integer of the same size, and PTRU/UPTR just doesn't exist at all.

Same as for TRUNC, I think. At the end it's sure we don't want them,
they are just the same as unsigned integers of the same size.
But maybe during early phases, we want to keep them as such
because we need to know they correspond to a pointer or an address.

>> - FCVTU & FCVTS: convert float to unsigned/signed integers
>> - UCVTF & SCVTF: convert int to float
>> - FCVTF: float to float convert (maybe even better/simpler with FTRUNC
>> & FEXT ?=C3=A0)
>>
>> The main objective being to make things more explicit a avoid to have
>> to test the orig-type at each time.
>
> Yes. I think what you describe is the right thing to do. The current
> casting is just wrong and nasty, and has too much implicit stuff.

Yes, the missing of an explicit information about the signed/unsigned
is quite error-prone.

-- Luc
