From: Derek M Jones <derek@knosof.co.uk>
Subject: Re: [patch 5/9] x86_64: arch_pick_mmap_layout() fixlet
Date: Fri, 06 Jul 2007 19:40:04 +0100
Message-ID: <468E8C84.1020508@knosof.co.uk>
References: <200707060939.l669drk2019988@imap1.linux-foundation.org> <alpine.LFD.0.98.0707061010060.21374@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:25563 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758033AbXGFSkJ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 14:40:09 -0400
In-Reply-To: <alpine.LFD.0.98.0707061010060.21374@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: akpm@linux-foundation.org, Josh Triplett <josh@freedesktop.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org, adobriyan@sw.ru, ak@suse.de

Linus,

> Returning a void-valued expression in a void-valued function is 
> proper C99 (and gcc has allowed it for longer). And it often makes for 

No such change was made in C99.
Sentence 1785 http://c0x.coding-guidelines.com/6.8.6.4.html

I don't recall seeing a proposal for this in C9X.
At the last WG14 meeting the gates were opened for C1X proposals.
Perhaps somebody should propose this change.  As you say there
is prior art in gcc.

-- 
Derek M. Jones                              tel: +44 (0) 1252 520 667
Knowledge Software Ltd                      mailto:derek@knosof.co.uk
Applications Standards Conformance Testing    http://www.knosof.co.uk
