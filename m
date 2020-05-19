From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v1 19/28] scope: let labels have their own scope
Date: Tue, 19 May 2020 02:57:19 +0200
Message-ID: <20200519005728.84594-20-luc.vanoostenryck@gmail.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgESA5y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 May 2020 20:57:54 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B477C061A0C
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:53 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id e10so10222164edq.0
        for <linux-sparse@vger.kernel.org>; Mon, 18 May 2020 17:57:53 -0700 (PDT)
In-Reply-To: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It's invalid to jump inside a statement expression.
So, concerning labels & gotos, a statement expression is
like a kind of scope.

So, in preparation for the detection of such jumps, create
these new scopes and open/close them when entering/leaving
statement expressions.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c |  2 ++
 scope.c      | 19 ++++++++++++++++---
 scope.h      |  4 ++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/expression.c b/expression.c
index ffb3c2dce4d5..f8a8f03e7402 100644
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
index 83cc34c44bf5..2e3a1c37ec15 100644
--- a/scope.c
+++ b/scope.c
@@ -36,7 +36,8 @@
 static struct scope builtin_scope = { .next = &builtin_scope };
 
 struct scope	*block_scope = &builtin_scope,		// regular automatic variables etc
-		*function_scope = NULL,			// __fun__, labels
+		*label_scope = NULL,			// expr-stmt labels
+		*function_scope = NULL,			// __fun__
 		*file_scope = &builtin_scope,		// static
 		*global_scope = &builtin_scope;		// externally visible
 
@@ -90,8 +91,9 @@ void start_block_scope(void)
 
 void start_function_scope(void)
 {
-	start_scope(&function_scope);
 	start_scope(&block_scope);
+	start_scope(&label_scope);
+	function_scope = label_scope;
 }
 
 static void remove_symbol_scope(struct symbol *sym)
@@ -136,8 +138,19 @@ void end_block_scope(void)
 void end_function_scope(void)
 {
 	end_scope(&block_scope);
-	end_scope(&function_scope);
+	end_label_scope();
 	function_scope = NULL;
+	label_scope = NULL;
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
2.26.2
