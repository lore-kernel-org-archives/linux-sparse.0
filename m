From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Interaction between bitfields and casts
Date: Thu, 10 Aug 2017 00:06:12 +0200
Message-ID: <CAMHZB6GwFtiXzKKRS79srkWH-Cq_mH5TmQJmro4qR3gto-WLqA@mail.gmail.com>
References: <CACXZuxfUC1DostLzrB2nk9eOvDox1oxG-HjHm+nrWqtyRWEGVQ@mail.gmail.com>
 <CA+55aFw6PfWeEFcRPQg5DQOU_8Xzc48N-5Hr2F_e4=BYgqzdDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35624 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbdHIWGN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 18:06:13 -0400
Received: by mail-qk0-f169.google.com with SMTP id d145so44098863qkc.2
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 15:06:13 -0700 (PDT)
In-Reply-To: <CA+55aFw6PfWeEFcRPQg5DQOU_8Xzc48N-5Hr2F_e4=BYgqzdDg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 9, 2017 at 11:27 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> So the OP_*CAST functions really are a bit confused. Maybe Luc has
> cleaned some of it up already, I'm going partly from memory.

I have but I never posted it yet.
Basically, I have specialized them:
- TRUNC, ZEXT & SEXT: truncate (may be not neede), zero & sign extend
for integers
- PTRU & UPTR: conversion pointer from/to unsigned integer (not sure
it's needed)
- FCVTU & FCVTS: convert float to unsigned/signed integers
- UCVTF & SCVTF: convert int to float
- FCVTF: float to float convert (maybe even better/simpler with FTRUNC
& FEXT ?=C3=A0)

The main objective being to make things more explicit a avoid to have
to test the orig-type at each time.

-- Luc
