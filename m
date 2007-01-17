From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 8] Enhance debug information.
Date: Tue, 16 Jan 2007 18:42:39 -0800
Message-ID: <20070117024239.GI962@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:47761 "EHLO
	rwcrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbXAQDFg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 22:05:36 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>

I found it very useful for debug_symbol to show the builtin
type name.

Signed-off-by: Christopher Li<sparse@chrisli.org>

Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2006-12-14 20:26:32.000000000 -0800
+++ sparse/symbol.h	2006-12-14 20:28:01.000000000 -0800
@@ -239,6 +239,8 @@ extern void bind_symbol(struct symbol *,
 extern struct symbol *examine_symbol_type(struct symbol *);
 extern void examine_simple_symbol_type(struct symbol *);
 extern const char *show_typename(struct symbol *sym);
+extern const char* builtin_typename(struct symbol *sym);
+extern const char* builtin_ctypename(struct ctype *ctype);
 
 extern void debug_symbol(struct symbol *);
 extern void merge_type(struct symbol *sym, struct symbol *base_type);
Index: sparse/show-parse.c
===================================================================
--- sparse.orig/show-parse.c	2006-12-14 20:26:32.000000000 -0800
+++ sparse/show-parse.c	2006-12-14 20:28:01.000000000 -0800
@@ -56,11 +56,12 @@ static void do_debug_symbol(struct symbo
 
 	if (!sym)
 		return;
-	fprintf(stderr, "%.*s%s%3d:%lu %lx %s (as: %d) %p (%s:%d:%d)\n",
+	fprintf(stderr, "%.*s%s%3d:%lu %s %s (as: %d) %p (%s:%d:%d) %s\n",
 		indent, indent_string, typestr[sym->type],
 		sym->bit_size, sym->ctype.alignment,
-		sym->ctype.modifiers, show_ident(sym->ident), sym->ctype.as,
-		sym, stream_name(sym->pos.stream), sym->pos.line, sym->pos.pos);
+		modifier_string(sym->ctype.modifiers), show_ident(sym->ident), sym->ctype.as,
+		sym, stream_name(sym->pos.stream), sym->pos.line, sym->pos.pos,
+		builtin_typename(sym) ?: "");
 	i = 0;
 	FOR_EACH_PTR(sym->ctype.contexts, context) {
 		/* FIXME: should print context expression */
@@ -98,7 +99,7 @@ const char *modifier_string(unsigned lon
 	const char *res,**ptr, *names[] = {
 		"auto", "register", "static", "extern",
 		"const", "volatile", "[signed]", "[unsigned]",
-		"[char]", "[short]", "[long]", "[long]",
+		"[char]", "[short]", "[long]", "[long long]",
 		"[typdef]", "[structof]", "[unionof]", "[enum]",
 		"[typeof]", "[attribute]", "inline", "[addressable]",
 		"[nocast]", "[noderef]", "[accessed]", "[toplevel]",
@@ -171,53 +172,74 @@ static void append(struct type_name *nam
 	name->end += n;
 }
 
+static struct ctype_name {
+	struct symbol *sym;
+	const char *name;
+} typenames[] = {
+	{ & char_ctype,  "char" },
+	{ &schar_ctype,  "signed char" },
+	{ &uchar_ctype,  "unsigned char" },
+	{ & short_ctype, "short" },
+	{ &sshort_ctype, "signed short" },
+	{ &ushort_ctype, "unsigned short" },
+	{ & int_ctype,   "int" },
+	{ &sint_ctype,   "signed int" },
+	{ &uint_ctype,   "unsigned int" },
+	{ &slong_ctype,  "signed long" },
+	{ & long_ctype,  "long" },
+	{ &ulong_ctype,  "unsigned long" },
+	{ & llong_ctype, "long long" },
+	{ &sllong_ctype, "signed long long" },
+	{ &ullong_ctype, "unsigned long long" },
+
+	{ &void_ctype,   "void" },
+	{ &bool_ctype,   "bool" },
+	{ &string_ctype, "string" },
+
+	{ &float_ctype,  "float" },
+	{ &double_ctype, "double" },
+	{ &ldouble_ctype,"long double" },
+	{ &incomplete_ctype, "incomplete type" },
+	{ &int_type, "abstract int" },
+	{ &fp_type, "abstract fp" },
+	{ &label_ctype, "label type" },
+	{ &bad_ctype, "bad type" },
+};
+
+const char* builtin_typename(struct symbol *sym)
+{
+	int i;
+
+	for (i = 0; i < sizeof(typenames)/sizeof(typenames[0]); i++)
+		if (typenames[i].sym == sym)
+			return typenames[i].name;
+	return NULL;
+}
+
+const char* builtin_ctypename(struct ctype *ctype)
+{
+	int i;
+
+	for (i = 0; i < sizeof(typenames)/sizeof(typenames[0]); i++)
+		if (&typenames[i].sym->ctype == ctype)
+			return typenames[i].name;
+	return NULL;
+}
+
 static void do_show_type(struct symbol *sym, struct type_name *name)
 {
-	int i, modlen;
+	int modlen;
 	const char *mod;
-	static struct ctype_name {
-		struct symbol *sym;
-		const char *name;
-	} typenames[] = {
-		{ & char_ctype,  "char" },
-		{ &schar_ctype,  "signed char" },
-		{ &uchar_ctype,  "unsigned char" },
-		{ & short_ctype, "short" },
-		{ &sshort_ctype, "signed short" },
-		{ &ushort_ctype, "unsigned short" },
-		{ & int_ctype,   "int" },
-		{ &sint_ctype,   "signed int" },
-		{ &uint_ctype,   "unsigned int" },
-		{ &slong_ctype,  "signed long" },
-		{ & long_ctype,  "long" },
-		{ &ulong_ctype,  "unsigned long" },
-		{ & llong_ctype, "long long" },
-		{ &sllong_ctype, "signed long long" },
-		{ &ullong_ctype, "unsigned long long" },
-
-		{ &void_ctype,   "void" },
-		{ &bool_ctype,   "bool" },
-		{ &string_ctype, "string" },
-
-		{ &float_ctype,  "float" },
-		{ &double_ctype, "double" },
-		{ &ldouble_ctype,"long double" },
-		{ &incomplete_ctype, "incomplete type" },
-		{ &label_ctype, "label type" },
-		{ &bad_ctype, "bad type" },
-	};
-
+	const char *typename;
 	if (!sym)
 		return;
 
-	for (i = 0; i < sizeof(typenames)/sizeof(typenames[0]); i++) {
-		if (typenames[i].sym == sym) {
-			int len = strlen(typenames[i].name);
-			*--name->start = ' ';
-			name->start -= len;
-			memcpy(name->start, typenames[i].name, len);
-			return;
-		}
+	if ((typename = builtin_typename(sym))) {
+		int len = strlen(typename);
+		*--name->start = ' ';
+		name->start -= len;
+		memcpy(name->start, typename, len);
+		return;
 	}
 
 	/* Prepend */
