From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: pointer arithmetics and casts
Date: Fri, 25 May 2007 23:00:51 +0100
Message-ID: <20070525220051.GO4095@ftp.linux.org.uk>
References: <20070525212300.GL4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35395 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757365AbXEYWAw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 May 2007 18:00:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1Hrhq7-0003cU-GD
	for linux-sparse@vger.kernel.org; Fri, 25 May 2007 23:00:51 +0100
Content-Disposition: inline
In-Reply-To: <20070525212300.GL4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

On Fri, May 25, 2007 at 10:23:00PM +0100, Al Viro wrote:
> 	BINOP[+]
> 		<tree for p>
> 		BINOP[*]
> 			IMPLICIEDT_CAST[ptrdiff_t]
> 				<tree for i>
> 			VAL[sizeof(*p)]
> 
> But that means a fsckload of extra nodes allocated on pretty much any
> program - use of arrays is not rare and indices tend to be int, so we
> hit an extra allocated node on each such place.

Argh...  Question: how much do we care if we see BINOP[+] with 64bit
type as result and 32bit type in one of the arguments?  That's what
we get when we have
	char *p;
	int i;

	p + i

with -m64.  IOW, how much does it violate the assumptions outside of
frontend?  We do not allocate any new nodes if sizeof(*p) is 1...
