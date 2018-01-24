From: Randy Dunlap <rdunlap@infradead.org>
Subject: should we document more command line options
Date: Wed, 24 Jan 2018 11:47:21 -0800
Message-ID: <23350ab8-06a9-5b09-2409-358d33219679@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:45275 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbeAXTrW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 24 Jan 2018 14:47:22 -0500
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.site)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1eeR10-0007QP-El
        for linux-sparse@vger.kernel.org; Wed, 24 Jan 2018 19:47:22 +0000
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

I suppose that we could just add something in the general DESCRIPTION paragraph
like:

  Besides the options listed below, sparse also accepts many C compiler command
  line options.

but that's not very helpful (at least to me).  For my use, I made a short text
file of other (not documented in sparse.1) command line options.  Should these
be added to sparse.1 or elsewhere or not at all?  (Of course, some of these
could be incorrect. :)

thanks,
-- 
~Randy

==========
sparse additional command-line options
(as of 2018.0123)

-ansi			set C89 standard

-Dsymbol[=value]	define a symbol plus an optional value for it

-dD			dump macro definitions

-E			preprocess only

-G[ ][0]		ignored

-I			-I- == #split_include
-Ipath			#add_include "path/"
-I path

-include filename
-imacros filename
-isystem filename	#add_isystem "path/"
-idirafter path		#add_dirafter "path/"

-MF arg			ignored
-MQ arg			ignored
-MT arg			ignored

-m64			set ARCH_LP64
-m32			set ARCH_LP32
-msize-llp64		set ARCH_LLP64
-msize-long		set msize_long
-mbig-endian		set big_endian
-mlittle-endian		clear big_endian

-nostdinc		#nostdinc

-o[ ]filename		output filename; ignored
-O{0..9,s}		set optimize level

-std=standard		c89 or iso9899:1990 == C89
			iso9899:199409 == C94
			c99 or c9x or iso9899:1999 or iso9899:199x == C99
			gnu89 == GNU89
			gnu99 or gnu9X == GNU99
			c11 or c1x or iso9899:2011 == C11
			gnu11 == GNU11

-U symbol		#undef symbol

-v[ ]entry		debug entry
-v[ ]dead		debug dead
-v[v...]		increment verbose level

--param[= ][value]	ignored

--version		print sparse version

#####

