From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Bogus sparse warning?
Date: Tue, 13 Feb 2007 00:15:56 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702130014290.6264@hermes-1.csi.cam.ac.uk>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk>
 <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org>
 <20070212191434.GA1041@chrisli.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ppsw-9.csi.cam.ac.uk ([131.111.8.139]:54445 "EHLO
	ppsw-9.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030602AbXBMAhf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 19:37:35 -0500
In-Reply-To: <20070212191434.GA1041@chrisli.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

Hi,

On Mon, 12 Feb 2007, Christopher Li wrote:
> On Mon, Feb 12, 2007 at 10:28:19AM -0800, Linus Torvalds wrote:
> > 
> > 
> > > From <include/linux/fs.h>:
> > > 
> > > typedef int (get_block_t)(struct inode *inode, sector_t iblock,
> > >                        struct buffer_head *bh_result, int create);
> > 
> > so that it looks like
> > 
> > 	typedef int (*get_block_t)(...)
> > 
> > instead?
> > 
> > (It is perfectly proper to have a typedef that is actually of a function 
> > type, so this looks like a sparse bug regardless, it looks just as if we 
> > don't turn a function type into a function pointer type when we see it as 
> > an argument in the declaration).
> 
> Yes, we does, in examine_fn_arguments(). But not correctly inherent the attribute bits.
> 
> > 
> > Has this been there for a long time, or was it something recent in sparse 
> > that seemed to trigger it (like the recent ctype conversion changes due to 
> > attribute parsing?)
> 
> I think this patch should fix it, I haven't try it myself on this bug yet.
> It works on a different test case "function vs function ptr".
> It has been posted to the list before. It is in my series as well.

I applied this patch to the current spares git code and reran my test and 
now we have two warnings:

  CHECK   fs/ntfs/file.c
fs/ntfs/file.c:2241:5: warning: incorrect type in argument 8 (different 
signedness)
fs/ntfs/file.c:2241:5:    expected int [signed] ( [signed] [usertype] 
get_block )( ... )
fs/ntfs/file.c:2241:5:    got int [signed] ( static [toplevel] *<noident> 
)( ... )
include/linux/fs.h:1791:14: warning: incorrect type in argument 8 
(different signedness)
include/linux/fs.h:1791:14:    expected int [signed] ( [signed] [usertype] 
get_block )( ... )
include/linux/fs.h:1791:14:    got int [signed] ( *get_block )( ... )

Best regards,

	Anton

> 
> Chris
> 
> Index: sparse/symbol.h
> ===================================================================
> --- sparse.orig/symbol.h	2007-02-04 23:46:07.000000000 -0800
> +++ sparse/symbol.h	2007-02-05 12:18:30.000000000 -0800
> @@ -191,6 +191,7 @@ struct symbol {
>  #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG)
>  #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
>  	MOD_ASSIGNED | MOD_USERTYPE | MOD_FORCE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
> +#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE)
>  
>  
>  /* Current parsing/evaluation function */
> Index: sparse/evaluate.c
> ===================================================================
> --- sparse.orig/evaluate.c	2007-02-04 00:47:46.000000000 -0800
> +++ sparse/evaluate.c	2007-02-05 12:20:08.000000000 -0800
> @@ -1282,7 +1282,7 @@ static void examine_fn_arguments(struct 
>  				else
>  					ptr->ctype.base_type = arg;
>  				ptr->ctype.as |= s->ctype.as;
> -				ptr->ctype.modifiers |= s->ctype.modifiers;
> +				ptr->ctype.modifiers |= s->ctype.modifiers & MOD_PTRINHERIT;
>  
>  				s->ctype.base_type = ptr;
>  				s->ctype.as = 0;
> @@ -1313,8 +1313,6 @@ static struct symbol *convert_to_as_mod(
>  	return sym;
>  }
>  
> -#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE)
> -
>  static struct symbol *create_pointer(struct expression *expr, struct symbol *sym, int degenerate)
>  {
>  	struct symbol *node = alloc_symbol(expr->pos, SYM_NODE);
> 
> 

-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer, http://www.linux-ntfs.org/
