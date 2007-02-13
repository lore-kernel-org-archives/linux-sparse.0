From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bogus sparse warning?
Date: Tue, 13 Feb 2007 08:10:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702130758380.8424@woody.linux-foundation.org>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk>
 <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130016220.6264@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.64.0702121636501.8424@woody.linux-foundation.org>
 <3164D760-5482-465F-8DF0-33D71AE79A88@cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:42750 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808AbXBMQKn (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Feb 2007 11:10:43 -0500
In-Reply-To: <3164D760-5482-465F-8DF0-33D71AE79A88@cam.ac.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>



On Tue, 13 Feb 2007, Anton Altaparmakov wrote:
> 
> Yes you are quite right in what it is flagging up.  But I would have assumed
> that my current code is more efficient than alternatives.  Here is the code
> from the first warning:
> 
>                /* Determine the runlist size. */
>                trl = rl + 1;
>                while (likely(trl->length))
>                        trl++;
>                old_size = trl - runlist->rl + 1;
> 
> Note "rl" and "trl" are "structs" of size 24 bytes (i.e. not a power of 2).
> What we are dealing with here is an array of those "structs" which is
> terminated by a "struct" where its "->length" is zero.  And I do the above
> loop to get the size, i.e. I look for the last element and then subtract the
> first element from the last element and add one to get the number of elements
> in the array.
> 
> Is this not more efficient than say doing it using an index like so:
> 
> 	for (old_size = 0; rl[old_size].length; old_size++)
> 		;
> 	old_size++;
> 
> My assumption has always been that using the rl[index] would generate larger
> and slower instructions because of the non-constant offset from pointer base.

I actually think that the second one is the much faster one (although they 
differ in where they start - your first code sequence starts at "rl+1", 
while the second one starts at "rl[0]". The compiler is quite possibly 
also able to avoid the "rl[index]" calculation in the loop, by rewriting 
it as

	for (old_size = 1; rl->length; old_size++)
		rl++;

which you could obviously have done manually too (this assumes that you 
don't care about the original value of "rl" - use a temporary if you do.

> Have I been going wrong all those years and in fact that is better?  Or is
> there yet another way of doing the above more efficiently?

It partly depends on how slow division is. The above "fastest" version 
uses two registers instead of one, and has two additions in the loop. It 
has two  downsides: slightly higher register pressure and just the extra 
addition. However, on most archiectures the extra addition will be 
basically free (the "old_size" update doesn't depend on anything else than 
its previous iteration), and the register pressure will depend on how many 
registers you have.

More importantly, it depends on whether the division is slow (which is a 
big "if" - the cost of a division like that can range from anything 
between 4 cycles to 50+ cycles) and how many iterations you normally go 
through. Is the common length small? Big?

So I don't think there is any final answer on this. On _many_ 
architectures, division is fairly slow. On something like Core 2 or the 
Opteron, I think most small values are just 4 cycles to divide. On the 
other hand, the addition inside the loop will likely end up entirely free, 
since it would be a reg-reg ALU operation in a loop where there are likely 
cycles to schedule it. 

Probably not a big deal in this case anyway. We added the warning when Al 
Viro found some really expensive stuff in the VM layer in some hot-paths. 
I doubt it matters for you.

			Linus
