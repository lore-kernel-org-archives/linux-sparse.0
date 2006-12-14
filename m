From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH][RFC] Re: sparse handles int64_t type wrong
Date: Wed, 13 Dec 2006 20:21:04 -0800
Message-ID: <20061214042104.GB20494@chrisli.org>
References: <1165952070.17896.7.camel@chaos.malinovka7.net> <Pine.LNX.4.64.0612121143280.3535@woody.osdl.org> <Pine.LNX.4.64.0612121155450.3535@woody.osdl.org> <20061213051827.GA13748@chrisli.org> <Pine.LNX.4.64.0612130733190.3418@woody.osdl.org> <20061214001355.GA20494@chrisli.org> <Pine.LNX.4.64.0612131657300.5718@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc11.comcast.net ([204.127.225.91]:54502 "EHLO
	alnrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbWLNEmO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Dec 2006 23:42:14 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612131657300.5718@woody.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Yura Pakhuchiy <pakhuchiy@gmail.com>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

Never mind my previous patch. It is too simple and wrong.
It can't really tell the C type is abstract or not because
int_ctype has base_type to int_type as well. It ends up applying
the modifiers to int_ctype.

You are right about it is very nasty to delay the finalization
of the C type. Back to drawing board.

Chris

On Wed, Dec 13, 2006 at 04:57:59PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 13 Dec 2006, Christopher Li wrote:
> > 
> > Do you mean some thing like this?  I might leave some abstract ctype
> > in the tree, it is hard to find all all the user of ctype before
> > it get finalized.  It seems work with the test case in my hand.
> 
> Yes, this is I think the proper way to do it. 
> 
> 		Linus
