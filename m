From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: comparison of safe pointers
Date: Fri, 25 May 2007 08:29:11 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705250827460.26602@woody.linux-foundation.org>
References: <20070525130749.GI4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:41609 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750789AbXEYP34 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 May 2007 11:29:56 -0400
In-Reply-To: <20070525130749.GI4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org



On Fri, 25 May 2007, Al Viro wrote:
> 
> What did you want that check in evaluate_compare() to catch?  Is that
> about warning on explicit comparison with NULL?

Yes. It was explicitly meant to be a "anybody who tests this pointer 
missed the 'safe' part of it".

But I never used it, so it was really meant as a concept thing, and I 
don't think it's wrong to test against non-null.

		Linus
