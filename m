From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/34] ptrlist: simplify DO_FOR_EACH_REVERSE/...
Date: Fri,  7 Jul 2017 15:39:30 +0200
Message-ID: <20170707134002.49500-3-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35051 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbdGGNkN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:13 -0400
Received: by mail-lf0-f66.google.com with SMTP id z78so4009644lff.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:12 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 9ffbc6e18..9bdce843d 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -170,22 +170,17 @@ static inline void *last_ptr_list(struct ptr_list *list)
 	struct ptr_list *__head = (struct ptr_list *) (head);				\
 	struct ptr_list *__list = __head;						\
 	CHECK_TYPE(head,ptr);								\
-	if (__head) {									\
-		do { int __nr;								\
-			__list = __list->prev;						\
-			__nr = __list->nr;						\
-			while (--__nr >= 0) {						\
-				do {							\
-					ptr = PTR_ENTRY(__list,__nr);			\
-					do {
+	if (!__head) break;								\
+	do { int __nr;									\
+		__list = __list->prev;							\
+		__nr = __list->nr;							\
+		while (--__nr >= 0) {							\
+			ptr = PTR_ENTRY(__list,__nr);					\
 
 
 #define DO_END_FOR_EACH_REVERSE(ptr, __head, __list, __nr)				\
-					} while (0);					\
-				} while (0);						\
-			}								\
-		} while (__list != __head);						\
-	}										\
+		}									\
+	} while (__list != __head);							\
 } while (0)
 
 #define DO_REVERSE(ptr, __head, __list, __nr, new, __newhead,				\
@@ -195,15 +190,12 @@ static inline void *last_ptr_list(struct ptr_list *list)
 	int __newnr = __nr;								\
 	new = ptr;									\
 	goto __inside##new;								\
-	if (1) {									\
-		do {									\
-			__newlist = __newlist->prev;					\
-			__newnr = __newlist->nr;					\
+	do {										\
+		__newlist = __newlist->prev;						\
+		__newnr = __newlist->nr;						\
 	__inside##new:									\
-			while (--__newnr >= 0) {					\
-				do {							\
-					new = PTR_ENTRY(__newlist,__newnr);		\
-					do {
+		while (--__newnr >= 0) {						\
+			new = PTR_ENTRY(__newlist,__newnr);				\
 
 #define RECURSE_PTR_REVERSE(ptr, new)							\
 	DO_REVERSE(ptr, __head##ptr, __list##ptr, __nr##ptr,				\
-- 
2.13.0

