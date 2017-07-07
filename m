From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/34] ptrlist: abstract away iterator initialization
Date: Fri,  7 Jul 2017 15:39:41 +0200
Message-ID: <20170707134002.49500-14-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34103 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbdGGNk3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:29 -0400
Received: by mail-lf0-f68.google.com with SMTP id g21so4004566lfk.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:28 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 0d17237f5..91019e7c5 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -111,13 +111,21 @@ static inline void *last_ptr_list(struct ptr_list *list)
 	return __PTR_STRIP_TAG(ptr_cur_entry(&cur));
 }
 
+static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
+{
+	cur->h = head;
+	cur->l = head;
+	cur->n = 0;
+}
+
+#define DO_INIT(cur, head)	\
+	ptr_cur_init(&cur, (struct ptr_list *) head)
+
 #define DO_PREPARE(head, ptr, __cur, PTR_ENTRY)						\
 	do {										\
 		struct ptr_cur __cur;							\
-		__cur.h = (struct ptr_list *) (head);					\
-		__cur.l = __cur.h;							\
-		__cur.n = 0;								\
 		CHECK_TYPE(head,ptr);							\
+		DO_INIT(__cur, head);							\
 		if (__cur.h) ptr = PTR_ENTRY(__cur.h, 0);				\
 		else ptr = NULL
 
@@ -162,9 +170,8 @@ static inline void *last_ptr_list(struct ptr_list *list)
 
 #define DO_FOR_EACH(head, ptr, __cur, PTR_ENTRY) do {					\
 	struct ptr_cur __cur;								\
-	__cur.h = (struct ptr_list *) (head);						\
-	__cur.l = __cur.h;								\
 	CHECK_TYPE(head,ptr);								\
+	DO_INIT(__cur, head);								\
 	if (!__cur.h) break;								\
 	do {										\
 		for (__cur.n = 0; __cur.n < __cur.l->nr; __cur.n++) {			\
@@ -177,9 +184,8 @@ static inline void *last_ptr_list(struct ptr_list *list)
 
 #define DO_FOR_EACH_REVERSE(head, ptr, __cur, PTR_ENTRY) do {				\
 	struct ptr_cur __cur;								\
-	__cur.h = (struct ptr_list *) (head);						\
-	__cur.l = __cur.h;								\
 	CHECK_TYPE(head,ptr);								\
+	DO_INIT(__cur, head);								\
 	if (!__cur.h) break;								\
 	do {										\
 		__cur.l = __cur.l->prev;						\
-- 
2.13.0

