From: Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH] dissect: introduce sym_is_local() for reporter
Date: Tue, 11 Feb 2020 17:01:36 +0100
Message-ID: <20200211160136.GA14027@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58940 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728389AbgBKQBl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Feb 2020 11:01:41 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Alexey Gladkov <gladkov.alexey@gmail.com>, linux-sparse@vger.kernel.org

Can be used to filter out the usage of local variables.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 dissect.c      |  2 +-
 dissect.h      |  5 +++++
 test-dissect.c | 18 ++++++++++++++----
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/dissect.c b/dissect.c
index d9ca142..823a348 100644
--- a/dissect.c
+++ b/dissect.c
@@ -165,7 +165,7 @@ static inline struct symbol *expr_symbol(struct expression *expr)
 		if (!sym) {
 			sym = alloc_symbol(expr->pos, SYM_BAD);
 			bind_symbol(sym, expr->symbol_name, NS_SYMBOL);
-			sym->ctype.modifiers = MOD_EXTERN;
+			sym->ctype.modifiers = MOD_EXTERN | MOD_TOPLEVEL;
 			sym->kind = expr->op ?: 'v'; /* see EXPR_CALL */
 		}
 	}
diff --git a/dissect.h b/dissect.h
index efe2c0b..178dba5 100644
--- a/dissect.h
+++ b/dissect.h
@@ -27,6 +27,11 @@ struct reporter
 
 extern struct symbol *dissect_ctx;
 
+static inline bool sym_is_local(struct symbol *sym)
+{
+	return sym->kind == 'v' && !(sym->ctype.modifiers & MOD_TOPLEVEL);
+}
+
 extern void dissect(struct symbol_list *, struct reporter *);
 
 #endif
diff --git a/test-dissect.c b/test-dissect.c
index ece2253..c4b454c 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -37,6 +37,16 @@ static void print_usage(struct position *pos, struct symbol *sym, unsigned mode)
 
 }
 
+static char symscope(struct symbol *sym)
+{
+	if (sym_is_local(sym)) {
+		if (!dissect_ctx)
+			warning(sym->pos, "no context");
+		return '.';
+	}
+	return ' ';
+}
+
 static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
 {
 	print_usage(pos, sym, mode);
@@ -44,8 +54,8 @@ static void r_symbol(unsigned mode, struct position *pos, struct symbol *sym)
 	if (!sym->ident)
 		sym->ident = built_in_ident("__asm__");
 
-	printf("%c %-32.*s %s\n",
-		sym->kind, sym->ident->len, sym->ident->name,
+	printf("%c %c %-32.*s %s\n",
+		symscope(sym), sym->kind, sym->ident->len, sym->ident->name,
 		show_typename(sym->ctype.base_type));
 
 	switch (sym->kind) {
@@ -80,8 +90,8 @@ static void r_member(unsigned mode, struct position *pos, struct symbol *sym, st
 	/* mem == NULL means entire struct accessed */
 	mi = mem ? mem->ident : built_in_ident("*");
 
-	printf("m %.*s.%-*.*s %s\n",
-		si->len, si->name,
+	printf("%c m %.*s.%-*.*s %s\n",
+		symscope(sym), si->len, si->name,
 		32-1 - si->len, mi->len, mi->name,
 		show_typename(mem ? mem->ctype.base_type : sym));
 
-- 
2.5.0
