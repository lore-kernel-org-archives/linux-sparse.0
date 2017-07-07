From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 03/34] ptrlist: simplify DO_NEXT link walking
Date: Fri,  7 Jul 2017 15:39:31 +0200
Message-ID: <20170707134002.49500-4-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33981 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752531AbdGGNkO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:14 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21so4003572lfk.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:13 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 9bdce843d..7ecf2b529 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -118,10 +118,10 @@ static inline void *last_ptr_list(struct ptr_list *list)
 			if (++__nr < __list->nr) {					\
 				ptr = PTR_ENTRY(__list,__nr);				\
 			} else {							\
-				__list = __list->next;					\
 				ptr = NULL;						\
-				while (__list->nr == 0 && __list != __head)		\
+				do							\
 					__list = __list->next;				\
+				while (__list->nr == 0 && __list != __head);		\
 				if (__list != __head) {					\
 					__nr = 0;					\
 					ptr = PTR_ENTRY(__list,0);			\
-- 
2.13.0

