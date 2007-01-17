From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 5] Update usage chain for dead instruction.
Date: Tue, 16 Jan 2007 18:38:04 -0800
Message-ID: <20070117023804.GE962@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc12.comcast.net ([206.18.177.52]:64787 "EHLO
	alnrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbXAQDBW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 22:01:22 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>


Branch like that:
br %c, 0x10, 0x10

Will be simplify and removed. But the usage information is not updated.

Signed-Off-By: Christopher Li<sparse@chrisli.org>

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
