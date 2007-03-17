From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: constness bug in include/linux/compiler.h
Date: Fri, 16 Mar 2007 19:30:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703161930260.3910@woody.linux-foundation.org>
References: <ee9e417a0703131523x2cc701f7l7938624175bf1fe0@mail.gmail.com>
 <45F8206E.8030706@freedesktop.org> <ee9e417a0703141210n7d8e8834j56c17b69ce68ff2c@mail.gmail.com>
 <45FAE16A.3080601@freedesktop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:47594 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753690AbXCQCbR (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 16 Mar 2007 22:31:17 -0400
In-Reply-To: <45FAE16A.3080601@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Russ Cox <rsc@swtch.com>, linux-sparse@vger.kernel.org, Tom Bergan <tbergan@ucla.edu>



On Fri, 16 Mar 2007, Josh Triplett wrote:
> 
> Hmmm, odd.  After a few iterations, I managed to discover that Sparse will
> warn if you attempt to convert a const int * to an int *, but not if you
> attempt to convert a const void * to a void *.  This seems like a bug to me.

Yeah, I think we allow *any* conversion to "void *". We probably should 
still check const/volatile.

		Linus
