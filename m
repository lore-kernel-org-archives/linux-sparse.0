From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 19/34] ptrlist: remove unneeded DO_INIT()
Date: Fri,  7 Jul 2017 15:39:47 +0200
Message-ID: <20170707134002.49500-20-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33160 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbdGGNkb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:31 -0400
Received: by mail-lf0-f68.google.com with SMTP id t72so4029424lff.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:30 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index c3538a260..0e6d30b99 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -113,18 +113,8 @@ static inline void *last_ptr_list(struct ptr_list *list)
 	return __PTR_STRIP_TAG(ptr_cur_entry(&cur));
 }
 
-static inline void ptr_cur_init(struct ptr_cur *cur, struct ptr_list *head)
-{
-	cur->h = head;
-	cur->l = head;
-	cur->n = 0;
-}
-
-#define DO_INIT(cur, head)	\
-	ptr_cur_init(&cur, (struct ptr_list *) head)
