From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: sparse (cgcc) vs lintool
Date: Fri, 6 Jun 2008 14:49:55 +0200
Message-ID: <20080606124955.GE600@ins.uni-bonn.de>
References: <20080606123434.GA23323@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:39405 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbYFFNRY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jun 2008 09:17:24 -0400
Content-Disposition: inline
In-Reply-To: <20080606123434.GA23323@lst.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-sparse@vger.kernel.org

Hello Christoph,

* Christoph Hellwig wrote on Fri, Jun 06, 2008 at 02:34:34PM CEST:
> 
> /usr/bin/libtool --mode=compile /home/hch/bin/cgcc -I. -g -O2 -DNDEBUG
> -DVERSION=\"2.9.8\" -DLOCALEDIR=\"/usr/local/share/locale\"
> -DPACKAGE=\"xfsprogs\" -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
> -funsigned-char -fno-strict-aliasing -Wall   -c bit.c
> libtool: compile: unable to infer tagged configuration
> libtool: compile: specify a tag with `--tag'
> make[1]: *** [bit.lo] Error 1
> make: *** [default] Error 2
> 
> Any idea what's up with sparse and libtool?

If --tag=CC is not passed to libtool before /home/hch/bin/cgcc, then it
tries to infer the set of compiler settings to use (CC, CXX, F77, ...)
from the compiler name passed.

I don't know the sources in question, but typically you can append
--tag=CC to some $(LIBTOOL) variable or set $(LIBTOOLFLAGS) or so.

Hope that helps.

Cheers,
Ralf
