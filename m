From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bogus sparse warning?
Date: Mon, 12 Feb 2007 16:42:48 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702121636501.8424@woody.linux-foundation.org>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk>
 <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130016220.6264@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:49151 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030606AbXBMAmy (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 19:42:54 -0500
In-Reply-To: <Pine.LNX.4.64.0702130016220.6264@hermes-1.csi.cam.ac.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>



On Tue, 13 Feb 2007, Anton Altaparmakov wrote:
> 
> I have Christopher Li's patch applied and with that and changing to the 
> (*get_block_t) in linux/fs.h it now produces no warnings:

I suspect that even without Chris' patch, you wouldn't get a warning with 
the explicit "pointer" conversion in <linux/fs.h>. But I didn't test.

> > Has this been there for a long time, or was it something recent in sparse 
> > that seemed to trigger it (like the recent ctype conversion changes due to 
> > attribute parsing?)
> 
> I am afraid I have no idea.  Until yesterday I used to run:
> 
> make CHECKFLAGS="-Wbitwise" C=2 modules
> 
> And also I kept pulling from your sparse repository and wondering why 
> there have not been any changes in so long!  Only yesterday did I spot an 
> actual endianness bug in NTFS which caused me to investigate why sparse 
> was not picking it up and in the process I discovered that the sparse 
> repository had moved and that "-Wbitwise" no longer was the correct 
> option...

Heh.

> I then pulled the new sparse repository and changed from -Wbitwise to 
> -D__CHECK_ENDIAN__ and then got tons of warnings that did not use to be 
> there before.  I managed to fix all except the two I reported on the 
> mailing list yesterday (and one more that I have not looked at yet - in 
> fs/ntfs/runlist.c I get 18 warnings like this:
>  
> fs/ntfs/runlist.c:1549:18: warning: potentially expensive pointer subtraction

Ok. That happens for code like

	struct some_struct *p, *q;
	int i;

	i = p - q;

because not everybody realizes that this simple subtraction can actually 
generate tons of instructions. It basically becomes

	i = ((unsigned long)p - (unsigned long)q) / sizeof(some_struct);

which is a potentially 64-bit divide with an awkward (but constant) 
divisor.

If the sizeof is a power-of-two, we don't care, because then it's 
obviously a normal shift. But depending on compiler and architecture and 
exact size of the struct, it can actually be tens of instructions and lots 
of cycles (gcc often tries to turn divisions by constants into a fancy 
code-sequence, which explains the "tens of instructions" part).

So the "potentially expensive" warning is not something really bad, but it 
can be a sign of "maybe you didn't realize that this can be quite 
expensive".

We had some code-sequences in the kernel where we could just rewrite the 
subtraction to something else entirely, and get rid of code.

		Linus
