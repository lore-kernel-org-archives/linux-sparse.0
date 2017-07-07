From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 08/34] ptrlist: let first_ptr_list() use the iterator API
Date: Fri,  7 Jul 2017 15:39:36 +0200
Message-ID: <20170707134002.49500-9-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36663 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752724AbdGGNkT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:19 -0400
Received: by mail-lf0-f68.google.com with SMTP id f28so3999324lfi.3
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:18 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index ff38538cb..b46967c58 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -86,19 +86,16 @@ static inline void *ptr_cur_entry(const struct ptr_cur *cur)
 #define __PTR_KEEP_TAG(ptr)	(ptr)
 #define PTR_ENTRY(h,i)		__PTR_STRIP_TAG(PTR_ENTRY_NOTAG(h,i))
 
+
 static inline void *first_ptr_list(struct ptr_list *list)
 {
-	struct ptr_list *head = list;
+	struct ptr_cur cur;
 
-	if (!list)
+	if (!ptr_cur_beg(&cur, list))
 		return NULL;
