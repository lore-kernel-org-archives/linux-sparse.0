From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: sparse (cgcc) vs lintool
Date: Fri, 6 Jun 2008 15:21:23 +0200
Message-ID: <20080606132123.GF600@ins.uni-bonn.de>
References: <20080606123434.GA23323@lst.de> <20080606124955.GE600@ins.uni-bonn.de> <20080606130756.GA24879@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:59628 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbYFFNV0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jun 2008 09:21:26 -0400
Content-Disposition: inline
In-Reply-To: <20080606130756.GA24879@lst.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-sparse@vger.kernel.org

* Christoph Hellwig wrote on Fri, Jun 06, 2008 at 03:07:56PM CEST:
> 
> LIBTOOL="libtool --tag=CC" CC=~/bin/cgcc ./configure
> 
> does it for me.  So I guess the problem is with libtool and it needs
> to be taught about cgcc.

Well, thing is, the typical way things work is that a libtool script is
generated as part of the configure process, and it sets things for the
$CC, $CXX, etc. used for that configure.  With this package, however,
/usr/bin/libtool is used, and that typically has been configured only
for /usr/bin/gcc etc.

I suppose a distro could add a section for cgcc, yes, or make it assume
--tag=CC for 'cgcc'.  But really passing --tag=CC is the sane thing to
do: the package knows that your code is C code, whereas libtool
inferring it from the command line is error-prone (which is why the tag
check was made stricter in the first place).

Cheers,
Ralf
