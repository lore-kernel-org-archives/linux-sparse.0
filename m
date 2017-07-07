From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 17/34] ptrlist: use iterator for FOR_EACH_PTR()
Date: Fri,  7 Jul 2017 15:39:45 +0200
Message-ID: <20170707134002.49500-18-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35230 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdGGNk2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:28 -0400
Received: by mail-lf0-f66.google.com with SMTP id z78so4011073lff.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:27 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 728f29593..d8b96304f 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -163,15 +163,13 @@ static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
 #define DO_FOR_EACH(head, ptr, __cur, CUR_ENTRY) do {					\
 	struct ptr_cur __cur;								\
 	CHECK_TYPE(head,ptr);								\
-	DO_INIT(__cur, head);								\
-	if (!__cur.h) break;								\
-	do {										\
-		for (__cur.n = 0; __cur.n < __cur.l->nr; __cur.n++) {			\
-			ptr = CUR_ENTRY(&__cur);					\
+	if (!head) break;								\
+	ptr_cur_beg(&__cur, (struct ptr_list *)head);					\
+	while (ptr_cur_next(&__cur)) {							\
+		ptr = CUR_ENTRY(&__cur);
 
 #define DO_END_FOR_EACH(ptr, __cur)							\
-		}									\
-	} while ((__cur.l = __cur.l->next) != __cur.h);					\
+	}										\
 } while (0)
 
 #define DO_FOR_EACH_REVERSE(head, ptr, __cur, CUR_ENTRY) do {				\
-- 
2.13.0

