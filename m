From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm issue with handling of phisrc instruction
Date: Wed, 22 Mar 2017 18:38:00 +0100
Message-ID: <CAExDi1RkSpRpSdm9i8ADSOkrQdVBMHNb=K5b+he4Gy4MMjD9wg@mail.gmail.com>
References: <CACXZuxdzxg_+rXu-OEUe+CwbbW+C-0CHZ=1wRrGa1ysptGDozA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:32832 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759029AbdCVRiC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 13:38:02 -0400
Received: by mail-qt0-f174.google.com with SMTP id i34so158066813qtc.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 10:38:01 -0700 (PDT)
In-Reply-To: <CACXZuxdzxg_+rXu-OEUe+CwbbW+C-0CHZ=1wRrGa1ysptGDozA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 22, 2017 at 5:46 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi
>
> I am trying to see if sparse-llvm can handle unsimplified IR output
> from linearizer. I think there is a problem in how it handles phisrc.

Does your non-simplified sparse IR contain the liveness information?
I think those are needed for the handling of OP_PHI & OP_PHISOURCE
in sparse-llvm.

Luc
