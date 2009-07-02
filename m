From: Josh Triplett <josh@freedesktop.org>
Subject: Re: RFC: Move sparse.git inside linux-kernel-2.6.git?
Date: Thu, 2 Jul 2009 16:21:10 -0700
Message-ID: <20090702232109.GJ19009@feather>
References: <20090618192058.GB14086@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:41343 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbZGBXsk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 2 Jul 2009 19:48:40 -0400
Received: from relay2-v.mail.gandi.net (relay2-v.mail.gandi.net [217.70.178.76])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id F2B55391FA
	for <linux-sparse@vger.kernel.org>; Fri,  3 Jul 2009 01:28:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090618192058.GB14086@uranus.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jun 18, 2009 at 09:20:58PM +0200, Sam Ravnborg wrote:
> The linux kernel is one of the major customers of
> sparse and several sparse hackers are very
> active on the kernel front too.
> 
> How about combining forces and move sparse.git inside
> the kernel.
> 
> Benefits doing so:
> 
> - Easy access to sparse from within the kernel.
>   Doing a make C=2 run is now trivial for everyone
> 
> - We (the kernel hackers) has the source readily
>   avalibale when we need to hack it.
> 
> Drawbacks:
> 
> - We need to come up with a solution so it is
>   easy to distribute sparse binaries/source packages
>   without the need to distribute the full kernel source
> 
> 
> The idea has come up before, and now that the kernel
> has a tools/ directory we have a place where sparse can live.
> 
> And I think Linus can find a way to pull sparse.git
> with full history so we do not loose anything doing so.

I think that Sparse needs to exist as a separate project for the benefit
of all the non-kernel users of Sparse, but at the same time I think
having Sparse in the kernel tree would help kernel developers actually
run Sparse as part of their build process.

Fortunately, Git offers a good solution to this problem: submodules.
linux-2.6 could have Sparse as a submodule under the tools/sparse
directory.  Anyone who checked out linux-2.6 via git could then
near-automatically get a copy of Sparse via git, and release tarballs of
Linux could fairly easily include Sparse.

The way submodules work, a commit in the linux-2.6 repository would refer to
a specific commit in the sparse repostory, so linux-2.6 could always point
to a version of Sparse known to more-or-less work with that version of
Linux.

How does that sound?

- Josh Triplett
