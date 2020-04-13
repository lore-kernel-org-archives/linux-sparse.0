From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/17] scope: let labels have their own scope
Date: Mon, 13 Apr 2020 18:16:01 +0200
Message-ID: <20200413161605.95900-14-luc.vanoostenryck@gmail.com>
References: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731400AbgDMQQ0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Apr 2020 12:16:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56BC0A3BDC
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v8so10420779wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 13 Apr 2020 09:16:24 -0700 (PDT)
In-Reply-To: <20200413161605.95900-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

One way of detecting gotos inside an statement expression
is to use a new kind of scope for the gotos & labels.

So create this new scope and open/close them when
entering/leaving statement expressions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c |  2 ++
 scope.c      | 14 ++++++++++++++
 scope.h      |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/expression.c b/expression.c
index 78e577cf10a1..08650724a988 100644
--- a/expression.c
+++ b/expression.c
@@ -71,7 +71,9 @@ struct token *parens_expression(struct token *token, struct expression **expr, c
 		struct statement *stmt = alloc_statement(token->pos, STMT_COMPOUND);
 		*expr = e;
 		e->statement = stmt;
+		start_label_scope();
 		token = compound_statement(token->next, stmt);
+		end_label_scope();
 		token = expect(token, '}', "at end of statement expression");
 	} else
 		token = parse_expression(token, expr);
diff --git a/scope.c b/scope.c
index be042a45357d..24c8a7a484f7 100644
--- a/scope.c
+++ b/scope.c
@@ -36,6 +36,7 @@
 static struct scope builtin_scope = { .next = &builtin_scope };
 
 struct scope	*block_scope = &builtin_scope,		// regular automatic variables etc
+		*label_scope = &builtin_scope,		// expr-stmt labels
 		*function_scope = &builtin_scope,	// labels, arguments etc
 		*file_scope = &builtin_scope,		// static
 		*global_scope = &builtin_scope;		// externally visible
@@ -81,6 +82,7 @@ void start_file_scope(void)
 
 	/* top-level stuff defaults to file scope, "extern" etc will choose global scope */
 	function_scope = scope;
+	label_scope = scope;
 	block_scope = scope;
 }
 
@@ -93,6 +95,7 @@ void start_function_scope(void)
 {
 	start_scope(&block_scope);
 	function_scope = block_scope;
+	label_scope = function_scope;
 }
 
 static void remove_symbol_scope(struct symbol *sym)
@@ -138,6 +141,17 @@ void end_function_scope(void)
 {
 	end_scope(&block_scope);
 	function_scope = block_scope;
+	label_scope = function_scope;
+}
+
+void start_label_scope(void)
+{
+	start_scope(&label_scope);
+}
+
+void end_label_scope(void)
+{
+	end_scope(&label_scope);
 }
 
 int is_outer_scope(struct scope *scope)
diff --git a/scope.h b/scope.h
index 83741459eb6a..ddcb90bd146b 100644
--- a/scope.h
+++ b/scope.h
@@ -34,6 +34,7 @@ struct scope {
 
 extern struct scope
 		*block_scope,
+		*label_scope,
 		*function_scope,
 		*file_scope,
 		*global_scope;
@@ -53,6 +54,9 @@ extern void end_block_scope(void);
 extern void start_function_scope(void);
 extern void end_function_scope(void);
 
+extern void start_label_scope(void);
+extern void end_label_scope(void);
+
 extern void set_current_scope(struct symbol *);
 extern void bind_scope(struct symbol *, struct scope *);
 extern void rebind_scope(struct symbol *, struct scope *);
-- 
2.26.0
