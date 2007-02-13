From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Another sparse warning...
Date: Mon, 12 Feb 2007 19:48:18 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702121947240.8424@woody.linux-foundation.org>
References: <4975FCBA-D3D4-4DF2-AC20-C11A5F97DE51@cam.ac.uk>
 <Pine.LNX.4.64.0702120742030.8424@woody.linux-foundation.org>
 <20070213020054.GB2922@chrisli.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:53163 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030626AbXBMDsa (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 22:48:30 -0500
In-Reply-To: <20070213020054.GB2922@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-sparse@vger.kernel.org



On Mon, 12 Feb 2007, Christopher Li wrote:
>
> >  - it shows the *programmer* that the function is doing somethign 
> >    "strange" (not really strange, but still: it's basically a fairly 
> >    readable way that it's doing locking in a weird way).
> 
> Should the function declare in the header file has that as well?

Yes.

> When call one of those functions, it can know that function will change
> context.  That might be a way to solve the problem that some of the
> spinlock function is not a inline function at all.

I thought we did that already. I'm fairly sure I had this working at some 
point - exactly by having the calls just add up the (known) lock/unlock 
offsets.

		Linus
