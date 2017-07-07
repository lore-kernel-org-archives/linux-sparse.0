From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/34] ptrlist: introduce the ptr_list iterator structure
Date: Fri,  7 Jul 2017 15:39:33 +0200
Message-ID: <20170707134002.49500-6-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32984 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbdGGNkQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:16 -0400
Received: by mail-lf0-f68.google.com with SMTP id t72so4027905lff.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:15 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ptrlist.h b/ptrlist.h
index 93de46c0b..e308f437c 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -31,6 +31,12 @@ struct ptr_list {
 	void *list[LIST_NODE_NR];
 };
 
+struct ptr_cur {
+	struct ptr_list *h;	/* head of the list */
+	struct ptr_list *l;	/* current block */
+	int n;			/* current index on the curent block */
+};
+
 #define ptr_list_empty(x) ((x) == NULL)
 
 void * undo_ptr_list_last(struct ptr_list **head);
-- 
2.13.0

