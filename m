From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: warning: division by zero
Date: Wed, 14 Feb 2018 01:39:09 +0100
Message-ID: <20180214003907.2ym6hgjp3vzptw53@ltop.local>
References: <8708546d-78da-622d-bc26-d2a0cf40cda4@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:51023 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966207AbeBNAjN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 13 Feb 2018 19:39:13 -0500
Received: by mail-wm0-f50.google.com with SMTP id k87so1510435wmi.0
        for <linux-sparse@vger.kernel.org>; Tue, 13 Feb 2018 16:39:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8708546d-78da-622d-bc26-d2a0cf40cda4@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Feb 13, 2018 at 04:26:04PM -0800, Randy Dunlap wrote:
> In Linux kernel, we get that message 2 times (in x86_64 allmodconfig):
> 
> ../fs/exofs/ore_raid.c:95:64: warning: division by zero
> ../fs/exofs/ore_raid.c:116:36: warning: division by zero
> 
> when dividing by variable sizeof_a1pa, where that is:
> 	const unsigned sizeof__a1pa = sizeof(_aab->__a1pa[0]);
> 
> which is in this struct:
> 	struct _alloc_all_bytes {
> 		struct __alloc_stripe_pages_2d {
> 			struct __stripe_pages_2d sp2d;
> 			struct __1_page_stripe _1p_stripes[pages_in_unit];
> 		} __asp2d;
> 		struct __alloc_1p_arrays {
> 			struct page *pages[group_width];
> 			struct page *scribble[group_width];
> 			char page_is_read[data_devs];
> 		} __a1pa[pages_in_unit];
> 	} *_aab;
> 
> where 'pages_in_unit' is a function parameter. So, yes, it could have a value
> of zero.
> 
> Is the warning message considered correct or useful as is?  If so, OK, no problem.

It's a division by zero, not because the parameter can be zero
but because currently sparse doesn't handle the size of VLAs which
are always considered as zero-sized.
So, no I don't consider this warning as correct and even less useful.

I have a WIP series to handle VLA's sizeof, if there is some interests
I can boost a bit its priority.

> Although I would rather see something more like:
> 	warning: variable length array on stack

That's of course something different that could indeed be quite useful.

-- Luc
