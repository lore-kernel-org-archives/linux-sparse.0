From: Christopher Li <sparse@chrisli.org>
Subject: Re: Bogus sparse warning?
Date: Mon, 12 Feb 2007 11:14:34 -0800
Message-ID: <20070212191434.GA1041@chrisli.org>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk> <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc15.comcast.net ([204.127.225.95]:33385 "EHLO
	alnrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965338AbXBLTnx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 14:43:53 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-sparse@vger.kernel.org

On Mon, Feb 12, 2007 at 10:28:19AM -0800, Linus Torvalds wrote:
> 
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
> 
> (It is perfectly proper to have a typedef that is actually of a function 
> type, so this looks like a sparse bug regardless, it looks just as if we 
> don't turn a function type into a function pointer type when we see it as 
> an argument in the declaration).

Yes, we does, in examine_fn_arguments(). But not correctly inherent the attribute bits.

> 
> Has this been there for a long time, or was it something recent in sparse 
> that seemed to trigger it (like the recent ctype conversion changes due to 
> attribute parsing?)

I think this patch should fix it, I haven't try it myself on this bug yet.
It works on a different test case "function vs function ptr".
It has been posted to the list before. It is in my series as well.

Chris

Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2007-02-04 23:46:07.000000000 -0800
+++ sparse/symbol.h	2007-02-05 12:18:30.000000000 -0800
@@ -191,6 +191,7 @@ struct symbol {
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG)
 #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_FORCE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
+#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE)
 
 
 /* Current parsing/evaluation function */
Index: sparse/evaluate.c
===================================================================
--- sparse.orig/evaluate.c	2007-02-04 00:47:46.000000000 -0800
+++ sparse/evaluate.c	2007-02-05 12:20:08.000000000 -0800
@@ -1282,7 +1282,7 @@ static void examine_fn_arguments(struct 
 				else
 					ptr->ctype.base_type = arg;
 				ptr->ctype.as |= s->ctype.as;
-				ptr->ctype.modifiers |= s->ctype.modifiers;
+				ptr->ctype.modifiers |= s->ctype.modifiers & MOD_PTRINHERIT;
 
 				s->ctype.base_type = ptr;
 				s->ctype.as = 0;
@@ -1313,8 +1313,6 @@ static struct symbol *convert_to_as_mod(
 	return sym;
 }
 
-#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE)
-
 static struct symbol *create_pointer(struct expression *expr, struct symbol *sym, int degenerate)
 {
 	struct symbol *node = alloc_symbol(expr->pos, SYM_NODE);
