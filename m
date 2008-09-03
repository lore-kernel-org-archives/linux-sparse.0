From: alexey.zaytsev@gmail.com
Subject: [PATCH 04/10] Add char *first_string(struct string_list *)
Date: Thu,  4 Sep 2008 01:55:48 +0400
Message-ID: <c97fb6bb13fb17d09a2d1525cb5b813ecebb804d.1220475018.git.xl0@xl0.local>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
 <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
 <6f37eec18608be0a86356a874836bea516317084.1220475018.git.xl0@xl0.local>
 <2faea660ccc7cae55a2d2cd28f64059b80356a8f.1220475018.git.xl0@xl0.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:41113 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbYICVxy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 17:53:54 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1952952ugf.37
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 14:53:53 -0700 (PDT)
In-Reply-To: <2faea660ccc7cae55a2d2cd28f64059b80356a8f.1220475018.git.xl0@xl0.local>
In-Reply-To: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
References: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, Chris Li <christ.li@gmail.com>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 lib.h     |    5 +++++
 ptrlist.h |   17 ++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/lib.h b/lib.h
index 19a724f..532e7a4 100644
--- a/lib.h
+++ b/lib.h
@@ -186,6 +186,11 @@ static inline pseudo_t first_pseudo(struct pseudo_list *head)
 	return first_ptr_list((struct ptr_list *)head);
 }
 
+static inline char *first_string(struct string_list *head)
+{
+	return first_ptr_list_notag((struct ptr_list *)head);
+}
+
 static inline void concat_symbol_list(struct symbol_list *from, struct symbol_list **to)
 {
 	concat_ptr_list((struct ptr_list *)from, (struct ptr_list **)to);
diff --git a/ptrlist.h b/ptrlist.h
index dae0906..fe43de1 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -73,15 +73,30 @@ static inline void *first_ptr_list(struct ptr_list *list)
 	return PTR_ENTRY(list, 0);
 }
 
-static inline void *last_ptr_list(struct ptr_list *list)
+static inline void *first_ptr_list_notag(struct ptr_list *list)
 {
+	if (!list)
+		return NULL;
+	return PTR_ENTRY_NOTAG(list, 0);
+}
 
+static inline void *last_ptr_list(struct ptr_list *list)
+{
 	if (!list)
 		return NULL;
 	list = list->prev;
 	return PTR_ENTRY(list, list->nr-1);
 }
 
+static inline void *last_ptr_list_notag(struct ptr_list *list)
+{
+	if (!list)
+		return NULL;
+	list = list->prev;
+	return PTR_ENTRY_NOTAG(list, list->nr-1);
+}
+
+
 #define DO_PREPARE(head, ptr, __head, __list, __nr, PTR_ENTRY)				\
 	do {										\
 		struct ptr_list *__head = (struct ptr_list *) (head);			\
-- 
1.5.6.3

