From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 32/34] ptrlist: tag/notag common case
Date: Fri,  7 Jul 2017 15:40:00 +0200
Message-ID: <20170707134002.49500-33-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34267 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752785AbdGGNkp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:45 -0400
Received: by mail-lf0-f66.google.com with SMTP id g21so4006230lfk.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:44 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 1a0d7225c..1796f8466 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -84,10 +84,9 @@ static inline void *ptr_cur_entry(const struct ptr_cur *cur)
 	return __ptr_entry(cur->l, cur->n);
 }
 
-#define PTR_ENTRY_NOTAG(h,i)	__ptr_entry(h, i)
 #define __PTR_STRIP_TAG(ptr)	(void *)(~3UL & (unsigned long)(ptr))
 #define __PTR_KEEP_TAG(ptr)	(ptr)
-#define PTR_ENTRY(h,i)		__PTR_STRIP_TAG(PTR_ENTRY_NOTAG(h,i))
+#define PTR_ENTRY(h,i)		__PTR_STRIP_TAG(__ptr_entry(h,i))
 #define CUR_ENTRY_NOTAG(cur)	ptr_cur_entry(cur)
 #define CUR_ENTRY(cur)		__PTR_STRIP_TAG(CUR_ENTRY_NOTAG(cur))
 
@@ -114,81 +113,81 @@ static inline void *last_ptr_list(struct ptr_list *list)
 	return __PTR_STRIP_TAG(ptr_cur_entry(&cur));
 }
 
-#define DO_PREPARE(head, ptr, __cur, CUR_ENTRY)						\
+#define DO_PREPARE(head, ptr, __cur)						\
 do {										\
 		struct ptr_cur __cur;							\
 		CHECK_TYPE(head,ptr);							\
 		if (!ptr_cur_beg(&__cur, (struct ptr_list *)head) ||			\
 		    !ptr_cur_next(&__cur)) ptr = NULL;					\
-		else ptr = CUR_ENTRY(&__cur);
+		else ptr = ptr_cur_entry(&__cur);
 
-#define DO_NEXT(ptr, __cur, CUR_ENTRY)							\
+#define DO_NEXT(ptr, __cur)							\
 	if (ptr) {									\
 		if (ptr_cur_next(&__cur))						\
-			ptr = CUR_ENTRY(&__cur);					\
+			ptr = ptr_cur_entry(&__cur);					\
 		else									\
 			ptr = NULL;							\
 	}
 
-#define DO_RESET(ptr, __cur, CUR_ENTRY)						\
+#define DO_RESET(ptr, __cur)								\
 	if (!ptr_cur_beg(&__cur, (struct ptr_list *)head) ||				\
 	    !ptr_cur_next(&__cur)) ptr = NULL;						\
-	else ptr = CUR_ENTRY(&__cur);
+	else ptr = ptr_cur_entry(&__cur);
 
 #define DO_FINISH(ptr, __cur)								\
 		(void)(__cur.n); /* Sanity-check nesting */				\
 	} while (0)
 
 #define PREPARE_PTR_LIST(head, ptr) \
-	DO_PREPARE(head, ptr, __cur##ptr, CUR_ENTRY)
+	DO_PREPARE(head, ptr, __cur##ptr)
 
 #define NEXT_PTR_LIST(ptr) \
-	DO_NEXT(ptr, __cur##ptr, CUR_ENTRY)
+	DO_NEXT(ptr, __cur##ptr)
 
 #define RESET_PTR_LIST(ptr) \
-	DO_RESET(ptr, __cur##ptr, CUR_ENTRY)
+	DO_RESET(ptr, __cur##ptr)
 
 #define FINISH_PTR_LIST(ptr) \
 	DO_FINISH(ptr, __cur##ptr)
 
-#define DO_FOR_EACH(head, ptr, __cur, CUR_ENTRY) do {					\
+#define DO_FOR_EACH(head, ptr, __cur) do {						\
 	struct ptr_cur __cur;								\
 	CHECK_TYPE(head,ptr);								\
 	if (!head) break;								\
 	ptr_cur_beg(&__cur, (struct ptr_list *)head);					\
 	while (ptr_cur_next(&__cur)) {							\
-		ptr = CUR_ENTRY(&__cur);
+		ptr = ptr_cur_entry(&__cur);
 
 #define DO_END_FOR_EACH(ptr, __cur)							\
 	}										\
 } while (0)
 
-#define DO_FOR_EACH_REVERSE(head, ptr, __cur, CUR_ENTRY) do {				\
+#define DO_FOR_EACH_REVERSE(head, ptr, __cur) do {					\
 	struct ptr_cur __cur;								\
 	CHECK_TYPE(head,ptr);								\
 	if (!head) break;								\
 	ptr_cur_end(&__cur, (struct ptr_list *)head);					\
 	while (ptr_cur_prev(&__cur)) {							\
-		ptr = CUR_ENTRY(&__cur);
+		ptr = ptr_cur_entry(&__cur);
 
 #define DO_END_FOR_EACH_REVERSE(ptr, __cur)						\
 	}										\
 } while (0)
 
-#define DO_REVERSE(ptr, __cur, new, __newcur, CUR_ENTRY) do {				\
+#define DO_REVERSE(ptr, __cur, new, __newcur) do {					\
 	struct ptr_cur __newcur = __cur;						\
 	while (ptr_cur_prev(&__newcur)) {						\
-		new = CUR_ENTRY(&__newcur);
+		new = ptr_cur_entry(&__newcur);
 
 #define RECURSE_PTR_REVERSE(ptr, new)							\
 	DO_REVERSE(ptr, __cur##ptr,							\
-		   new, __cur##new, CUR_ENTRY)
+		   new, __cur##new)
 
 #define DO_THIS_ADDRESS(ptr, __cur)							\
 	((__typeof__(&(ptr))) (__cur.l->list + __cur.n))
 
 #define FOR_EACH_PTR(head, ptr) \
-	DO_FOR_EACH(head, ptr, __cur##ptr, CUR_ENTRY)
+	DO_FOR_EACH(head, ptr, __cur##ptr)
 
 #define FOR_EACH_TAGGED_PTR(head, ptr) \
 	FOR_EACH_PTR(head, ptr) \
@@ -198,18 +197,18 @@ do {										\
 	DO_END_FOR_EACH(ptr, __cur##ptr)
 
 #define FOR_EACH_PTR_NOTAG(head, ptr) \
-	DO_FOR_EACH(head, ptr, __cur##ptr, CUR_ENTRY_NOTAG)
+	FOR_EACH_PTR(head, ptr)
 
 #define END_FOR_EACH_PTR_NOTAG(ptr) END_FOR_EACH_PTR(ptr)
 
 #define FOR_EACH_PTR_REVERSE(head, ptr) \
-	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr, CUR_ENTRY)
+	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr)
 
 #define END_FOR_EACH_PTR_REVERSE(ptr) \
 	DO_END_FOR_EACH_REVERSE(ptr, __cur##ptr)
 
 #define FOR_EACH_PTR_REVERSE_NOTAG(head, ptr) \
-	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr, CUR_ENTRY_NOTAG)
+	FOR_EACH_REVERSE(head, ptr)
 
 #define END_FOR_EACH_PTR_REVERSE_NOTAG(ptr) END_FOR_EACH_PTR_REVERSE(ptr)
 
-- 
2.13.0

