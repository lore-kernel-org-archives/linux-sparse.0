From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/34] ptrlist: add forward iterator
Date: Fri,  7 Jul 2017 15:39:35 +0200
Message-ID: <20170707134002.49500-8-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:34705 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752523AbdGGNkX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:23 -0400
Received: by mail-lf0-f49.google.com with SMTP id t72so24097547lff.1
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:17 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.c | 27 +++++++++++++++++++++++++++
 ptrlist.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/ptrlist.c b/ptrlist.c
index 5dc1117c5..5798aec43 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -246,3 +246,30 @@ void __free_ptr_list(struct ptr_list **listp)
 
 	*listp = NULL;
 }
+
+
+int ptr_cur_next(struct ptr_cur *cur)
+{
+	do {
+		struct ptr_list *curl = cur->l;
+
+		if (++cur->n < curl->nr)
+			return 1;
+
+		cur->l = curl->next;
+		cur->n = -1;
+	} while (cur->l != cur->h);
+
+	return 0;
+}
+
+int ptr_cur_beg(struct ptr_cur *cur, struct ptr_list *head)
+{
+	if (!head)
+		return 0;
+
+	cur->h = head;
+	cur->l = head;
+	cur->n = -1;
+	return 1;
+}
diff --git a/ptrlist.h b/ptrlist.h
index d271f9e04..ff38538cb 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -51,6 +51,9 @@ extern void __free_ptr_list(struct ptr_list **);
 extern int ptr_list_size(struct ptr_list *);
 extern int linearize_ptr_list(struct ptr_list *, void **, int);
 
+int ptr_cur_beg(struct ptr_cur *cur, struct ptr_list *head);
+int ptr_cur_next(struct ptr_cur *cur);
+
 /*
  * Hey, who said that you can't do overloading in C?
  *
-- 
2.13.0

