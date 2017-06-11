From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Status of sparse-next
Date: Mon, 12 Jun 2017 01:24:43 +0200
Message-ID: <20170611232441.djt2hlryzwsrzzk6@ltop.local>
References: <CACXZuxfeUP6bvDwmYv=O4yR7GXOCDeFPf5Sk-_OdXtE+=uZ1Eg@mail.gmail.com>
 <20170611224629.ak7evynf6lcyorz7@ltop.local>
 <CACXZuxdqtQY=ak+tNJ64H4hg2CdCxLs_W73tYEQhMKFCmoJ3_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33565 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbdFKXYq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Jun 2017 19:24:46 -0400
Received: by mail-wr0-f176.google.com with SMTP id v104so78897875wrb.0
        for <linux-sparse@vger.kernel.org>; Sun, 11 Jun 2017 16:24:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdqtQY=ak+tNJ64H4hg2CdCxLs_W73tYEQhMKFCmoJ3_A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Jun 11, 2017 at 11:57:39PM +0100, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> On 11 June 2017 at 23:46, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Sun, Jun 11, 2017 at 11:02:40PM +0100, Dibyendu Majumdar wrote:
> >> I was wondering if the sparse-next branch is going to be stable soon.
> >
> > As far as I know, sparse-next is very stable.
> > Are you aware of any instability?
> >
> 
> I don't actively use sparse-next so I don't know of any. Good to know
> that sparse-next is stable.

In fact, the master branch is itself very stable but
sparse-next already contains a bunch of fixes, most
related to code generation, as well ass some small
features.

> > But yes, all the LLVM patches I suppose you're interested in
> > haven't yet made it and sparse-next itself still need to be
> > promoted to master.
> >
> 
> I am interested in merging all the other changes too - but I wanted to
> do this when all of the outstanding changes are included.

That's quite understandable.
 
> Is there a specific goal for the next release of sparse, or will it be
> just a point in time snapshot of sparse-next?

As far as I understand the maintainer's intention,
it's not to just have a snapshot. About the timeframe,
I have no idea though, I'm waiting myself since way too long.

-- Luc Van Oostenryck
