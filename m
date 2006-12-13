From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][RFC] Re: sparse handles int64_t type wrong
Date: Wed, 13 Dec 2006 07:36:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612130733190.3418@woody.osdl.org>
References: <1165952070.17896.7.camel@chaos.malinovka7.net>
 <Pine.LNX.4.64.0612121143280.3535@woody.osdl.org>
 <Pine.LNX.4.64.0612121155450.3535@woody.osdl.org> <20061213051827.GA13748@chrisli.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.25]:40459 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964995AbWLMPgk (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Dec 2006 10:36:40 -0500
In-Reply-To: <20061213051827.GA13748@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Yura Pakhuchiy <pakhuchiy@gmail.com>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org


On Tue, 12 Dec 2006, Christopher Li wrote:
>
> I took a stab at it.  It seems that direct_declarator() does handle
> attributes, but it does not change the ctype to the declarator.
> It is kind of awkward that the type is already build when it hit
> the attribute in the end. It need to go back to overwrite
> the already parsed type.

Yes. I actually tried to fix this by moving the type "finalization" part 
later, but it got really really nasty.

> I have this patch seems make the test case happy. I am not sure
> this is correct or not.

It looks correct to me, although not wonderfully pretty. But it's simpler 
than the "don't do the int/fp type finalization until later" that I 
couldn't even get to work (not that I spent a lot of time on it, but 
still)

		Linus
