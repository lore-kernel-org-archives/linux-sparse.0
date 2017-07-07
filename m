From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 22/34] ptrlist: simplify ptr_cur_insert()
Date: Fri,  7 Jul 2017 15:39:50 +0200
Message-ID: <20170707134002.49500-23-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34181 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbdGGNke (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21so4005476lfk.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:33 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index 03a93db03..c7d049616 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -308,21 +308,22 @@ int ptr_cur_end(struct ptr_cur *cur, struct ptr_list *head)
 
 void ptr_cur_insert(struct ptr_cur *cur, void *new, void *ptr)
 {
+	struct ptr_list *curl = cur->l;
 	void **this, **last;
 
-	if (cur->l->nr == LIST_NODE_NR) {
-		split_ptr_list_head(cur->l);
-		if (cur->n >= cur->l->nr) {
-			cur->n -= cur->l->nr;
-			cur->l = cur->l->next;
+	if (curl->nr == LIST_NODE_NR) {
+		split_ptr_list_head(curl);
+		if (cur->n >= curl->nr) {
+			cur->n -= curl->nr;
+			curl = curl->next;
 		}
 	}
-	this = cur->l->list + cur->n;
-	last = cur->l->list + cur->l->nr - 1;
+	this = curl->list + cur->n;
+	last = curl->list + curl->nr - 1;
 	while (last >= this) {
 		last[1] = last[0];
 		last--;
 	}
 	*this = new;
-	cur->l->nr++;
+	curl->nr++;
 }
-- 
2.13.0

