From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Sat, 7 Jul 2007 03:30:57 +0100
Message-ID: <20070707023057.GB21668@ftp.linux.org.uk>
References: <20070705093528.GK21478@ftp.linux.org.uk> <468D1003.1050901@freedesktop.org> <20070705164334.GM21478@ftp.linux.org.uk> <1183661456.2604.43.camel@josh-work.beaverton.ibm.com> <20070706074803.GV21478@ftp.linux.org.uk> <468DFE5A.8080602@freedesktop.org> <20070706155245.GX21478@ftp.linux.org.uk> <1183750167.2613.36.camel@josh-work.beaverton.ibm.com> <20070707021152.GA21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58471 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636AbXGGCa7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 22:30:59 -0400
Content-Disposition: inline
In-Reply-To: <20070707021152.GA21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, Jul 07, 2007 at 03:11:52AM +0100, Al Viro wrote:
> Still not expressive enough...  Consider e.g.
> 
> struct foo *lookup_foo(char *s); // lookup by name, return NULL if failed
> 				 // or pointer to struct foo with ->mutex
> 				 // held.  Caller should unlock.
> 
> It's legitimate, not particulary rare and AFAICS can't be expressed.

Another fun problem: consider a structure with pair of methods - ->start()
and ->stop().  The only locking requirement is that calls are inverse wrt
locking (i.e. foo->start();foo->stop(); leaves the locking state unchanged).
Different instances may deal with different locks, different _kinds_ of
locks or no locks at all.  How do you annotate ->start() and ->stop()?

We have just such a beast in the kernel - seq_operations (see fs/seq_file.c
for code that calls these methods and grep for seq_operations to see users).
