From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/5] keyword driven parsing
Date: Wed, 7 Mar 2007 07:45:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703070742290.5963@woody.linux-foundation.org>
References: <20070307100109.GA10577@chrisli.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:40518 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbXCGPpq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 7 Mar 2007 10:45:46 -0500
In-Reply-To: <20070307100109.GA10577@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@freedesktop.org>



On Wed, 7 Mar 2007, Christopher Li wrote:
>
> Here is an attempt to use keyword driven parsing.

Ack, looks good to me.

> BTW, why asm is a statement not an expression? If it is an
> expression, it seems make sense to merge the volatile to the
> ctype modifiers.

I personally certainly wouldn't mind at all making asm's expressions 
instead. In fact, I think it would potentially be a good idea to make 
*everything* an expression, ie a C statement would be just an expression 
that returns "void".

			Linus
