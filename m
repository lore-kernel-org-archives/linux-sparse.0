From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v5 05/14] add is_signed_type()
Date: Sat, 25 Mar 2017 00:14:12 +0100
Message-ID: <20170324231421.14869-6-luc.vanoostenryck@gmail.com>
References: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35896 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755308AbdCXXOe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 19:14:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id x124so780247wmf.3
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 16:14:33 -0700 (PDT)
In-Reply-To: <20170324231421.14869-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 compile-i386.c | 14 ++------------
 show-parse.c   | 11 +----------
 symbol.h       |  9 +++++++++
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index 44b72ec39..a7db0843d 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -192,7 +192,6 @@ static const char *current_section;
 static void emit_comment(const char * fmt, ...) FORMAT_ATTR(1);
 static void emit_move(struct storage *src, struct storage *dest,
 		      struct symbol *ctype, const char *comment);
-static int type_is_signed(struct symbol *sym);
 static struct storage *x86_address_gen(struct expression *expr);
 static struct storage *x86_symbol_expr(struct symbol *sym);
 static void x86_symbol(struct symbol *sym);
@@ -1165,7 +1164,7 @@ static void emit_move(struct storage *src, struct storage *dest,
 
 	if (ctype) {
 		bits = ctype->bit_size;
-		is_signed = type_is_signed(ctype);
+		is_signed = is_signed_type(ctype);
 	} else {
 		bits = 32;
 		is_signed = 0;
@@ -1357,7 +1356,7 @@ static struct storage *emit_binop(struct expression *expr)
 	if ((expr->op == '/') || (expr->op == '%'))
 		return emit_divide(expr, left, right);
 
-	is_signed = type_is_signed(expr->ctype);
+	is_signed = is_signed_type(expr->ctype);
 
 	switch (expr->op) {
 	case '+':
@@ -2266,15 +2265,6 @@ static void x86_symbol_init(struct symbol *sym)
 	priv->addr = new;
 }
 
-static int type_is_signed(struct symbol *sym)
-{
-	if (sym->type == SYM_NODE)
-		sym = sym->ctype.base_type;
-	if (sym->type == SYM_PTR)
-		return 0;
-	return !(sym->ctype.modifiers & MOD_UNSIGNED);
-}
-
 static struct storage *x86_label_expr(struct expression *expr)
 {
 	struct storage *new = stack_alloc(4);
diff --git a/show-parse.c b/show-parse.c
index d365d737f..b6ab7b3db 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -949,15 +949,6 @@ static int show_symbol_init(struct symbol *sym)
 	return 0;
 }
 
-static int type_is_signed(struct symbol *sym)
-{
-	if (sym->type == SYM_NODE)
-		sym = sym->ctype.base_type;
-	if (sym->type == SYM_PTR)
-		return 0;
-	return !(sym->ctype.modifiers & MOD_UNSIGNED);
-}
-
 static int show_cast_expr(struct expression *expr)
 {
 	struct symbol *old_type, *new_type;
@@ -973,7 +964,7 @@ static int show_cast_expr(struct expression *expr)
 	if (oldbits >= newbits)
 		return op;
 	new = new_pseudo();
-	is_signed = type_is_signed(old_type);
+	is_signed = is_signed_type(old_type);
 	if (is_signed) {
 		printf("\tsext%d.%d\tv%d,v%d\n", oldbits, newbits, new, op);
 	} else {
diff --git a/symbol.h b/symbol.h
index 36f8345b5..0621d36d7 100644
--- a/symbol.h
+++ b/symbol.h
@@ -335,6 +335,15 @@ static inline int is_enum_type(const struct symbol *type)
 	return (type->type == SYM_ENUM);
 }
 
+static inline int is_signed_type(struct symbol *sym)
+{
+	if (sym->type == SYM_NODE)
+		sym = sym->ctype.base_type;
+	if (sym->type == SYM_PTR)
+		return 0;
+	return !(sym->ctype.modifiers & MOD_UNSIGNED);
+}
+
 static inline int is_type_type(struct symbol *type)
 {
 	return (type->ctype.modifiers & MOD_TYPE) != 0;
-- 
2.12.0

