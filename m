From: Christopher Li <sparse@chrisli.org>
Subject: [RFC] [PATCH 2/4] remove dead branch usage
Date: Thu, 28 Dec 2006 01:25:40 -0800
Message-ID: <20061228092540.GC6573@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc11.comcast.net ([63.240.77.81]:47557 "EHLO
	sccrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932832AbWL1Jn6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 28 Dec 2006 04:43:58 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Josh Triplett <josh@freedesktop.org>, Dan Carpenter <error27@gmail.com>

Fix some problem cause by dead branch instruction left in the user chain.

Signed-off-by: Christopher Li <sparse@chrisli.org>

Index: sparse/flow.c
===================================================================
--- sparse.orig/flow.c	2006-12-21 14:35:18.000000000 -0800
+++ sparse/flow.c	2006-12-21 14:35:55.000000000 -0800
@@ -195,6 +195,7 @@ try_to_rewrite_target:
 	if (bb_list_size(target->parents) != 1)
 		return retval;
 	insert_branch(target, insn, final);
+	kill_instruction(insn);
 	return 1;
 }
 
Index: sparse/simplify.c
===================================================================
--- sparse.orig/simplify.c	2006-12-21 14:35:18.000000000 -0800
+++ sparse/simplify.c	2006-12-21 14:35:55.000000000 -0800
@@ -217,6 +217,11 @@ void kill_instruction(struct instruction
 		kill_use(&insn->src2);
 		kill_use(&insn->src3);
 		return;
+	case OP_BR:
+		insn->bb = NULL;
+		repeat_phase |= REPEAT_CSE;
+		if (insn->cond)
+			kill_use(&insn->cond);
 	}
 }
 
