From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/34] ptrlist: let lastst_ptr_list() use the iterator API
Date: Fri,  7 Jul 2017 15:39:38 +0200
Message-ID: <20170707134002.49500-11-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35168 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbdGGNkb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:31 -0400
Received: by mail-lf0-f65.google.com with SMTP id z78so4010470lff.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:25 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 883cca952..f856a54eb 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -102,17 +102,13 @@ static inline void *first_ptr_list(struct ptr_list *list)
 
 static inline void *last_ptr_list(struct ptr_list *list)
 {
-	struct ptr_list *head = list;
+	struct ptr_cur cur;
 
-	if (!list)
+	if (!ptr_cur_end(&cur, list))
+		return NULL;
+	if (!ptr_cur_prev(&cur))
 		return NULL;
-	list = list->prev;
-	while (list->nr == 0) {
-		if (list == head)
-			return NULL;
-		list = list->prev;
-	}
-	return PTR_ENTRY(list, list->nr-1);
+	return __PTR_STRIP_TAG(ptr_cur_entry(&cur));
 }
 
 #define PTR_DEREF(__head, idx, PTR_ENTRY) ({						\
-- 
2.13.0

