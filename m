From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [FAIL 4/5] parse: Add acquire, release, requires and guarded_by attributes
Date: Wed, 17 Feb 2016 10:51:34 +0100
Message-ID: <1455702695-6199-5-git-send-email-daniel.wagner@bmw-carit.de>
References: <1455702695-6199-1-git-send-email-daniel.wagner@bmw-carit.de>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:46770 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756926AbcBQJvv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 17 Feb 2016 04:51:51 -0500
In-Reply-To: <1455702695-6199-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Daniel Wagner <daniel.wagner@bmw-carit.de>

The static clang and also gcc knows this attributes and they
are used to do thread safety analysis.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Link: http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
---
 allocate.c |  1 +
 allocate.h |  1 +
 parse.c    | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 symbol.c   |  5 +++++
 symbol.h   | 17 +++++++++++++++++
 5 files changed, 88 insertions(+)

diff --git a/allocate.c b/allocate.c
index f597caf..6506fcd 100644
--- a/allocate.c
+++ b/allocate.c
@@ -130,6 +130,7 @@ void show_allocations(struct allocator_struct *x)
 ALLOCATOR(ident, "identifiers");
 ALLOCATOR(token, "tokens");
 ALLOCATOR(context, "contexts");
+ALLOCATOR(capability, "capability");
 ALLOCATOR(symbol, "symbols");
 ALLOCATOR(expression, "expressions");
 ALLOCATOR(statement, "statements");
diff --git a/allocate.h b/allocate.h
index 9f1dc8c..ce0677d 100644
--- a/allocate.h
+++ b/allocate.h
@@ -65,6 +65,7 @@ extern void show_allocations(struct allocator_struct *);
 DECLARE_ALLOCATOR(ident);
 DECLARE_ALLOCATOR(token);
 DECLARE_ALLOCATOR(context);
+DECLARE_ALLOCATOR(capability);
 DECLARE_ALLOCATOR(symbol);
 DECLARE_ALLOCATOR(expression);
 DECLARE_ALLOCATOR(statement);
diff --git a/parse.c b/parse.c
index b43d683..aef71f1 100644
--- a/parse.c
+++ b/parse.c
@@ -80,6 +80,8 @@ typedef struct token *attr_t(struct token *, struct symbol *,
 static attr_t
 	attribute_packed, attribute_aligned, attribute_modifier,
 	attribute_address_space, attribute_context,
+	attribute_acquire, attribute_release, attribute_requires,
+	attribute_guarded_by,
 	attribute_designated_init,
 	attribute_transparent_union, ignore_attribute,
 	attribute_mode, attribute_force;
@@ -336,6 +338,22 @@ static struct symbol_op context_op = {
 	.attribute = attribute_context,
 };
 
+static struct symbol_op acquire_op = {
+	.attribute = attribute_acquire,
+};
+
+static struct symbol_op release_op = {
+	.attribute = attribute_release,
+};
+
+static struct symbol_op requires_op = {
+	.attribute = attribute_requires,
+};
+
+static struct symbol_op guarded_by_op = {
+	.attribute = attribute_guarded_by,
+};
+
 static struct symbol_op designated_init_op = {
 	.attribute = attribute_designated_init,
 };
@@ -476,6 +494,10 @@ static struct init_keyword {
 	{ "address_space",NS_KEYWORD,	.op = &address_space_op },
 	{ "mode",	NS_KEYWORD,	.op = &mode_op },
 	{ "context",	NS_KEYWORD,	.op = &context_op },
+	{ "acquire_capability",	NS_KEYWORD,	.op = &acquire_op },
+	{ "release_capability",	NS_KEYWORD,	.op = &release_op },
+	{ "requires_capability",	NS_KEYWORD,	.op = &requires_op },
+	{ "guarded_by", NS_KEYWORD,	.op = &guarded_by_op },
 	{ "designated_init",	NS_KEYWORD,	.op = &designated_init_op },
 	{ "__transparent_union__",	NS_KEYWORD,	.op = &transparent_union_op },
 	{ "noreturn",	NS_KEYWORD,	MOD_NORETURN,	.op = &attr_mod_op },
@@ -1197,6 +1219,48 @@ static struct token *attribute_context(struct token *token, struct symbol *attr,
 	return token;
 }
 
+static const char *cap_ops[] = {
+	[CAP_ACQUIRE] = "after acquire_capability attribute",
+	[CAP_RELEASE] = "after release_capability attribute",
+	[CAP_REQUIRES] = "after requires_capability attribute",
+	[CAP_GUARDED_BY] = "after guarded_by attribute",
+};
+
+static struct token *attribute_capability(struct token *token, struct decl_state *ctx, enum cap_op op)
+{
+	struct expression *expr = NULL;
+	struct capability *cap;
+
+	token = expect(token, '(', cap_ops[op]);
+	token = conditional_expression(token, &expr);
+	cap = alloc_capability();
+	cap->op = op;
+	cap->expr = expr;
+	add_ptr_list(&ctx->ctype.capabilities, cap);
+	token = expect(token, ')', cap_ops[op]);
+	return token;
+}
+
+static struct token *attribute_acquire(struct token *token, struct symbol *attr, struct decl_state *ctx)
+{
+	return attribute_capability(token, ctx, CAP_ACQUIRE);
+}
+
+static struct token *attribute_release(struct token *token, struct symbol *attr, struct decl_state *ctx)
+{
+	return attribute_capability(token, ctx, CAP_RELEASE);
+}
+
+static struct token *attribute_requires(struct token *token, struct symbol *attr, struct decl_state *ctx)
+{
+	return attribute_capability(token, ctx, CAP_REQUIRES);
+}
+
+static struct token *attribute_guarded_by(struct token *token, struct symbol *attr, struct decl_state *ctx)
+{
+	return attribute_capability(token, ctx, CAP_GUARDED_BY);
+}
+
 static struct token *attribute_designated_init(struct token *token, struct symbol *attr, struct decl_state *ctx)
 {
 	if (ctx->ctype.base_type && ctx->ctype.base_type->type == SYM_STRUCT)
diff --git a/symbol.c b/symbol.c
index 0ceff62..12e23b4 100644
--- a/symbol.c
+++ b/symbol.c
@@ -73,6 +73,11 @@ struct context *alloc_context(void)
 	return __alloc_context(0);
 }
 
+struct capability *alloc_capability(void)
+{
+	return __alloc_capability(0);
+}
+
 struct symbol *alloc_symbol(struct position pos, int type)
 {
 	struct symbol *sym = __alloc_symbol(0);
diff --git a/symbol.h b/symbol.h
index ccb5dcb..bcb41b7 100644
--- a/symbol.h
+++ b/symbol.h
@@ -97,10 +97,27 @@ extern struct context *alloc_context(void);
 
 DECLARE_PTR_LIST(context_list, struct context);
 
+enum cap_op {
+	CAP_ACQUIRE,
+	CAP_RELEASE,
+	CAP_REQUIRES,
+	CAP_GUARDED_BY,
+};
+
+struct capability {
+	struct expression *expr;
+	enum cap_op op;
+};
+
+extern struct capability *alloc_capability(void);
+
+DECLARE_PTR_LIST(capability_list, struct capability);
+
 struct ctype {
 	unsigned long modifiers;
 	unsigned long alignment;
 	struct context_list *contexts;
+	struct capability_list *capabilities;
 	unsigned int as;
 	struct symbol *base_type;
 };
-- 
2.5.0

