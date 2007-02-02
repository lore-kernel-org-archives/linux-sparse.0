From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Feature request - allow boolean operations of undefined cpp
 symbols
Date: Fri, 2 Feb 2007 14:45:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702021444480.15057@woody.linux-foundation.org>
References: <1170437836.2272.22.camel@dv> <Pine.LNX.4.64.0702021021570.15057@woody.linux-foundation.org>
 <20070202215603.GA27667@chrisli.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:43485 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946142AbXBBWpR (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 17:45:17 -0500
In-Reply-To: <20070202215603.GA27667@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org



On Fri, 2 Feb 2007, Christopher Li wrote:
> 
> On sparse git tip, or sparse 0.2. Here is what I get:
> 
> ./sparse /tmp/a.c 

Try again, but with "-Wall".

		Linus
