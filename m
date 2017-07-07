From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 28/34] ptrlist: let undo_ptr_list_last() use the iterator API
Date: Fri,  7 Jul 2017 15:39:56 +0200
Message-ID: <20170707134002.49500-29-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33242 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbdGGNkk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:40 -0400
Received: by mail-lf0-f68.google.com with SMTP id t72so4030130lff.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:39 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index b4fb3fd6e..bae5512f3 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -192,22 +192,17 @@ out:
 /* This removes the last entry, but doesn't pack the ptr list */
 void * undo_ptr_list_last(struct ptr_list **head)
 {
-	struct ptr_list *last, *first = *head;
+	struct ptr_cur cur;
+	void *ptr;
 
-	if (!first)
+	if (!ptr_cur_end(&cur, *head) || !ptr_cur_prev(&cur))
 		return NULL;
-	last = first;
-	do {
-		last = last->prev;
-		if (last->nr) {
-			void *ptr;
-			int nr = --last->nr;
-			ptr = last->list[nr];
-			last->list[nr] = (void *)0xf1f1f1f1;
-			return ptr;
-		}
-	} while (last != first);
-	return NULL;
+
+	ptr = cur.l->list[cur.n];
+	cur.l->list[cur.n--] = (void *)0xf1f1f1f1;
+	cur.l->nr--;
+
+	return ptr;
 }
 
 void * delete_ptr_list_last(struct ptr_list **head)
-- 
2.13.0

