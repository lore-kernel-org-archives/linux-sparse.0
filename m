From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 25/34] ptrlist: let delete_ptr_list() use the iterator API
Date: Fri,  7 Jul 2017 15:39:53 +0200
Message-ID: <20170707134002.49500-26-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35303 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbdGGNkh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:37 -0400
Received: by mail-lf0-f66.google.com with SMTP id z78so4011884lff.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:37 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index c532dbaac..95ff319db 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -150,15 +150,19 @@ void **__add_ptr_list(struct ptr_list **listp, void *ptr, unsigned long tag)
 
 int delete_ptr_list_entry(struct ptr_list **list, void *entry, int count)
 {
-	void *ptr;
+	struct ptr_cur cur;
 
-	FOR_EACH_PTR(*list, ptr) {
+	if (!ptr_cur_beg(&cur, *list))
+                goto out;
+
+	while (ptr_cur_next(&cur)) {
+		void *ptr = cur.l->list[cur.n];
 		if (ptr == entry) {
-			DELETE_CURRENT_PTR(ptr);
+			ptr_cur_delete(&cur, ptr);
 			if (!--count)
 				goto out;
 		}
-	} END_FOR_EACH_PTR(ptr);
+	}
 	assert(count <= 0);
 out:
 	pack_ptr_list(list);
-- 
2.13.0

