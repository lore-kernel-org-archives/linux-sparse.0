From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [patchset] rewrite of initializer handling
Date: Mon, 18 Jun 2007 23:43:55 +0100
Message-ID: <20070618224355.GK21478@ftp.linux.org.uk>
References: <20070618101929.GE21478@ftp.linux.org.uk> <4676CC9C.3050903@freedesktop.org> <20070618191653.GG21478@ftp.linux.org.uk> <4676FD25.9030504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:52474 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762953AbXFRWn5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Jun 2007 18:43:57 -0400
Content-Disposition: inline
In-Reply-To: <4676FD25.9030504@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

On Mon, Jun 18, 2007 at 11:46:13PM +0200, Michael Stefaniuc wrote:

> > Umm...  I don't think that it's related.  count_array_initializer() would
> > work just fine for that one, since the straightforward list element counting
> > would work as-is.
> Right, it doesn't fixes this error. Actually the output of
> make clean; CHECK='sparse -Wno-transparent-union -Wno-old-initializer
> -Wno-non-pointer-null' make CC=cgcc > build.out 2>&1
> is identical bit by bit with or without Al's patch series.

Eh...  count_array_initializer() is not even touched in that series anyway.
The question had been how to fix it; Josh asked if fixing it would take
care of your report as well and I said "no".  Patch that followed was
unrelated to count_array_initializer() problems or problems fixed by
patch series that went into the tree.

> Works for Wine and removes most of the "error: cannot size expression"
> errors.

Any regressions?

> The 7 remaining errors are preceded by "error: bad constant
> expression" in the same line. Have to condense those into a test case too.

Probably genuine VLAs...
