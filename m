From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/34] ptrlist: add ptr_cur_entry() to get iterator's current entry
Date: Fri,  7 Jul 2017 15:39:34 +0200
Message-ID: <20170707134002.49500-7-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34018 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbdGGNkR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id g21so4003883lfk.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:16 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ptrlist.h b/ptrlist.h
index e308f437c..d271f9e04 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -73,6 +73,11 @@ static inline void *__ptr_entry(const struct ptr_list *l, unsigned int i)
 	return l->list[i];
 }
 
+static inline void *ptr_cur_entry(const struct ptr_cur *cur)
+{
+	return __ptr_entry(cur->l, cur->n);
+}
+
 #define PTR_ENTRY_NOTAG(h,i)	__ptr_entry(h, i)
 #define __PTR_STRIP_TAG(ptr)	(void *)(~3UL & (unsigned long)(ptr))
 #define __PTR_KEEP_TAG(ptr)	(ptr)
-- 
2.13.0

