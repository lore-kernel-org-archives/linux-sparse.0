From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 29/34] ptrlist: let delete_ptr_list_last() use the iterator API
Date: Fri,  7 Jul 2017 15:39:57 +0200
Message-ID: <20170707134002.49500-30-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36859 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752791AbdGGNkl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:41 -0400
Received: by mail-lf0-f66.google.com with SMTP id f28so4001181lfi.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:41 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index bae5512f3..1957baf1f 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -207,20 +207,21 @@ void * undo_ptr_list_last(struct ptr_list **head)
 
 void * delete_ptr_list_last(struct ptr_list **head)
 {
-	void *ptr = NULL;
-	struct ptr_list *last, *first = *head;
+	struct ptr_cur cur;
+	void *ptr;
 
-	if (!first)
+	if (!ptr_cur_end(&cur, *head) || !ptr_cur_prev(&cur))
 		return NULL;
-	last = first->prev;
-	if (last->nr)
-		ptr = last->list[--last->nr];
-	if (last->nr <=0) {
-		first->prev = last->prev;
-		last->prev->next = first;
-		if (last == first)
+
+	ptr = ptr_cur_entry(&cur);
+	if (--cur.l->nr == 0) {
+		if (cur.l == cur.h)
 			*head = NULL;
-		__free_ptrlist(last);
+		else {
+			cur.h->prev = cur.l->prev;
+			cur.l->prev->next = cur.h;
+		}
+		__free_ptrlist(cur.l);
 	}
 	return ptr;
 }
-- 
2.13.0

