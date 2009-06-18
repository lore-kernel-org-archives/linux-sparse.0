From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: RFC: Move sparse.git inside linux-kernel-2.6.git?
Date: Thu, 18 Jun 2009 22:18:40 +0200
Message-ID: <20090618201840.GA14661@uranus.ravnborg.org>
References: <20090618192058.GB14086@uranus.ravnborg.org> <4A3A96E2.5080504@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:56022 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbZFRUQW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Jun 2009 16:16:22 -0400
Content-Disposition: inline
In-Reply-To: <4A3A96E2.5080504@garzik.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

> 
> Even though I _am_ one of those weirdos that would love to 
> sparse+something become the official kernel compiler -- many years from 
> now -- I think that they are best kept separate.
> 
> sparse -does- serve as "libsparse" to a few independent projects, and 
> the current sparse/kernel has clear benefits for those projects.  Being 
> a separate project helps keep sparse small, simple, focused and 
> portable, IMO.

"housing" the source inside the kernel source tree should not
be an excuse to make this kernel only.
It should rather expose the source.

And then people could extend sparse and say that they contributes
to the linux kernel. Maybe that could make it more sexy.

I at least does not see that housing the source inside the kernel
automatically will make it kernel only.
But I on the other hand are sure we will see additional
contributions / improvements and extended use.

Having sparse inside the kernel is therefore in no way a blocker
for smatch, or Jeff's x86 compilter toy.

	Sam
