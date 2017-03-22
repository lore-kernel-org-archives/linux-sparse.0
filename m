From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm issue with handling of phisrc instruction
Date: Wed, 22 Mar 2017 21:42:59 +0100
Message-ID: <20170322204258.gpyewnksfccv5bta@macbook.local>
References: <CACXZuxdzxg_+rXu-OEUe+CwbbW+C-0CHZ=1wRrGa1ysptGDozA@mail.gmail.com>
 <CAExDi1RkSpRpSdm9i8ADSOkrQdVBMHNb=K5b+he4Gy4MMjD9wg@mail.gmail.com>
 <CACXZuxecFEoQPsUcbq8Oujvt5OYiscqcuYeMwQc5fv1ehPuAgA@mail.gmail.com>
 <CAExDi1Q_FMB+W_0-vscA6KWSPs4nZ4Dzmb42DrSrzFJ3Y5MiKw@mail.gmail.com>
 <CACXZuxfrMKckUhy9+kWGeBZt2dWiFqmXEvgJgCV7xmWej3A_Fw@mail.gmail.com>
 <CACXZuxfaQn+XApJpRY_63zf28VSeywj6R_kmy1sUHU3kEFpu-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36570 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751799AbdCVUnW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 16:43:22 -0400
Received: by mail-wm0-f41.google.com with SMTP id n11so46610712wma.1
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 13:43:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxfaQn+XApJpRY_63zf28VSeywj6R_kmy1sUHU3kEFpu-g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 22, 2017 at 06:55:37PM +0000, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> On 22 March 2017 at 18:17, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> >>>>> I am trying to see if sparse-llvm can handle unsimplified IR output
> >>>>> from linearizer. I think there is a problem in how it handles phisrc.
> >>>>
> >>>> Does your non-simplified sparse IR contain the liveness information?
> >>>> I think those are needed for the handling of OP_PHI & OP_PHISOURCE
> >>>> in sparse-llvm.
> >>>>
> >>>
> >>> Probably not - I commented out everything in linearize_fn() from
> >>> simplify_symbol_usage() and downwards. Please tell me if this is
> >>> incorrect.
> >>
> >> As far as I understand, sparse-llvm needs track_pseudo_liveness().
> >>
> >
> > Tried that - it made no difference.
> >
> 
> If there is a single phisrc and phi instruction then is phisrc meant
> to have the phi in its user list?

Yes but again this may depends on the simplification for
its correctness.

Also, for phi-nodes liveness is a bit different, unintuitive at first,
the PSEUDO_PHI play no role in liveness. So, in IR code like:
   .L0
	phisrc	%phi1 <- ...
	...

   .L1
	phi	%r2 <- %phi1, %phi2

the "liveness between .L0 & .L1" is not made via %phi1 but with the
"real" pseudo: %r2 (.L0 defines %r2, .L1 needs %r2).
 
-- Luc
