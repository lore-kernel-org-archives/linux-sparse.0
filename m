From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] parser: add Blackfin gcc info
Date: Wed, 6 Oct 2010 00:05:10 -0700
Message-ID: <20101006070509.GA2320@feather>
References: <1286267670-20974-1-git-send-email-vapier@gentoo.org>
 <20101005161829.GB1859@feather>
 <201010052134.42915.vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:60698 "EHLO
	relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906Ab0JFHFX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Oct 2010 03:05:23 -0400
Content-Disposition: inline
In-Reply-To: <201010052134.42915.vapier@gentoo.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: linux-sparse@vger.kernel.org, michael.hennerich@analog.com

On Tue, Oct 05, 2010 at 09:34:41PM -0400, Mike Frysinger wrote:
> On Tuesday, October 05, 2010 12:18:30 Josh Triplett wrote:
> > On Tue, Oct 05, 2010 at 04:34:30AM -0400, Mike Frysinger wrote:
> > > The Blackfin port uses some custom attributes to control memory
> > > placement, and it has some custom builtins.  So add the ones that the
> > > kernel actually utilizes to avoid massive build errors with sparse.
> > 
> > I wonder, does it make sense to support these kinds of
> > architecture-specific builtins on all architectures, rather than
> > limiting them based on some specified target architecture?
> > 
> > Since Sparse doesn't generate code, it can easily target all
> > architectures simultaneously, but that doesn't mean we couldn't tell it
> > what architecture to target.  Sparse could default to targeting the
> > host architecture, which would avoid the need to pass extra flags in the
> > common case.
> 
> it does sound like it'd be useful to add an arch command line option.  but i 
> hoped we could sneak in the Blackfin stuff first since other arches (like 
> alpha) have been whitelisted.

Absolutely.  I took the opportunity to raise the general problem, but
that doesn't mean that Blackfin should have to wait for the general
solution. :)

- Josh Triplett
