From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: declaration specifiers wooziness
Date: Wed, 27 Jun 2007 16:41:52 +0100
Message-ID: <20070627154152.GW21478@ftp.linux.org.uk>
References: <20070627103320.GA11047@localhost.sw.ru> <1182956472.8970.35.camel@josh-work.beaverton.ibm.com> <46827F4D.7010305@knosof.co.uk> <1182958775.8970.56.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:46704 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212AbXF0PmS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 11:42:18 -0400
Content-Disposition: inline
In-Reply-To: <1182958775.8970.56.camel@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Derek M Jones <derek@knosof.co.uk>, Alexey Dobriyan <adobriyan@sw.ru>, linux-sparse@vger.kernel.org, adobriyan@gmail.com

On Wed, Jun 27, 2007 at 08:39:35AM -0700, Josh Triplett wrote:
> On Wed, 2007-06-27 at 16:16 +0100, Derek M Jones wrote:
> > Alex, Josh,
> > 
> > > On Wed, 2007-06-27 at 14:33 +0400, Alexey Dobriyan wrote:
> > >> sparse silently accepts some peculiar combinations of declaration
> > >> specifiers:
> > 
> > These are all permitted by the syntax of C.
> > 
> > 6.7 Declarations, the init-declarator-list is optional.
> 
> Huh; interesting.  That explains "int volatile;" as well; it doesn't
> parse as an attempt to declare an integer named volatile, but as a
> declaration with no variable.
 
It is optional for structs, unions and enums.

> > >> "typedef extern;" passes.
> > ...
> > >> Not sure how many different bugs there are here, though...
> > 
> > Sparse might flag the usage as suspicious, but it is not a bug.
> 
> Probably not worth the trouble of flagging.

... only because any compiler is going to throw up on it anyway.
