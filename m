From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [SPARSE] cast rework (was: Re: Interaction between bitfields and
 casts)
Date: Sat, 25 Nov 2017 17:18:31 +0100
Message-ID: <20171125161825.64d4s27k57ep3psg@ltop.local>
References: <CACXZuxfUC1DostLzrB2nk9eOvDox1oxG-HjHm+nrWqtyRWEGVQ@mail.gmail.com>
 <CA+55aFw6PfWeEFcRPQg5DQOU_8Xzc48N-5Hr2F_e4=BYgqzdDg@mail.gmail.com>
 <CAMHZB6GwFtiXzKKRS79srkWH-Cq_mH5TmQJmro4qR3gto-WLqA@mail.gmail.com>
 <CA+55aFyKPG265hBvvo7rYmzKkeOD+-o-Xr6UNzcJzKhxDYyy7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38191 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbdKYQSf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 25 Nov 2017 11:18:35 -0500
Received: by mail-wm0-f44.google.com with SMTP id n74so1888185wmi.3
        for <linux-sparse@vger.kernel.org>; Sat, 25 Nov 2017 08:18:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+55aFyKPG265hBvvo7rYmzKkeOD+-o-Xr6UNzcJzKhxDYyy7w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 09, 2017 at 03:44:02PM -0700, Linus Torvalds wrote:
> On Wed, Aug 9, 2017 at 3:06 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > I have but I never posted it yet.
> > Basically, I have specialized them:
> > - TRUNC, ZEXT & SEXT: truncate (may be not neede), zero & sign extend
> > for integers
> 
> Makes sense.
> 
> And yes, I think we could skip TRUNC (casting to a smaller type is one
> of those questionable things we do now).
> 
> Our IR doesn't really have any well-defined form for upper bits anyway
> (ie there's no guarantee that values are zero-extended or
> sign-extended to the full register width in the IR), so "TRUNC"
> doesn't really have any sane semantics.
> 
> > - PTRU & UPTR: conversion pointer from/to unsigned integer (not sure
> > it's needed)
> 
> So this is a separate thing that doesn't take a size?
> 
> So a "int to ptr" conversion on a 64-bit architecture would be a
> combination of SEXT.64 and a UPTR?
> 
> If so, then yes, I think that's the right thing to do (and then in
> basically all cases the PTRU/UPTR just goes away).
> 
> Or, like TRUNC, just say that pointers simply *are* the same thing as
> an integer of the same size, and PTRU/UPTR just doesn't exist at all.
> 
> > - FCVTU & FCVTS: convert float to unsigned/signed integers
> > - UCVTF & SCVTF: convert int to float
> > - FCVTF: float to float convert (maybe even better/simpler with FTRUNC
> > & FEXT ?à)
> >
> > The main objective being to make things more explicit a avoid to have
> > to test the orig-type at each time.
> 
> Yes. I think what you describe is the right thing to do. The current
> casting is just wrong and nasty, and has too much implicit stuff.
> 
>                     Linus

I'm busy to test & polish the patch series corresponding to this and
I discovered an annoying oddball:
   Cast to an union (where the union contains a field of the same
   type as the source).
This is a GCC extension and unlike a normal cast it produces an l-value.
The kernel uses this a few times (at least once as an l-value).
It will need a bit work on sparse side to handle this.

-- Luc
