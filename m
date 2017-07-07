From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/34] ptrlist: add backward iterator
Date: Fri,  7 Jul 2017 15:39:37 +0200
Message-ID: <20170707134002.49500-10-luc.vanoostenryck@gmail.com>
References: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33321 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbdGGNkZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 09:40:25 -0400
Received: by mail-wr0-f169.google.com with SMTP id r103so47754816wrb.0
        for <linux-sparse@vger.kernel.org>; Fri, 07 Jul 2017 06:40:24 -0700 (PDT)
In-Reply-To: <20170707134002.49500-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 ptrlist.c | 32 ++++++++++++++++++++++++++++++++
 ptrlist.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/ptrlist.c b/ptrlist.c
index 5798aec43..031c53262 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -273,3 +273,35 @@ int ptr_cur_beg(struct ptr_cur *cur, struct ptr_list *head)
 	cur->n = -1;
 	return 1;
 }
+
+int ptr_cur_prev(struct ptr_cur *cur)
+{
+	do {
+		struct ptr_list *curl = cur->l;
+
+		if (--cur->n >= 0)
+			return 1;
+
+		if (curl == cur->h)
+			break;
+		curl = curl->prev;
+		cur->l = curl;
+		cur->n = curl->nr;
+	} while (1);
+
+	return 0;
+}
+
+int ptr_cur_end(struct ptr_cur *cur, struct ptr_list *head)
+{
+	struct ptr_list *prev;
+
+	if (!head)
+		return 0;
+
+	prev = head->prev;
+	cur->h = head;
+	cur->l = prev;
+	cur->n = prev->nr;
+	return 1;
+}
diff --git a/ptrlist.h b/ptrlist.h
index b46967c58..883cca952 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -53,6 +53,8 @@ extern int linearize_ptr_list(struct ptr_list *, void **, int);
 
 int ptr_cur_beg(struct ptr_cur *cur, struct ptr_list *head);
 int ptr_cur_next(struct ptr_cur *cur);
+int ptr_cur_end(struct ptr_cur *cur, struct ptr_list *head);
+int ptr_cur_prev(struct ptr_cur *cur);
 
 /*
  * Hey, who said that you can't do overloading in C?
-- 
2.13.0

