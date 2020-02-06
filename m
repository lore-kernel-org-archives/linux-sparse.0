From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] dissect: introduce dissect_ctx
Date: Thu, 6 Feb 2020 18:01:32 +0100
Message-ID: <20200206170132.GA8908@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35529 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726990AbgBFRB5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Feb 2020 12:01:57 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

Points to the current function or to the global variable in case of
compound initializer.

Kill the ugly test-dissect.c:storage() and change print_usage() to
report dissect_ctx->ident instead.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c      | 17 +++++++++++++++--
 dissect.h      |  2 ++
 test-dissect.c | 21 ++++++++-------------
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/dissect.c b/dissect.c
index 60fccbd..54e11d2 100644
--- a/dissect.c
+++ b/dissect.c
@@ -51,6 +51,8 @@
 
 typedef unsigned usage_t;
 
+struct symbol *dissect_ctx;
+
 static struct reporter *reporter;
 static struct symbol *return_type;
 
@@ -211,7 +213,7 @@ static void report_memdef(struct symbol *sym, struct symbol *mem)
 
 static void examine_sym_node(struct symbol *node, struct symbol *parent)
 {
-	struct symbol *base;
+	struct symbol *base, *dctx;
 	struct ident *name;
 
 	if (node->examined)
@@ -240,6 +242,9 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 				return;
 			base->evaluated = 1;
 
+			dctx = dissect_ctx;
+			dissect_ctx = NULL;
+
 			if (base->ident || deanon(base, name, parent))
 				reporter->r_symdef(base);
 
@@ -248,6 +253,7 @@ static void examine_sym_node(struct symbol *node, struct symbol *parent)
 			DO_LIST(base->symbol_list, mem,
 				examine_sym_node(mem, parent);
 				report_memdef(parent, mem));
+			dissect_ctx = dctx;
 		default:
 			return;
 		}
@@ -582,6 +588,7 @@ static struct symbol *do_initializer(struct symbol *type, struct expression *exp
 static inline struct symbol *do_symbol(struct symbol *sym)
 {
 	struct symbol *type = base_type(sym);
+	struct symbol *dctx = dissect_ctx;
 
 	reporter->r_symdef(sym);
 
@@ -590,14 +597,20 @@ static inline struct symbol *do_symbol(struct symbol *sym)
 		if (!sym->initializer)
 			break;
 		reporter->r_symbol(U_W_VAL, &sym->pos, sym);
+		if (!dctx)
+			dissect_ctx = sym;
 		do_initializer(type, sym->initializer);
+		dissect_ctx = dctx;
 
 	break; case SYM_FN:
-		do_sym_list(type->arguments);
+		dissect_ctx = sym;
 		return_type = base_type(type);
+		do_sym_list(type->arguments);
 		do_statement(U_VOID, sym->ctype.modifiers & MOD_INLINE
 					? type->inline_stmt
 					: type->stmt);
+		dissect_ctx = dctx;
+		return_type = NULL;
 	}
 
 	return type;
diff --git a/dissect.h b/dissect.h
index 1f5b1d9..efe2c0b 100644
--- a/dissect.h
+++ b/dissect.h
@@ -25,6 +25,8 @@ struct reporter
 	void (*r_member)(unsigned, struct position *, struct symbol *, struct symbol *);
 };
 
+extern struct symbol *dissect_ctx;
+
 extern void dissect(struct symbol_list *, struct reporter *);
 
 #endif
diff --git a/test-dissect.c b/test-dissect.c
index e725eec..d93a2a0 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -2,17 +2,6 @@
 
 static unsigned dotc_stream;
 
-static inline char storage(struct symbol *sym)
-{
-	int t = sym->type;
-	unsigned m = sym->ctype.modifiers;
-
-	if (m & MOD_INLINE || t == SYM_STRUCT || t == SYM_UNION /*|| t == SYM_ENUM*/)
-		return sym->pos.stream == dotc_stream ? 's' : 'g';
-
-	return (m & MOD_STATIC) ? 's' : (m & MOD_NONLOCAL) ? 'g' : 'l';
-}
-
 static inline const char *show_mode(unsigned mode)
 {
 	static char str[3];
@@ -32,14 +21,20 @@ static inline const char *show_mode(unsigned mode)
 static void print_usage(struct position *pos, struct symbol *sym, unsigned mode)
 {
 	static unsigned curr_stream = -1;
+	static struct ident null;
+	struct ident *ctx = &null;
 
 	if (curr_stream != pos->stream) {
 		curr_stream = pos->stream;
 		printf("\nFILE: %s\n\n", stream_name(curr_stream));
 	}
 
-	printf("%4d:%-3d %c %-5.3s",
-		pos->line, pos->pos, storage(sym), show_mode(mode));
+	if (dissect_ctx)
+		ctx = dissect_ctx->ident;
+
+	printf("%4d:%-3d %-16.*s %-5.3s",
+		pos->line, pos->pos, ctx->len, ctx->name, show_mode(mode));
+
 }
 
 static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
-- 
2.5.0
