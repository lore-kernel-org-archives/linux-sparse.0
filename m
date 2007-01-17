From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 1] The updated sparse ctags
Date: Tue, 16 Jan 2007 18:33:42 -0800
Message-ID: <20070117023342.GA962@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from sccrmhc12.comcast.net ([204.127.200.82]:53632 "EHLO
	sccrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbXAQC4v (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 21:56:51 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>


This is the updated ctags that actually generate output to tags file.

Signed-Off-By: Christopher Li<sparse@chrisli.org>

Index: sparse/symbol.h
===================================================================
--- sparse.orig/symbol.h	2007-01-16 14:52:24.000000000 -0800
+++ sparse/symbol.h	2007-01-16 14:52:36.000000000 -0800
@@ -133,6 +133,10 @@ struct symbol {
 	union /* backend */ {
 		struct basic_block *bb_target;	/* label */
 		void *aux;			/* Auxiliary info, eg. backend information */
+		struct {			/* sparse ctags */
+			char kind;
+			unsigned char visited:1;
+		};
 	};
 	pseudo_t pseudo;
 };
Index: sparse/Makefile
===================================================================
--- sparse.orig/Makefile	2007-01-16 14:52:24.000000000 -0800
+++ sparse/Makefile	2007-01-16 14:53:32.000000000 -0800
@@ -22,7 +22,8 @@ LIBDIR=$(PREFIX)/lib
 INCLUDEDIR=$(PREFIX)/include
 PKGCONFIGDIR=$(PREFIX)/share/pkgconfig
 
-PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize example test-unssa test-dissect
+PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize example \
+	 test-unssa test-dissect ctags
 INST_PROGRAMS=sparse cgcc
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
@@ -93,6 +94,9 @@ test-unssa: test-unssa.o $(LIBS)
 test-dissect: test-dissect.o $(LIBS)
 	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
 
+ctags: ctags.o
+	$(CC) $(LDFLAGS) -o $@ $< $(LIBS)
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(AR) rcs $@ $(LIB_OBJS)
 
@@ -122,6 +126,7 @@ test-lexing.o: $(LIB_H)
 test-parsing.o: $(LIB_H)
 test-linearize.o: $(LIB_H)
 test-dissect.o: $(LIB_H)
+ctags.o: $(LIB_H)
 compile.o: $(LIB_H) compile.h
 compile-i386.o: $(LIB_H) compile.h
 tokenize.o: $(LIB_H)
Index: sparse/ctags.c
===================================================================
--- sparse.orig/ctags.c	2007-01-16 14:52:36.000000000 -0800
+++ sparse/ctags.c	2007-01-16 14:52:36.000000000 -0800
@@ -0,0 +1,210 @@
+/*
+ * Sparse Ctags
+ * 
+ * Ctags generate tags from preprocessing results.
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
+static void show_tag_header(FILE *fp)
+{
+	fprintf(fp, "!_TAG_FILE_FORMAT\t2\t/extended format; --format=1 will not append ;\" to lines/\n");
+	fprintf(fp, "!_TAG_FILE_SORTED\t0\t/1=unsorted, 1=sorted, 2=foldcase/\n");
+	fprintf(fp, "!_TAG_PROGRAM_AUTHOR\tChristopher Li\t/sparse@chrisli.org/\n");
+	fprintf(fp, "!_TAG_PROGRAM_NAME\tSparse Ctags\t//\n");
+	fprintf(fp, "!_TAG_PROGRAM_URL\thttp://kernel.org/pub/linux/kernel/people/josh/sparse/\t/official site/\n");
+	fprintf(fp, "!_TAG_PROGRAM_VERSION\t0.01\t//\n");
+}
+
+static inline void show_symbol_tag(FILE *fp, struct symbol *sym)
+{
+	fprintf(fp, "%s\t%s\t%d;\"\t%c\tfile:\n", show_ident(sym->ident),
+	       stream_name(sym->pos.stream), sym->pos.line, (int)sym->kind);
+}
+
+static void show_tags(struct symbol_list *list)
+{
+	struct symbol *sym;
+	struct ident *ident = NULL;
+	struct position pos = {};
+	static const char *filename;
+	FILE *fp;
+
+	if (!list)
+		return;
+
+	fp = fopen("tags", "w");
+	if (!fp) {
+		perror("open tags file");
+		return;
+	}
+	show_tag_header(fp);
+	FOR_EACH_PTR(list, sym) {
+		if (ident == sym->ident && pos.line == sym->pos.line &&
+		    !strcmp(filename, stream_name(sym->pos.stream)))
+			continue;
+
+		show_symbol_tag(fp, sym);
+		ident = sym->ident;
+		pos = sym->pos;
+		filename = stream_name(sym->pos.stream);
+	} END_FOR_EACH_PTR(sym);
+	fclose(fp);
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
