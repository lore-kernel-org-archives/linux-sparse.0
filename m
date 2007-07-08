From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [RFC] bloody mess with __attribute__() syntax
Date: Sun, 8 Jul 2007 22:52:17 +0100
Message-ID: <20070708215217.GO21668@ftp.linux.org.uk>
References: <468D1003.1050901@freedesktop.org> <20070705164334.GM21478@ftp.linux.org.uk> <1183661456.2604.43.camel@josh-work.beaverton.ibm.com> <20070706074803.GV21478@ftp.linux.org.uk> <468DFE5A.8080602@freedesktop.org> <20070706155245.GX21478@ftp.linux.org.uk> <1183750167.2613.36.camel@josh-work.beaverton.ibm.com> <20070707021152.GA21668@ftp.linux.org.uk> <20070707023057.GB21668@ftp.linux.org.uk> <1183776903.2613.197.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:44714 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757197AbXGHVwT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 8 Jul 2007 17:52:19 -0400
Content-Disposition: inline
In-Reply-To: <1183776903.2613.197.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jul 06, 2007 at 07:55:03PM -0700, Josh Triplett wrote:
>      2. Does Sparse need to enforce any requirement that the functions
>         you assign to the function pointers actually acquire and release
>         some context?  If so, you'd have to do some kind of unification.
>         However, I don't think Sparse needs to enforce that requirement.
>         Either your particular seq_operations need pairing for some
>         context reason, in which case you can specify a particular
>         context on them, or they don't need pairing for some reason, in
>         which case you don't need to specify a context on them.
>         Meanwhile, any actual callers of those functions using the
>         function pointers will get warnings as appropriate based on the
>         solution to problem 1.

That won't work.  You'll have ->show() calling the stuff that assumes
that locks are already grabbed by ->start() => warnings galore.
