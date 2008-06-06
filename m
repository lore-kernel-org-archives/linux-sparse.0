From: Christoph Hellwig <hch@lst.de>
Subject: Re: sparse (cgcc) vs lintool
Date: Fri, 6 Jun 2008 15:07:56 +0200
Message-ID: <20080606130756.GA24879@lst.de>
References: <20080606123434.GA23323@lst.de> <20080606124955.GE600@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:37673 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbYFFNII (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jun 2008 09:08:08 -0400
Content-Disposition: inline
In-Reply-To: <20080606124955.GE600@ins.uni-bonn.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, linux-sparse@vger.kernel.org

On Fri, Jun 06, 2008 at 02:49:55PM +0200, Ralf Wildenhues wrote:
> > Any idea what's up with sparse and libtool?
> 
> If --tag=CC is not passed to libtool before /home/hch/bin/cgcc, then it
> tries to infer the set of compiler settings to use (CC, CXX, F77, ...)
> from the compiler name passed.
> 
> I don't know the sources in question, but typically you can append
> --tag=CC to some $(LIBTOOL) variable or set $(LIBTOOLFLAGS) or so.

Thanks, a

LIBTOOL="libtool --tag=CC" CC=~/bin/cgcc ./configure

does it for me.  So I guess the problem is with libtool and it needs
to be taught about cgcc.
