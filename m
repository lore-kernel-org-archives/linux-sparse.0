From: Randy Dunlap <rdunlap@infradead.org>
Subject: warning: division by zero
Date: Tue, 13 Feb 2018 16:26:04 -0800
Message-ID: <8708546d-78da-622d-bc26-d2a0cf40cda4@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:36064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966222AbeBNA0F (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 19:26:05 -0500
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.89 #1 (Red Hat Linux))
        id 1elkth-0004bg-Cg
        for linux-sparse@vger.kernel.org; Wed, 14 Feb 2018 00:26:05 +0000
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

In Linux kernel, we get that message 2 times (in x86_64 allmodconfig):

../fs/exofs/ore_raid.c:95:64: warning: division by zero
../fs/exofs/ore_raid.c:116:36: warning: division by zero

when dividing by variable sizeof_a1pa, where that is:
	const unsigned sizeof__a1pa = sizeof(_aab->__a1pa[0]);

which is in this struct:
	struct _alloc_all_bytes {
		struct __alloc_stripe_pages_2d {
			struct __stripe_pages_2d sp2d;
			struct __1_page_stripe _1p_stripes[pages_in_unit];
		} __asp2d;
		struct __alloc_1p_arrays {
			struct page *pages[group_width];
			struct page *scribble[group_width];
			char page_is_read[data_devs];
		} __a1pa[pages_in_unit];
	} *_aab;

where 'pages_in_unit' is a function parameter. So, yes, it could have a value
of zero.

Is the warning message considered correct or useful as is?  If so, OK, no problem.
Although I would rather see something more like:
	warning: variable length array on stack

thanks,
-- 
~Randy
