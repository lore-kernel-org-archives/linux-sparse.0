From: Christoph Hellwig <hch@infradead.org>
Subject: unable to open limits.h
Date: Tue, 25 Nov 2008 06:07:03 -0500
Message-ID: <20081125110703.GA23049@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:44560 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbYKYLHE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 25 Nov 2008 06:07:04 -0500
Received: from hch by bombadil.infradead.org with local (Exim 4.68 #1 (Red Hat Linux))
	id 1L4vl1-0002cX-O9
	for linux-sparse@vger.kernel.org; Tue, 25 Nov 2008 11:07:03 +0000
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Ubuntu 8.10 (glibc 2.8.90) I get the following warnings when
compiling any program using limits.h:

/usr/include/limits.h:125:17: error: unable to open 'limits.h'

The easiest testcase is:

cat > test.c  << EOF
#include <limits.h>
EOF
cgcc -c test.c 

