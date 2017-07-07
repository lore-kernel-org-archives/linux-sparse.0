From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 15/34] ptrlist: use iterator API for PREPARE/NEXT_PTR_LIST()
Date: Fri,  7 Jul 2017 15:39:43 +0200
Message-ID: <20170707134002.49500-16-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33123 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbdGGNk0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:26 -0400
Received: by mail-lf0-f66.google.com with SMTP id t72so4029044lff.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:26 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 7c8fefe42..32773b378 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -127,25 +127,17 @@ static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
 	do {										\
 		struct ptr_cur __cur;							\
 		CHECK_TYPE(head,ptr);							\
-		DO_INIT(__cur, head);							\
-		if (__cur.h) ptr = CUR_ENTRY(&__cur);					\
-		else ptr = NULL
+		if (!ptr_cur_beg(&__cur, (struct ptr_list *)head) ||			\
+		    !ptr_cur_next(&__cur)) ptr = NULL;					\
+		else ptr = CUR_ENTRY(&__cur);
 
 #define DO_NEXT(ptr, __cur, CUR_ENTRY)							\
-		if (ptr) {								\
-			if (++__cur.n < __cur.l->nr) {					\
-				ptr = CUR_ENTRY(&__cur);				\
-			} else {							\
-				ptr = NULL;						\
-				do							\
-					__cur.l = __cur.l->next;			\
-				while (__cur.l->nr == 0 && __cur.l != __cur.h);		\
-				if (__cur.l != __cur.h) {				\
-					__cur.n = 0;					\
-					ptr = CUR_ENTRY(&__cur);				\
-				}							\
-			}								\
-		}
+	if (ptr) {									\
+		if (ptr_cur_next(&__cur))						\
+			ptr = CUR_ENTRY(&__cur);					\
+		else									\
+			ptr = NULL;							\
+	}
 
 #define DO_RESET(ptr, __cur, CUR_ENTRY)						\
 	do {										\
-- 
2.13.0

