From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] Sparse Ctags
Date: Thu, 7 Dec 2006 18:27:05 -0800
Message-ID: <20061208022705.GA18370@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc11.comcast.net ([204.127.200.81]:50029 "EHLO
	sccrmhc11.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164385AbWLHCkh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 7 Dec 2006 21:40:37 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

Here is my attempt to write a Ctags base on sparse.
It depend on the result from actually preprocessing the C source file.
It can handle the tags from macro expansion.

It works well enough for me to locate "int32_t" and "clear_token_alloc".

Signed-Off-By: Christopher Li <sparse@chrisli.org>

Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2006-12-07 18:27:50.000000000 -0800
+++ sparse/symbol.h	2006-12-07 18:27:52.000000000 -0800
@@ -133,6 +133,10 @@ struct symbol {
 	union /* backend */ {
 		struct basic_block *bb_target;	/* label */
 		void *aux;			/* Auxiliary info, eg. backend information */
+		struct {			/* sparse ctags */
+			char kind;
+			unsigned int visited:1;
+		};
 	};
 	pseudo_t pseudo;
 };
Index: sparse/Makefile
===================================================================
--- sparse.orig/Makefile	2006-12-07 18:27:50.000000000 -0800
+++ sparse/Makefile	2006-12-07 18:27:52.000000000 -0800
@@ -22,7 +22,7 @@ LIBDIR=$(PREFIX)/lib
 INCLUDEDIR=$(PREFIX)/include
 PKGCONFIGDIR=$(PREFIX)/share/pkgconfig
 
-PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize example test-unssa test-dissect
+PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize example test-unssa test-dissect sctags
 INST_PROGRAMS=sparse cgcc
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
@@ -93,6 +93,9 @@ test-unssa: test-unssa.o $(LIBS)
 test-dissect: test-dissect.o $(LIBS)
 	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
+sctags: sctags.o
+	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(AR) rcs $@ $(LIB_OBJS)
 
@@ -122,6 +125,7 @@ test-lexing.o: $(LIB_H)
 test-parsing.o: $(LIB_H)
 test-linearize.o: $(LIB_H)
 test-dissect.o: $(LIB_H)
+sctags.o: $(LIB_H)
 compile.o: $(LIB_H) compile.h
 compile-i386.o: $(LIB_H) compile.h
 tokenize.o: $(LIB_H)
Index: sparse/sctags.c
===================================================================
--- sparse.orig/sctags.c	2006-12-07 18:27:52.000000000 -0800
+++ sparse/sctags.c	2006-12-07 18:28:11.000000000 -0800
@@ -0,0 +1,202 @@
+/*
+ * Sparse Ctags
+ * 
+ * SCtags generate tags from preprocessing results.
+ *
+ * Copyright (C) 2006 Christopher Li
+ *
+ * Licensed under the Open Software License version 1.1
+ */
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+
+#include "parse.h"
+#include "scope.h"
+
+static struct symbol_list *taglist = NULL;
+
+static void examine_symbol(struct symbol *sym);
+
+#define MAX(_x,_y) ((_x) > (_y) ? (_x) : (_y))
+
+static int cmp_sym(const void* m, const void*n)
+{
+	struct ident *a = ((struct symbol*)m)->ident;
+	struct ident *b = ((struct symbol*)n)->ident;
+	int ret = strncmp(a->name, b->name, MAX(a->len, b->len));
+	if (!ret) {
+		struct position a = ((struct symbol*)m)->pos;
+		struct position b = ((struct symbol*)n)->pos;
+
+		ret = strcmp(stream_name(a.stream), stream_name(b.stream));
+		if (!ret)
+			return a.line < b.line;
+	}
+	return ret;
+}
+
+static void show_tag_header(void)
+{
+	printf("!_TAG_FILE_FORMAT\t2\t/extended format; --format=1 will not append ;\" to lines/\n");
+	printf("!_TAG_FILE_SORTED\t0\t/1=unsorted, 1=sorted, 2=foldcase/\n");
+	printf("!_TAG_PROGRAM_AUTHOR\tChristopher Li\t/sparse@chrisli.org/\n");
+	printf("!_TAG_PROGRAM_NAME\tSparse Ctags\t//\n");
+	printf("!_TAG_PROGRAM_URL\thttp://kernel.org/pub/linux/kernel/people/josh/sparse/\t/official site/\n");
+	printf("!_TAG_PROGRAM_VERSION\t0.01\t//\n");
+}
+
+static inline void show_symbol_tag(struct symbol *sym)
+{
+	printf("%s\t%s\t%d;\"\t%c\tfile:\n", show_ident(sym->ident),
+	       stream_name(sym->pos.stream), sym->pos.line, (int)sym->aux);
+}
+
+static void show_tags(struct symbol_list *list)
+{
+	struct symbol *sym;
+	struct ident *ident = NULL;
+	struct position pos = {};
+	static const char *filename;
+
+	if (!list)
+		return;
+	show_tag_header();
+	FOR_EACH_PTR(list, sym) {
+		if (ident == sym->ident && pos.line == sym->pos.line &&
+		    !strcmp(filename, stream_name(sym->pos.stream)))
+			continue;
+
+		show_symbol_tag(sym);
+		ident = sym->ident;
+		pos = sym->pos;
+		filename = stream_name(sym->pos.stream);
+	} END_FOR_EACH_PTR(sym);
+}
+
+static inline void add_tag(struct symbol *sym)
+{
+	if (sym->ident && !sym->visited) {
+		sym->visited = 1;
+		add_symbol(&taglist, sym);
+	}
+}
+
+
+static inline void examine_members(struct symbol_list *list)
+{
+	struct symbol *sym;
+
+	FOR_EACH_PTR(list, sym) {
+		sym->kind = 'm';
+		examine_symbol(sym);
+	} END_FOR_EACH_PTR(sym);
+}
+
+static void examine_symbol(struct symbol *sym)
+{
+	struct symbol *base = sym;
+
+	if (!sym || sym->visited)
+		return;
+	if (sym->ident && sym->ident->reserved)
+		return;
+
+	add_tag(sym);
+	base = sym->ctype.base_type;
+
+	switch (sym->type) {
+	case SYM_NODE:
+		if (base->type == SYM_FN)
+			sym->kind = 'f';
+		examine_symbol(base);
+		break;
+	case SYM_STRUCT:
+		sym->kind = 's';
+		examine_members(sym->symbol_list);
+		break;
+	case SYM_UNION:
+		sym->kind = 'u';
+		examine_members(sym->symbol_list);
+		break;
+	case SYM_ENUM:
+		sym->kind = 'e';
+	case SYM_PTR:
+	case SYM_TYPEOF:
+	case SYM_BITFIELD:
+	case SYM_FN:
+	case SYM_ARRAY:
+		examine_symbol(sym->ctype.base_type);
+		break;
+	case SYM_BASETYPE:
+		break;
+		
+	default:
+		die("unknown symbol %s namespace:%d type:%d\n", show_ident(sym->ident),
+		    sym->namespace, sym->type);
+	}
+	if (!sym->kind)
+		sym->kind = 'v';
+	return;
+}
+
+static void examine_namespace(struct symbol *sym)
+{
+	if (sym->visited)
+		return;
+	if (sym->ident && sym->ident->reserved)
+		return;
+
+	switch(sym->namespace) {
+	case NS_LABEL:
+		sym->kind = 'l';
+		break;
+	case NS_PREPROCESSOR:
+		break;
+	case NS_MACRO:
+	case NS_UNDEF:
+		sym->kind = 'd';
+		break;
+	case NS_TYPEDEF:
+		sym->kind = 't';
+	case NS_SYMBOL:
+	case NS_STRUCT:
+		examine_symbol(sym);
+		break;
+	default:
+		die("unknown namespace %d symbol:%s type:%d\n", sym->namespace,
+		    show_ident(sym->ident), sym->type);
+	}
+	add_tag(sym);
+}
+
+static inline void examine_symbol_list(struct symbol_list *list)
+{
+	struct symbol *sym;
+
+	if (!list)
+		return;
+	FOR_EACH_PTR(list, sym) {
+		examine_namespace(sym);
+	} END_FOR_EACH_PTR(sym);
+}
+
+
+int main(int argc, char **argv)
+{
+	struct string_list *filelist = NULL;
+	char *file;
+
+	examine_symbol_list(sparse_initialize(argc, argv, &filelist));
+	FOR_EACH_PTR_NOTAG(filelist, file) {
+		sparse(file);
+		examine_symbol_list(file_scope->symbols);
+	} END_FOR_EACH_PTR_NOTAG(file);
+	examine_symbol_list(global_scope->symbols);
+	sort_list((struct ptr_list**)&taglist, cmp_sym);
+	show_tags(taglist);
+	return 0;
+}
+
