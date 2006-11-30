From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH] cleanup write to argument array hack
Date: Thu, 30 Nov 2006 02:11:36 -0800
Message-ID: <20061130101136.GA27500@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc14.comcast.net ([204.127.192.84]:23718 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S934366AbWK3KXS (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Nov 2006 05:23:18 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

The sparse interface is a kind of snaky that it change the input argument
array. The function sparse() does the same hack just to skip the files.

This patch add the ptr list for string. So sparse_initialize will
return list of file to compile. The string pointer is not aligned
at word boundary. This patch introduce non taged version of the ptr
list iteration function.

Signed-off-by: Christopher Li <sparse@chrisli.org>
Index: sparse/lib.h
===================================================================
--- sparse.orig/lib.h	2006-11-29 23:34:48.000000000 -0800
+++ sparse/lib.h	2006-11-29 23:38:31.000000000 -0800
@@ -51,6 +51,7 @@
 DECLARE_PTR_LIST(instruction_list, struct instruction);
 DECLARE_PTR_LIST(multijmp_list, struct multijmp);
 DECLARE_PTR_LIST(pseudo_list, struct pseudo);
+DECLARE_PTR_LIST(string_list, char);
 
 typedef struct pseudo *pseudo_t;
 
@@ -89,9 +90,9 @@
 
 extern void declare_builtin_functions(void);
 extern void create_builtin_stream(void);
-extern struct symbol_list *sparse_initialize(int argc, char **argv);
-extern struct symbol_list *__sparse(char **argv);
-extern struct symbol_list *sparse(char **argv);
+extern struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list** files);
+extern struct symbol_list *__sparse(char *filename);
+extern struct symbol_list *sparse(char *filename);
 
 static inline int symbol_list_size(struct symbol_list* list)
 {
Index: sparse/lib.c
===================================================================
--- sparse.orig/lib.c	2006-11-29 23:34:48.000000000 -0800
+++ sparse/lib.c	2006-11-30 01:40:53.000000000 -0800
@@ -612,10 +612,9 @@
 	return sparse_tokenstream(token);
 }
 
-struct symbol_list *sparse_initialize(int argc, char **argv)
+struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list **filelist)
 {
 	char **args;
-	int files = 0;
 	struct symbol_list *list;
 
 	// Initialize symbol stream first, so that we can add defines etc
@@ -631,17 +630,11 @@
 			args = handle_switch(arg+1, args);
 			continue;
 		}
-
-		/*
-		 * Hacky hacky hacky: we re-use the argument space
-		 * to save the filenames.
-		 */
-		argv[files++] = arg;
+		add_ptr_list_notag(filelist, arg);
 	}
 
 	list = NULL;
-	argv[files] = NULL;
-	if (files) {
+	if (!ptr_list_empty(filelist)) {
 		// Initialize type system
 		init_ctype();
 
@@ -661,22 +654,13 @@
 	return list;
 }
 
-struct symbol_list * __sparse(char **argv)
+struct symbol_list * __sparse(char *filename)
 {
 	struct symbol_list *res;
-	char *filename, *next;
 
 	/* Clear previous symbol list */
 	translation_unit_used_list = NULL;
 
-	filename = *argv;
-	if (!filename)
-		return NULL;
-	do {
-		next = argv[1];
-		*argv++ = next;
-	} while (next);
-
 	start_file_scope();
 	res = sparse_file(filename);
 	end_file_scope();
@@ -688,9 +672,9 @@
 	return res;
 }
 
-struct symbol_list * sparse(char **argv)
+struct symbol_list * sparse(char *filename)
 {
-	struct symbol_list *res = __sparse(argv);
+	struct symbol_list *res = __sparse(filename);
 
 	/* Evaluate the complete symbol list */
 	evaluate_symbol_list(res);
Index: sparse/test-lexing.c
===================================================================
--- sparse.orig/test-lexing.c	2006-11-29 23:34:48.000000000 -0800
+++ sparse/test-lexing.c	2006-11-30 01:43:58.000000000 -0800
@@ -20,10 +20,14 @@
 
 int main(int argc, char **argv)
 {
+	struct string_list *filelist = NULL;
+	char *file;
+
 	preprocess_only = 1;
-	sparse_initialize(argc, argv);
-	while (*argv)
-		sparse(argv);
+	sparse_initialize(argc, argv, &filelist);
+	FOR_EACH_PTR_NOTAG(filelist, file) {
+		sparse(file);
+	} END_FOR_EACH_PTR_NOTAG(file);
 	show_identifier_stats();
 	return 0;
 }
Index: sparse/test-dissect.c
===================================================================
--- sparse.orig/test-dissect.c	2006-11-29 23:34:48.000000000 -0800
+++ sparse/test-dissect.c	2006-11-29 23:38:31.000000000 -0800
@@ -83,13 +83,15 @@
 		.r_symbol = r_symbol,
 		.r_member = r_member,
 	};
+	struct string_list *filelist = NULL;
+	char *file;
 
-	sparse_initialize(argc, argv);
+	sparse_initialize(argc, argv, &filelist);
 
-	while (*argv) {
+	FOR_EACH_PTR_NOTAG(filelist, file) {
 		dotc_stream = input_stream_nr;
-		dissect(__sparse(argv), &reporter);
-	}
+		dissect(__sparse(file), &reporter);
+	} END_FOR_EACH_PTR_NOTAG(file);
 
 	return 0;
 }
Index: sparse/test-linearize.c
===================================================================
--- sparse.orig/test-linearize.c	2006-11-29 23:34:48.000000000 -0800
+++ sparse/test-linearize.c	2006-11-29 23:38:31.000000000 -0800
@@ -38,8 +38,12 @@
 
 int main(int argc, char **argv)
 {
-	clean_up_symbols(sparse_initialize(argc, argv));
-	while (*argv)
-		clean_up_symbols(sparse(argv));
+	struct string_list *filelist = NULL;
+	char *file;
+
+	clean_up_symbols(sparse_initialize(argc, argv, &filelist));
+	FOR_EACH_PTR_NOTAG(filelist, file) {
+		clean_up_symbols(sparse(file));
+	} END_FOR_EACH_PTR_NOTAG(file);
 	return 0;
 }
Index: sparse/test-parsing.c
===================================================================
--- sparse.orig/test-parsing.c	2006-11-29 23:34:48.000000000 -0800
+++ sparse/test-parsing.c	2006-11-29 23:38:31.000000000 -0800
@@ -35,8 +35,10 @@
 int main(int argc, char **argv)
 {
 	struct symbol_list * list;
+	struct string_list * filelist = NULL;
+	char *file;
 
-	list = sparse_initialize(argc, argv);
+	list = sparse_initialize(argc, argv, &filelist);
 
 	// Simplification
 	clean_up_symbols(list);
@@ -46,8 +48,8 @@
 	printf("\n\n");
 #endif
 
-	while (*argv) {
-		list = sparse(argv);
+	FOR_EACH_PTR_NOTAG(filelist, file) {
+		list = sparse(file);
 
 		// Simplification
 		clean_up_symbols(list);
@@ -57,7 +59,7 @@
 		show_symbol_list(list, "\n\n");
 		printf("\n\n");
 #endif
-	}
+	} END_FOR_EACH_PTR_NOTAG(file);
 
 #if 0
 	// And show the allocation statistics
Index: sparse/test-sort.c
===================================================================
Index: sparse/test-unssa.c
===================================================================
Index: sparse/ptrlist.h
===================================================================
--- sparse.orig/ptrlist.h	2006-11-29 23:34:48.000000000 -0800
+++ sparse/ptrlist.h	2006-11-29 23:38:31.000000000 -0800
@@ -40,7 +40,7 @@
 int replace_ptr_list_entry(struct ptr_list **, void *old, void *new, int);
 extern void sort_list(struct ptr_list **, int (*)(const void *, const void *));
 
-extern void **__add_ptr_list(struct ptr_list **, void *, unsigned long tag);
+extern void **__add_ptr_list(struct ptr_list **, void *, unsigned long);
 extern void concat_ptr_list(struct ptr_list *a, struct ptr_list **b);
 extern void __free_ptr_list(struct ptr_list **);
 extern int ptr_list_size(struct ptr_list *);
@@ -54,18 +54,23 @@
  */
 #define add_ptr_list_tag(list,entry,tag) \
 	MKTYPE(*(list), (CHECK_TYPE(*(list),(entry)),__add_ptr_list((struct ptr_list **)(list), (entry), (tag))))
+#define add_ptr_list_notag(list,entry)										\
+	MKTYPE(*(list), (CHECK_TYPE(*(list),(entry)),__add_ptr_list((struct ptr_list **)(list),			\
+								    (void*)((unsigned long)(entry) & ~3UL), 	\
+								    (unsigned long)(entry) & 3)))
 #define add_ptr_list(list,entry) \
 	add_ptr_list_tag(list,entry,0)
 #define free_ptr_list(list) \
 	do { VRFY_PTR_LIST(*(list)); __free_ptr_list((struct ptr_list **)(list)); } while (0)
 
-#define PTR_ENTRY(h,i)	(void *)(~3UL & (unsigned long)(h)->list[i])
+#define PTR_ENTRY_NOTAG(h,i)	((h)->list[i])
+#define PTR_ENTRY_WITHTAG(h,i)	(void *)(~3UL & (unsigned long)PTR_ENTRY_NOTAG(h,i))
 
 static inline void *first_ptr_list(struct ptr_list *list)
 {
 	if (!list)
 		return NULL;
-	return PTR_ENTRY(list, 0);
+	return PTR_ENTRY_WITHTAG(list, 0);
 }
 
 static inline void *last_ptr_list(struct ptr_list *list)
@@ -74,10 +79,10 @@
 	if (!list)
 		return NULL;
 	list = list->prev;
-	return PTR_ENTRY(list, list->nr-1);
+	return PTR_ENTRY_WITHTAG(list, list->nr-1);
 }
 
-#define DO_PREPARE(head, ptr, __head, __list, __nr)					\
+#define DO_PREPARE(head, ptr, __head, __list, __nr, PTR_ENTRY)				\
 	do {										\
 		struct ptr_list *__head = (struct ptr_list *) (head);			\
 		struct ptr_list *__list = __head;					\
@@ -86,7 +91,7 @@
 		if (__head) ptr = PTR_ENTRY(__head, 0);					\
 		else ptr = NULL
 
-#define DO_NEXT(ptr, __head, __list, __nr)						\
+#define DO_NEXT(ptr, __head, __list, __nr, PTR_ENTRY)					\
 		if (ptr) {								\
 			if (++__nr < __list->nr) {					\
 				ptr = PTR_ENTRY(__list,__nr);				\
@@ -100,7 +105,7 @@
 			}								\
 		}
 
-#define DO_RESET(ptr, __head, __list, __nr)						\
+#define DO_RESET(ptr, __head, __list, __nr, PTR_ENTRY)					\
 	do {										\
 		__nr = 0;								\
 		__list = __head;							\
@@ -112,18 +117,18 @@
 	} while (0)
 
 #define PREPARE_PTR_LIST(head, ptr) \
-	DO_PREPARE(head, ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_PREPARE(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_WITHTAG)
 
 #define NEXT_PTR_LIST(ptr) \
-	DO_NEXT(ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_NEXT(ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_WITHTAG)
 
 #define RESET_PTR_LIST(ptr) \
-	DO_RESET(ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_RESET(ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_WITHTAG)
 
 #define FINISH_PTR_LIST(ptr) \
 	DO_FINISH(ptr, __head##ptr, __list##ptr, __nr##ptr)
 
-#define DO_FOR_EACH(head, ptr, __head, __list, __nr) do {				\
+#define DO_FOR_EACH(head, ptr, __head, __list, __nr, PTR_ENTRY) do {			\
 	struct ptr_list *__head = (struct ptr_list *) (head);				\
 	struct ptr_list *__list = __head;						\
 	CHECK_TYPE(head,ptr);								\
@@ -142,7 +147,7 @@
 	}										\
 } while (0)
 
-#define DO_FOR_EACH_REVERSE(head, ptr, __head, __list, __nr) do {			\
+#define DO_FOR_EACH_REVERSE(head, ptr, __head, __list, __nr, PTR_ENTRY) do {		\
 	struct ptr_list *__head = (struct ptr_list *) (head);				\
 	struct ptr_list *__list = __head;						\
 	CHECK_TYPE(head,ptr);								\
@@ -164,7 +169,8 @@
 	}										\
 } while (0)
 
-#define DO_REVERSE(ptr, __head, __list, __nr, new, __newhead, __newlist, __newnr) do {	\
+#define DO_REVERSE(ptr, __head, __list, __nr, new, __newhead,				\
+		   __newlist, __newnr, PTR_ENTRY) do { 					\
 	struct ptr_list *__newhead = __head;						\
 	struct ptr_list *__newlist = __list;						\
 	int __newnr = __nr;								\
@@ -182,23 +188,33 @@
 
 #define RECURSE_PTR_REVERSE(ptr, new)							\
 	DO_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr,				\
-		   new, __head##new, __list##new, __nr##new)
+		   new, __head##new, __list##new, __nr##new, PTR_ENTRY_WITHTAG)
 
 #define DO_THIS_ADDRESS(ptr, __head, __list, __nr)					\
 	((__typeof__(&(ptr))) (__list->list + __nr))
 
 #define FOR_EACH_PTR(head, ptr) \
-	DO_FOR_EACH(head, ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_FOR_EACH(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_WITHTAG)
 
 #define END_FOR_EACH_PTR(ptr) \
 	DO_END_FOR_EACH(ptr, __head##ptr, __list##ptr, __nr##ptr)
 
+#define FOR_EACH_PTR_NOTAG(head, ptr) \
+	DO_FOR_EACH(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_NOTAG)
+
+#define END_FOR_EACH_PTR_NOTAG(ptr) END_FOR_EACH_PTR(ptr)
+
 #define FOR_EACH_PTR_REVERSE(head, ptr) \
-	DO_FOR_EACH_REVERSE(head, ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_FOR_EACH_REVERSE(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_WITHTAG)
 
 #define END_FOR_EACH_PTR_REVERSE(ptr) \
 	DO_END_FOR_EACH_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr)
 
+#define FOR_EACH_PTR_REVERSE_NOTAG(head, ptr) \
+	DO_FOR_EACH_REVERSE(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_NOTAG)
+
+#define END_FOR_EACH_PTR_REVERSE_NOTAG(ptr) END_FOR_EACH_PTR_REVERSE(ptr)
+	
 #define THIS_ADDRESS(ptr) \
 	DO_THIS_ADDRESS(ptr, __head##ptr, __list##ptr, __nr##ptr)
 
Index: sparse/ptrlist.c
===================================================================
Index: sparse/sort.c
===================================================================
--- sparse.orig/sort.c	2006-11-29 23:34:48.000000000 -0800
+++ sparse/sort.c	2006-11-29 23:38:31.000000000 -0800
@@ -138,7 +138,7 @@
 	// Do a quick skip in case entire blocks from b1 are
 	// already less than smallest element in b2.
 	while (b1->nr == 0 ||
-	       cmp (PTR_ENTRY(b1, b1->nr - 1), PTR_ENTRY(b2,0)) < 0) {
+	       cmp (PTR_ENTRY_WITHTAG(b1, b1->nr - 1), PTR_ENTRY_WITHTAG(b2,0)) < 0) {
 		// printf ("Skipping whole block.\n");
 		BEEN_THERE('H');
 		b1 = b1->next;
@@ -149,8 +149,8 @@
 	}
 
 	while (1) {
-		const void *d1 = PTR_ENTRY(b1,i1);
-		const void *d2 = PTR_ENTRY(b2,i2);
+		const void *d1 = PTR_ENTRY_WITHTAG(b1,i1);
+		const void *d2 = PTR_ENTRY_WITHTAG(b2,i2);
 
 		assert (i1 >= 0 && i1 < b1->nr);
 		assert (i2 >= 0 && i2 < b2->nr);
Index: sparse/obfuscate.c
===================================================================
--- sparse.orig/obfuscate.c	2006-11-29 23:34:48.000000000 -0800
+++ sparse/obfuscate.c	2006-11-29 23:38:31.000000000 -0800
@@ -49,8 +49,12 @@
 
 int main(int argc, char **argv)
 {
-	emit_symbol_list(sparse_initialize(argc, argv));
-	while (*argv)
-		emit_symbol_list(sparse(argv));
+	struct string_list *filelist = NULL;
+	char *file;
+
+	emit_symbol_list(sparse_initialize(argc, argv, &filelist));
+	FOR_EACH_PTR_NOTAG(filelist, file) {
+		emit_symbol_list(sparse(file));
+	} END_FOR_EACH_PTR_NOTAG(file);
 	return 0;
 }
Index: sparse/compile.c
===================================================================
--- sparse.orig/compile.c	2006-11-29 23:34:48.000000000 -0800
+++ sparse/compile.c	2006-11-29 23:38:31.000000000 -0800
@@ -37,21 +37,22 @@
 
 int main(int argc, char **argv)
 {
-	const char *filename;
+	char *file;
+	struct string_list *filelist = NULL;
 
-	clean_up_symbols(sparse_initialize(argc, argv));
-	while ((filename = *argv) != NULL) {
+	clean_up_symbols(sparse_initialize(argc, argv, &filelist));
+	FOR_EACH_PTR_NOTAG(filelist, file) {
 		struct symbol_list *list;
-		const char *basename = strrchr(filename, '/');
-		if (basename)
-			filename = basename+1;
-		list = sparse(argv);
+		const char *basename = strrchr(file, '/');
+		basename = basename ?  basename+1 : file;
+
+		list = sparse(file);
 
 		// Do type evaluation and simplification
-		emit_unit_begin(filename);
+		emit_unit_begin(basename);
 		clean_up_symbols(list);
 		emit_unit_end();
-	}
+	} END_FOR_EACH_PTR_NOTAG(file);
 
 #if 0
 	// And show the allocation statistics
Index: sparse/graph.c
===================================================================
--- sparse.orig/graph.c	2006-11-29 23:34:49.000000000 -0800
+++ sparse/graph.c	2006-11-29 23:38:31.000000000 -0800
@@ -55,10 +55,15 @@
 
 int main(int argc, char **argv)
 {
+	struct string_list *filelist = NULL;
+	char *file;
+
 	printf("digraph control_flow {\n");
-	graph_symbols(sparse_initialize(argc, argv));
-	while (*argv)
-		graph_symbols(sparse(argv));
+	graph_symbols(sparse_initialize(argc, argv, &filelist));
+	
+	FOR_EACH_PTR_NOTAG(filelist, file) {
+		graph_symbols(sparse(file));
+	} END_FOR_EACH_PTR_NOTAG(file);
 	printf("}\n");
 	return 0;
 }
Index: sparse/check.c
===================================================================
--- sparse.orig/check.c	2006-11-29 23:34:49.000000000 -0800
+++ sparse/check.c	2006-11-29 23:38:31.000000000 -0800
@@ -271,9 +271,13 @@
 
 int main(int argc, char **argv)
 {
+	struct string_list *filelist = NULL;
+	char *file;
+
 	// Expand, linearize and show it.
-	check_symbols(sparse_initialize(argc, argv));
-	while (*argv)
-		check_symbols(sparse(argv));
+	check_symbols(sparse_initialize(argc, argv, &filelist));
+	FOR_EACH_PTR_NOTAG(filelist, file) {
+		check_symbols(sparse(file));
+	} END_FOR_EACH_PTR_NOTAG(file);
 	return 0;
 }
Index: sparse/example.c
===================================================================
--- sparse.orig/example.c	2006-11-29 23:34:49.000000000 -0800
+++ sparse/example.c	2006-11-29 23:38:31.000000000 -0800
@@ -1942,9 +1942,13 @@
 
 int main(int argc, char **argv)
 {
-	compile(sparse_initialize(argc, argv));
-	while (*argv)
-		compile(sparse(argv));
+	struct string_list *filelist = NULL;
+	char *file;
+
+	compile(sparse_initialize(argc, argv, &filelist));
+	FOR_EACH_PTR_NOTAG(filelist, file) {
+		compile(sparse(file));
+	} END_FOR_EACH_PTR_NOTAG(file);
 	return 0;
 }
 
