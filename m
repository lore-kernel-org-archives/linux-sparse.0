From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: How do I get the latest sparse?
Date: Wed, 17 Jan 2007 20:05:20 +0100
Message-ID: <20070117190520.GA30108@uranus.ravnborg.org>
References: <AKEOJDDJLNPHDAKOMMBHCEGHCPAA.mshah@teja.com> <20070116001735.GA12002@chrisli.org> <45ACC3DD.6050702@freedesktop.org> <20070117014923.GA641@chrisli.org> <45ADB71D.3080502@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:32948 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932686AbXAQTjm (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Jan 2007 14:39:42 -0500
Content-Disposition: inline
In-Reply-To: <45ADB71D.3080502@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

> 
> Excellent.  I would welcome any attempts at cross-function and cross-file
> checking, rather than continuing to add annotations for that purpose.

I experimented with a patch some time ago that allowed us to run
sparse on all files in a directory for the kernel.
But I experienced OOM while checking the XFS sources.
Reply on the matter from Linus was at that time something in the line
of that sparse did not do any atemp to free up memory after the early
parse stage so it is consuming much more memory than needed.

This was almost one year ago so things may have changed - but at least
something to keep an eye on.

XFS was just triggering this - it surely was due to codesize alone so
any other big directory could have been the trigger too. It is not XFS specific.

	Sam
