From: Jeff Garzik <jeff@garzik.org>
Subject: Re: RFC: Move sparse.git inside linux-kernel-2.6.git?
Date: Thu, 18 Jun 2009 15:34:58 -0400
Message-ID: <4A3A96E2.5080504@garzik.org>
References: <20090618192058.GB14086@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from srv5.dvmed.net ([207.36.208.214]:59672 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbZFRTeo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Jun 2009 15:34:44 -0400
In-Reply-To: <20090618192058.GB14086@uranus.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

Sam Ravnborg wrote:
> The linux kernel is one of the major customers of
> sparse and several sparse hackers are very
> active on the kernel front too.
> 
> How about combining forces and move sparse.git inside
> the kernel.
> 
> I assume that we can work out something on the
> license side so sparse has the correct license??
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
> 
> On the maintainer side of sparse one has to ask Linus to
> pull now and then - this is a doable task.

Even though I _am_ one of those weirdos that would love to 
sparse+something become the official kernel compiler -- many years from 
now -- I think that they are best kept separate.

sparse -does- serve as "libsparse" to a few independent projects, and 
the current sparse/kernel has clear benefits for those projects.  Being 
a separate project helps keep sparse small, simple, focused and 
portable, IMO.

One specific roadblock in any case is the license issue.  sparse's 
license is incompatible with the kernel's, and it is difficult to change 
the license at present.

	Jeff



