From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] doc: fix manpage formatting
Date: Wed, 24 Jan 2018 09:18:14 +0100
Message-ID: <20180124081812.wsfgd6j2zhm42xsp@ltop.local>
References: <20180121044644.90500-1-luc.vanoostenryck@gmail.com>
 <CANeU7QmhApyECXRr0mmWEOH4q+NmEDrVYNxps5uKYMN2mXkS_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:43088 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbeAXISQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 24 Jan 2018 03:18:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id g1so6659501wmg.2
        for <linux-sparse@vger.kernel.org>; Wed, 24 Jan 2018 00:18:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QmhApyECXRr0mmWEOH4q+NmEDrVYNxps5uKYMN2mXkS_A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jan 23, 2018 at 03:03:01AM -0800, Christopher Li wrote:
> On Sat, Jan 20, 2018 at 8:46 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > A '.TP' was missing when describing '-fmem-report'.
> >
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> I get some conflict when I apply this one on master.
> May be it is relate to the other document patches recently applied.

Yes, sort of.
A .TP was missing when I added -fdump-linearize and the one
that was there for the next option was removed when I changed
the name to -fdump-ir.

-- Luc
