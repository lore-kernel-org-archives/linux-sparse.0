From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Fix the annotated inline call position
Date: Fri, 23 Mar 2007 16:08:17 -0700
Message-ID: <20070323230817.GC27992@chrisli.org>
References: <20070322063600.GD15364@redhat.com> <20070322073344.GU4095@ftp.linux.org.uk> <20070322070354.GA22151@chrisli.org> <20070322125911.GW4095@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc15.comcast.net ([204.127.200.85]:39169 "EHLO
	sccrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbXCWXqq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Mar 2007 19:46:46 -0400
Content-Disposition: inline
In-Reply-To: <20070322125911.GW4095@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Dave Jones <davej@redhat.com>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org


Here is some diff comparing output between the sparse 0.2 and the tip of git.

-mm/mmap.c:1631:2: warning: context imbalance in 'expand_stack' - different lock
 contexts for basic block
+include/linux/rmap.h:55:2: warning: context imbalance in 'expand_stack' - diffe

The change is introduced by the inline annotate instruction,
which mark the bb->pos to the inline function.

This change make it back to the caller position.

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/linearize.c
===================================================================
--- sparse.orig/linearize.c	2007-03-22 14:11:40.000000000 -0700
+++ sparse/linearize.c	2007-03-23 13:15:28.000000000 -0700
@@ -1650,6 +1650,7 @@ static pseudo_t linearize_inlined_call(s
 {
 	struct instruction *insn = alloc_instruction(OP_INLINED_CALL, 0);
 	struct statement *args = stmt->args;
+	struct basic_block *bb;
 	pseudo_t pseudo;
 
 	if (args) {
@@ -1664,6 +1665,9 @@ static pseudo_t linearize_inlined_call(s
 
 	insn->target = pseudo = linearize_compound_statement(ep, stmt);
 	use_pseudo(insn, symbol_pseudo(ep, stmt->inline_fn), &insn->func);
+	bb = ep->active;
+	if (bb && !bb->insns)
+		bb->pos = stmt->pos;
 	add_one_insn(ep, insn);
 	return pseudo;
 }
