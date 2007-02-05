From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Re: error, types differ in signedness
Date: Mon, 5 Feb 2007 12:06:17 -0800
Message-ID: <20070205200617.GA14964@chrisli.org>
References: <20070205105420.6f19a57d.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc13.comcast.net ([204.127.192.83]:36774 "EHLO
	rwcrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933366AbXBEUdz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 5 Feb 2007 15:33:55 -0500
Content-Disposition: inline
In-Reply-To: <20070205105420.6f19a57d.rdunlap@xenotime.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-sparse@vger.kernel.org

On Mon, Feb 05, 2007 at 10:54:20AM -0800, Randy Dunlap wrote:
> The skbuff.[hc] difference is in *getfrag vs. getfrag.
> The mpage.[hc] difference is in  *get_block vs. getblock.
> 
> Questions:
> 1.  Is the warning valid?

I don't think so.

> 2.  Isn't the '*' unnecessary?

It is valid in C without '*'. Sparse already know the function
is going to degenerated into function pointers. It wrongly inherent
the signedness. You get a signed pointer.

Can you please try this patch?

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
