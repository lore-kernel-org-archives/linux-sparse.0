From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse-llvm issue with handling of phisrc instruction
Date: Wed, 22 Mar 2017 20:29:30 +0100
Message-ID: <20170322192929.waqifaco6wtm7wue@macpro.local>
References: <CACXZuxdzxg_+rXu-OEUe+CwbbW+C-0CHZ=1wRrGa1ysptGDozA@mail.gmail.com>
 <CAExDi1RkSpRpSdm9i8ADSOkrQdVBMHNb=K5b+he4Gy4MMjD9wg@mail.gmail.com>
 <CACXZuxecFEoQPsUcbq8Oujvt5OYiscqcuYeMwQc5fv1ehPuAgA@mail.gmail.com>
 <CAExDi1Q_FMB+W_0-vscA6KWSPs4nZ4Dzmb42DrSrzFJ3Y5MiKw@mail.gmail.com>
 <CACXZuxfrMKckUhy9+kWGeBZt2dWiFqmXEvgJgCV7xmWej3A_Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:33768 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758975AbdCVT3f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 15:29:35 -0400
Received: by mail-wr0-f171.google.com with SMTP id y90so17156319wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 12:29:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxfrMKckUhy9+kWGeBZt2dWiFqmXEvgJgCV7xmWej3A_Fw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 22, 2017 at 06:17:50PM +0000, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> On 22 March 2017 at 18:15, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >>>> I am trying to see if sparse-llvm can handle unsimplified IR output
> >>>> from linearizer. I think there is a problem in how it handles phisrc.
> >>>
> >>> Does your non-simplified sparse IR contain the liveness information?
> >>> I think those are needed for the handling of OP_PHI & OP_PHISOURCE
> >>> in sparse-llvm.
> >>>
> >>
> >> Probably not - I commented out everything in linearize_fn() from
> >> simplify_symbol_usage() and downwards. Please tell me if this is
> >> incorrect.
> >
> > As far as I understand, sparse-llvm needs track_pseudo_liveness().
> >
> 
> Tried that - it made no difference.

I'm not sure liveness info has much sense without simplification,
at least part of it.

-- Luc
