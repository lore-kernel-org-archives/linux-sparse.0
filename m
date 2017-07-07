From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 21/34] ptrlist: extract ptr_cur_insert from ptrlist.h
Date: Fri,  7 Jul 2017 15:39:49 +0200
Message-ID: <20170707134002.49500-22-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34168 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbdGGNki (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:38 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21so4005361lfk.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:32 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.c | 21 +++++++++++++++++++++
 ptrlist.h | 22 +---------------------
 2 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index 031c53262..03a93db03 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -305,3 +305,24 @@ int ptr_cur_end(struct ptr_cur *cur, struct ptr_list *head)
 	cur->n = prev->nr;
 	return 1;
 }
+
+void ptr_cur_insert(struct ptr_cur *cur, void *new, void *ptr)
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
+	*this = new;
+	cur->l->nr++;
+}
diff --git a/ptrlist.h b/ptrlist.h
index ab2b13a3c..26697c62f 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -55,6 +55,7 @@ int ptr_cur_beg(struct ptr_cur *cur, struct ptr_list *head);
 int ptr_cur_next(struct ptr_cur *cur);
 int ptr_cur_end(struct ptr_cur *cur, struct ptr_list *head);
 int ptr_cur_prev(struct ptr_cur *cur);
+void ptr_cur_insert(struct ptr_cur *cur, void *new, void *ptr);
 
 /*
  * Hey, who said that you can't do overloading in C?
@@ -213,27 +214,6 @@ do {										\
 
 extern void split_ptr_list_head(struct ptr_list *);
 
-static inline void ptr_cur_insert(struct ptr_cur *cur, void *new, void *ptr)
-{
-	void **this, **last;
-
-	if (cur->l->nr == LIST_NODE_NR) {
-		split_ptr_list_head(cur->l);
-		if (cur->n >= cur->l->nr) {
-			cur->n -= cur->l->nr;
-			cur->l = cur->l->next;
-		}
-	}
-	this = cur->l->list + cur->n;
-	last = cur->l->list + cur->l->nr - 1;
-	while (last >= this) {
-		last[1] = last[0];
-		last--;
-	}
-	*this = (new);
-	cur->l->nr++;
-}
