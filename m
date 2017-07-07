From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/34] ptrlist: simplify initialization of DO_REVERSE()'s cursor
Date: Fri,  7 Jul 2017 15:39:40 +0200
Message-ID: <20170707134002.49500-13-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35188 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752522AbdGGNkX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:23 -0400
Received: by mail-lf0-f67.google.com with SMTP id z78so4010649lff.2
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:22 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 8941c339a..0d17237f5 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -194,10 +194,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
 } while (0)
 
 #define DO_REVERSE(ptr, __cur, new, __newcur, PTR_ENTRY) do {				\
-	struct ptr_cur __newcur;							\
-	__newcur.h = __cur.h;								\
-	__newcur.l = __cur.l;								\
-	__newcur.n = __cur.n;								\
+	struct ptr_cur __newcur = __cur;						\
 	new = ptr;									\
 	goto __inside##new;								\
 	do {										\
-- 
2.13.0

