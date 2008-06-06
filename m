From: Christoph Hellwig <hch@lst.de>
Subject: sparse (cgcc) vs lintool
Date: Fri, 6 Jun 2008 14:34:34 +0200
Message-ID: <20080606123434.GA23323@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:36587 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753831AbYFFMen (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jun 2008 08:34:43 -0400
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id m56CYYOc023441
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jun 2008 14:34:34 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id m56CYYxW023437
	for linux-sparse@vger.kernel.org; Fri, 6 Jun 2008 14:34:34 +0200
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

When trying to compile xfsprogs (from oss.sgi.com/projects/xfs)

hch@bigmac:~/work/xfs-cmds/xfsprogs$ CC=~/bin/cgcc ./configure
hch@bigmac:~/work/xfs-cmds/xfsprogs$ make

I get this error:

=== libxfs ===
/usr/bin/libtool --mode=compile /home/hch/bin/cgcc -I. -g -O2 -DNDEBUG
-DVERSION=\"2.9.8\" -DLOCALEDIR=\"/usr/local/share/locale\"
-DPACKAGE=\"xfsprogs\" -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
-funsigned-char -fno-strict-aliasing -Wall   -c bit.c
libtool: compile: unable to infer tagged configuration
libtool: compile: specify a tag with `--tag'
make[1]: *** [bit.lo] Error 1
make: *** [default] Error 2

Any idea what's up with sparse and libtool?

