From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 16/34] ptrlist: use iterator API for RESET_PTR_LIST()
Date: Fri,  7 Jul 2017 15:39:44 +0200
Message-ID: <20170707134002.49500-17-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35225 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbdGGNk1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:27 -0400
Received: by mail-lf0-f65.google.com with SMTP id z78so4011000lff.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:27 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 32773b378..728f29593 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -140,11 +140,9 @@ static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
 	}
 
 #define DO_RESET(ptr, __cur, CUR_ENTRY)						\
-	do {										\
-		__cur.n = 0;								\
-		__cur.l = __cur.h;							\
-		if (__cur.h) ptr = CUR_ENTRY(&__cur);					\
-	} while (0)
+	if (!ptr_cur_beg(&__cur, (struct ptr_list *)head) ||				\
+	    !ptr_cur_next(&__cur)) ptr = NULL;						\
+	else ptr = CUR_ENTRY(&__cur);
 
 #define DO_FINISH(ptr, __cur)								\
 		(void)(__cur.n); /* Sanity-check nesting */				\
-- 
2.13.0

