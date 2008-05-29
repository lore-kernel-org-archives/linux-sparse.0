From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 9/9] check inlines explicitly
Date: Thu, 29 May 2008 10:54:11 +0200
Message-ID: <20080529085519.078206000@sipsolutions.net>
References: <20080529085402.814224000@sipsolutions.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:45765 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756696AbYE2JAo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 05:00:44 -0400
Content-Disposition: inline; filename=010-check-inlines.patch
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org

An earlier patch disabled checking through inline functions because
inlining them clashes with the context tracking code, so this now
makes sparse check the inline functions as though they were really
functions.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 sparse.c |   15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- sparse.orig/sparse.c	2008-05-29 10:19:13.000000000 +0200
+++ sparse/sparse.c	2008-05-29 10:19:14.000000000 +0200
@@ -29,11 +29,12 @@ struct context_check {
 	const struct expression *expr;
 };
 
-DECLARE_ALLOCATOR(context_check);
 DECLARE_PTR_LIST(context_check_list, struct context_check);
 DECLARE_PTR_LIST(context_list_list, struct context_check_list);
 ALLOCATOR(context_check, "context check list");
 
+static struct symbol_list *inline_list = NULL;
+
 
 static void context_add(struct context_check_list **ccl,
 			const struct expression *expr,
@@ -277,6 +278,15 @@ static int check_bb_context(struct entry
 	 */
 	FOR_EACH_PTR(bb->insns, insn) {
 		switch (insn->opcode) {
+		case OP_INLINED_CALL: {
+			if (!insn->func->sym)
+				break;
+			if (insn->func->sym->visited)
+				break;
+			insn->func->sym->visited = 1;
+			add_ptr_list(&inline_list, insn->func->sym);
+			break;
+		}
 		case OP_CONTEXT:
 			if (handle_context(ep, bb, insn, &combined))
 				goto out;
@@ -545,6 +555,9 @@ int main(int argc, char **argv)
 	check_symbols(sparse_initialize(argc, argv, &filelist));
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		check_symbols(sparse(file));
+		evaluate_symbol_list(inline_list);
+		check_symbols(inline_list);
+		free_ptr_list(&inline_list);
 	} END_FOR_EACH_PTR_NOTAG(file);
 	return 0;
 }

-- 

