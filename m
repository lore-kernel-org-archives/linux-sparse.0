From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/34] ptrlist: simplify DO_FOR_EACH/DO_END_FOR_EACH
Date: Fri,  7 Jul 2017 15:39:29 +0200
Message-ID: <20170707134002.49500-2-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33954 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbdGGNkM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:12 -0400
Received: by mail-lf0-f67.google.com with SMTP id g21so4003393lfk.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:11 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index d09be2f51..9ffbc6e18 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -156,19 +156,14 @@ static inline void *last_ptr_list(struct ptr_list *list)
 	struct ptr_list *__head = (struct ptr_list *) (head);				\
 	struct ptr_list *__list = __head;						\
 	CHECK_TYPE(head,ptr);								\
-	if (__head) {									\
-		do { int __nr;								\
-			for (__nr = 0; __nr < __list->nr; __nr++) {			\
-				do {							\
-					ptr = PTR_ENTRY(__list,__nr);			\
-					do {
+	if (!__head) break;								\
+	do { int __nr;									\
+		for (__nr = 0; __nr < __list->nr; __nr++) {				\
+			ptr = PTR_ENTRY(__list,__nr);					\
 
 #define DO_END_FOR_EACH(ptr, __head, __list, __nr)					\
-					} while (0);					\
-				} while (0);						\
-			}								\
-		} while ((__list = __list->next) != __head);				\
-	}										\
+		}									\
+	} while ((__list = __list->next) != __head);					\
 } while (0)
 
 #define DO_FOR_EACH_REVERSE(head, ptr, __head, __list, __nr, PTR_ENTRY) do {		\
-- 
2.13.0

