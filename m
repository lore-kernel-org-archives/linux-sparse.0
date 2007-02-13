From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Bogus sparse warning?
Date: Tue, 13 Feb 2007 00:25:32 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702130016220.6264@hermes-1.csi.cam.ac.uk>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk>
 <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ppsw-4.csi.cam.ac.uk ([131.111.8.134]:42529 "EHLO
	ppsw-4.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030584AbXBMAZi (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 19:25:38 -0500
In-Reply-To: <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

On Mon, 12 Feb 2007, Linus Torvalds wrote:
> On Mon, 12 Feb 2007, Anton Altaparmakov wrote:
> > Using latest code from
> > git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git
> > 
> > When I run:  make CHECKFLAGS="-D__CHECK_ENDIAN__" C=2 modules
> > 
> > I get this warning:
> > 
> >  CHECK   fs/ntfs/file.c
> > fs/ntfs/file.c:2241:5: warning: incorrect type in argument 8 (different
> > signedness)
> > fs/ntfs/file.c:2241:5:    expected int [signed] ( [signed] [usertype] get_block )( ... )
> > fs/ntfs/file.c:2241:5:    got int [signed] ( static [toplevel] *<noident> )( ... )
> 
> Ok, that does seem like a sparse bug. I _think_ that the trigger here is 
> the fact that we make "get_block_t" be the *function* type, rather than a 
> "pointer to function" type, and then we screw up somewhere when we do the 
> don't do the implicit pointer conversion, and we also thus don't move the 
> type attributes around properly (notice how "get_block" is marked as being 
> a "signed usertype", _not_ a pointer).
> 
> So we should really have converted the function type in the declaration to 
> a "pointer to function", but since this is such an unusual thing to have, 
> nobody noticed.
> 
> Does the warning go away if you make "get_block_t" explicitly a pointer to 
> a function, ie you add the "*" to the typedef:
> 
> > From <include/linux/fs.h>:
> > 
> > typedef int (get_block_t)(struct inode *inode, sector_t iblock,
> >                        struct buffer_head *bh_result, int create);
> 
> so that it looks like
> 
> 	typedef int (*get_block_t)(...)
> 
> instead?

I have Christopher Li's patch applied and with that and changing to the 
(*get_block_t) in linux/fs.h it now produces no warnings:

  CHECK   fs/ntfs/file.c
  CC [M]  fs/ntfs/file.o

> (It is perfectly proper to have a typedef that is actually of a function 
> type, so this looks like a sparse bug regardless, it looks just as if we 
> don't turn a function type into a function pointer type when we see it as 
> an argument in the declaration).
> 
> Has this been there for a long time, or was it something recent in sparse 
> that seemed to trigger it (like the recent ctype conversion changes due to 
> attribute parsing?)

I am afraid I have no idea.  Until yesterday I used to run:

make CHECKFLAGS="-Wbitwise" C=2 modules

And also I kept pulling from your sparse repository and wondering why 
there have not been any changes in so long!  Only yesterday did I spot an 
actual endianness bug in NTFS which caused me to investigate why sparse 
was not picking it up and in the process I discovered that the sparse 
repository had moved and that "-Wbitwise" no longer was the correct 
option...  I then pulled the new sparse repository and changed from 
-Wbitwise to -D__CHECK_ENDIAN__ and then got tons of warnings that did not 
use to be there before.  I managed to fix all except the two I reported on 
the mailing list yesterday (and one more that I have not looked at yet - 
in fs/ntfs/runlist.c I get 18 warnings like this:
 
fs/ntfs/runlist.c:1549:18: warning: potentially expensive pointer subtraction

I have not had a chance to investigate what those mean yet)...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
