From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Bogus sparse warning?
Date: Tue, 13 Feb 2007 21:23:04 +0000
Message-ID: <C9A59294-6927-4F50-9DEC-1A6CCA75A77D@cam.ac.uk>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk> <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org> <Pine.LNX.4.64.0702130016220.6264@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.64.0702121636501.8424@woody.linux-foundation.org> <3164D760-5482-465F-8DF0-33D71AE79A88@cam.ac.uk> <Pine.LNX.4.64.0702130758380.8424@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:55061 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086AbXBMVXs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Feb 2007 16:23:48 -0500
In-Reply-To: <Pine.LNX.4.64.0702130758380.8424@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On 13 Feb 2007, at 16:10, Linus Torvalds wrote:
> On Tue, 13 Feb 2007, Anton Altaparmakov wrote:
>> Yes you are quite right in what it is flagging up.  But I would  
>> have assumed
>> that my current code is more efficient than alternatives.  Here is  
>> the code
>> from the first warning:
>>
>>                /* Determine the runlist size. */
>>                trl = rl + 1;
>>                while (likely(trl->length))
>>                        trl++;
>>                old_size = trl - runlist->rl + 1;
>>
>> Note "rl" and "trl" are "structs" of size 24 bytes (i.e. not a  
>> power of 2).
>> What we are dealing with here is an array of those "structs" which is
>> terminated by a "struct" where its "->length" is zero.  And I do  
>> the above
>> loop to get the size, i.e. I look for the last element and then  
>> subtract the
>> first element from the last element and add one to get the number  
>> of elements
>> in the array.
>>
>> Is this not more efficient than say doing it using an index like so:
>>
>> 	for (old_size = 0; rl[old_size].length; old_size++)
>> 		;
>> 	old_size++;
>>
>> My assumption has always been that using the rl[index] would  
>> generate larger
>> and slower instructions because of the non-constant offset from  
>> pointer base.
>
> I actually think that the second one is the much faster one  
> (although they
> differ in where they start - your first code sequence starts at "rl 
> +1",
> while the second one starts at "rl[0]".

Yes, sorry, that was just me being silly.  I can just make it start  
with "old_size = 1"...

> The compiler is quite possibly
> also able to avoid the "rl[index]" calculation in the loop, by  
> rewriting
> it as
>
> 	for (old_size = 1; rl->length; old_size++)
> 		rl++;
>
> which you could obviously have done manually too (this assumes that  
> you
> don't care about the original value of "rl" - use a temporary if  
> you do.

Hm, good point!  Yes, even I can see that that version would be  
faster...  I will switch the loops to doing this and see how many of  
the warnings I can get rid of that way...  Thanks for the suggestion!

>> Have I been going wrong all those years and in fact that is  
>> better?  Or is
>> there yet another way of doing the above more efficiently?
>
> It partly depends on how slow division is. The above "fastest" version
> uses two registers instead of one, and has two additions in the  
> loop. It
> has two  downsides: slightly higher register pressure and just the  
> extra
> addition. However, on most archiectures the extra addition will be
> basically free (the "old_size" update doesn't depend on anything  
> else than
> its previous iteration), and the register pressure will depend on  
> how many
> registers you have.
>
> More importantly, it depends on whether the division is slow (which  
> is a
> big "if" - the cost of a division like that can range from anything
> between 4 cycles to 50+ cycles) and how many iterations you  
> normally go
> through. Is the common length small? Big?

Common should be very small.  The "runlist" is basically an array of  
extents describing where the (meta)data of an inode is located on  
disk.  So in an ideal world where there is no fragmentation on the  
disk at all, all runlists would contain only two elements, one to  
state "logical block 0 corresponds to physical block X and the number  
of blocks in this extent is Y" and one to terminate the array which  
would have a length of zero.

In reality there will be fragmentation so the number of extents will  
increase.

As to how many there can be: A long time ago, the NTFS driver used to  
crash when accessing some files.  It turned out I was using kmalloc()  
to allocate the array of extents and the array was so big for some  
files that we tried to allocate more than kmalloc() allows (64kiB  
IIRC or was it 128kiB?) so assuming the maximum is 64kiB (the  
observations were on i386) that would mean that there are files out  
there that have more than 2^16 / 24 = 2740 entries in the array...   
Nowadays I allocate the array in multiples of PAGE_SIZE and if it is  
less than or equal to a page we I kmalloc() and otherwise I use  
vmalloc() which seems to work very well.

> So I don't think there is any final answer on this. On _many_
> architectures, division is fairly slow. On something like Core 2 or  
> the
> Opteron, I think most small values are just 4 cycles to divide. On the
> other hand, the addition inside the loop will likely end up  
> entirely free,
> since it would be a reg-reg ALU operation in a loop where there are  
> likely
> cycles to schedule it.

Yes, that makes perfect sense.  On modern pipelined CPUs it literally  
should be totally free.

> Probably not a big deal in this case anyway. We added the warning  
> when Al
> Viro found some really expensive stuff in the VM layer in some hot- 
> paths.
> I doubt it matters for you.

It can be at least somewhat of a deal because this is the extent map  
so it can be a very frequently traversed structure (e.g. in direct i/ 
o where we do not cache the on-disk location in buffers attached to  
page cache pages...).

But in any case having sparse spew over 20 warnings is annoying  
enough that I want to improve the code so the number of warnings at  
least goes down.  (-:

Thanks a lot for your advice!

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
