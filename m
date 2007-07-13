From: Al Viro <viro@ftp.linux.org.uk>
Subject: [PATCH 1/8] saner show_type()
Date: Fri, 13 Jul 2007 18:44:27 +0100
Message-ID: <E1I9PBr-0000Dj-4W@ZenIV.linux.org.uk>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:49717 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbXGMRo1 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 13:44:27 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1I9PBr-0000Dj-4W
	for linux-sparse@vger.kernel.org; Fri, 13 Jul 2007 18:44:27 +0100
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org


Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 show-parse.c |   62 +++++++++++++++++++++++++++++++++++++++++----------------
 1 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/show-parse.c b/show-parse.c
index aae8b74..9a1f796 100644
--- a/show-parse.c
+++ b/show-parse.c
@@ -226,11 +226,28 @@ const char *builtin_ctypename(struct ctype *ctype)
 	return NULL;
 }
 
-static void do_show_type(struct symbol *sym, struct type_name *name)
+static void do_show_type(struct symbol *sym, struct type_name *name,
+			 unsigned long mod, int as, int was_ptr)
 {
-	int modlen;
-	const char *mod;
 	const char *typename;
+	int is_ptr = was_ptr;
+
+	if (!sym || (sym->type != SYM_NODE && sym->type != SYM_ARRAY &&
+		     sym->type != SYM_BITFIELD)) {
+		const char *s;
+		size_t len;
+
+		if (as)
+			prepend(name, "<asn:%d>", as);
+
+		s = modifier_string(mod);
+		len = strlen(s);
+		name->start -= len;    
+		memcpy(name->start, s, len);  
+		mod = 0;
+		as = 0;
+	}
+
 	if (!sym)
 		return;
 
@@ -246,9 +263,14 @@ static void do_show_type(struct symbol *sym, struct type_name *name)
 	switch (sym->type) {
 	case SYM_PTR:
 		prepend(name, "*");
+		mod = sym->ctype.modifiers;
+		as = sym->ctype.as;
+		is_ptr = 1;
 		break;
 	case SYM_FN:
-		prepend(name, "( ");
+		if (was_ptr)
+			prepend(name, "( ");
+		is_ptr = 0;
 		break;
 	case SYM_STRUCT:
 		prepend(name, "struct %s ", show_ident(sym->ident));
@@ -264,9 +286,13 @@ static void do_show_type(struct symbol *sym, struct type_name *name)
 
 	case SYM_NODE:
 		append(name, "%s", show_ident(sym->ident));
+		mod |= sym->ctype.modifiers;
+		as |= sym->ctype.as;
 		break;
 
 	case SYM_BITFIELD:
+		mod |= sym->ctype.modifiers;
+		as |= sym->ctype.as;
 		append(name, ":%d", sym->bit_size);
 		break;
 
@@ -275,6 +301,11 @@ static void do_show_type(struct symbol *sym, struct type_name *name)
 		break;
 
 	case SYM_ARRAY:
+		mod |= sym->ctype.modifiers;
+		as |= sym->ctype.as;
+		if (was_ptr)
+			prepend(name, "( ");
+		is_ptr = 0;
 		break;
 
 	case SYM_RESTRICT:
@@ -288,26 +319,21 @@ static void do_show_type(struct symbol *sym, struct type_name *name)
 		return;
 	}
 
-	mod = modifier_string(sym->ctype.modifiers);
-	modlen = strlen(mod);
-	name->start -= modlen;    
-	memcpy(name->start, mod, modlen);  
-
-	do_show_type(sym->ctype.base_type, name);
-
-	/* Postpend */
-	if (sym->ctype.as)
-		append(name, "<asn:%d>", sym->ctype.as);
+	do_show_type(sym->ctype.base_type, name, mod, as, is_ptr);
 
 	switch (sym->type) {
 	case SYM_PTR:
-		return; 
+		return;
 
 	case SYM_FN:
-		append(name, " )( ... )");
+		if (was_ptr)
+			append(name, " )");
+		append(name, "( ... )");
 		return;
 
 	case SYM_ARRAY:
+		if (was_ptr)
+			append(name, " )");
 		append(name, "[%lld]", get_expression_value(sym->array_size));
 		return;
 
@@ -330,7 +356,7 @@ void show_type(struct symbol *sym)
 	struct type_name name;
 
 	name.start = name.end = array+100;
-	do_show_type(sym, &name);
+	do_show_type(sym, &name, 0, 0, 0);
 	*name.end = 0;
 	printf("%s", name.start);
 }
@@ -341,7 +367,7 @@ const char *show_typename(struct symbol *sym)
 	struct type_name name;
 
 	name.start = name.end = array+100;
-	do_show_type(sym, &name);
+	do_show_type(sym, &name, 0, 0, 0);
 	*name.end = 0;
 	return name.start;
 }
-- 
1.5.0-rc2.GIT
