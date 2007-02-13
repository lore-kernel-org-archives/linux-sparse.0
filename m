From: Christopher Li <sparse@chrisli.org>
Subject: Re: Bogus sparse warning?
Date: Mon, 12 Feb 2007 17:46:57 -0800
Message-ID: <20070213014657.GA2922@chrisli.org>
References: <780B1941-729E-47CB-9716-578AD8D25302@cam.ac.uk> <Pine.LNX.4.64.0702121018270.8424@woody.linux-foundation.org> <20070212191434.GA1041@chrisli.org> <Pine.LNX.4.64.0702130014290.6264@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([216.148.227.153]:55084 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933132AbXBMCQR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 12 Feb 2007 21:16:17 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702130014290.6264@hermes-1.csi.cam.ac.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

On Tue, Feb 13, 2007 at 12:15:56AM +0000, Anton Altaparmakov wrote:
> 
> I applied this patch to the current spares git code and reran my test and 
> now we have two warnings:
> 
>   CHECK   fs/ntfs/file.c
> fs/ntfs/file.c:2241:5: warning: incorrect type in argument 8 (different 
> signedness)
> fs/ntfs/file.c:2241:5:    expected int [signed] ( [signed] [usertype] 
> get_block )( ... )
> fs/ntfs/file.c:2241:5:    got int [signed] ( static [toplevel] *<noident> 
> )( ... )
> include/linux/fs.h:1791:14: warning: incorrect type in argument 8 
> (different signedness)
> include/linux/fs.h:1791:14:    expected int [signed] ( [signed] [usertype] 
> get_block )( ... )
> include/linux/fs.h:1791:14:    got int [signed] ( *get_block )( ... )
> 
> Best regards,
>

I see. In evaluate_call().
evaluate_arguments() is called before target function arguments
are converted into pointers.

Can you please try this patch instead?

Chris

Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2007-02-12 18:10:01.000000000 -0800
+++ sparse/symbol.h	2007-02-12 18:10:06.000000000 -0800
@@ -191,6 +191,7 @@ struct symbol {
 #define MOD_SIZE	(MOD_CHAR | MOD_SHORT | MOD_LONG | MOD_LONGLONG)
 #define MOD_IGNORE (MOD_TOPLEVEL | MOD_STORAGE | MOD_ADDRESSABLE |	\
 	MOD_ASSIGNED | MOD_USERTYPE | MOD_FORCE | MOD_ACCESSED | MOD_EXPLICITLY_SIGNED)
+#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE)
 
 
 /* Current parsing/evaluation function */
Index: sparse/evaluate.c
===================================================================
--- sparse.orig/evaluate.c	2007-02-12 18:10:01.000000000 -0800
+++ sparse/evaluate.c	2007-02-12 18:10:48.000000000 -0800
@@ -1282,11 +1282,11 @@ static void examine_fn_arguments(struct 
 				else
 					ptr->ctype.base_type = arg;
 				ptr->ctype.as |= s->ctype.as;
-				ptr->ctype.modifiers |= s->ctype.modifiers;
+				ptr->ctype.modifiers |= s->ctype.modifiers & MOD_PTRINHERIT;
 
 				s->ctype.base_type = ptr;
 				s->ctype.as = 0;
-				s->ctype.modifiers = 0;
+				s->ctype.modifiers &= ~MOD_PTRINHERIT;
 				s->bit_size = 0;
 				s->examined = 0;
 				examine_symbol_type(s);
@@ -1313,8 +1313,6 @@ static struct symbol *convert_to_as_mod(
 	return sym;
 }
 
-#define MOD_PTRINHERIT (MOD_VOLATILE | MOD_CONST | MOD_NODEREF | MOD_STORAGE)
-
 static struct symbol *create_pointer(struct expression *expr, struct symbol *sym, int degenerate)
 {
 	struct symbol *node = alloc_symbol(expr->pos, SYM_NODE);
@@ -2309,7 +2307,6 @@ static int evaluate_symbol_call(struct e
 		int ret;
 		struct symbol *curr = current_fn;
 		current_fn = ctype->ctype.base_type;
-		examine_fn_arguments(current_fn);
 
 		ret = inline_function(expr, ctype);
 
@@ -2336,6 +2333,7 @@ static struct symbol *evaluate_call(stru
 	if (ctype->type == SYM_PTR || ctype->type == SYM_ARRAY)
 		ctype = get_base_type(ctype);
 
+	examine_fn_arguments(ctype);
         if (sym->type == SYM_NODE && fn->type == EXPR_PREOP &&
 	    sym->op && sym->op->args) {
 		if (!sym->op->args(expr))

 
