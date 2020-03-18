From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] add support for linearization of builtins
Date: Wed, 18 Mar 2020 18:31:19 +0100
Message-ID: <20200318173120.63939-5-luc.vanoostenryck@gmail.com>
References: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37033 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgCRRb3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Mar 2020 13:31:29 -0400
Received: by mail-wm1-f68.google.com with SMTP id d1so2763445wmb.2
        for <linux-sparse@vger.kernel.org>; Wed, 18 Mar 2020 10:31:28 -0700 (PDT)
In-Reply-To: <20200318173120.63939-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Sparse ignores most builtins. A few of them are directly
interpreted at parsing time (types_compatible_p, offsetof).
Some others are expanded if their argument(s) are constant
but that's all.

However, some of the builtins are significant at the IR
level and shouldn't thus be ignored.

This patch add the support needed for the linearization of
these builtins.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 builtin.c   |  2 ++
 linearize.c | 32 ++++++++++++++++++++++++++++++++
 symbol.h    |  7 ++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/builtin.c b/builtin.c
index 52285a91cd1e..debc22c036ec 100644
--- a/builtin.c
+++ b/builtin.c
@@ -418,6 +418,8 @@ void init_builtins(int stream)
 		sym->op = ptr->op;
 		sym->builtin = 1;
 	}
+
+	init_linearized_builtins(stream);
 }
 
 static void declare_builtin(const char *name, struct symbol *rtype, int variadic, ...)
diff --git a/linearize.c b/linearize.c
index 19c284c4a456..25d6327bf6f1 100644
--- a/linearize.c
+++ b/linearize.c
@@ -1509,6 +1509,11 @@ static pseudo_t linearize_call_expression(struct entrypoint *ep, struct expressi
 
 	fn = expr->fn;
 	fntype = fn->ctype;
+
+	// handle builtins
+	if (fntype->op && fntype->op->linearize)
+		return fntype->op->linearize(ep, expr);
+
 	ctype = &fntype->ctype;
 	if (fntype->type == SYM_NODE)
 		fntype = fntype->ctype.base_type;
@@ -2526,3 +2531,30 @@ struct entrypoint *linearize_symbol(struct symbol *sym)
 		return linearize_fn(sym, base_type);
 	return NULL;
 }
+
+/*
+ * Builtin functions
+ */
+
+static struct sym_init {
+	const char *name;
+	pseudo_t (*linearize)(struct entrypoint *, struct expression*);
+	struct symbol_op op;
+} builtins_table[] = {
+	// must be declared in builtin.c:declare_builtins[]
+	{ }
+};
+
+void init_linearized_builtins(int stream)
+{
+	struct sym_init *ptr;
+
+	for (ptr = builtins_table; ptr->name; ptr++) {
+		struct symbol *sym;
+		sym = create_symbol(stream, ptr->name, SYM_NODE, NS_SYMBOL);
+		if (!sym->op)
+			sym->op = &ptr->op;
+		sym->op->type |= KW_BUILTIN;
+		ptr->op.linearize = ptr->linearize;
+	}
+}
diff --git a/symbol.h b/symbol.h
index 9ef5a886172f..270ae098cacf 100644
--- a/symbol.h
+++ b/symbol.h
@@ -78,7 +78,7 @@ enum keyword {
 	KW_MODIFIER	= 1 << 1,
 	KW_QUALIFIER	= 1 << 2,
 	KW_ATTRIBUTE	= 1 << 3,
-     // KW UNUSED	= 1 << 4,
+	KW_BUILTIN	= 1 << 4,
 	KW_ASM		= 1 << 5,
 	KW_MODE		= 1 << 6,
      // KW UNUSED	= 1 << 7,
@@ -112,11 +112,15 @@ struct decl_state {
 	unsigned char is_ext_visible;
 };
 
+struct pseudo;
+struct entrypoint;
+
 struct symbol_op {
 	enum keyword type;
 	int (*evaluate)(struct expression *);
 	int (*expand)(struct expression *, int);
 	int (*args)(struct expression *);
+	struct pseudo *(*linearize)(struct entrypoint *, struct expression *);
 
 	/* keywords */
 	struct token *(*declarator)(struct token *token, struct decl_state *ctx);
@@ -308,6 +312,7 @@ extern struct symbol *lookup_symbol(struct ident *, enum namespace);
 extern struct symbol *create_symbol(int stream, const char *name, int type, int namespace);
 extern void init_symbols(void);
 extern void init_builtins(int stream);
+extern void init_linearized_builtins(int stream);
 extern void declare_builtins(void);
 extern void init_ctype(void);
 extern struct symbol *alloc_symbol(struct position, int type);
-- 
2.25.1
