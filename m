From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 24/34] ptrlist: extract prt_cur_delete() from ptrlist.h
Date: Fri,  7 Jul 2017 15:39:52 +0200
Message-ID: <20170707134002.49500-25-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35295 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752783AbdGGNkq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:46 -0400
Received: by mail-lf0-f66.google.com with SMTP id z78so4011793lff.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:46 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.c | 15 +++++++++++++++
 ptrlist.h | 15 +--------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index c7d049616..c532dbaac 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -327,3 +327,18 @@ void ptr_cur_insert(struct ptr_cur *cur, void *new, void *ptr)
 	*this = new;
 	curl->nr++;
 }
+
+void ptr_cur_delete(struct ptr_cur *cur, void *ptr)
+{
+	struct ptr_list *curl = cur->l;
+	void **this = curl->list + cur->n;
+	void **last = curl->list + curl->nr - 1;
+
+	while (this < last) {
+		this[0] = this[1];
+		this++;
+	}
+	*this = (void *)0xf0f0f0f0;
+	curl->nr--;
+	cur->n--;
+}
diff --git a/ptrlist.h b/ptrlist.h
index c27a68f38..c1d53632d 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -56,6 +56,7 @@ int ptr_cur_next(struct ptr_cur *cur);
 int ptr_cur_end(struct ptr_cur *cur, struct ptr_list *head);
 int ptr_cur_prev(struct ptr_cur *cur);
 void ptr_cur_insert(struct ptr_cur *cur, void *new, void *ptr);
+void ptr_cur_delete(struct ptr_cur *cur, void *ptr);
 
 /*
  * Hey, who said that you can't do overloading in C?
@@ -220,20 +221,6 @@ extern void split_ptr_list_head(struct ptr_list *);
 #define INSERT_CURRENT(new, ptr) \
 	DO_INSERT_CURRENT(new, ptr, __cur##ptr)
 
-static inline void ptr_cur_delete(struct ptr_cur *cur, void *ptr)
-{
-	void **this = cur->l->list + cur->n;
-	void **last = cur->l->list + cur->l->nr - 1;
-
-	while (this < last) {
-		this[0] = this[1];
-		this++;
-	}
-	*this = (void *)0xf0f0f0f0;
-	cur->l->nr--;
-	cur->n--;
-}
