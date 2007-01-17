From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Change the symbol access list to pseudo list
Date: Tue, 16 Jan 2007 18:34:41 -0800
Message-ID: <20070117023441.GB962@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc13.comcast.net ([204.127.200.83]:59244 "EHLO
	sccrmhc13.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbXAQC5t (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 21:57:49 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>

The pseudo list contain more information. It can
get to the symbol as well as the usage information.
Now it is much easier to answer the question like:
"what function does this functions calls to."

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/flow.c
===================================================================
--- sparse.orig/flow.c	2007-01-16 11:06:05.000000000 -0800
+++ sparse/flow.c	2007-01-16 11:07:09.000000000 -0800
@@ -709,11 +709,11 @@ external_visibility:
 
 void simplify_symbol_usage(struct entrypoint *ep)
 {
-	struct symbol *sym;
+	pseudo_t pseudo;
 
-	FOR_EACH_PTR(ep->accesses, sym) {
-		simplify_one_symbol(ep, sym);
-	} END_FOR_EACH_PTR(sym);
+	FOR_EACH_PTR(ep->accesses, pseudo) {
+		simplify_one_symbol(ep, pseudo->sym);
+	} END_FOR_EACH_PTR(pseudo);
 }
 
 static void mark_bb_reachable(struct basic_block *bb, unsigned long generation)
Index: sparse/linearize.h
===================================================================
--- sparse.orig/linearize.h	2007-01-16 11:06:05.000000000 -0800
+++ sparse/linearize.h	2007-01-16 11:07:09.000000000 -0800
@@ -294,7 +294,7 @@ static inline void replace_bb_in_list(st
 struct entrypoint {
 	struct symbol *name;
 	struct symbol_list *syms;
-	struct symbol_list *accesses;
+	struct pseudo_list *accesses;
 	struct basic_block_list *bbs;
 	struct basic_block *active;
 	struct instruction *entry;
Index: sparse/linearize.c
===================================================================
--- sparse.orig/linearize.c	2007-01-16 11:06:05.000000000 -0800
+++ sparse/linearize.c	2007-01-16 11:07:09.000000000 -0800
@@ -735,11 +735,11 @@ pseudo_t alloc_pseudo(struct instruction
 
 static void clear_symbol_pseudos(struct entrypoint *ep)
 {
-	struct symbol *sym;
+	pseudo_t pseudo;
 
-	FOR_EACH_PTR(ep->accesses, sym) {
-		sym->pseudo = NULL;
-	} END_FOR_EACH_PTR(sym);
+	FOR_EACH_PTR(ep->accesses, pseudo) {
+		pseudo->sym->pseudo = NULL;
+	} END_FOR_EACH_PTR(pseudo);
 }
 
 static pseudo_t symbol_pseudo(struct entrypoint *ep, struct symbol *sym)
@@ -757,7 +757,7 @@ static pseudo_t symbol_pseudo(struct ent
 		pseudo->sym = sym;
 		pseudo->ident = sym->ident;
 		sym->pseudo = pseudo;
-		add_symbol(&ep->accesses, sym);
+		add_pseudo(&ep->accesses, pseudo);
 	}
 	/* Symbol pseudos have neither nr, usage nor def */
 	return pseudo;
