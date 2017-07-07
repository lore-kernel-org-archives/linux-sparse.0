From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 33/34] ptrlist: drop the now unneeded _NOTAG versions
Date: Fri,  7 Jul 2017 15:40:01 +0200
Message-ID: <20170707134002.49500-34-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35374 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbdGGNkq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id z78so4012557lff.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:45 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 c2xml.c          |  4 ++--
 compile.c        |  4 ++--
 ctags.c          |  4 ++--
 graph.c          |  8 ++++----
 obfuscate.c      |  4 ++--
 ptrlist.h        | 10 ----------
 sparse-llvm.c    |  4 ++--
 sparse.c         |  4 ++--
 test-dissect.c   |  4 ++--
 test-inspect.c   |  4 ++--
 test-lexing.c    |  4 ++--
 test-linearize.c |  4 ++--
 test-parsing.c   |  4 ++--
 test-unssa.c     |  4 ++--
 14 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/c2xml.c b/c2xml.c
index c45d5818a..1a24c3a81 100644
--- a/c2xml.c
+++ b/c2xml.c
@@ -318,12 +318,12 @@ int main(int argc, char **argv)
 */
 	symlist = sparse_initialize(argc, argv, &filelist);
 
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		examine_symbol_list(file, symlist);
 		sparse_keep_tokens(file);
 		examine_symbol_list(file, file_scope->symbols);
 		examine_symbol_list(file, global_scope->symbols);
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 
 
 	xmlSaveFormatFileEnc("-", doc, "UTF-8", 1);
diff --git a/compile.c b/compile.c
index eeb996abd..7c16d5b55 100644
--- a/compile.c
+++ b/compile.c
@@ -59,7 +59,7 @@ int main(int argc, char **argv)
 	bits_in_bool = 8;
 
 	clean_up_symbols(sparse_initialize(argc, argv, &filelist));
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		struct symbol_list *list;
 		const char *basename = strrchr(file, '/');
 		basename = basename ?  basename+1 : file;
@@ -70,7 +70,7 @@ int main(int argc, char **argv)
 		emit_unit_begin(basename);
 		clean_up_symbols(list);
 		emit_unit_end();
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 
 #if 0
 	// And show the allocation statistics
diff --git a/ctags.c b/ctags.c
index 9ec6b3c37..6cf8d29be 100644
--- a/ctags.c
+++ b/ctags.c
@@ -216,10 +216,10 @@ int main(int argc, char **argv)
 	char *file;
 
 	examine_symbol_list(sparse_initialize(argc, argv, &filelist));
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		sparse(file);
 		examine_symbol_list(file_scope->symbols);
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 	examine_symbol_list(global_scope->symbols);
 	sort_list((struct ptr_list **)&taglist, cmp_sym);
 	show_tags(taglist);
diff --git a/graph.c b/graph.c
index 8cbc22027..4b7ca489b 100644
--- a/graph.c
+++ b/graph.c
@@ -172,7 +172,7 @@ int main(int argc, char **argv)
 
 	/* Linearize all symbols, graph internal basic block
 	 * structures and intra-file calls */
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 
 		fsyms = sparse(file);
 		concat_symbol_list(fsyms, &all_syms);
@@ -187,15 +187,15 @@ int main(int argc, char **argv)
 				graph_ep(sym->ep);
 				graph_calls(sym->ep, 1);
 			}
-		} END_FOR_EACH_PTR_NOTAG(sym);
+		} END_FOR_EACH_PTR(sym);
 
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 
 	/* Graph inter-file calls */
 	FOR_EACH_PTR(all_syms, sym) {
 		if (sym->ep)
 			graph_calls(sym->ep, 0);
-	} END_FOR_EACH_PTR_NOTAG(sym);
+	} END_FOR_EACH_PTR(sym);
 
 	printf("}\n");
 	return 0;
diff --git a/obfuscate.c b/obfuscate.c
index 18cbd0eef..998eda643 100644
--- a/obfuscate.c
+++ b/obfuscate.c
@@ -69,8 +69,8 @@ int main(int argc, char **argv)
 	char *file;
 
 	emit_symbol_list(sparse_initialize(argc, argv, &filelist));
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		emit_symbol_list(sparse(file));
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 	return 0;
 }
diff --git a/ptrlist.h b/ptrlist.h
index 1796f8466..263e68d01 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -196,22 +196,12 @@ do {										\
 #define END_FOR_EACH_PTR(ptr) \
 	DO_END_FOR_EACH(ptr, __cur##ptr)
 
-#define FOR_EACH_PTR_NOTAG(head, ptr) \
-	FOR_EACH_PTR(head, ptr)
-
-#define END_FOR_EACH_PTR_NOTAG(ptr) END_FOR_EACH_PTR(ptr)
-
 #define FOR_EACH_PTR_REVERSE(head, ptr) \
 	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr)
 
 #define END_FOR_EACH_PTR_REVERSE(ptr) \
 	DO_END_FOR_EACH_REVERSE(ptr, __cur##ptr)
 
-#define FOR_EACH_PTR_REVERSE_NOTAG(head, ptr) \
-	FOR_EACH_REVERSE(head, ptr)
-
-#define END_FOR_EACH_PTR_REVERSE_NOTAG(ptr) END_FOR_EACH_PTR_REVERSE(ptr)
-
 #define THIS_ADDRESS(ptr) \
 	DO_THIS_ADDRESS(ptr, __cur##ptr)
 
diff --git a/sparse-llvm.c b/sparse-llvm.c
index 29fb65f15..447a97977 100644
--- a/sparse-llvm.c
+++ b/sparse-llvm.c
@@ -1153,12 +1153,12 @@ int main(int argc, char **argv)
 
 	/* need ->phi_users */
 	dbg_dead = 1;
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		symlist = sparse(file);
 		if (die_if_error)
 			return 1;
 		compile(module, symlist);
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 
 	LLVMVerifyModule(module, LLVMPrintMessageAction, NULL);
 
diff --git a/sparse.c b/sparse.c
index bceacd94e..0b074a063 100644
--- a/sparse.c
+++ b/sparse.c
@@ -299,9 +299,9 @@ int main(int argc, char **argv)
 
 	// Expand, linearize and show it.
 	check_symbols(sparse_initialize(argc, argv, &filelist));
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		check_symbols(sparse(file));
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 
 	report_stats();
 	return 0;
diff --git a/test-dissect.c b/test-dissect.c
index 862318f81..266148be0 100644
--- a/test-dissect.c
+++ b/test-dissect.c
@@ -88,10 +88,10 @@ int main(int argc, char **argv)
 
 	sparse_initialize(argc, argv, &filelist);
 
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		dotc_stream = input_stream_nr;
 		dissect(__sparse(file), &reporter);
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 
 	return 0;
 }
diff --git a/test-inspect.c b/test-inspect.c
index e437e1124..63754cb3c 100644
--- a/test-inspect.c
+++ b/test-inspect.c
@@ -32,11 +32,11 @@ int main(int argc, char **argv)
 
 	gtk_init(&argc,&argv);
 	expand_symbols(sparse_initialize(argc, argv, &filelist));
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		struct symbol_list *syms = sparse(file);
 		expand_symbols(syms);
 		concat_symbol_list(syms, &view_syms);
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 	treeview_main(view_syms);
 	return 0;
 }
diff --git a/test-lexing.c b/test-lexing.c
index 5c7ab2adf..a26398635 100644
--- a/test-lexing.c
+++ b/test-lexing.c
@@ -41,9 +41,9 @@ int main(int argc, char **argv)
 
 	preprocess_only = 1;
 	sparse_initialize(argc, argv, &filelist);
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		sparse(file);
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 	show_identifier_stats();
 	return 0;
 }
diff --git a/test-linearize.c b/test-linearize.c
index fe0673bef..3f29eecd3 100644
--- a/test-linearize.c
+++ b/test-linearize.c
@@ -58,9 +58,9 @@ int main(int argc, char **argv)
 	char *file;
 
 	clean_up_symbols(sparse_initialize(argc, argv, &filelist));
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		clean_up_symbols(sparse(file));
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 
 	report_stats();
 	return 0;
diff --git a/test-parsing.c b/test-parsing.c
index 7642205af..c5bc42e19 100644
--- a/test-parsing.c
+++ b/test-parsing.c
@@ -64,7 +64,7 @@ int main(int argc, char **argv)
 	printf("\n\n");
 #endif
 
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		list = sparse(file);
 
 		// Simplification
@@ -75,7 +75,7 @@ int main(int argc, char **argv)
 		show_symbol_list(list, "\n\n");
 		printf("\n\n");
 #endif
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 
 #if 0
 	// And show the allocation statistics
diff --git a/test-unssa.c b/test-unssa.c
index 240d99601..3d0a82b7c 100644
--- a/test-unssa.c
+++ b/test-unssa.c
@@ -78,9 +78,9 @@ int main(int argc, char **argv)
 	char *file;
 
 	compile(sparse_initialize(argc, argv, &filelist));
-	FOR_EACH_PTR_NOTAG(filelist, file) {
+	FOR_EACH_PTR(filelist, file) {
 		compile(sparse(file));
-	} END_FOR_EACH_PTR_NOTAG(file);
+	} END_FOR_EACH_PTR(file);
 
 	report_stats();
 	return 0;
-- 
2.13.0

