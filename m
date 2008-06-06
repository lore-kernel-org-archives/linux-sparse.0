From: Christoph Hellwig <hch@lst.de>
Subject: Re: sparse (cgcc) vs lintool
Date: Fri, 6 Jun 2008 15:25:57 +0200
Message-ID: <20080606132557.GA27189@lst.de>
References: <20080606123434.GA23323@lst.de> <20080606124955.GE600@ins.uni-bonn.de> <20080606130756.GA24879@lst.de> <20080606132123.GF600@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:38304 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753973AbYFFN0G (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jun 2008 09:26:06 -0400
Content-Disposition: inline
In-Reply-To: <20080606132123.GF600@ins.uni-bonn.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, linux-sparse@vger.kernel.org

On Fri, Jun 06, 2008 at 03:21:23PM +0200, Ralf Wildenhues wrote:
> Well, thing is, the typical way things work is that a libtool script is
> generated as part of the configure process, and it sets things for the
> $CC, $CXX, etc. used for that configure.  With this package, however,
> /usr/bin/libtool is used, and that typically has been configured only
> for /usr/bin/gcc etc.
> 
> I suppose a distro could add a section for cgcc, yes, or make it assume
> --tag=CC for 'cgcc'.  But really passing --tag=CC is the sane thing to
> do: the package knows that your code is C code, whereas libtool
> inferring it from the command line is error-prone (which is why the tag
> check was made stricter in the first place).

Thanks, that explanation makes a lot of sense.  I'll see if I can
fix up the xfsprogs buildsystems, it's a little odd anyway.

