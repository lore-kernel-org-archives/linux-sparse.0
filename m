From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 5/9] x86_64: arch_pick_mmap_layout() fixlet
Date: Fri, 6 Jul 2007 11:48:31 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707061145440.8278@woody.linux-foundation.org>
References: <200707060939.l669drk2019988@imap1.linux-foundation.org>
 <alpine.LFD.0.98.0707061010060.21374@woody.linux-foundation.org>
 <468E8C84.1020508@knosof.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45750 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757034AbXGFStr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 14:49:47 -0400
In-Reply-To: <468E8C84.1020508@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: akpm@linux-foundation.org, Josh Triplett <josh@freedesktop.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org, adobriyan@sw.ru, ak@suse.de



On Fri, 6 Jul 2007, Derek M Jones wrote:
> 
> > Returning a void-valued expression in a void-valued function is proper C99
> > (and gcc has allowed it for longer). And it often makes for 
> 
> No such change was made in C99.
> Sentence 1785 http://c0x.coding-guidelines.com/6.8.6.4.html

Oops. Ok, my bad. It's apparently just a long-time gcc feature.

It's one that I was initially surprised by, but it's certainly a sensible 
one from a type standpoint, and a lot better thought out than some gcc 
extensions ;)

So I do actually like it. It's much nicer exactly for code like

	if (somecase)
		return that_case_handler();

where the type of the function to handle the case matches the type of the 
calling function (regardless of whether that type is void or not, but 
void obviously is a special case).

		Linus
