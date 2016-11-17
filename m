From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/2] mark lists to be repacked as dirty
Date: Thu, 17 Nov 2016 18:25:59 +0100
Message-ID: <20161117172559.29417-3-luc.vanoostenryck@gmail.com>
References: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33573 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934606AbcKQR0L (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 12:26:11 -0500
Received: by mail-wm0-f67.google.com with SMTP id u144so23258027wmu.0
        for <linux-sparse@vger.kernel.org>; Thu, 17 Nov 2016 09:26:11 -0800 (PST)
In-Reply-To: <20161117172559.29417-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Use a bit in the head of a ptrlist and set it when
DELETE_PTR() is called.
Check the bit when repacking a list and do nothing if the
bit is not set.

Note: delete_ptr_list_entry() & delete_ptr_list_last()
don't need any handling because they either always call
pack_ptr_list() or remove the last block when it becomes empty.

Suggested-by: Christopher Li <sparse@chrisli.org>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.c | 7 +++++++
 ptrlist.h | 4 +++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/ptrlist.c b/ptrlist.c
index 5dc1117c..e817bad1 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -70,6 +70,11 @@ void pack_ptr_list(struct ptr_list **listp)
 
 	if (head) {
 		struct ptr_list *entry = head;
+
+		if (!head->dirty)
+			return;
+		head->dirty = 0;
+
 		do {
 			struct ptr_list *next;
 restart:
@@ -138,6 +143,7 @@ void **__add_ptr_list(struct ptr_list **listp, void *ptr, unsigned long tag)
 			list->prev = newlist;
 			last->next = newlist;
 		}
+		newlist->dirty = 0;
 		last = newlist;
 		nr = 0;
 	}
@@ -188,6 +194,7 @@ void * undo_ptr_list_last(struct ptr_list **head)
 
 	if (!first)
 		return NULL;
+	first->dirty = 1;
 	last = first;
 	do {
 		last = last->prev;
diff --git a/ptrlist.h b/ptrlist.h
index 61e159fd..c24bfb82 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -25,7 +25,8 @@
 #define LIST_NODE_NR (29)
 
 struct ptr_list {
-	int nr;
+	int nr:31;
+	unsigned int dirty:1;		// will need to be repacked
 	struct ptr_list *prev;
 	struct ptr_list *next;
 	void *list[LIST_NODE_NR];
@@ -254,6 +255,7 @@ extern void split_ptr_list_head(struct ptr_list *);
 		__this++;								\
 	}										\
 	*__this = (void *)0xf0f0f0f0;							\
+	__head->dirty = 1;								\
 	__list->nr--; __nr--;								\
 } while (0)
 
-- 
2.10.2

