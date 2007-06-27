From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: declaration specifiers wooziness
Date: Wed, 27 Jun 2007 16:39:27 +0100
Message-ID: <20070627153927.GV21478@ftp.linux.org.uk>
References: <20070627103320.GA11047@localhost.sw.ru> <1182956472.8970.35.camel@josh-work.beaverton.ibm.com> <46827F4D.7010305@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:46499 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754211AbXF0PkD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 11:40:03 -0400
Content-Disposition: inline
In-Reply-To: <46827F4D.7010305@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Josh Triplett <josht@linux.vnet.ibm.com>, Alexey Dobriyan <adobriyan@sw.ru>, linux-sparse@vger.kernel.org, adobriyan@gmail.com

On Wed, Jun 27, 2007 at 04:16:29PM +0100, Derek M Jones wrote:

> These are all permitted by the syntax of C.
> 
> 6.7 Declarations, the init-declarator-list is optional.

See 6.7[2]; the things like
	int ;
violate the constraint.
 
> >>"typedef extern;" passes.
> ...
> >>Not sure how many different bugs there are here, though...
> 
> Sparse might flag the usage as suspicious, but it is not a bug.

See 6.7.1[2]; no more than one storage class specifier in a declaration.

> >Several more:
> 
> The syntax permits:
> 
> signed unsigned short long double int;

See 6.7.2[2]; the set you've given is not in the list given there.
