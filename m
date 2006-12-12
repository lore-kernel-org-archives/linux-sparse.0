From: Christopher Li <sparse@chrisli.org>
Subject: basic block output order?
Date: Tue, 12 Dec 2006 02:24:22 -0800
Message-ID: <20061212102422.GA6013@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc11.comcast.net ([206.18.177.51]:59883 "EHLO
	alnrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbWLLKiz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 12 Dec 2006 05:38:55 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>

I am playing with the example.c. I am wondering why the parent
basic blocks need to generate first?

The entry point has it's own "entry" instruction now, it should
remain as the first basic block in entry->bbs.

e.g. what is wrong with the following patch?

The reason I ask is because I think I need a few more pass
on the basic block. I try to avoid recursive if it is not necessary.

Thanks

Chris

Index: sparse/flow.c
===================================================================
--- sparse.orig/flow.c	2006-12-12 01:52:06.000000000 -0800
+++ sparse/flow.c	2006-12-12 01:52:40.000000000 -0800
@@ -903,12 +903,10 @@ void vrfy_flow(struct entrypoint *ep)
 	struct basic_block *bb;
 	struct basic_block *entry = ep->entry->bb;
 
+	assert(first_basic_block(ep->bbs) == entry);
 	FOR_EACH_PTR(ep->bbs, bb) {
-		if (bb == entry)
-			entry = NULL;
 		vrfy_bb_flow(bb);
 	} END_FOR_EACH_PTR(bb);
-	assert(!entry);
 }
 
 void pack_basic_blocks(struct entrypoint *ep)
Index: sparse/example.c
===================================================================
--- sparse.orig/example.c	2006-12-12 01:52:06.000000000 -0800
+++ sparse/example.c	2006-12-12 01:52:40.000000000 -0800
@@ -1765,9 +1765,6 @@ static void output_bb(struct basic_block
 
 	bb->generation = generation;
 
-	/* Make sure all parents have been generated first */
-	generate_list(bb->parents, generation);
-
 	state.pos = bb->pos;
 	state.inputs = gather_storage(bb, STOR_IN);
 	state.outputs = gather_storage(bb, STOR_OUT);
@@ -1782,9 +1779,6 @@ static void output_bb(struct basic_block
 
 	free_ptr_list(&state.inputs);
 	free_ptr_list(&state.outputs);
-
-	/* Generate all children... */
-	generate_list(bb->children, generation);
 }
 
 /*
@@ -1920,7 +1914,7 @@ static void output(struct entrypoint *ep
 	arch_set_up_storage(ep);
 
 	/* Show the results ... */
-	output_bb(ep->entry->bb, generation);
+	generate_list(ep->bbs, generation);
 
 	/* Clear the storage hashes for the next function.. */
 	free_storage();
