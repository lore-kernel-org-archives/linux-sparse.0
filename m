From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 9/9 v2] check inlines explicitly
Date: Fri, 30 May 2008 01:14:12 +0200
Message-ID: <1212102852.10109.15.camel@johannes.berg>
References: <20080529085402.814224000@sipsolutions.net>
	 <20080529085519.078206000@sipsolutions.net>
	 (sfid-20080529_110105_170182_8D02CA8F)
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:51299 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093AbYE2XPk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 19:15:40 -0400
In-Reply-To: <20080529085519.078206000@sipsolutions.net> (sfid-20080529_110105_170182_8D02CA8F)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org, Harvey Harrison <harvey.harrison@gmail.com>, Pavel Roskin <proski@gnu.org>

An earlier patch disabled checking through inline functions because
inlining them clashes with the context tracking code, so this now
makes sparse check the inline functions as though they were really
functions.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
Maybe linearize_symbol() should do the check and return sym->ep if not
NULL?

 sparse.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

--- sparse.orig/sparse.c	2008-05-30 00:53:33.000000000 +0200
+++ sparse/sparse.c	2008-05-30 01:12:55.000000000 +0200
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
@@ -526,7 +536,14 @@ static void check_symbols(struct symbol_
 		struct entrypoint *ep;
 
 		expand_symbol(sym);
-		ep = linearize_symbol(sym);
+		/*
+		 * If we're passing back an inline via the special code
+		 * that tests those, it might already be linearized, if
+		 * so just check it and don't linearize again.
+		 */
+		ep = sym->ep;
+		if (!ep)
+			ep = linearize_symbol(sym);
 		if (ep) {
 			if (dbg_entry)
 				show_entry(ep);
@@ -545,6 +562,9 @@ int main(int argc, char **argv)
 	check_symbols(sparse_initialize(argc, argv, &filelist));
 	FOR_EACH_PTR_NOTAG(filelist, file) {
 		check_symbols(sparse(file));
+		evaluate_symbol_list(inline_list);
+		check_symbols(inline_list);
+		free_ptr_list(&inline_list);
 	} END_FOR_EACH_PTR_NOTAG(file);
 	return 0;
 }


