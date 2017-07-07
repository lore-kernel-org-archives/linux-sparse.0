From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 27/34] ptrlist: let concat_ptr_list() use the iterator API
Date: Fri,  7 Jul 2017 15:39:55 +0200
Message-ID: <20170707134002.49500-28-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35322 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752779AbdGGNkj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:39 -0400
Received: by mail-lf0-f68.google.com with SMTP id z78so4012033lff.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:39 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index cdc4ae4b0..b4fb3fd6e 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -232,10 +232,13 @@ void * delete_ptr_list_last(struct ptr_list **head)
 
 void concat_ptr_list(struct ptr_list *a, struct ptr_list **b)
 {
-	void *entry;
-	FOR_EACH_PTR(a, entry) {
-		add_ptr_list(b, entry);
-	} END_FOR_EACH_PTR(entry);
+	struct ptr_cur cur;
+
+	if (!ptr_cur_beg(&cur, a))
+                return;
+
+	while (ptr_cur_next(&cur))
+		__add_ptr_list(b, ptr_cur_entry(&cur), 0);
 }
 
 void __free_ptr_list(struct ptr_list **listp)
-- 
2.13.0

