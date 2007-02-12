From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bogus sparse warning?
Date: Mon, 12 Feb 2007 11:53:35 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702121147170.8424@woody.linux-foundation.org>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk>
 <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org>
 <20070212191434.GA1041@chrisli.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:40179 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965355AbXBLTxq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 14:53:46 -0500
In-Reply-To: <20070212191434.GA1041@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@freedesktop.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-sparse@vger.kernel.org



On Mon, 12 Feb 2007, Christopher Li wrote:
>
> On Mon, Feb 12, 2007 at 10:28:19AM -0800, Linus Torvalds wrote:
> >
> > (It is perfectly proper to have a typedef that is actually of a function 
> > type, so this looks like a sparse bug regardless, it looks just as if we 
> > don't turn a function type into a function pointer type when we see it as 
> > an argument in the declaration).
> 
> Yes, we does, in examine_fn_arguments(). But not correctly inherent the attribute bits.

Ahh. 

> I think this patch should fix it, I haven't try it myself on this bug yet.
> It works on a different test case "function vs function ptr".
> It has been posted to the list before. It is in my series as well.

This looks good. Ack.  Josh?

The only thing that I reacted to is that maybe we should change the

	s->ctype.modifiers = 0;

a few lines down into a

	s->ctype.modifiers &= ~MOD_PTRINHERIT;

or something? Although the normal "create_pointer()" function just leaves 
it entirely alone. So I don't know what the correct thing to do is. I 
wonder why I did that in the first place (that code is _old_).

		Linus
