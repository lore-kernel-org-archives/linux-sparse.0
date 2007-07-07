From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Fri, 06 Jul 2007 19:55:03 -0700
Message-ID: <1183776903.2613.197.camel@josh-work.beaverton.ibm.com>
References: <20070705093528.GK21478@ftp.linux.org.uk>
	 <468D1003.1050901@freedesktop.org>
	 <20070705164334.GM21478@ftp.linux.org.uk>
	 <1183661456.2604.43.camel@josh-work.beaverton.ibm.com>
	 <20070706074803.GV21478@ftp.linux.org.uk>
	 <468DFE5A.8080602@freedesktop.org>
	 <20070706155245.GX21478@ftp.linux.org.uk>
	 <1183750167.2613.36.camel@josh-work.beaverton.ibm.com>
	 <20070707021152.GA21668@ftp.linux.org.uk>
	 <20070707023057.GB21668@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:53998 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbXGGCyz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 6 Jul 2007 22:54:55 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l672nZwM017742
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 22:49:35 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id l672stQP216566
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 20:54:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l672ssZ6003174
	for <linux-sparse@vger.kernel.org>; Fri, 6 Jul 2007 20:54:54 -0600
In-Reply-To: <20070707023057.GB21668@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Sat, 2007-07-07 at 03:30 +0100, Al Viro wrote:
> On Sat, Jul 07, 2007 at 03:11:52AM +0100, Al Viro wrote:
> > Still not expressive enough...  Consider e.g.
> > 
> > struct foo *lookup_foo(char *s); // lookup by name, return NULL if failed
> > 				 // or pointer to struct foo with ->mutex
> > 				 // held.  Caller should unlock.
> > 
> > It's legitimate, not particulary rare and AFAICS can't be expressed.
> 
> Another fun problem: consider a structure with pair of methods - ->start()
> and ->stop().  The only locking requirement is that calls are inverse wrt
> locking (i.e. foo->start();foo->stop(); leaves the locking state unchanged).
> Different instances may deal with different locks, different _kinds_ of
> locks or no locks at all.  How do you annotate ->start() and ->stop()?
>
> We have just such a beast in the kernel - seq_operations (see fs/seq_file.c
> for code that calls these methods and grep for seq_operations to see users).

Yeah, I've used seq_file.  I'd suggest treating this as two separate
problems:
     1. How do you express the semantic of function pointers that
        represent a paired context in a seq_file?  For this case, I
        suggest just saying that start and stop acquire and release the
        seq_operations structure itself, or some similar dummy context
        specific to the instance of the structure.  Any caller that
        calls the function pointers in a seq_operations struct would
        then need to properly pair them.  If you wrote a function that
        took a seq_operations and didn't properly manage the context
        with paired calls, Sparse would warn about it, just as if the
        contexts applied to local function pointers or pointers from any
        other struct.
     2. Does Sparse need to enforce any requirement that the functions
        you assign to the function pointers actually acquire and release
        some context?  If so, you'd have to do some kind of unification.
        However, I don't think Sparse needs to enforce that requirement.
        Either your particular seq_operations need pairing for some
        context reason, in which case you can specify a particular
        context on them, or they don't need pairing for some reason, in
        which case you don't need to specify a context on them.
        Meanwhile, any actual callers of those functions using the
        function pointers will get warnings as appropriate based on the
        solution to problem 1.

- Josh Triplett
