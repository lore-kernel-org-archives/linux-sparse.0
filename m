From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 18/34] ptrlist: use iterator for FOR_EACH_PTR_REVERSE()
Date: Fri,  7 Jul 2017 15:39:46 +0200
Message-ID: <20170707134002.49500-19-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33150 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbdGGNke (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:34 -0400
Received: by mail-lf0-f65.google.com with SMTP id t72so4029274lff.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:29 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index d8b96304f..c3538a260 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -175,30 +175,19 @@ static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
 #define DO_FOR_EACH_REVERSE(head, ptr, __cur, CUR_ENTRY) do {				\
 	struct ptr_cur __cur;								\
 	CHECK_TYPE(head,ptr);								\
-	DO_INIT(__cur, head);								\
-	if (!__cur.h) break;								\
-	do {										\
-		__cur.l = __cur.l->prev;						\
-		__cur.n = __cur.l->nr;							\
-		while (--__cur.n >= 0) {						\
-			ptr = CUR_ENTRY(&__cur);					\
-
+	if (!head) break;								\
+	ptr_cur_end(&__cur, (struct ptr_list *)head);					\
+	while (ptr_cur_prev(&__cur)) {							\
+		ptr = CUR_ENTRY(&__cur);
 
 #define DO_END_FOR_EACH_REVERSE(ptr, __cur)						\
-		}									\
-	} while (__cur.l != __cur.h);							\
+	}										\
 } while (0)
 
 #define DO_REVERSE(ptr, __cur, new, __newcur, CUR_ENTRY) do {				\
 	struct ptr_cur __newcur = __cur;						\
-	new = ptr;									\
-	goto __inside##new;								\
-	do {										\
-		__newcur.l = __newcur.l->prev;						\
-		__newcur.n = __newcur.l->nr;						\
-	__inside##new:									\
-		while (--__newcur.n >= 0) {						\
-			new = CUR_ENTRY(&__newcur);					\
+	while (ptr_cur_prev(&__newcur)) {						\
+		new = CUR_ENTRY(&__newcur);
 
 #define RECURSE_PTR_REVERSE(ptr, new)							\
 	DO_REVERSE(ptr, __cur##ptr,							\
-- 
2.13.0

