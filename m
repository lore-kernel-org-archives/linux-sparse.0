From: Rob Taylor <rob.taylor@codethink.co.uk>
Subject: [PATCH] c2xml
Date: Wed, 27 Jun 2007 14:51:36 +0100
Message-ID: <46826B68.5040302@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040106000808060508000303"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from 208-78-103-131.slicehost.net ([208.78.103.131]:44984 "EHLO
	mail.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753568AbXF0OVn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 27 Jun 2007 10:21:43 -0400
Received: from [192.168.0.4] (82-69-7-91.dsl.in-addr.zen.co.uk [82.69.7.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.codethink.co.uk (Postfix) with ESMTP id A250988246
	for <linux-sparse@vger.kernel.org>; Wed, 27 Jun 2007 13:50:06 +0000 (UTC)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

This is a multi-part message in MIME format.
--------------040106000808060508000303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Here's something I've hacked up for my work on gobject-introspection
[1]. It basically dumps the parse tree for a given file as simplistic
xml, suitable for further transformation by something else (in my case,
some python).

I'd expect this to also be useful for code navigation in editors and c
refactoring tools, but I've really only focused on my needs for c api
description.

There are 3 patches here. The first introduces a field in the symbol
struct for the end position of the symbol. I've added this in my case
for documentation generation, but again I think it'd be useful in other
cases. The next introduces a sparse_keep_tokens, which parses a file,
but doesn't free the tokens after parsing. The final one adds c2xml and
the DTD for the xml format. It builds conditionally on whether libxml2
is available.

All feedback appreciated!

Thanks,
Rob Taylor

[1] http://svn.gnome.org/viewcvs/gobject-introspection/trunk/

--------------040106000808060508000303
Content-Type: text/x-patch;
 name="0001-add-end-position-to-symbols.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-add-end-position-to-symbols.patch"

From c25de54a1a21f98420be67e1007bd26389264f23 Mon Sep 17 00:00:00 2001
From: Rob Taylor <rob.taylor@codethink.co.uk>
Date: Wed, 27 Jun 2007 13:24:57 +0100
Subject: [PATCH 1/3] add end position to symbols

This adds a field in the symbol struct for the position of the end of the
symbol and code to parse.c to fill this in for the various symbol types when
parsing.
---
 parse.c  |   21 ++++++++++++++++++++-
 symbol.c |    1 +
 symbol.h |    1 +
 3 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/parse.c b/parse.c
index cb9f87a..ae14642 100644
--- a/parse.c
+++ b/parse.c
@@ -505,6 +505,7 @@ static struct token *struct_union_enum_specifier(enum type type,
 
 			// Mark the structure as needing re-examination
 			sym->examined = 0;
+			sym->endpos = token->pos;
 		}
 		return token;
 	}
@@ -519,7 +520,10 @@ static struct token *struct_union_enum_specifier(enum type type,
 	sym = alloc_symbol(token->pos, type);
 	token = parse(token->next, sym);
 	ctype->base_type = sym;
-	return expect(token, '}', "at end of specifier");
+	token =  expect(token, '}', "at end of specifier");
+	sym->endpos = token->pos;
+
+	return token;
 }
 
 static struct token *parse_struct_declaration(struct token *token, struct symbol *sym)
@@ -712,6 +716,9 @@ static struct token *parse_enum_declaration(struct token *token, struct symbol *
 			lower_boundary(&lower, &v);
 		}
 		token = next;
+
+		sym->endpos = token->pos;
+
 		if (!match_op(token, ','))
 			break;
 		token = token->next;
@@ -775,6 +782,7 @@ static struct token *typeof_specifier(struct token *token, struct ctype *ctype)
 		token = parse_expression(token->next, &typeof_sym->initializer);
 
 		ctype->modifiers = 0;
+		typeof_sym->endpos = token->pos;
 		ctype->base_type = typeof_sym;
 	}		
 	return expect(token, ')', "after typeof");
@@ -1193,12 +1201,14 @@ static struct token *direct_declarator(struct token *token, struct symbol *decl,
 			sym = alloc_indirect_symbol(token->pos, ctype, SYM_FN);
 			token = parameter_type_list(next, sym, p);
 			token = expect(token, ')', "in function declarator");
+			sym->endpos = token->pos;
 			continue;
 		}
 		if (token->special == '[') {
 			struct symbol *array = alloc_indirect_symbol(token->pos, ctype, SYM_ARRAY);
 			token = abstract_array_declarator(token->next, array);
 			token = expect(token, ']', "in abstract_array_declarator");
+			array->endpos = token->pos;
 			ctype = &array->ctype;
 			continue;
 		}
@@ -1232,6 +1242,7 @@ static struct token *pointer(struct token *token, struct ctype *ctype)
 
 		token = declaration_specifiers(token->next, ctype, 1);
 		modifiers = ctype->modifiers;
+		ctype->base_type->endpos = token->pos;
 	}
 	return token;
 }
@@ -1286,6 +1297,7 @@ static struct token *handle_bitfield(struct token *token, struct symbol *decl)
 		}
 	}
 	bitfield->bit_size = width;
+	bitfield->endpos = token->pos;
 	return token;
 }
 
@@ -1306,6 +1318,7 @@ static struct token *declaration_list(struct token *token, struct symbol_list **
 		}
 		apply_modifiers(token->pos, &decl->ctype);
 		add_symbol(list, decl);
+		decl->endpos = token->pos;
 		if (!match_op(token, ','))
 			break;
 		token = token->next;
@@ -1340,6 +1353,7 @@ static struct token *parameter_declaration(struct token *token, struct symbol **
 	token = declarator(token, sym, &ident);
 	sym->ident = ident;
 	apply_modifiers(token->pos, &sym->ctype);
+	sym->endpos = token->pos;
 	return token;
 }
 
@@ -1350,6 +1364,7 @@ struct token *typename(struct token *token, struct symbol **p)
 	token = declaration_specifiers(token, &sym->ctype, 0);
 	token = declarator(token, sym, NULL);
 	apply_modifiers(token->pos, &sym->ctype);
+	sym->endpos = token->pos;
 	return token;
 }
 
@@ -1818,6 +1833,7 @@ static struct token *parameter_type_list(struct token *token, struct symbol *fn,
 			warning(token->pos, "void parameter");
 		}
 		add_symbol(list, sym);
+		sym->endpos = token->pos;
 		if (!match_op(token, ','))
 			break;
 		token = token->next;
@@ -2104,6 +2120,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 	token = declarator(token, decl, &ident);
 	apply_modifiers(token->pos, &decl->ctype);
 
+	decl->endpos = token->pos;
+
 	/* Just a type declaration? */
 	if (!ident)
 		return expect(token, ';', "end of type declaration");
@@ -2164,6 +2182,7 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
 		token = declaration_specifiers(token, &decl->ctype, 1);
 		token = declarator(token, decl, &ident);
 		apply_modifiers(token->pos, &decl->ctype);
+		decl->endpos = token->pos;
 		if (!ident) {
 			sparse_error(token->pos, "expected identifier name in type definition");
 			return token;
diff --git a/symbol.c b/symbol.c
index 329fed9..7585978 100644
--- a/symbol.c
+++ b/symbol.c
@@ -62,6 +62,7 @@ struct symbol *alloc_symbol(struct position pos, int type)
 	struct symbol *sym = __alloc_symbol(0);
 	sym->type = type;
 	sym->pos = pos;
+	sym->endpos.type = 0;
 	return sym;
 }
 
diff --git a/symbol.h b/symbol.h
index 2bde84d..be5e6b1 100644
--- a/symbol.h
+++ b/symbol.h
@@ -111,6 +111,7 @@ struct symbol {
 	enum namespace namespace:9;
 	unsigned char used:1, attr:2, enum_member:1;
 	struct position pos;		/* Where this symbol was declared */
+	struct position endpos;		/* Where this symbol ends*/
 	struct ident *ident;		/* What identifier this symbol is associated with */
 	struct symbol *next_id;		/* Next semantic symbol that shares this identifier */
 	struct symbol **id_list;	/* Back pointer to symbol list head */
-- 
1.5.2-rc3.GIT


--------------040106000808060508000303
Content-Type: text/x-patch;
 name="0002-add-sparse_keep_tokens-api-to-lib.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-add-sparse_keep_tokens-api-to-lib.h.patch"

From 1e5f5f0a74a21dfe1119c3fdf5ee7410af609623 Mon Sep 17 00:00:00 2001
From: Rob Taylor <rob.taylor@codethink.co.uk>
Date: Wed, 27 Jun 2007 01:33:26 +0100
Subject: [PATCH 2/3] add sparse_keep_tokens api to lib.h

Adds sparse_keep_tokens, which is the same as __sparse, but doesn't free the
tokens after parsing. Useful fow ehen you want to inspect macro symbols after
parsing.
---
 lib.c |   13 ++++++++++++-
 lib.h |    1 +
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/lib.c b/lib.c
index 7fea474..aba547a 100644
--- a/lib.c
+++ b/lib.c
@@ -741,7 +741,7 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 	return list;
 }
 
-struct symbol_list * __sparse(char *filename)
+struct symbol_list * sparse_keep_tokens(char *filename)
 {
 	struct symbol_list *res;
 
@@ -751,6 +751,17 @@ struct symbol_list * __sparse(char *filename)
 	new_file_scope();
 	res = sparse_file(filename);
 
+	/* And return it */
+	return res;
+}
+
+
+struct symbol_list * __sparse(char *filename)
+{
+	struct symbol_list *res;
+
+	res = sparse_keep_tokens(filename);
+
 	/* Drop the tokens for this file after parsing */
 	clear_token_alloc();
 
diff --git a/lib.h b/lib.h
index bc2a8c2..aacafea 100644
--- a/lib.h
+++ b/lib.h
@@ -113,6 +113,7 @@ extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
 extern struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list **files);
 extern struct symbol_list *__sparse(char *filename);
+extern struct symbol_list *sparse_keep_tokens(char *filename);
 extern struct symbol_list *sparse(char *filename);
 
 static inline int symbol_list_size(struct symbol_list *list)
-- 
1.5.2-rc3.GIT


--------------040106000808060508000303
Content-Type: text/x-patch;
 name="0003-add-c2xml-program.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0003-add-c2xml-program.patch"

From 2df402576afb333577647e86d024907e1ab33830 Mon Sep 17 00:00:00 2001
From: Rob Taylor <rob.taylor@codethink.co.uk>
Date: Wed, 27 Jun 2007 01:36:14 +0100
Subject: [PATCH 3/3] add c2xml program

Adds new c2xml program which dumps out the parse tree for a given file as well formed xml. A DTD for the format is included as parse.dtd.
---
 Makefile  |   15 +++
 c2xml.c   |  346 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 parse.dtd |   48 +++++++++
 3 files changed, 409 insertions(+), 0 deletions(-)
 create mode 100644 c2xml.c
 create mode 100644 parse.dtd

diff --git a/Makefile b/Makefile
index 039fe38..67da31f 100644
--- a/Makefile
+++ b/Makefile
@@ -7,6 +7,8 @@ CFLAGS=-O -g -Wall -Wwrite-strings -fpic
 LDFLAGS=-g
 AR=ar
 
+HAVE_LIBXML=$(shell pkg-config --exists libxml-2.0 && echo 'yes')
+
 #
 # For debugging, uncomment the next one
 #
@@ -21,8 +23,15 @@ PKGCONFIGDIR=$(LIBDIR)/pkgconfig
 
 PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize example \
 	 test-unssa test-dissect ctags
+
+
 INST_PROGRAMS=sparse cgcc
 
+ifeq ($(HAVE_LIBXML),yes)
+PROGRAMS+=c2xml
+INST_PROGRAMS+=c2xml
+endif
+
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
 	  linearize.h bitmap.h ident-list.h compat.h flow.h allocate.h \
 	  storage.h ptrlist.h dissect.h
@@ -107,6 +116,12 @@ test-dissect: test-dissect.o $(LIBS)
 ctags: ctags.o $(LIBS)
 	$(QUIET_LINK)$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
+ifeq ($(HAVE_LIBXML),yes)
+c2xml: c2xml.c $(LIBS) $(LIB_H)
+	$(CC) $(LDFLAGS) `pkg-config --cflags --libs libxml-2.0` -o $@ $< $(LIBS)
+
+endif
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(AR) rcs $@ $(LIB_OBJS)
 
diff --git a/c2xml.c b/c2xml.c
new file mode 100644
index 0000000..e42dc31
--- /dev/null
+++ b/c2xml.c
@@ -0,0 +1,346 @@
+/*
+ * Sparse c2xml
+ *
+ * Dumps the parse tree as an xml document
+ *
+ * Copyright (C) 2007 Rob Taylor
+ *
+ * Licensed under the Open Software License version 1.1
+ */
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <libxml/parser.h>
+#include <libxml/tree.h>
+
+#include "parse.h"
+#include "scope.h"
+
+xmlDocPtr doc = NULL;       /* document pointer */
+xmlNodePtr root_node = NULL;/* root node pointer */
+xmlDtdPtr dtd = NULL;       /* DTD pointer */
+xmlNsPtr ns = NULL;         /* namespace pointer */
+int idcount = 0;
+
+static struct symbol_list *taglist = NULL;
+
+static void examine_symbol(struct symbol *sym, xmlNodePtr node);
+
+static inline xmlNodePtr new_sym_node(struct symbol *sym, const char *name, xmlNodePtr parent)
+{
+	xmlNodePtr node;
+	char buf[256];
+	const char *ident = show_ident(sym->ident);
+
+	node = xmlNewChild(parent, NULL, "symbol", NULL);
+
+        xmlNewProp(node, BAD_CAST "type", (xmlChar*) name);
+
+	snprintf(buf, 256, "_%d", idcount);
+	xmlNewProp(node, BAD_CAST "id", BAD_CAST buf);
+
+	if (sym->ident && ident)
+		xmlNewProp(node, BAD_CAST "ident", BAD_CAST ident);
+	xmlNewProp(node, BAD_CAST "file", BAD_CAST stream_name(sym->pos.stream));
+	snprintf(buf, 256, "%d:%d", sym->pos.line, sym->pos.pos);
+	xmlNewProp(node, BAD_CAST "start", BAD_CAST buf);
+
+	if (sym->endpos.type) {
+		snprintf(buf, 256, "%d:%d", sym->endpos.line, sym->endpos.pos);
+		xmlNewProp(node, BAD_CAST "end", BAD_CAST buf);
+        }
+	sym->aux = node;
+
+	idcount++;
+
+	return node;
+}
+
+static inline void examine_members(struct symbol_list *list, xmlNodePtr node)
+{
+	struct symbol *sym;
+	xmlNodePtr child;
+	char buf[256];
+
+	FOR_EACH_PTR(list, sym) {
+		examine_symbol(sym, node);
+	} END_FOR_EACH_PTR(sym);
+}
+
+static const char* get_type_name(enum type type)
+{
+	switch (type) {
+	case SYM_NODE:
+		return "node";
+	case SYM_STRUCT:
+		return "struct";
+	case SYM_UNION:
+		return "union";
+	case SYM_ENUM:
+		return "enum";
+	case SYM_PTR:
+		return "pointer";
+	case SYM_TYPEDEF:
+		return "typedef";
+	case SYM_TYPEOF:
+		return "typeof";
+	case SYM_BITFIELD:
+		return "bitfield";
+	case SYM_FN:
+		return "function";
+	case SYM_ARRAY:
+		return "array";
+	case SYM_BASETYPE:
+		return "basetype";
+	case SYM_KEYWORD:
+		return "keyword";
+	case SYM_PREPROCESSOR:
+		return "preprocessor";
+	case SYM_UNINITIALIZED:
+		return "uninitialized";
+	default:
+		die("unknown type:%d\n", type);
+	}
+}
+
+static void examine_modifiers(struct symbol *sym, xmlNodePtr node)
+{
+	const char *modifiers[] = {
+			"auto",
+			"register",
+			"static",
+			"extern",
+			"const",
+			"volatile",
+			"signed",
+			"unsigned",
+			"char",
+			"short",
+			"long",
+			"long-long",
+			"typedef",
+			NULL,
+			NULL,
+			NULL,
+			NULL,
+			NULL,
+			"inline",
+			"addressable",
+			"nocast",
+			"noderef",
+			"accessed",
+			"toplevel",
+			"label",
+			"assigned",
+			"type-type",
+			"safe",
+			"user-type",
+			"force",
+			"explicitly-signed",
+			"bitwise"};
+
+	int i;
+
+	if (sym->namespace != NS_SYMBOL)
+		return;
+
+	/*iterate over the 32 bit bitfield*/
+	for (i=0; i < 32; i++) {
+		if ((sym->ctype.modifiers & 1<<i) && modifiers[i])
+			xmlNewProp(node, BAD_CAST modifiers[i], BAD_CAST "1");
+	}
+}
+
+static void
+examine_layout(struct symbol *sym, xmlNodePtr node)
+{
+	char buf[256];
+
+	examine_symbol_type(sym);
+
+	snprintf(buf, 256, "%d", sym->bit_size);
+	xmlNewProp(node, BAD_CAST "bit-size", BAD_CAST buf);
+	snprintf(buf, 256, "%d", sym->ctype.alignment);
+	xmlNewProp(node, BAD_CAST "alignment", BAD_CAST buf);
+	snprintf(buf, 256, "%d", sym->offset);
+	xmlNewProp(node, BAD_CAST "offset", BAD_CAST buf);
+	if (is_bitfield_type(sym)) {
+		snprintf(buf, 256, "%d", sym->bit_offset);
+		xmlNewProp(node, BAD_CAST "bit-offset", BAD_CAST buf);
+	}
+}
+
+static void examine_symbol(struct symbol *sym, xmlNodePtr node)
+{
+	xmlNodePtr child = NULL;
+	const char *base;
+	int array_size;
+	char buf[256];
+
+	if (!sym)
+		return;
+	if (sym->aux)		/*already visited */
+		return;
+
+	if (sym->ident && sym->ident->reserved)
+		return;
+
+	child = new_sym_node(sym, get_type_name(sym->type), node);
+	examine_modifiers(sym, child);
+	examine_layout(sym, child);
+
+	if (sym->ctype.base_type) {
+		if ((base = builtin_typename(sym->ctype.base_type)) == NULL) {
+			if (!sym->ctype.base_type->aux) {
+				examine_symbol(sym->ctype.base_type, root_node);
+			}
+			xmlNewProp(child, BAD_CAST "base-type", 
+				xmlGetProp((xmlNodePtr)sym->ctype.base_type->aux, "id"));
+		} else {
+			xmlNewProp(child, BAD_CAST "base-type-builtin", base);
+		}
+	}
+	if (sym->array_size) {
+		/* TODO: modify get_expression_value to give error return */
+		array_size = get_expression_value(sym->array_size);
+		snprintf(buf, 256, "%d", array_size);
+		xmlNewProp(child, BAD_CAST "array-size", BAD_CAST buf);
+	}
+
+
+	switch (sym->type) {
+	case SYM_STRUCT:
+	case SYM_UNION:
+		examine_members(sym->symbol_list, child);
+		break;
+	case SYM_FN:
+		examine_members(sym->arguments, child);
+		break;
+	case SYM_UNINITIALIZED:
+		xmlNewProp(child, BAD_CAST "base-type-builtin", builtin_typename(sym));
+		break;
+	}
+	return;
+}
+
+static struct position *get_expansion_end (struct token *token)
+{
+	struct token *p1, *p2;
+
+	for (p1=NULL, p2=NULL;
+	     !eof_token(token);
+	     p2 = p1, p1 = token, token = token->next);
+
+	if (p2)
+		return &(p2->pos);
+	else
+		return NULL;
+}
+
+static void examine_macro(struct symbol *sym, xmlNodePtr node)
+{
+	xmlNodePtr child;
+	struct position *pos;
+	char buf[256];
+
+	child = new_sym_node(sym, "macro", node);
+	pos = get_expansion_end(sym->expansion);
+        if (pos) {
+		snprintf(buf, 256, "%d:%d", pos->line, pos->pos);
+		xmlNewProp(child, BAD_CAST "end", BAD_CAST buf);
+	} else {
+		xmlNewProp(child, BAD_CAST "end",
+			   xmlGetProp(child, "start"));
+	}
+}
+
+static void examine_namespace(struct symbol *sym)
+{
+	xmlChar *namespace_type = NULL;
+
+	if (sym->ident && sym->ident->reserved)
+		return;
+
+	switch(sym->namespace) {
+	case NS_MACRO:
+		examine_macro(sym, root_node);
+		break;
+	case NS_TYPEDEF:
+	case NS_STRUCT:
+	case NS_SYMBOL:
+		examine_symbol(sym, root_node);
+		break;
+	case NS_NONE:
+	case NS_LABEL:
+	case NS_ITERATOR:
+	case NS_UNDEF:
+	case NS_PREPROCESSOR:
+	case NS_KEYWORD:
+		break;
+	default:
+		die("Unregonised namespace type %d",sym->namespace);
+	}
+
+}
+
+static int get_stream_id (const char *name)
+{
+	int i;
+	for (i=0; i<input_stream_nr; i++) {
+		if (strcmp(name, stream_name(i))==0)
+			return i;
+	}
+	return -1;
+}
+
+static inline void examine_symbol_list(const char *file, struct symbol_list *list)
+{
+	struct symbol *sym;
+	int stream_id = get_stream_id (file);
+
+	if (!list)
+		return;
+	FOR_EACH_PTR(list, sym) {
+		if (sym->pos.stream == stream_id)
+			examine_namespace(sym);
+	} END_FOR_EACH_PTR(sym);
+}
+
+int main(int argc, char **argv)
+{
+	struct string_list *filelist = NULL;
+	struct symbol_list *symlist = NULL;
+	char *file;
+
+	doc = xmlNewDoc(BAD_CAST "1.0");
+	root_node = xmlNewNode(NULL, BAD_CAST "parse");
+	xmlDocSetRootElement(doc, root_node);
+
+/* - A DTD is probably unnecessary for something like this
+ 
+	dtd = xmlCreateIntSubset(doc, BAD_CAST "parse", "http://www.kernel.org/pub/software/devel/sparse/parse.dtd" NULL, BAD_CAST "parse.dtd");
+
+	ns = xmlNewNs (root_node, "http://www.kernel.org/pub/software/devel/sparse/parse.dtd", NULL);
+
+	xmlSetNs(root_node, ns);
+*/
+	symlist = sparse_initialize(argc, argv, &filelist);
+
+	FOR_EACH_PTR_NOTAG(filelist, file) {
+		examine_symbol_list(file, symlist);
+		sparse_keep_tokens(file);
+		examine_symbol_list(file, file_scope->symbols);
+		examine_symbol_list(file, global_scope->symbols);
+	} END_FOR_EACH_PTR_NOTAG(file);
+
+
+	xmlSaveFormatFileEnc("-", doc, "UTF-8", 1);
+	xmlFreeDoc(doc);
+	xmlCleanupParser();
+
+	return 0;
+}
+
+/* vim:set sw=8 noet */
diff --git a/parse.dtd b/parse.dtd
new file mode 100644
index 0000000..dfcef0c
--- /dev/null
+++ b/parse.dtd
@@ -0,0 +1,48 @@
+<!ELEMENT parse (symbol+) >
+
+<!ELEMENT symbol (symbol*) >
+
+<!ATTLIST symbol type CDATA #REQUIRED
+                 id ID #REQUIRED
+		 file CDATA #REQUIRED
+		 start CDATA #REQUIRED
+		 end CDATA #IMPLIED
+
+		 ident CDATA #IMPLIED
+		 base-type IDREF #IMPLIED
+		 base-type-builtin CDATA #IMPLIED
+
+		 array-size CDATA #IMPLIED
+
+		 bit-size CDATA #IMPLIED
+		 alignment CDATA #IMPLIED
+		 offset CDATA #IMPLIED
+		 bit-offset CDATA #IMPLIED
+
+		 auto (0|1) #IMPLIED
+		 register (0|1) #IMPLIED
+		 static (0|1) #IMPLIED
+		 extern (0|1) #IMPLIED
+		 const (0|1) #IMPLIED
+		 volatile (0|1) #IMPLIED
+		 signed (0|1) #IMPLIED
+		 unsigned (0|1) #IMPLIED
+		 char (0|1) #IMPLIED
+		 short (0|1) #IMPLIED
+		 long (0|1) #IMPLIED
+		 long-long (0|1) #IMPLIED
+		 typedef (0|1) #IMPLIED
+		 inline (0|1) #IMPLIED
+		 addressable (0|1) #IMPLIED
+		 nocast (0|1) #IMPLIED
+		 noderef (0|1) #IMPLIED
+		 accessed (0|1) #IMPLIED
+		 toplevel (0|1) #IMPLIED
+		 label (0|1) #IMPLIED
+		 assigned (0|1) #IMPLIED
+		 type-type (0|1) #IMPLIED
+		 safe (0|1) #IMPLIED
+		 usertype (0|1) #IMPLIED
+		 force (0|1) #IMPLIED
+		 explicitly-signed (0|1) #IMPLIED
+		 bitwise (0|1) #IMPLIED >
-- 
1.5.2-rc3.GIT


--------------040106000808060508000303--
