From: alexey.zaytsev@gmail.com
Subject: [PATCH 05/10] Serializable ptr lists.
Date: Thu,  4 Sep 2008 01:55:49 +0400
Message-ID: <b0118cf8f9301f77a141af47739aa599ae1e624b.1220475018.git.xl0@xl0.local>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
 <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
 <6f37eec18608be0a86356a874836bea516317084.1220475018.git.xl0@xl0.local>
 <2faea660ccc7cae55a2d2cd28f64059b80356a8f.1220475018.git.xl0@xl0.local>
 <c97fb6bb13fb17d09a2d1525cb5b813ecebb804d.1220475018.git.xl0@xl0.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:48383 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752757AbYICVx5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 17:53:57 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1952946ugf.37
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 14:53:56 -0700 (PDT)
In-Reply-To: <c97fb6bb13fb17d09a2d1525cb5b813ecebb804d.1220475018.git.xl0@xl0.local>
In-Reply-To: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
References: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, Chris Li <christ.li@gmail.com>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 ptrlist.c |   30 +++++++++++++++++++++++++++---
 ptrlist.h |    7 +++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/ptrlist.c b/ptrlist.c
index 2620412..fb6b6db 100644
--- a/ptrlist.c
+++ b/ptrlist.c
@@ -12,9 +12,33 @@
 #include "ptrlist.h"
 #include "allocate.h"
 #include "compat.h"
+#include "lib.h"
+#include "serialization.h"
+
+static int ptr_list_serializer(struct serialization_stream *s, struct ptr_list *w)
+{
+	die("Don't serialize abstract ptr lists, serialize your custom ones.");
+	return 0;
+}
+
+__DECLARE_ALLOCATOR(struct ptr_list, ptr_list_core);
+__ALLOCATOR(struct ptr_list, "ptr list", ptr_list_core);
+DO_WRAP(struct ptr_list, ptr_list, "ptrlist.h", __alloc_ptr_list_core,
+	__alloc_ptrlist, __free_ptr_list_core, __free_ptrlist,
+	ptr_list_serializer);
+
+
+struct ptr_list *fail_ptrlist_allocation(int i)
+{
+        die("Don't try to allocate ptr_list instances directly, use __add_ptr_list instead.");
+        return NULL;
+}
+
+void fail_ptrlist_free(void *p)
+{
+        die("Don't free ptr list instances directly, use free_ptr_list instead.");
+}
 
-__DECLARE_ALLOCATOR(struct ptr_list, ptrlist);
-__ALLOCATOR(struct ptr_list, "ptr list", ptrlist);
 
 int ptr_list_size(struct ptr_list *head)
 {
@@ -95,7 +119,7 @@ restart:
 			entry = next;
 		} while (entry != head);
 	}
-}		
+}
 
 void split_ptr_list_head(struct ptr_list *head)
 {
diff --git a/ptrlist.h b/ptrlist.h
index fe43de1..1a16819 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -7,6 +7,8 @@
  * (C) Copyright Linus Torvalds 2003-2005
  */
 
+#include "serialization.h"
+
 #define container(ptr, type, member) \
 	(type *)((void *)(ptr) - offsetof(type, member))
 
@@ -32,6 +34,8 @@ struct ptr_list {
 	void *list[LIST_NODE_NR];
 };
 
+DO_DECLARE_WRAPPER(struct ptr_list, ptr_list, __alloc_ptrlist, __free_ptrlist);
+
 #define ptr_list_empty(x) ((x) == NULL)
 
 void * undo_ptr_list_last(struct ptr_list **head);
@@ -46,6 +50,9 @@ extern void __free_ptr_list(struct ptr_list **);
 extern int ptr_list_size(struct ptr_list *);
 extern int linearize_ptr_list(struct ptr_list *, void **, int);
 
+/* To be used by custom ptr list serializers. */
+struct ptr_list *fail_ptrlist_allocation(int);
+void fail_ptrlist_free(void *);
 /*
  * Hey, who said that you can't do overloading in C?
  *
-- 
1.5.6.3

