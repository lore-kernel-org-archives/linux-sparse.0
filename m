From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/34] ptrlist: mechanically replace head-list-nr triplets by an iterator struct
Date: Fri,  7 Jul 2017 15:39:39 +0200
Message-ID: <20170707134002.49500-12-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36698 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbdGGNkW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:22 -0400
Received: by mail-lf0-f66.google.com with SMTP id f28so3999596lfi.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:21 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 174 ++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 84 insertions(+), 90 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index f856a54eb..8941c339a 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -111,180 +111,174 @@ static inline void *last_ptr_list(struct ptr_list *list)
 	return __PTR_STRIP_TAG(ptr_cur_entry(&cur));
 }
 
-#define PTR_DEREF(__head, idx, PTR_ENTRY) ({						\
-	struct ptr_list *__list = __head;						\
-	while (__list && __list->nr == 0) {						\
-		__list = __list->next;							\
-		if (__list == __head)							\
-			__list = NULL;							\
-	}										\
-	__list ? PTR_ENTRY(__list, idx) : NULL;						\
-})
-
-#define DO_PREPARE(head, ptr, __head, __list, __nr, PTR_ENTRY)				\
+#define DO_PREPARE(head, ptr, __cur, PTR_ENTRY)						\
 	do {										\
-		struct ptr_list *__head = (struct ptr_list *) (head);			\
-		struct ptr_list *__list = __head;					\
-		int __nr = 0;								\
+		struct ptr_cur __cur;							\
+		__cur.h = (struct ptr_list *) (head);					\
+		__cur.l = __cur.h;							\
+		__cur.n = 0;								\
 		CHECK_TYPE(head,ptr);							\
-		ptr = PTR_DEREF(__head, 0, PTR_ENTRY);					\
+		if (__cur.h) ptr = PTR_ENTRY(__cur.h, 0);				\
+		else ptr = NULL
 
-#define DO_NEXT(ptr, __head, __list, __nr, PTR_ENTRY)					\
+#define DO_NEXT(ptr, __cur, PTR_ENTRY)							\
 		if (ptr) {								\
-			if (++__nr < __list->nr) {					\
-				ptr = PTR_ENTRY(__list,__nr);				\
+			if (++__cur.n < __cur.l->nr) {					\
+				ptr = PTR_ENTRY(__cur.l,__cur.n);			\
 			} else {							\
 				ptr = NULL;						\
 				do							\
-					__list = __list->next;				\
-				while (__list->nr == 0 && __list != __head);		\
-				if (__list != __head) {					\
-					__nr = 0;					\
-					ptr = PTR_ENTRY(__list,0);			\
+					__cur.l = __cur.l->next;			\
+				while (__cur.l->nr == 0 && __cur.l != __cur.h);		\
+				if (__cur.l != __cur.h) {				\
+					__cur.n = 0;					\
+					ptr = PTR_ENTRY(__cur.l,0);			\
 				}							\
 			}								\
 		}
 
-#define DO_RESET(ptr, __head, __list, __nr, PTR_ENTRY)					\
+#define DO_RESET(ptr, __cur, PTR_ENTRY)						\
 	do {										\
-		__nr = 0;								\
-		__list = __head;							\
-		if (__head) ptr = PTR_DEREF(__head, 0, PTR_ENTRY);			\
+		__cur.n = 0;								\
+		__cur.l = __cur.h;							\
+		if (__cur.h) ptr = PTR_ENTRY(__cur.h, 0);				\
 	} while (0)
 
-#define DO_FINISH(ptr, __head, __list, __nr)						\
-		(void)(__nr); /* Sanity-check nesting */				\
+#define DO_FINISH(ptr, __cur)								\
+		(void)(__cur.n); /* Sanity-check nesting */				\
 	} while (0)
 
 #define PREPARE_PTR_LIST(head, ptr) \
-	DO_PREPARE(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY)
+	DO_PREPARE(head, ptr, __cur##ptr, PTR_ENTRY)
 
 #define NEXT_PTR_LIST(ptr) \
-	DO_NEXT(ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY)
+	DO_NEXT(ptr, __cur##ptr, PTR_ENTRY)
 
 #define RESET_PTR_LIST(ptr) \
-	DO_RESET(ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY)
+	DO_RESET(ptr, __cur##ptr, PTR_ENTRY)
 
 #define FINISH_PTR_LIST(ptr) \
-	DO_FINISH(ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_FINISH(ptr, __cur##ptr)
 
-#define DO_FOR_EACH(head, ptr, __head, __list, __nr, PTR_ENTRY) do {			\
-	struct ptr_list *__head = (struct ptr_list *) (head);				\
-	struct ptr_list *__list = __head;						\
+#define DO_FOR_EACH(head, ptr, __cur, PTR_ENTRY) do {					\
+	struct ptr_cur __cur;								\
+	__cur.h = (struct ptr_list *) (head);						\
+	__cur.l = __cur.h;								\
 	CHECK_TYPE(head,ptr);								\
-	if (!__head) break;								\
-	do { int __nr;									\
-		for (__nr = 0; __nr < __list->nr; __nr++) {				\
-			ptr = PTR_ENTRY(__list,__nr);					\
+	if (!__cur.h) break;								\
+	do {										\
+		for (__cur.n = 0; __cur.n < __cur.l->nr; __cur.n++) {			\
+			ptr = PTR_ENTRY(__cur.l,__cur.n);				\
 
-#define DO_END_FOR_EACH(ptr, __head, __list, __nr)					\
+#define DO_END_FOR_EACH(ptr, __cur)							\
 		}									\
-	} while ((__list = __list->next) != __head);					\
+	} while ((__cur.l = __cur.l->next) != __cur.h);					\
 } while (0)
 
-#define DO_FOR_EACH_REVERSE(head, ptr, __head, __list, __nr, PTR_ENTRY) do {		\
-	struct ptr_list *__head = (struct ptr_list *) (head);				\
-	struct ptr_list *__list = __head;						\
+#define DO_FOR_EACH_REVERSE(head, ptr, __cur, PTR_ENTRY) do {				\
+	struct ptr_cur __cur;								\
+	__cur.h = (struct ptr_list *) (head);						\
+	__cur.l = __cur.h;								\
 	CHECK_TYPE(head,ptr);								\
-	if (!__head) break;								\
-	do { int __nr;									\
-		__list = __list->prev;							\
-		__nr = __list->nr;							\
-		while (--__nr >= 0) {							\
-			ptr = PTR_ENTRY(__list,__nr);					\
+	if (!__cur.h) break;								\
+	do {										\
+		__cur.l = __cur.l->prev;						\
+		__cur.n = __cur.l->nr;							\
+		while (--__cur.n >= 0) {						\
+			ptr = PTR_ENTRY(__cur.l,__cur.n);				\
 
 
-#define DO_END_FOR_EACH_REVERSE(ptr, __head, __list, __nr)				\
+#define DO_END_FOR_EACH_REVERSE(ptr, __cur)						\
 		}									\
-	} while (__list != __head);							\
+	} while (__cur.l != __cur.h);							\
 } while (0)
 
-#define DO_REVERSE(ptr, __head, __list, __nr, new, __newhead,				\
-		   __newlist, __newnr, PTR_ENTRY) do { 					\
-	struct ptr_list *__newhead = __head;						\
-	struct ptr_list *__newlist = __list;						\
-	int __newnr = __nr;								\
+#define DO_REVERSE(ptr, __cur, new, __newcur, PTR_ENTRY) do {				\
+	struct ptr_cur __newcur;							\
+	__newcur.h = __cur.h;								\
+	__newcur.l = __cur.l;								\
+	__newcur.n = __cur.n;								\
 	new = ptr;									\
 	goto __inside##new;								\
 	do {										\
-		__newlist = __newlist->prev;						\
-		__newnr = __newlist->nr;						\
+		__newcur.l = __newcur.l->prev;						\
+		__newcur.n = __newcur.l->nr;						\
 	__inside##new:									\
-		while (--__newnr >= 0) {						\
-			new = PTR_ENTRY(__newlist,__newnr);				\
+		while (--__newcur.n >= 0) {						\
+			new = PTR_ENTRY(__newcur.l,__newcur.n);				\
 
 #define RECURSE_PTR_REVERSE(ptr, new)							\
-	DO_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr,				\
-		   new, __head##new, __list##new, __nr##new, PTR_ENTRY)
+	DO_REVERSE(ptr, __cur##ptr,							\
+		   new, __cur##new, PTR_ENTRY)
 
-#define DO_THIS_ADDRESS(ptr, __head, __list, __nr)					\
-	((__typeof__(&(ptr))) (__list->list + __nr))
+#define DO_THIS_ADDRESS(ptr, __cur)							\
+	((__typeof__(&(ptr))) (__cur.l->list + __cur.n))
 
 #define FOR_EACH_PTR(head, ptr) \
-	DO_FOR_EACH(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY)
+	DO_FOR_EACH(head, ptr, __cur##ptr, PTR_ENTRY)
 
 #define END_FOR_EACH_PTR(ptr) \
-	DO_END_FOR_EACH(ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_END_FOR_EACH(ptr, __cur##ptr)
 
 #define FOR_EACH_PTR_NOTAG(head, ptr) \
-	DO_FOR_EACH(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_NOTAG)
+	DO_FOR_EACH(head, ptr, __cur##ptr, PTR_ENTRY_NOTAG)
 
 #define END_FOR_EACH_PTR_NOTAG(ptr) END_FOR_EACH_PTR(ptr)
 
 #define FOR_EACH_PTR_REVERSE(head, ptr) \
-	DO_FOR_EACH_REVERSE(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY)
+	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr, PTR_ENTRY)
 
 #define END_FOR_EACH_PTR_REVERSE(ptr) \
-	DO_END_FOR_EACH_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_END_FOR_EACH_REVERSE(ptr, __cur##ptr)
 
 #define FOR_EACH_PTR_REVERSE_NOTAG(head, ptr) \
-	DO_FOR_EACH_REVERSE(head, ptr, __head##ptr, __list##ptr, __nr##ptr, PTR_ENTRY_NOTAG)
+	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr, PTR_ENTRY_NOTAG)
 
 #define END_FOR_EACH_PTR_REVERSE_NOTAG(ptr) END_FOR_EACH_PTR_REVERSE(ptr)
 
 #define THIS_ADDRESS(ptr) \
-	DO_THIS_ADDRESS(ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_THIS_ADDRESS(ptr, __cur##ptr)
 
 extern void split_ptr_list_head(struct ptr_list *);
 
-#define DO_SPLIT(ptr, __head, __list, __nr) do {					\
-	split_ptr_list_head(__list);							\
-	if (__nr >= __list->nr) {							\
-		__nr -= __list->nr;							\
-		__list = __list->next;							\
+#define DO_SPLIT(ptr, __cur) do {							\
+	split_ptr_list_head(__cur.l);							\
+	if (__cur.n >= __cur.l->nr) {							\
+		__cur.n -= __cur.l->nr;							\
+		__cur.l = __cur.l->next;						\
 	};										\
 } while (0)
 
-#define DO_INSERT_CURRENT(new, ptr, __head, __list, __nr) do {				\
+#define DO_INSERT_CURRENT(new, ptr, __cur) do {						\
 	void **__this, **__last;							\
-	if (__list->nr == LIST_NODE_NR)							\
-		DO_SPLIT(ptr, __head, __list, __nr);					\
-	__this = __list->list + __nr;							\
-	__last = __list->list + __list->nr - 1;						\
+	if (__cur.l->nr == LIST_NODE_NR)						\
+		DO_SPLIT(ptr, __cur);							\
+	__this = __cur.l->list + __cur.n;						\
+	__last = __cur.l->list + __cur.l->nr - 1;					\
 	while (__last >= __this) {							\
 		__last[1] = __last[0];							\
 		__last--;								\
 	}										\
 	*__this = (new);								\
-	__list->nr++;									\
+	__cur.l->nr++;									\
 } while (0)
 
 #define INSERT_CURRENT(new, ptr) \
-	DO_INSERT_CURRENT(new, ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_INSERT_CURRENT(new, ptr, __cur##ptr)
 
-#define DO_DELETE_CURRENT(ptr, __head, __list, __nr) do {				\
-	void **__this = __list->list + __nr;						\
-	void **__last = __list->list + __list->nr - 1;					\
+#define DO_DELETE_CURRENT(ptr, __cur) do {						\
+	void **__this = __cur.l->list + __cur.n;					\
+	void **__last = __cur.l->list + __cur.l->nr - 1;				\
 	while (__this < __last) {							\
 		__this[0] = __this[1];							\
 		__this++;								\
 	}										\
 	*__this = (void *)0xf0f0f0f0;							\
-	__list->nr--; __nr--;								\
+	__cur.l->nr--; __cur.n--;							\
 } while (0)
 
 #define DELETE_CURRENT_PTR(ptr) \
-	DO_DELETE_CURRENT(ptr, __head##ptr, __list##ptr, __nr##ptr)
+	DO_DELETE_CURRENT(ptr, __cur##ptr)
 
 #define REPLACE_CURRENT_PTR(ptr, new_ptr)						\
 	do { *THIS_ADDRESS(ptr) = (new_ptr); } while (0)
-- 
2.13.0

