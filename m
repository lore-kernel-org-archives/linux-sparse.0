From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/34] ptrlist: add helper __PTR_STRIP_TAG()
Date: Fri,  7 Jul 2017 15:39:32 +0200
Message-ID: <20170707134002.49500-5-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32970 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752352AbdGGNkP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:15 -0400
Received: by mail-lf0-f68.google.com with SMTP id t72so4027817lff.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:14 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 7ecf2b529..93de46c0b 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -62,8 +62,15 @@ extern int linearize_ptr_list(struct ptr_list *, void **, int);
 #define free_ptr_list(list) \
 	do { VRFY_PTR_LIST(*(list)); __free_ptr_list((struct ptr_list **)(list)); } while (0)
 
-#define PTR_ENTRY_NOTAG(h,i)	((h)->list[i])
-#define PTR_ENTRY(h,i)	(void *)(~3UL & (unsigned long)PTR_ENTRY_NOTAG(h,i))
+static inline void *__ptr_entry(const struct ptr_list *l, unsigned int i)
+{
+	return l->list[i];
+}
+
+#define PTR_ENTRY_NOTAG(h,i)	__ptr_entry(h, i)
+#define __PTR_STRIP_TAG(ptr)	(void *)(~3UL & (unsigned long)(ptr))
+#define __PTR_KEEP_TAG(ptr)	(ptr)
+#define PTR_ENTRY(h,i)		__PTR_STRIP_TAG(PTR_ENTRY_NOTAG(h,i))
 
 static inline void *first_ptr_list(struct ptr_list *list)
 {
-- 
2.13.0

