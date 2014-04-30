From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Warn for extern prototypes
Date: Wed, 30 Apr 2014 22:48:16 +0200
Message-ID: <20140430204816.GA14951@ravnborg.org>
References: <20140430200730.GA11100@ravnborg.org>
 <20140430203056.GJ26890@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk4.altibox.net ([109.247.116.15]:41446 "EHLO
	asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752334AbaD3UsU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Apr 2014 16:48:20 -0400
Content-Disposition: inline
In-Reply-To: <20140430203056.GJ26890@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: sparse <linux-sparse@vger.kernel.org>

On Wed, Apr 30, 2014 at 11:30:57PM +0300, Dan Carpenter wrote:
> On Wed, Apr 30, 2014 at 10:07:30PM +0200, Sam Ravnborg wrote:
> > The rationale behind this is that at least in some areas of the kernel,
> > the use of "extern" for prototypes are no longer accepted.
> > A sparse warnings would be good to tell me all the cases I missed
> > in the conversion.
> 
> Doesn't checkpatch.pl already check for this?
checkpatch --strict -f foo.h will include this check.

But then there are so much other noise...

It is much simpler to do:

   make C=2 arch/sparc/

and the process the sparse warnings.

	Sam

