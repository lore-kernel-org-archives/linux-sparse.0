From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH 11] Make the ptrlist using the sparse allocator.
Date: Tue, 16 Jan 2007 18:48:39 -0800
Message-ID: <20070117024839.GL962@chrisli.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from alnrmhc12.comcast.net ([204.127.225.92]:47292 "EHLO
	alnrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbXAQDL5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 16 Jan 2007 22:11:57 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@freedesktop.org>

We can drop the whole allocator without freeing the
ptrlist one by one.

Signed-off-by: Christopher Li <sparse@chrisli.org>

Index: sparse/ptrlist.h
===================================================================
Index: sparse/allocate.c
===================================================================
--- sparse.orig/allocate.c	2007-01-10 22:26:27.000000000 -0800
+++ sparse/allocate.c	2007-01-16 18:27:48.000000000 -0800
@@ -119,7 +119,7 @@ ALLOCATOR(expression, "expressions");
 ALLOCATOR(statement, "statements");
 ALLOCATOR(string, "strings");
 ALLOCATOR(scope, "scopes");
-__ALLOCATOR(void, 0, 1, "bytes", bytes);
+__DO_ALLOCATOR(void, 0, 1, "bytes", bytes);
 ALLOCATOR(basic_block, "basic_block");
 ALLOCATOR(entrypoint, "entrypoint");
 ALLOCATOR(instruction, "instruction");
Index: sparse/allocate.h
===================================================================
--- sparse.orig/allocate.h	2007-01-10 21:38:26.000000000 -0800
+++ sparse/allocate.h	2007-01-16 18:26:22.000000000 -0800
@@ -31,7 +31,7 @@ extern void show_allocations(struct allo
 	extern void protect_##x##_alloc(void);
 #define DECLARE_ALLOCATOR(x) __DECLARE_ALLOCATOR(struct x, x)
 
-#define __ALLOCATOR(type, objsize, objalign, objname, x)	\
+#define __DO_ALLOCATOR(type, objsize, objalign, objname, x)	\
 	static struct allocator_struct x##_allocator = {	\
 		.name = objname,				\
 		.alignment = objalign,				\
@@ -57,7 +57,10 @@ extern void show_allocations(struct allo
 		protect_allocations(&x##_allocator);		\
 	}
 
-#define ALLOCATOR(x, n) __ALLOCATOR(struct x, sizeof(struct x), __alignof__(struct x), n, x)
+#define __ALLOCATOR(t, n, x) 					\
+	__DO_ALLOCATOR(t, sizeof(t), __alignof__(t), n, x)
+
+#define ALLOCATOR(x, n) __ALLOCATOR(struct x, n, x)
 
 DECLARE_ALLOCATOR(ident);
 DECLARE_ALLOCATOR(token);
Index: sparse/ptrlist.c
===================================================================
--- sparse.orig/ptrlist.c	2007-01-16 18:20:12.000000000 -0800
+++ sparse/ptrlist.c	2007-01-16 18:26:49.000000000 -0800
@@ -10,6 +10,11 @@
 #include <assert.h>
 
 #include "ptrlist.h"
+#include "allocate.h"
+#include "compat.h"
+
+__DECLARE_ALLOCATOR(struct ptr_list, ptrlist);
+__ALLOCATOR(struct ptr_list, "ptr list", ptrlist);
 
 int ptr_list_size(struct ptr_list *head)
 {
@@ -72,14 +77,14 @@ restart:
 			if (!entry->nr) {
 				struct ptr_list *prev;
 				if (next == entry) {
-					free(entry);
+					__free_ptrlist(entry);
 					*listp = NULL;
 					return;
 				}
 				prev = entry->prev;
 				prev->next = next;
 				next->prev = prev;
-				free(entry);
+				__free_ptrlist(entry);
 				if (entry == head) {
 					*listp = next;
 					head = next;
@@ -95,7 +100,7 @@ restart:
 void split_ptr_list_head(struct ptr_list *head)
 {
 	int old = head->nr, nr = old / 2;
-	struct ptr_list *newlist = malloc(sizeof(*newlist));
+	struct ptr_list *newlist = __alloc_ptrlist(0);
 	struct ptr_list *next = head->next;
 
 	old -= nr;
@@ -122,9 +127,7 @@ void **__add_ptr_list(struct ptr_list **
 	ptr = (void *)(tag | (unsigned long)ptr);
 
 	if (!list || (nr = (last = list->prev)->nr) >= LIST_NODE_NR) {
-		struct ptr_list *newlist = malloc(sizeof(*newlist));
-		assert(newlist);
-		memset(newlist, 0, sizeof(*newlist));
+		struct ptr_list *newlist = __alloc_ptrlist(0);
 		if (!list) {
 			newlist->next = newlist;
 			newlist->prev = newlist;
@@ -214,7 +217,7 @@ void * delete_ptr_list_last(struct ptr_l
 		last->prev->next = first;
 		if (last == first)
 			*head = NULL;
-		free(last);
+		__free_ptrlist(last);
 	}
 	return ptr;
 }
@@ -238,7 +241,7 @@ void __free_ptr_list(struct ptr_list **l
 	while (list) {
 		tmp = list;
 		list = list->next;
-		free(tmp);
+		__free_ptrlist(tmp);
 	}
 
 	*listp = NULL;
