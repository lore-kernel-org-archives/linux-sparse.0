From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Re: Sparse just seg faulted on me!
Date: Wed, 14 Feb 2007 12:48:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702141242460.20368@woody.linux-foundation.org>
References: <9C17AC42-0C51-44D9-B126-1FB781DE0ECA@cam.ac.uk>
 <20070214172905.GA17959@chrisli.org> <Pine.LNX.4.64.0702141022570.3604@woody.linux-foundation.org>
 <20070214195447.GA18753@chrisli.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:44901 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbXBNUsZ (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Feb 2007 15:48:25 -0500
In-Reply-To: <20070214195447.GA18753@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Sparse <linux-sparse@vger.kernel.org>, Josh Triplett <josh@freedesktop.org>



On Wed, 14 Feb 2007, Christopher Li wrote:
> > 
> > It's nice if a NULL type means "type has not been evaluated yet", and then 
> > using "&bad_ctype" to mean "type evaluated to crap".
> 
> Good idea. Some of the code already doing that.

Yeah. I started out leaving bad stuff as NULL originally, but over time, 
as I noticed SIGSEGV's, I mostly changed the ones that I ended up having 
trigger to &bad_ctype.

Otherwise we either need to test for NULL all the time (and especially 
since NULL under _some_ circumstances is ok and means "not evaluated yet", 
that can be confusing), and having to pass up errors higher and higher up.

I at some point considered having a "silent bad_ctype" - a way of saying 
"ok, the type here is bad, but I already warned about the thing that 
_caused_ it to be bad, so don't warn any more about any type clashes".

But I don't think I ever did that, so now you often get two different 
warnings (first a warning about "no such symbol" or something and then a 
warning about "bad types to binary operation" or similar). Anyway, if 
somebody ever gets irritated about the duplicate warnings, I thought I'd 
mention that as a potential way to perhaps avoid havign things that 
already caused errors cause even more verbose errors up the chain..

		Linus
