From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 10/27] add ptr_list_nth_entry()
Date: Sat, 11 Mar 2017 10:06:49 +0100
Message-ID: <20170311090706.17171-11-luc.vanoostenryck@gmail.com>
References: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35137 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752741AbdCKJHc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 04:07:32 -0500
Received: by mail-wm0-f66.google.com with SMTP id z63so2304776wmg.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 01:07:31 -0800 (PST)
In-Reply-To: <20170311090706.17171-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Usually ptr lists are accessed iteratively via the FOR/END macros
but in few case we may need to access a given element in a list,
like for example when accessing a given argument of a function.

Create an helper doing that instead of open coding it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.c | 18 ++++++++++++++++++
 ptrlist.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/ptrlist.c b/ptrlist.c
index 5dc1117c5..29aafac7d 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -246,3 +246,21 @@ void __free_ptr_list(struct ptr_list **listp)
 
 	*listp = NULL;
 }
+
+void *ptr_list_nth_entry(struct ptr_list *list, unsigned int idx)
+{
+	struct ptr_list *head = list;
+
+	if (!head)
+		return NULL;
+
+	do {
+		unsigned int nr = list->nr;
+
+		if (idx < nr)
+			return list->list[idx];
+		else
+			idx -= nr;
+	} while ((list = list->next) != head);
+	return NULL;
+}
diff --git a/ptrlist.h b/ptrlist.h
index d09be2f51..bf171f89f 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -44,6 +44,7 @@ extern void concat_ptr_list(struct ptr_list *a, struct ptr_list **b);
 extern void __free_ptr_list(struct ptr_list **);
 extern int ptr_list_size(struct ptr_list *);
 extern int linearize_ptr_list(struct ptr_list *, void **, int);
+extern void *ptr_list_nth_entry(struct ptr_list *, unsigned int idx);
 
 /*
  * Hey, who said that you can't do overloading in C?
-- 
2.11.1

