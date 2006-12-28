From: Christopher Li <sparse@chrisli.org>
Subject: [RFC] [PATCH 3/4] and other branch usage fix
Date: Thu, 28 Dec 2006 01:26:18 -0800
Message-ID: <20061228092618.GD6573@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:44034 "EHLO
	rwcrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827AbWL1JuK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Dec 2006 04:50:10 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Josh Triplett <josh@freedesktop.org>, Dan Carpenter <error27@gmail.com>

Remove dead branch from usage chain.

Branch like the following will get simplify and removed.
But the usage information is not updated.

br %c, 0x10, 0x10

Singed-off-by: Christopher Li <sparse@chrisli.org>

Index: sparse/flow.c
===================================================================
--- sparse.orig/flow.c	2006-12-21 20:48:07.000000000 -0800
+++ sparse/flow.c	2006-12-21 22:20:44.000000000 -0800
@@ -987,7 +987,7 @@ out:
 			replace_bb_in_list(&child->parents, bb, parent, 0);
 		} END_FOR_EACH_PTR(child);
 
-		delete_last_instruction(&parent->insns);
+		kill_instruction(delete_last_instruction(&parent->insns));
 		FOR_EACH_PTR(bb->insns, insn) {
 			if (insn->bb) {
 				assert(insn->bb == bb);
