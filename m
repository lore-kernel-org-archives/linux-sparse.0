From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 20/34] ptrlist: use the iterator API for DO_INSERT_CURRENT()
Date: Fri,  7 Jul 2017 15:39:48 +0200
Message-ID: <20170707134002.49500-21-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33168 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbdGGNkc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id t72so4029493lff.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:31 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 0e6d30b99..ab2b13a3c 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -213,27 +213,29 @@ do {										\
 
 extern void split_ptr_list_head(struct ptr_list *);
 
-#define DO_SPLIT(ptr, __cur) do {							\
-	split_ptr_list_head(__cur.l);							\
-	if (__cur.n >= __cur.l->nr) {							\
-		__cur.n -= __cur.l->nr;							\
-		__cur.l = __cur.l->next;						\
-	};										\
-} while (0)
+static inline void ptr_cur_insert(struct ptr_cur *cur, void *new, void *ptr)
+{
+	void **this, **last;
+
+	if (cur->l->nr == LIST_NODE_NR) {
+		split_ptr_list_head(cur->l);
+		if (cur->n >= cur->l->nr) {
+			cur->n -= cur->l->nr;
+			cur->l = cur->l->next;
+		}
+	}
+	this = cur->l->list + cur->n;
+	last = cur->l->list + cur->l->nr - 1;
+	while (last >= this) {
+		last[1] = last[0];
+		last--;
+	}
+	*this = (new);
+	cur->l->nr++;
+}
 
-#define DO_INSERT_CURRENT(new, ptr, __cur) do {						\
-	void **__this, **__last;							\
-	if (__cur.l->nr == LIST_NODE_NR)						\
-		DO_SPLIT(ptr, __cur);							\
-	__this = __cur.l->list + __cur.n;						\
-	__last = __cur.l->list + __cur.l->nr - 1;					\
-	while (__last >= __this) {							\
-		__last[1] = __last[0];							\
-		__last--;								\
-	}										\
-	*__this = (new);								\
-	__cur.l->nr++;									\
-} while (0)
+#define DO_INSERT_CURRENT(new, ptr, __cur) \
+	ptr_cur_insert(&__cur, new, ptr)
 
 #define INSERT_CURRENT(new, ptr) \
 	DO_INSERT_CURRENT(new, ptr, __cur##ptr)
-- 
2.13.0

