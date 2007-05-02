From: Andi Kleen <andi@firstfloor.org>
Subject: Re: sparse -Wptr-subtraction-blows: still needed?
Date: 02 May 2007 15:03:59 +0200
Message-ID: <p73abwnxtq8.fsf@bingen.suse.de>
References: <4637AC3D.6000008@freedesktop.org>
	<alpine.LFD.0.98.0705011442320.3808@woody.linux-foundation.org>
	<20070502024242.GC6935@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46791 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993052AbXEBMGd (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2007 08:06:33 -0400
In-Reply-To: <20070502024242.GC6935@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>

Dave Jones <davej@redhat.com> writes:
> 
> #define __page_to_pfn(page)     ((unsigned long)((page) - mem_map) + \
>                                  ARCH_PFN_OFFSET)
> 
> looks like the other two variants of __page_to_pfn also use similar arithmatic.

No way around this. The only way to turn a page into a pfn is to do 
a constant division.  Should be fairly cheap here though.

-Andi (who thinks the sparse warning is dumb; better to look at oprofiles
of hot paths)
