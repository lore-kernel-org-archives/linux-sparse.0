From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: Memory corruption with long filenames
Date: Sun, 25 May 2008 13:21:21 +0200
Message-ID: <20080525112121.GA15577@damson.getinternet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:47274 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbYEYLV1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 25 May 2008 07:21:27 -0400
Received: by nf-out-0910.google.com with SMTP id d3so696605nfc.21
        for <linux-sparse@vger.kernel.org>; Sun, 25 May 2008 04:21:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi,

Running sparse with this single line as the input file:

#include "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

(yes, that's exactly 257 "x"es)

gives me this peculiar message:

crash.c:1:10: error: unable to open 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/usr/lib/gcc/i386-redhat-linux/4.1.2/include/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/'

Running it under valgrind gives a bit more info:

==15582== Source and destination overlap in memcpy(0x80A1BC0, 0x80A1AC0, 257)
==15582==    at 0x4024116: memcpy (mc_replace_strmem.c:116)
==15582==    by 0x8078E07: try_include (pre-process.c:713)
==15582==    by 0x807B6F7: handle_include_path (pre-process.c:732)
==15582==    by 0x807A476: preprocess (pre-process.c:1682)
==15582==    by 0x804EB70: sparse_tokenstream (lib.c:751)
==15582==    by 0x804FC1D: sparse (lib.c:878)
==15582==    by 0x804A613: main (sparse.c:606)

But I don't know how to best fix this, so I'm simply posting the report here.

Thanks :-)


Vegard
