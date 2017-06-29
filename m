From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/7] diet: squeeze struct ctype's members
Date: Thu, 29 Jun 2017 07:16:46 +0200
Message-ID: <20170629051646.35988-8-luc.vanoostenryck@gmail.com>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33147 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdF2FTG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 29 Jun 2017 01:19:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id j85so351869wmj.0
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 22:19:05 -0700 (PDT)
In-Reply-To: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Using 'int' instead of 'long' for alignment and shuffling
struct ctype's member around avoid any hole in the structure
(on a 64bit machine), making it and struct symbol smaller.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 compile-i386.c | 10 +++++-----
 show-parse.c   |  6 +++---
 symbol.h       |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/compile-i386.c b/compile-i386.c
index 633d9a476..24e408baa 100644
--- a/compile-i386.c
+++ b/compile-i386.c
@@ -899,13 +899,13 @@ static void emit_func_post(struct symbol *sym)
 
 /* emit object (a.k.a. variable, a.k.a. data) prologue */
 static void emit_object_pre(const char *name, unsigned long modifiers,
-			    unsigned long alignment, unsigned int byte_size)
+			    unsigned int alignment, unsigned int byte_size)
 {
 	if ((modifiers & MOD_STATIC) == 0)
 		printf(".globl %s\n", name);
 	emit_section(".data");
 	if (alignment)
-		printf("\t.align %lu\n", alignment);
+		printf("\t.align %u\n", alignment);
 	printf("\t.type\t%s, @object\n", name);
 	printf("\t.size\t%s, %d\n", name, byte_size);
 	printf("%s:\n", name);
@@ -940,7 +940,7 @@ static void emit_scalar(struct expression *expr, unsigned int bit_size)
 }
 
 static void emit_global_noinit(const char *name, unsigned long modifiers,
-			       unsigned long alignment, unsigned int byte_size)
+			       unsigned int alignment, unsigned int byte_size)
 {
 	char s[64];
 
@@ -949,7 +949,7 @@ static void emit_global_noinit(const char *name, unsigned long modifiers,
 		textbuf_push(&unit_post_text, s);
 	}
 	if (alignment)
-		sprintf(s, "\t.comm\t%s,%d,%lu\n", name, byte_size, alignment);
+		sprintf(s, "\t.comm\t%s,%d,%u\n", name, byte_size, alignment);
 	else
 		sprintf(s, "\t.comm\t%s,%d\n", name, byte_size);
 	textbuf_push(&unit_post_text, s);
@@ -1796,7 +1796,7 @@ static void emit_switch_statement(struct statement *stmt)
 
 static void x86_struct_member(struct symbol *sym)
 {
-	printf("\t%s:%d:%ld at offset %ld.%d", show_ident(sym->ident), sym->bit_size, sym->ctype.alignment, sym->offset, sym->bit_offset);
+	printf("\t%s:%d:%u at offset %ld.%d", show_ident(sym->ident), sym->bit_size, sym->ctype.alignment, sym->offset, sym->bit_offset);
 	printf("\n");
 }
 
diff --git a/show-parse.c b/show-parse.c
index dd7e76fc4..5e3e13165 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -72,7 +72,7 @@ static void do_debug_symbol(struct symbol *sym, int indent)
 
 	if (!sym)
 		return;
-	fprintf(stderr, "%.*s%s%3d:%lu %s %s (as: %d) %p (%s:%d:%d) %s\n",
+	fprintf(stderr, "%.*s%s%3d:%u %s %s (as: %d) %p (%s:%d:%d) %s\n",
 		indent, indent_string, typestr[sym->type],
 		sym->bit_size, sym->ctype.alignment,
 		modifier_string(sym->ctype.modifiers), show_ident(sym->ident), sym->ctype.as,
@@ -166,7 +166,7 @@ const char *modifier_string(unsigned long mod)
 
 static void show_struct_member(struct symbol *sym)
 {
-	printf("\t%s:%d:%ld at offset %ld.%d", show_ident(sym->ident), sym->bit_size, sym->ctype.alignment, sym->offset, sym->bit_offset);
+	printf("\t%s:%d:%u at offset %ld.%d", show_ident(sym->ident), sym->bit_size, sym->ctype.alignment, sym->offset, sym->bit_offset);
 	printf("\n");
 }
 
@@ -432,7 +432,7 @@ void show_symbol(struct symbol *sym)
 		return;
 
 	if (sym->ctype.alignment)
-		printf(".align %ld\n", sym->ctype.alignment);
+		printf(".align %u\n", sym->ctype.alignment);
 
 	show_type(sym);
 	type = sym->ctype.base_type;
diff --git a/symbol.h b/symbol.h
index d8733e99f..ab3124662 100644
--- a/symbol.h
+++ b/symbol.h
@@ -99,9 +99,9 @@ DECLARE_PTR_LIST(context_list, struct context);
 
 struct ctype {
 	unsigned long modifiers;
-	unsigned long alignment;
-	struct context_list *contexts;
+	unsigned int alignment;
 	unsigned int as;
+	struct context_list *contexts;
 	struct symbol *base_type;
 };
 
-- 
2.13.0

