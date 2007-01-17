From: Christopher Li <sparse@chrisli.org>
Subject: Re: How do I get the latest sparse?
Date: Tue, 16 Jan 2007 17:49:23 -0800
Message-ID: <20070117014923.GA641@chrisli.org>
References: <AKEOJDDJLNPHDAKOMMBHCEGHCPAA.mshah@teja.com> <20070116001735.GA12002@chrisli.org> <45ACC3DD.6050702@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc13.comcast.net ([204.127.225.93]:65339 "EHLO
	alnrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156AbXAQCRl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 21:17:41 -0500
Content-Disposition: inline
In-Reply-To: <45ACC3DD.6050702@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Mitesh Shah <mshah@teja.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Jan 16, 2007 at 04:23:57AM -0800, Josh Triplett wrote:
> I've followed all the patches on linux-sparse, and I have tested several of
> them in local git; I just haven't pushed out new bits.  I particularly look

Great to know you are back. I can resend my stack of patches now :-)

> forward to integrating your NULL pointer checking code, and I think I can

I haven't get much feed back of the new checking code yet. I will refresh my
patch as well. Without cross function/file checking, the interrupt checking
generates way too many false positives. I am working on the cross file checking
right now.

> adapt some of the dataflow analysis code for lock context checking as well.  I
> also know at least one likely customer for the smarter Sparse-based ctags, and
> I plan to look into generating cscope information as well (sparscope).  Expect
> bits soon.

Sparscope will be interesting.

Chris
