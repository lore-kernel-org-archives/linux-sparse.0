From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Another sparse warning...
Date: Mon, 12 Feb 2007 07:50:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702120742030.8424@woody.linux-foundation.org>
References: <4975FCBA-D3D4-4DF2-AC20-C11A5F97DE51@cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:59138 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933014AbXBLPu3 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 10:50:29 -0500
In-Reply-To: <4975FCBA-D3D4-4DF2-AC20-C11A5F97DE51@cam.ac.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-sparse@vger.kernel.org



On Mon, 12 Feb 2007, Anton Altaparmakov wrote:
> 
> What can I do to tell sparse that this code is ok and there should not be a
> warning?  Is there a "__ignore_context_imbalance" or something that I can mark
> up the {un,}lock_kernel() with or something like that?

No, you should annotate the function as already having the lock when 
entered.

What sparse warns about is not a locking imbalance (it's all balanced) but 
the fact that locking counts go negative (which is always a bug). And they 
go negative because you drop a lock that git didn't even know about 
(because it doesn't do global analysis - just per-function).

Now, you can either try to make sparsedo global analysis (which some 
people apparently really _are_ trying to do), or you can tell sparse that 
it holds a certain lock on entry, and is _supposed_ to release it. You can 
do that by annotating the function with __acquires/__releases():

	int myfunction(..)
		__releases(kernel_lock)
		__acquires(kernel_lock)
	{
		unlock_kernel();
		..
		lock_kernel();
	}

which does two things:

 - it shows the *programmer* that the function is doing somethign 
   "strange" (not really strange, but still: it's basically a fairly 
   readable way that it's doing locking in a weird way).

 - it tells sparse that the function is actually supposed to release the 
   lock and then re-acquire it.

This would also be how you annotate functions that really *are* 
unbalanced. Some functions get entered with a lock held, and release it, 
or the other way around (the simplest example of that is obviously the 
"__raw_spin_[un]lock()" functions themselves, but it's pretty common in 
"locking helper functions" too).

		Linus
