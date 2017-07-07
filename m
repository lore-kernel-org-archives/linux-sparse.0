From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 26/34] ptrlist: let replace_ptr_list_entry() use the iterator API
Date: Fri,  7 Jul 2017 15:39:54 +0200
Message-ID: <20170707134002.49500-27-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33223 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdGGNki (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:38 -0400
Received: by mail-lf0-f68.google.com with SMTP id t72so4029988lff.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:38 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index 95ff319db..cdc4ae4b0 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -171,15 +171,19 @@ out:
 
 int replace_ptr_list_entry(struct ptr_list **list, void *old_ptr, void *new_ptr, int count)
 {
-	void *ptr;
+	struct ptr_cur cur;
+
+	if (!ptr_cur_beg(&cur, *list))
+                goto out;
 
-	FOR_EACH_PTR(*list, ptr) {
-		if (ptr==old_ptr) {
-			REPLACE_CURRENT_PTR(ptr, new_ptr);
+	while (ptr_cur_next(&cur)) {
+		void **this = &cur.l->list[cur.n];
+		if (*this == old_ptr) {
+			*this = new_ptr;
 			if (!--count)
 				goto out;
 		}
-	}END_FOR_EACH_PTR(ptr);
+	}
 	assert(count <= 0);
 out:
 	return count;
-- 
2.13.0

