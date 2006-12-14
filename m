From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][RFC] Re: sparse handles int64_t type wrong
Date: Wed, 13 Dec 2006 16:57:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612131657300.5718@woody.osdl.org>
References: <1165952070.17896.7.camel@chaos.malinovka7.net>
 <Pine.LNX.4.64.0612121143280.3535@woody.osdl.org>
 <Pine.LNX.4.64.0612121155450.3535@woody.osdl.org> <20061213051827.GA13748@chrisli.org>
 <Pine.LNX.4.64.0612130733190.3418@woody.osdl.org> <20061214001355.GA20494@chrisli.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:35086 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbWLNA6H (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Dec 2006 19:58:07 -0500
In-Reply-To: <20061214001355.GA20494@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Yura Pakhuchiy <pakhuchiy@gmail.com>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org



On Wed, 13 Dec 2006, Christopher Li wrote:
> 
> Do you mean some thing like this?  I might leave some abstract ctype
> in the tree, it is hard to find all all the user of ctype before
> it get finalized.  It seems work with the test case in my hand.

Yes, this is I think the proper way to do it. 

		Linus
