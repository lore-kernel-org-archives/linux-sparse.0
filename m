From: Christopher Li <sparse@chrisli.org>
Subject: Re: How do I get the latest sparse?
Date: Wed, 17 Jan 2007 12:03:57 -0800
Message-ID: <20070117200357.GB2077@chrisli.org>
References: <AKEOJDDJLNPHDAKOMMBHCEGHCPAA.mshah@teja.com> <20070116001735.GA12002@chrisli.org> <45ACC3DD.6050702@freedesktop.org> <20070117014923.GA641@chrisli.org> <45ADB71D.3080502@freedesktop.org> <20070117190520.GA30108@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc11.comcast.net ([204.127.200.81]:57514 "EHLO
	sccrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932749AbXAQU1R (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Jan 2007 15:27:17 -0500
Content-Disposition: inline
In-Reply-To: <20070117190520.GA30108@uranus.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Josh Triplett <josh@freedesktop.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Yes, sparse is a memory hog if you keep adding files to it.
It is actually very hard to free the memory used in middle
stage, because they have dependences.

Here is my plan on this:

Save the linearized/AST result as byte code to file. Because
my checking is linearization based. Currently I only include the
information I cared. Most of the expression and statement
is not stored. They turn into linearize code any way.

Process all the byte code result, build a global symbol dictionary
into ident hash table. The implementation part of the symbol, namely
the function body, is dynamically loaded.

When we need some global symbol, the corresponding byte code file can
be load into memory. I don't deal with individual symbol loading because
they have dependence to other symbol in the same file any way. A byte
code file can be removed from the memory as well.

My current hacking shows that the byte code size is about 10x the size
of the .o file. Given that each linearized instruction is 32 bytes, it
is not as bad as it sounds. The total result of a linux kernel will
be a few hundred Mb. It might be possible to fit that all in the machine
I have, keep my finger crossed.

Chris


On Wed, Jan 17, 2007 at 08:05:20PM +0100, Sam Ravnborg wrote:
> 
> I experimented with a patch some time ago that allowed us to run
> sparse on all files in a directory for the kernel.
> But I experienced OOM while checking the XFS sources.
> Reply on the matter from Linus was at that time something in the line
> of that sparse did not do any atemp to free up memory after the early
> parse stage so it is consuming much more memory than needed.
> 
> This was almost one year ago so things may have changed - but at least
> something to keep an eye on.
> 
> XFS was just triggering this - it surely was due to codesize alone so
> any other big directory could have been the trigger too. It is not XFS specific.
> 
> 	Sam
