From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 23/34] ptrlist: use the iterator API for DO_DELETE_CURRENT()
Date: Fri,  7 Jul 2017 15:39:51 +0200
Message-ID: <20170707134002.49500-24-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35288 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbdGGNkk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:40 -0400
Received: by mail-lf0-f68.google.com with SMTP id z78so4011723lff.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:39 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 26697c62f..c27a68f38 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -220,16 +220,22 @@ extern void split_ptr_list_head(struct ptr_list *);
 #define INSERT_CURRENT(new, ptr) \
 	DO_INSERT_CURRENT(new, ptr, __cur##ptr)
 
-#define DO_DELETE_CURRENT(ptr, __cur) do {						\
-	void **__this = __cur.l->list + __cur.n;					\
-	void **__last = __cur.l->list + __cur.l->nr - 1;				\
-	while (__this < __last) {							\
-		__this[0] = __this[1];							\
-		__this++;								\
-	}										\
-	*__this = (void *)0xf0f0f0f0;							\
-	__cur.l->nr--; __cur.n--;							\
-} while (0)
+static inline void ptr_cur_delete(struct ptr_cur *cur, void *ptr)
+{
+	void **this = cur->l->list + cur->n;
+	void **last = cur->l->list + cur->l->nr - 1;
+
+	while (this < last) {
+		this[0] = this[1];
+		this++;
+	}
+	*this = (void *)0xf0f0f0f0;
+	cur->l->nr--;
+	cur->n--;
+}
+
+#define DO_DELETE_CURRENT(ptr, __cur) \
+	ptr_cur_delete(&__cur, ptr)
 
 #define DELETE_CURRENT_PTR(ptr) \
 	DO_DELETE_CURRENT(ptr, __cur##ptr)
-- 
2.13.0

