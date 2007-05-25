From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: comparison of safe pointers
Date: Fri, 25 May 2007 16:44:37 +0100
Message-ID: <20070525154437.GJ4095@ftp.linux.org.uk>
References: <20070525130749.GI4095@ftp.linux.org.uk> <alpine.LFD.0.98.0705250827460.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:43404 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbXEYPoi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 May 2007 11:44:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705250827460.26602@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org

On Fri, May 25, 2007 at 08:29:11AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 25 May 2007, Al Viro wrote:
> > 
> > What did you want that check in evaluate_compare() to catch?  Is that
> > about warning on explicit comparison with NULL?
> 
> Yes. It was explicitly meant to be a "anybody who tests this pointer 
> missed the 'safe' part of it".
> 
> But I never used it, so it was really meant as a concept thing, and I 
> don't think it's wrong to test against non-null.

OK...  Pointer comparisons care about null pointer constants anyway
(BTW, ordered comparison with NULL should give a warning - it's not
a valid C and it makes no sense whatsoever even as an extension),
so that's not a problem.

Other places that care are ?:, simple assignment when target is a pointer,
passing arguments to function with prototype when parameter type is a pointer
(same logics as with assignment) and cast adding address space (valid for
NULL, not valid for random void *).

AFAICS, that covers everything; definitely all contexts where null pointer
constants are recognized by C and I think that it covers all places where
they matter for sparse extensions...
