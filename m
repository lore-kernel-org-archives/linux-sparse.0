From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Feature request - allow boolean operations of undefined cpp
 symbols
Date: Fri, 2 Feb 2007 10:25:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702021021570.15057@woody.linux-foundation.org>
References: <1170437836.2272.22.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:33994 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946016AbXBBSZ2 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 13:25:28 -0500
In-Reply-To: <1170437836.2272.22.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org



On Fri, 2 Feb 2007, Pavel Roskin wrote:
> 
> I think sparse should distinguish between safe and unsafe preprocessor
> operations on undefined symbols.

It does.

Try this:

	#define NECESSARY 1

	#if NECESSARY || UNNECESSARY
	#endif

and notice how sparse does NOT warn about UNNECESSARY not being defined. 
Because it doesn't matter.

> For instance, "#if SYMBOL" has a very specific meaning

No.

	#if SYMBOL

has a very specific *problem* - it very possibly is a typo.

So this is a warning I absolutely *want* for the kernel. If some other 
projects don't want it, fine, but it should be on by default as a warnign 
for potentially dangerous use of preprocessor symbols.

		Linus
