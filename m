From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bogus sparse warning?
Date: Mon, 12 Feb 2007 10:28:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:37460 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965023AbXBLS2j (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 13:28:39 -0500
In-Reply-To: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>



On Mon, 12 Feb 2007, Anton Altaparmakov wrote:
> 
> Using latest code from
> git://git.kernel.org/pub/scm/linux/kernel/git/josh/sparse.git
> 
> When I run:  make CHECKFLAGS="-D__CHECK_ENDIAN__" C=2 modules
> 
> I get this warning:
> 
>  CHECK   fs/ntfs/file.c
> fs/ntfs/file.c:2241:5: warning: incorrect type in argument 8 (different
> signedness)
> fs/ntfs/file.c:2241:5:    expected int [signed] ( [signed] [usertype] get_block )( ... )
> fs/ntfs/file.c:2241:5:    got int [signed] ( static [toplevel] *<noident> )( ... )

Ok, that does seem like a sparse bug. I _think_ that the trigger here is 
the fact that we make "get_block_t" be the *function* type, rather than a 
"pointer to function" type, and then we screw up somewhere when we do the 
don't do the implicit pointer conversion, and we also thus don't move the 
type attributes around properly (notice how "get_block" is marked as being 
a "signed usertype", _not_ a pointer).

So we should really have converted the function type in the declaration to 
a "pointer to function", but since this is such an unusual thing to have, 
nobody noticed.

Does the warning go away if you make "get_block_t" explicitly a pointer to 
a function, ie you add the "*" to the typedef:

> From <include/linux/fs.h>:
> 
> typedef int (get_block_t)(struct inode *inode, sector_t iblock,
>                        struct buffer_head *bh_result, int create);

so that it looks like

	typedef int (*get_block_t)(...)

instead?

(It is perfectly proper to have a typedef that is actually of a function 
type, so this looks like a sparse bug regardless, it looks just as if we 
don't turn a function type into a function pointer type when we see it as 
an argument in the declaration).

Has this been there for a long time, or was it something recent in sparse 
that seemed to trigger it (like the recent ctype conversion changes due to 
attribute parsing?)

			Linus
