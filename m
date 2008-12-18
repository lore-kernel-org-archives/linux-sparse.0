From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH 09/16] Add __exact_context__
Date: Fri, 19 Dec 2008 01:33:28 +0300
Message-ID: <20081218223320.23692.2908.stgit@zaytsev.su>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:12371 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbYLRWYP (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Dec 2008 17:24:15 -0500
Received: by ug-out-1314.google.com with SMTP id 39so511368ugf.37
        for <linux-sparse@vger.kernel.org>; Thu, 18 Dec 2008 14:24:13 -0800 (PST)
In-Reply-To: <20081218181935.28136.60256.stgit@zaytsev.su>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>

From: Johannes Berg <johannes@sipsolutions.net>

We also need a statement to indicate that an exact context is
required, most notably the next patch will require it so that
it can translate attributes on variables into statements.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 ident-list.h               |    1 +
 linearize.c                |    1 +
 linearize.h                |    2 +
 parse.c                    |   20 ++++++++++++-
 parse.h                    |    1 +
 sparse.1                   |    2 +
 sparse.c                   |   14 +++++++--
 validation/context-exact.c |   67 ++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 101 insertions(+), 7 deletions(-)
 create mode 100644 validation/context-exact.c

diff --git a/ident-list.h b/ident-list.h
index 6104826..13b76d8 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -98,6 +98,7 @@ __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
 
 /* Sparse commands */
 IDENT_RESERVED(__context__);
+IDENT_RESERVED(__exact_context__);
 IDENT_RESERVED(__range__);
 
 /* Magic function names we recognize */
diff --git a/linearize.c b/linearize.c
index 526a710..111e7af 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1683,6 +1683,7 @@ static pseudo_t linearize_context(struct entrypoint *ep, struct statement *stmt)
 		value = expr->value;
 
 	insn->required = value;
+	insn->exact = stmt->exact;
 
 	insn->context_expr = stmt->context;
 	add_one_insn(ep, insn);
diff --git a/linearize.h b/linearize.h
index 0c5e4ef..69341c2 100644
--- a/linearize.h
+++ b/linearize.h
@@ -117,7 +117,7 @@ struct instruction {
 			struct pseudo_list *arguments;
 		};
 		struct /* context */ {
-			int increment, required, inc_false;
+			int increment, required, inc_false, exact;
 			struct expression *context_expr;
 		};
 		struct /* asm */ {
diff --git a/parse.c b/parse.c
index eb31871..5ad8c68 100644
--- a/parse.c
+++ b/parse.c
@@ -52,6 +52,7 @@ static struct token *parse_while_statement(struct token *token, struct statement
 static struct token *parse_do_statement(struct token *token, struct statement *stmt);
 static struct token *parse_goto_statement(struct token *token, struct statement *stmt);
 static struct token *parse_context_statement(struct token *token, struct statement *stmt);
+static struct token *parse_exact_context_statement(struct token *token, struct statement *stmt);
 static struct token *parse_range_statement(struct token *token, struct statement *stmt);
 static struct token *parse_asm_statement(struct token *token, struct statement *stmt);
 static struct token *toplevel_asm_declaration(struct token *token, struct symbol_list **list);
@@ -149,6 +150,10 @@ static struct symbol_op __context___op = {
 	.statement = parse_context_statement,
 };
 
+static struct symbol_op __exact_context___op = {
+	.statement = parse_exact_context_statement,
+};
+
 static struct symbol_op range_op = {
 	.statement = parse_range_statement,
 };
@@ -254,6 +259,7 @@ static struct init_keyword {
 	{ "do",		NS_KEYWORD, .op = &do_op },
 	{ "goto",	NS_KEYWORD, .op = &goto_op },
 	{ "__context__",NS_KEYWORD, .op = &__context___op },
+	{ "__exact_context__",NS_KEYWORD, .op = &__exact_context___op },
 	{ "__range__",	NS_KEYWORD, .op = &range_op },
 	{ "asm",	NS_KEYWORD, .op = &asm_op },
 	{ "__asm",	NS_KEYWORD, .op = &asm_op },
@@ -1811,7 +1817,7 @@ static struct token *parse_goto_statement(struct token *token, struct statement
 	return expect(token, ';', "at end of statement");
 }
 
-static struct token *parse_context_statement(struct token *token, struct statement *stmt)
+static struct token *_parse_context_statement(struct token *token, struct statement *stmt, int exact)
 {
 	struct expression *args[3];
 	int argc = 0;
@@ -1836,6 +1842,8 @@ static struct token *parse_context_statement(struct token *token, struct stateme
 	stmt->expression = args[0];
 	stmt->context = NULL;
 
+	stmt->exact = exact;
+
 	switch (argc) {
 	case 0:
 		sparse_error(token->pos, "__context__ statement needs argument(s)");
@@ -1865,6 +1873,16 @@ static struct token *parse_context_statement(struct token *token, struct stateme
 	return expect(token, ')', "at end of __context__");
 }
 
+static struct token *parse_context_statement(struct token *token, struct statement *stmt)
+{
+	return _parse_context_statement(token, stmt, 0);
+}
+
+static struct token *parse_exact_context_statement(struct token *token, struct statement *stmt)
+{
+	return _parse_context_statement(token, stmt, 1);
+}
+
 static struct token *parse_range_statement(struct token *token, struct statement *stmt)
 {
 	stmt->type = STMT_RANGE;
diff --git a/parse.h b/parse.h
index a2b9aa3..ae50720 100644
--- a/parse.h
+++ b/parse.h
@@ -43,6 +43,7 @@ struct statement {
 			struct expression *expression;
 			struct expression *context;
 			struct expression *required;
+			int exact;
 		};
 		struct /* return_statement */ {
 			struct expression *ret_value;
diff --git a/sparse.1 b/sparse.1
index 92a1cae..45eea6f 100644
--- a/sparse.1
+++ b/sparse.1
@@ -90,7 +90,7 @@ To indicate that a function requires
 .BI exactly
 a certain lock context (not "at least" as above), use the form
 .BI __attribute__((exact_context( [expression ,] in_context , out_context ))
-There currently is no corresponding
+There is also the corresponding
 .BI __exact_context__( [expression , ]adjust_value[ , required] )
 statement.
 
diff --git a/sparse.c b/sparse.c
index 785a6f6..a26c8f2 100644
--- a/sparse.c
+++ b/sparse.c
@@ -239,7 +239,7 @@ static int handle_context(struct entrypoint *ep, struct basic_block *bb,
 			  struct context_check_list **combined)
 {
 	struct context_check *c;
-	const char *name;
+	const char *name, *cmp;
 	char *buf;
 	int val, ok;
 
@@ -256,7 +256,13 @@ static int handle_context(struct entrypoint *ep, struct basic_block *bb,
 		}
 	} END_FOR_EACH_PTR(c);
 
-	ok = insn->required <= val;
+	if (insn->exact) {
+		ok = insn->required == val;
+		cmp = "";
+	} else {
+		ok = insn->required <= val;
+		cmp = ">= ";
+	}
 
 	if (!ok && Wcontext) {
 		get_context_string(&buf, &name);
@@ -266,8 +272,8 @@ static int handle_context(struct entrypoint *ep, struct basic_block *bb,
 			"__context__ statement expected different context",
 			show_ident(ep->name->ident));
 
-		info(insn->pos, "%swanted >= %d, got %d",
-		     name, insn->required, val);
+		info(insn->pos, "%swanted %s%d, got %d",
+		     name, cmp, insn->required, val);
 
 		free(buf);
 		return -1;
diff --git a/validation/context-exact.c b/validation/context-exact.c
new file mode 100644
index 0000000..bacd9a1
--- /dev/null
+++ b/validation/context-exact.c
@@ -0,0 +1,67 @@
+static void a(void) __attribute__((context(TEST,0,1)))
+{
+	__context__(TEST,1);
+}
+
+static void r(void) __attribute__((context(TEST,1,0)))
+{
+	__context__(TEST,-1,1);
+}
+
+static void good_1(void)
+{
+	a();
+	r();
+}
+
+static void good_2(void)
+{
+	a();
+	r();
+	a();
+	r();
+}
+
+static void good_3(void)
+{
+	a();
+	a();
+	r();
+	r();
+}
+
+static void good_4(void)
+{
+	a();
+	a();
+	__context__(TEST,0,1);
+	r();
+	r();
+}
+
+static void warn_1(void)
+{
+	a();
+	a();
+	__exact_context__(TEST,0,1);
+	r();
+	r();
+}
+
+static void good_5(void)
+{
+	a();
+	a();
+	__exact_context__(TEST,0,2);
+	r();
+	r();
+}
+
+/*
+ * check-name: Check __exact_context__ statement with required context
+ *
+ * check-error-start
+context-exact.c:46:2: warning: context imbalance in 'warn_1': __context__ statement expected different context
+context-exact.c:46:2:    context 'TEST': wanted 1, got 2
+ * check-error-end
+ */

