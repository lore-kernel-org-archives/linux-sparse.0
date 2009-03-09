From: Al Viro <viro@ftp.linux.org.uk>
Subject: Fix __label__ handling
Date: Mon, 09 Mar 2009 23:32:36 +0000
Message-ID: <E1LgoxY-0005y2-C8@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:40554 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbZCIXci (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 9 Mar 2009 19:32:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.69 #1 (Red Hat Linux))
	id 1LgoxY-0005y2-C8
	for linux-sparse@vger.kernel.org; Mon, 09 Mar 2009 23:32:36 +0000
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


a) __label__ in gcc is not a type, it's a statement.  Accepted in the beginning
of compound-statement, has form __label__ ident-list;
b) instead of crapping into NS_SYMBOL namespace (and consequent shadowing
issues), reassign the namespace to NS_LABEL after we'd bound it.  We'll get
block scope and label namespace, i.e. what we get in gcc.
c) MOD_LABEL can be dropped now.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 gdbhelpers               |    3 --
 ident-list.h             |    1 +
 parse.c                  |   55 ++++++++++++++++++++++-----------------------
 symbol.h                 |    1 -
 validation/label-scope.c |   12 ++++++++++
 5 files changed, 40 insertions(+), 32 deletions(-)
 create mode 100644 validation/label-scope.c

diff --git a/gdbhelpers b/gdbhelpers
index 7223ffd..e28417a 100644
--- a/gdbhelpers
+++ b/gdbhelpers
@@ -146,9 +146,6 @@ define gdb_show_ctype
 	if ($arg0->modifiers & MOD_TOPLEVEL)
 		printf "MOD_TOPLEVEL "
 	end
-	if ($arg0->modifiers & MOD_LABEL)
-		printf "MOD_LABEL "
-	end
 	if ($arg0->modifiers & MOD_ASSIGNED)
 		printf "MOD_ASSIGNED "
 	end
diff --git a/ident-list.h b/ident-list.h
index e22084e..29ddeca 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -31,6 +31,7 @@ IDENT(alignof); IDENT_RESERVED(__alignof); IDENT_RESERVED(__alignof__);
 IDENT_RESERVED(__sizeof_ptr__);
 IDENT_RESERVED(__builtin_types_compatible_p);
 IDENT_RESERVED(__builtin_offsetof);
+IDENT_RESERVED(__label__);
 
 /* Attribute names */
 IDENT(packed); IDENT(__packed__);
diff --git a/parse.c b/parse.c
index 00469b2..fa0c511 100644
--- a/parse.c
+++ b/parse.c
@@ -372,8 +372,6 @@ static struct init_keyword {
 	{ "_Bool",	NS_TYPEDEF, .type = &bool_ctype, .op = &spec_op },
 
 	/* Predeclared types */
-	{ "__label__",	NS_TYPEDEF, MOD_LABEL,
-		.type =&label_ctype, .op = &spec_op },
 	{ "__builtin_va_list", NS_TYPEDEF, .type = &ptr_ctype, .op = &spec_op },
 
 	/* Extended types */
@@ -594,28 +592,6 @@ static struct symbol * alloc_indirect_symbol(struct position pos, struct ctype *
 	return sym;
 }
 
-static struct symbol *lookup_or_create_symbol(enum namespace ns, enum type type, struct token *token)
-{
-	struct symbol *sym = lookup_symbol(token->ident, ns);
-	if (!sym) {
-		sym = alloc_symbol(token->pos, type);
-		bind_symbol(sym, token->ident, ns);
-		if (type == SYM_LABEL)
-			fn_local_symbol(sym);
-	}
-	return sym;
-}
-
-static struct symbol * local_label(struct token *token)
-{
-	struct symbol *sym = lookup_symbol(token->ident, NS_SYMBOL);
-
-	if (sym && sym->ctype.modifiers & MOD_LABEL)
-		return sym;
-
-	return NULL;
-}
-
 /*
  * NOTE! NS_LABEL is not just a different namespace,
  * it also ends up using function scope instead of the
@@ -623,10 +599,13 @@ static struct symbol * local_label(struct token *token)
  */
 struct symbol *label_symbol(struct token *token)
 {
-	struct symbol *sym = local_label(token);
-	if (sym)
-		return sym;
-	return lookup_or_create_symbol(NS_LABEL, SYM_LABEL, token);
+	struct symbol *sym = lookup_symbol(token->ident, NS_LABEL);
+	if (!sym) {
+		sym = alloc_symbol(token->pos, SYM_LABEL);
+		bind_symbol(sym, token->ident, NS_LABEL);
+		fn_local_symbol(sym);
+	}
+	return sym;
 }
 
 static struct token *struct_union_enum_specifier(enum type type,
@@ -2149,9 +2128,29 @@ static struct token *statement(struct token *token, struct statement **tree)
 	return expression_statement(token, &stmt->expression);
 }
 
+/* gcc extension - __label__ ident-list; in the beginning of compound stmt */
+static struct token *label_statement(struct token *token)
+{
+	while (token_type(token) == TOKEN_IDENT) {
+		struct symbol *sym = alloc_symbol(token->pos, SYM_LABEL);
+		/* it's block-scope, but we want label namespace */
+		bind_symbol(sym, token->ident, NS_SYMBOL);
+		sym->namespace = NS_LABEL;
+		fn_local_symbol(sym);
+		token = token->next;
+		if (!match_op(token, ','))
+			break;
+		token = token->next;
+	}
+	return expect(token, ';', "at end of label declaration");
+}
+
 static struct token * statement_list(struct token *token, struct statement_list **list)
 {
 	int seen_statement = 0;
+	while (token_type(token) == TOKEN_IDENT &&
+	       token->ident == &__label___ident)
+		token = label_statement(token->next);
 	for (;;) {
 		struct statement * stmt;
 		if (eof_token(token))
diff --git a/symbol.h b/symbol.h
index f9944bf..f58c80a 100644
--- a/symbol.h
+++ b/symbol.h
@@ -207,7 +207,6 @@ struct symbol {
 #define MOD_ACCESSED	0x400000
 #define MOD_TOPLEVEL	0x800000	// scoping..
 
-#define MOD_LABEL	0x1000000
 #define MOD_ASSIGNED	0x2000000
 #define MOD_TYPE	0x4000000
 #define MOD_SAFE	0x8000000	// non-null/non-trapping pointer
diff --git a/validation/label-scope.c b/validation/label-scope.c
new file mode 100644
index 0000000..7af3d91
--- /dev/null
+++ b/validation/label-scope.c
@@ -0,0 +1,12 @@
+static int f(int n)
+{
+	__label__ n;
+n:	return n;
+}
+static int g(int n)
+{
+n:	return n;
+}
+/*
+ * check-name: __label__ scope
+ */
-- 
1.5.6.5

