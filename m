From: Pavel Roskin <proski@gnu.org>
Subject: Re: sparse (cgcc) vs lintool
Date: Fri, 06 Jun 2008 15:39:16 -0400
Message-ID: <1212781156.18886.7.camel@dv>
References: <20080606123434.GA23323@lst.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:54396 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754941AbYFFTjS (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jun 2008 15:39:18 -0400
In-Reply-To: <20080606123434.GA23323@lst.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-sparse@vger.kernel.org

On Fri, 2008-06-06 at 14:34 +0200, Christoph Hellwig wrote:
> When trying to compile xfsprogs (from oss.sgi.com/projects/xfs)
> 
> hch@bigmac:~/work/xfs-cmds/xfsprogs$ CC=~/bin/cgcc ./configure
> hch@bigmac:~/work/xfs-cmds/xfsprogs$ make
> 
> I get this error:
> 
> === libxfs ===
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

It can be reproduced without sparse:

[proski@dv xfsprogs-2.9.8]$ ./configure CC=/usr/bin/gcc
checking for gcc... /usr/bin/gcc
checking for C compiler default output file name... a.out
checking whether the C compiler works... yes
checking whether we are cross compiling... no
...
checking size of char *... 8
configure: creating ./config.status
config.status: creating include/builddefs
config.status: creating include/platform_defs.h
config.status: include/platform_defs.h is unchanged
[proski@dv xfsprogs-2.9.8]$ make
=== include ===
rm -f xfs disk
ln -s . xfs
ln -s . disk
=== libxfs ===
/usr/bin/libtool --mode=compile /usr/bin/gcc -I. -g -O2 -DNDEBUG
-DVERSION=\"2.9.8\" -DLOCALEDIR=\"/usr/local/share/locale\" -DPACKAGE=
\"xfsprogs\" -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
-funsigned-char -fno-strict-aliasing -Wall   -c bit.c
libtool: compile: unable to infer tagged configuration
libtool: compile: specify a tag with `--tag'
gmake[1]: *** [bit.lo] Error 1
make: *** [default] Error 2
[proski@dv xfsprogs-2.9.8]$

Besides, replying on user installed libtool is asking for trouble.  The
proper way to use libtool is to include it into the package.

It's recommended to use automake with libtool, but even if they are too
automake-averse, there are still some rules how to use libtool properly.

-- 
Regards,
Pavel Roskin
