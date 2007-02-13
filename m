From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Bogus sparse warning?
Date: Tue, 13 Feb 2007 09:53:14 +0000
Message-ID: <3164D760-5482-465F-8DF0-33D71AE79A88@cam.ac.uk>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk> <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org> <Pine.LNX.4.64.0702130016220.6264@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.64.0702121636501.8424@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ppsw-3.csi.cam.ac.uk ([131.111.8.133]:47257 "EHLO
	ppsw-3.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbXBMJxi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Feb 2007 04:53:38 -0500
In-Reply-To: <Pine.LNX.4.64.0702121636501.8424@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On 13 Feb 2007, at 00:42, Linus Torvalds wrote:
> On Tue, 13 Feb 2007, Anton Altaparmakov wrote:
>> I have Christopher Li's patch applied and with that and changing  
>> to the
>> (*get_block_t) in linux/fs.h it now produces no warnings:
>
> I suspect that even without Chris' patch, you wouldn't get a  
> warning with
> the explicit "pointer" conversion in <linux/fs.h>. But I didn't test.

I did't either.  The good news is that Chris' second patch fixes the  
warning both with the explicit "pointer" conversion and without.

>> I then pulled the new sparse repository and changed from -Wbitwise to
>> -D__CHECK_ENDIAN__ and then got tons of warnings that did not use  
>> to be
>> there before.  I managed to fix all except the two I reported on the
>> mailing list yesterday (and one more that I have not looked at yet  
>> - in
>> fs/ntfs/runlist.c I get 18 warnings like this:
>>
>> fs/ntfs/runlist.c:1549:18: warning: potentially expensive pointer  
>> subtraction
>
> Ok. That happens for code like
>
> 	struct some_struct *p, *q;
> 	int i;
>
> 	i = p - q;
>
> because not everybody realizes that this simple subtraction can  
> actually
> generate tons of instructions. It basically becomes
>
> 	i = ((unsigned long)p - (unsigned long)q) / sizeof(some_struct);
>
> which is a potentially 64-bit divide with an awkward (but constant)
> divisor.
>
> If the sizeof is a power-of-two, we don't care, because then it's
> obviously a normal shift. But depending on compiler and  
> architecture and
> exact size of the struct, it can actually be tens of instructions  
> and lots
> of cycles (gcc often tries to turn divisions by constants into a fancy
> code-sequence, which explains the "tens of instructions" part).
>
> So the "potentially expensive" warning is not something really bad,  
> but it
> can be a sign of "maybe you didn't realize that this can be quite
> expensive".
>
> We had some code-sequences in the kernel where we could just  
> rewrite the
> subtraction to something else entirely, and get rid of code.

Yes you are quite right in what it is flagging up.  But I would have  
assumed that my current code is more efficient than alternatives.   
Here is the code from the first warning:

                 /* Determine the runlist size. */
                 trl = rl + 1;
                 while (likely(trl->length))
                         trl++;
                 old_size = trl - runlist->rl + 1;

Note "rl" and "trl" are "structs" of size 24 bytes (i.e. not a power  
of 2).  What we are dealing with here is an array of those "structs"  
which is terminated by a "struct" where its "->length" is zero.  And  
I do the above loop to get the size, i.e. I look for the last element  
and then subtract the first element from the last element and add one  
to get the number of elements in the array.

Is this not more efficient than say doing it using an index like so:

	for (old_size = 0; rl[old_size].length; old_size++)
		;
	old_size++;

My assumption has always been that using the rl[index] would generate  
larger and slower instructions because of the non-constant offset  
from pointer base.

Have I been going wrong all those years and in fact that is better?   
Or is there yet another way of doing the above more efficiently?

(Yes I know that keeping the size of the array in the array header  
would be most efficient but that is not how the code works at the  
moment.  It is my long term goal to switch to code that does make use  
of the array size and in fact in my OSX NTFS driver I have done this  
and plan to backport the changes to the Linux driver once I have it  
working there...)

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
