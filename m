From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 30/34] ptrlist: simplify common case for __add_ptr_list()
Date: Fri,  7 Jul 2017 15:39:58 +0200
Message-ID: <20170707134002.49500-31-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35845 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751034AbdGGNkn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:43 -0400
Received: by mail-lf0-f66.google.com with SMTP id f28so4001259lfi.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:42 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The vast majority of pointer list use non-tagged pointer,
the core library and the sparse tool doesn't use them
(in fact only 'example.c' use them).

The current functions to add a pointer to a ptr_list suppose
that all pointers are tagged and in the case of non-word-aligned
pointers (strings) it create a a fake tag consiting of the last
2 bits.

This patch siplify the situation by separating the common case
(non-tagged or non-word-aligned pointers) which ignore the presence
of a tag and make another version which check and combien the tag
with the pointer before calling the common case.
---
 ptrlist.c | 30 +++++++++++++++++++++++-------
 ptrlist.h | 11 +++++------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index 1957baf1f..95447eaea 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -114,18 +114,19 @@ void split_ptr_list_head(struct ptr_list *head)
 	memset(head->list + old, 0xf0, nr * sizeof(void *));
 }
 
-void **__add_ptr_list(struct ptr_list **listp, void *ptr, unsigned long tag)
+/*
+ * Add 'ptr' to 'listp'.
+ * 'ptr' can be a tagged pointer, a non-tagged one or a
+ * non-word-aligned one, it doesn't matter.
+ * Returns the address where 'ptr' was stored.
+ */
+void **__add_ptr_list(struct ptr_list **listp, void *ptr)
 {
 	struct ptr_list *list = *listp;
 	struct ptr_list *last = NULL; /* gcc complains needlessly */
 	void **ret;
 	int nr;
 
-	/* The low two bits are reserved for tags */
-	assert((3 & (unsigned long)ptr) == 0);
-	assert((~3 & tag) == 0);
-	ptr = (void *)(tag | (unsigned long)ptr);
-
 	if (!list || (nr = (last = list->prev)->nr) >= LIST_NODE_NR) {
 		struct ptr_list *newlist = __alloc_ptrlist(0);
 		if (!list) {
@@ -148,6 +149,21 @@ void **__add_ptr_list(struct ptr_list **listp, void *ptr, unsigned long tag)
 	return ret;
 }
 
+/*
+ * Add 'ptr' to 'listp' and tag it with 'tag'
+ * 'ptr' must be a non-tagged word-aligned pointer.
+ * Returns the address where 'ptr' was stored.
+ */
+void **__add_ptr_list_tag(struct ptr_list **listp, void *ptr, unsigned long tag)
+{
+	/* The low two bits are reserved for tags */
+	assert((3 & (unsigned long)ptr) == 0);
+	assert((~3 & tag) == 0);
+	ptr = (void *)(tag | (unsigned long)ptr);
+
+	return __add_ptr_list(listp, ptr);
+}
+
 int delete_ptr_list_entry(struct ptr_list **list, void *entry, int count)
 {
 	struct ptr_cur cur;
@@ -234,7 +250,7 @@ void concat_ptr_list(struct ptr_list *a, struct ptr_list **b)
                 return;
 
 	while (ptr_cur_next(&cur))
-		__add_ptr_list(b, ptr_cur_entry(&cur), 0);
+		__add_ptr_list(b, ptr_cur_entry(&cur));
 }
 
 void __free_ptr_list(struct ptr_list **listp)
diff --git a/ptrlist.h b/ptrlist.h
index c1d53632d..9e16adb36 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -45,7 +45,8 @@ int delete_ptr_list_entry(struct ptr_list **, void *, int);
 int replace_ptr_list_entry(struct ptr_list **, void *old, void *new, int);
 extern void sort_list(struct ptr_list **, int (*)(const void *, const void *));
 
-extern void **__add_ptr_list(struct ptr_list **, void *, unsigned long);
+extern void **__add_ptr_list(struct ptr_list **, void *);
+extern void **__add_ptr_list_tag(struct ptr_list **, void *, unsigned long);
 extern void concat_ptr_list(struct ptr_list *a, struct ptr_list **b);
 extern void __free_ptr_list(struct ptr_list **);
 extern int ptr_list_size(struct ptr_list *);
@@ -65,13 +66,11 @@ void ptr_cur_delete(struct ptr_cur *cur, void *ptr);
  * extensions..
  */
 #define add_ptr_list_tag(list,entry,tag) \
-	MKTYPE(*(list), (CHECK_TYPE(*(list),(entry)),__add_ptr_list((struct ptr_list **)(list), (entry), (tag))))
+	MKTYPE(*(list), (CHECK_TYPE(*(list),(entry)),__add_ptr_list_tag((struct ptr_list **)(list), (entry), (tag))))
 #define add_ptr_list_notag(list,entry)										\
-	MKTYPE(*(list), (CHECK_TYPE(*(list),(entry)),__add_ptr_list((struct ptr_list **)(list),			\
-								    (void *)((unsigned long)(entry) & ~3UL), 	\
-								    (unsigned long)(entry) & 3)))
+	MKTYPE(*(list), (CHECK_TYPE(*(list),(entry)),__add_ptr_list((struct ptr_list **)(list),	 (entry))))
 #define add_ptr_list(list,entry) \
-	add_ptr_list_tag(list,entry,0)
+	add_ptr_list_notag(list,entry)
 #define free_ptr_list(list) \
 	do { VRFY_PTR_LIST(*(list)); __free_ptr_list((struct ptr_list **)(list)); } while (0)
 
-- 
2.13.0

