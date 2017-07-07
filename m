From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/34] ptrlist: CUR_ENTRY/CUR_ENTRY_NOTAG
Date: Fri,  7 Jul 2017 15:39:42 +0200
Message-ID: <20170707134002.49500-15-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34114 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752746AbdGGNk0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:26 -0400
Received: by mail-lf0-f68.google.com with SMTP id g21so4004675lfk.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:25 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 91019e7c5..7c8fefe42 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -87,6 +87,8 @@ static inline void *ptr_cur_entry(const struct ptr_cur *cur)
 #define __PTR_STRIP_TAG(ptr)	(void *)(~3UL & (unsigned long)(ptr))
 #define __PTR_KEEP_TAG(ptr)	(ptr)
 #define PTR_ENTRY(h,i)		__PTR_STRIP_TAG(PTR_ENTRY_NOTAG(h,i))
+#define CUR_ENTRY_NOTAG(cur)	ptr_cur_entry(cur)
+#define CUR_ENTRY(cur)		__PTR_STRIP_TAG(CUR_ENTRY_NOTAG(cur))
 
 
 static inline void *first_ptr_list(struct ptr_list *list)
@@ -121,18 +123,18 @@ static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
 #define DO_INIT(cur, head)	\
 	ptr_cur_init(&cur, (struct ptr_list *) head)
 
-#define DO_PREPARE(head, ptr, __cur, PTR_ENTRY)						\
+#define DO_PREPARE(head, ptr, __cur, CUR_ENTRY)						\
 	do {										\
 		struct ptr_cur __cur;							\
 		CHECK_TYPE(head,ptr);							\
 		DO_INIT(__cur, head);							\
-		if (__cur.h) ptr = PTR_ENTRY(__cur.h, 0);				\
+		if (__cur.h) ptr = CUR_ENTRY(&__cur);					\
 		else ptr = NULL
 
-#define DO_NEXT(ptr, __cur, PTR_ENTRY)							\
+#define DO_NEXT(ptr, __cur, CUR_ENTRY)							\
 		if (ptr) {								\
 			if (++__cur.n < __cur.l->nr) {					\
-				ptr = PTR_ENTRY(__cur.l,__cur.n);			\
+				ptr = CUR_ENTRY(&__cur);				\
 			} else {							\
 				ptr = NULL;						\
 				do							\
@@ -140,16 +142,16 @@ static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
 				while (__cur.l->nr == 0 && __cur.l != __cur.h);		\
 				if (__cur.l != __cur.h) {				\
 					__cur.n = 0;					\
-					ptr = PTR_ENTRY(__cur.l,0);			\
+					ptr = CUR_ENTRY(&__cur);				\
 				}							\
 			}								\
 		}
 
-#define DO_RESET(ptr, __cur, PTR_ENTRY)						\
+#define DO_RESET(ptr, __cur, CUR_ENTRY)						\
 	do {										\
 		__cur.n = 0;								\
 		__cur.l = __cur.h;							\
-		if (__cur.h) ptr = PTR_ENTRY(__cur.h, 0);				\
+		if (__cur.h) ptr = CUR_ENTRY(&__cur);					\
 	} while (0)
 
 #define DO_FINISH(ptr, __cur)								\
@@ -157,32 +159,32 @@ static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
 	} while (0)
 
 #define PREPARE_PTR_LIST(head, ptr) \
-	DO_PREPARE(head, ptr, __cur##ptr, PTR_ENTRY)
+	DO_PREPARE(head, ptr, __cur##ptr, CUR_ENTRY)
 
 #define NEXT_PTR_LIST(ptr) \
-	DO_NEXT(ptr, __cur##ptr, PTR_ENTRY)
+	DO_NEXT(ptr, __cur##ptr, CUR_ENTRY)
 
 #define RESET_PTR_LIST(ptr) \
-	DO_RESET(ptr, __cur##ptr, PTR_ENTRY)
+	DO_RESET(ptr, __cur##ptr, CUR_ENTRY)
 
 #define FINISH_PTR_LIST(ptr) \
 	DO_FINISH(ptr, __cur##ptr)
 
-#define DO_FOR_EACH(head, ptr, __cur, PTR_ENTRY) do {					\
+#define DO_FOR_EACH(head, ptr, __cur, CUR_ENTRY) do {					\
 	struct ptr_cur __cur;								\
 	CHECK_TYPE(head,ptr);								\
 	DO_INIT(__cur, head);								\
 	if (!__cur.h) break;								\
 	do {										\
 		for (__cur.n = 0; __cur.n < __cur.l->nr; __cur.n++) {			\
-			ptr = PTR_ENTRY(__cur.l,__cur.n);				\
+			ptr = CUR_ENTRY(&__cur);					\
 
 #define DO_END_FOR_EACH(ptr, __cur)							\
 		}									\
 	} while ((__cur.l = __cur.l->next) != __cur.h);					\
 } while (0)
 
-#define DO_FOR_EACH_REVERSE(head, ptr, __cur, PTR_ENTRY) do {				\
+#define DO_FOR_EACH_REVERSE(head, ptr, __cur, CUR_ENTRY) do {				\
 	struct ptr_cur __cur;								\
 	CHECK_TYPE(head,ptr);								\
 	DO_INIT(__cur, head);								\
@@ -191,7 +193,7 @@ static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
 		__cur.l = __cur.l->prev;						\
 		__cur.n = __cur.l->nr;							\
 		while (--__cur.n >= 0) {						\
-			ptr = PTR_ENTRY(__cur.l,__cur.n);				\
+			ptr = CUR_ENTRY(&__cur);					\
 
 
 #define DO_END_FOR_EACH_REVERSE(ptr, __cur)						\
@@ -199,7 +201,7 @@ static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
 	} while (__cur.l != __cur.h);							\
 } while (0)
 
-#define DO_REVERSE(ptr, __cur, new, __newcur, PTR_ENTRY) do {				\
+#define DO_REVERSE(ptr, __cur, new, __newcur, CUR_ENTRY) do {				\
 	struct ptr_cur __newcur = __cur;						\
 	new = ptr;									\
 	goto __inside##new;								\
@@ -208,34 +210,34 @@ static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
 		__newcur.n = __newcur.l->nr;						\
 	__inside##new:									\
 		while (--__newcur.n >= 0) {						\
-			new = PTR_ENTRY(__newcur.l,__newcur.n);				\
+			new = CUR_ENTRY(&__newcur);					\
 
 #define RECURSE_PTR_REVERSE(ptr, new)							\
 	DO_REVERSE(ptr, __cur##ptr,							\
-		   new, __cur##new, PTR_ENTRY)
+		   new, __cur##new, CUR_ENTRY)
 
 #define DO_THIS_ADDRESS(ptr, __cur)							\
 	((__typeof__(&(ptr))) (__cur.l->list + __cur.n))
 
 #define FOR_EACH_PTR(head, ptr) \
-	DO_FOR_EACH(head, ptr, __cur##ptr, PTR_ENTRY)
+	DO_FOR_EACH(head, ptr, __cur##ptr, CUR_ENTRY)
 
 #define END_FOR_EACH_PTR(ptr) \
 	DO_END_FOR_EACH(ptr, __cur##ptr)
 
 #define FOR_EACH_PTR_NOTAG(head, ptr) \
-	DO_FOR_EACH(head, ptr, __cur##ptr, PTR_ENTRY_NOTAG)
+	DO_FOR_EACH(head, ptr, __cur##ptr, CUR_ENTRY_NOTAG)
 
 #define END_FOR_EACH_PTR_NOTAG(ptr) END_FOR_EACH_PTR(ptr)
 
 #define FOR_EACH_PTR_REVERSE(head, ptr) \
-	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr, PTR_ENTRY)
+	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr, CUR_ENTRY)
 
 #define END_FOR_EACH_PTR_REVERSE(ptr) \
 	DO_END_FOR_EACH_REVERSE(ptr, __cur##ptr)
 
 #define FOR_EACH_PTR_REVERSE_NOTAG(head, ptr) \
-	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr, PTR_ENTRY_NOTAG)
+	DO_FOR_EACH_REVERSE(head, ptr, __cur##ptr, CUR_ENTRY_NOTAG)
 
 #define END_FOR_EACH_PTR_REVERSE_NOTAG(ptr) END_FOR_EACH_PTR_REVERSE(ptr)
 
-- 
2.13.0

