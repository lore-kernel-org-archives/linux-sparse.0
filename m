From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] parser: add Blackfin gcc info
Date: Wed, 6 Oct 2010 00:10:19 -0700
Message-ID: <20101006071018.GB2320@feather>
References: <1286267670-20974-1-git-send-email-vapier@gentoo.org>
 <201010052134.42915.vapier@gentoo.org>
 <AANLkTi=_MVVqr_hBx9GbhB5pmJWznakp8bmUXggfZAOi@mail.gmail.com>
 <201010060138.04508.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:54179 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758637Ab0JFHKd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Oct 2010 03:10:33 -0400
Content-Disposition: inline
In-Reply-To: <201010060138.04508.vapier@gentoo.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, michael.hennerich@analog.com

On Wed, Oct 06, 2010 at 01:38:02AM -0400, Mike Frysinger wrote:
> On Tuesday, October 05, 2010 22:33:21 Christopher Li wrote:
> > On Tue, Oct 5, 2010 at 6:34 PM, Mike Frysinger wrote:
> > >> I wonder, does it make sense to support these kinds of
> > >> architecture-specific builtins on all architectures, rather than
> > >> limiting them based on some specified target architecture?
> > >> 
> > >> Since Sparse doesn't generate code, it can easily target all
> > >> architectures simultaneously, but that doesn't mean we couldn't tell it
> > >> what architecture to target.  Sparse could default to targeting the
> > >> host architecture, which would avoid the need to pass extra flags in the
> > >> common case.
> > > 
> > > it does sound like it'd be useful to add an arch command line option.
> > >  but i hoped we could sneak in the Blackfin stuff first since other
> > > arches (like alpha) have been whitelisted.
> > 
> > Can we have some "ifdef" for the blackfin architecture in the pre buffer?
> > I agree with Josh, that do look like very much blackfin specific. We can
> > leave the ignore attribute alone for now.
> 
> how would #ifdefs help ?  i'm not building sparse for a Blackfin arch, host or 
> target wise.  if there's something more, you'd have to be specific as to what 
> you mean, otherwise i wont be able to send an updated patch.

I suspect that Chris meant that you could add_pre_buffer an #ifdef and
#endif surrounding the #define, so that the #define would only take
effect if Sparse (or the command-line options passed by cgcc or Linux)
defined some appropriate architecture-specific symbol for Blackfin.

> yes, these things are completely Blackfin specific, but i dont see how that's 
> a barrier for entry when both attributes and the builtin ignore lists contain 
> completely architecture specific stuff without any #ifdef logic.  using sparse 
> on the Linux kernel for the Blackfin port is pretty useless atm because of 
> these missing pieces.

Agreed.  At this point, it seems best to allow the Blackfin bits in to
fix the immediate problem, and independently fix the general problem and
apply the solution to all the arch-specific bits at once.  It certainly
seems unfair to single out Blackfin here.

- Josh Triplett
