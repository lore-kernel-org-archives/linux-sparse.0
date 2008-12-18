From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 16/16] Check inlines explicitly
Date: Fri, 19 Dec 2008 01:35:45 +0300
Message-ID: <20081218223538.23692.93413.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:64178 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbYLRW0h (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 17:26:37 -0500
Received: by ug-out-1314.google.com with SMTP id 39so511495ugf.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 14:26:31 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

From: Johannes Berg <johannes@sipsolutions.net>

An earlier patch disabled checking through inline functions because
inlining them clashes with the context tracking code, so this now
makes sparse check the inline functions as though they were really
functions.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 sparse.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/sparse.c b/sparse.c
index 9f4ec03..0bf85fc 100644
--- a/sparse.c
+++ b/sparse.c
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
@@ -277,6 +278,15 @@ static int check_bb_context(struct entrypoint *ep, struct basic_block *bb,
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
@@ -526,7 +536,14 @@ static void check_symbols(struct symbol_list *list)
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

