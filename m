From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 5/5] mark pseudo users as deleted instead of removing them
Date: Sat,  5 Aug 2017 00:17:42 +0200
Message-ID: <20170804221742.66665-6-luc.vanoostenryck@gmail.com>
References: <20170804221742.66665-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35751 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbdHDWSA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 18:18:00 -0400
Received: by mail-wr0-f196.google.com with SMTP id c24so3788819wra.2
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 15:17:59 -0700 (PDT)
In-Reply-To: <20170804221742.66665-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This will fix the (rare) problems with deletion while doing
nested ptrlist walking that occurs when doing recursive
kill_instruction() - remove_usage() - kill_instruction()

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.h  | 4 ++--
 simplify.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/ptrlist.h b/ptrlist.h
index 1839b0f46..78625c8d8 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -162,7 +162,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
 			for (__nr = 0; __nr < __list->nr; __nr++) {			\
 				do {							\
 					ptr = PTR_ENTRY(__list,__nr);			\
-					if (list->rm && !ptr)				\
+					if (__list->rm && !ptr)				\
 						continue;				\
 					do {
 
@@ -185,7 +185,7 @@ static inline void *last_ptr_list(struct ptr_list *list)
 			while (--__nr >= 0) {						\
 				do {							\
 					ptr = PTR_ENTRY(__list,__nr);			\
-					if (list->rm && !ptr)				\
+					if (__list->rm && !ptr)				\
 						continue;				\
 					do {
 
diff --git a/simplify.c b/simplify.c
index 03ff9c942..2bc86f53e 100644
--- a/simplify.c
+++ b/simplify.c
@@ -172,14 +172,15 @@ static int delete_pseudo_user_list_entry(struct pseudo_user_list **list, pseudo_
 
 	FOR_EACH_PTR(*list, pu) {
 		if (pu->userp == entry) {
-			DELETE_CURRENT_PTR(pu);
+			MARK_CURRENT_DELETED(pu);
 			if (!--count)
 				goto out;
 		}
 	} END_FOR_EACH_PTR(pu);
 	assert(count <= 0);
 out:
-	pack_ptr_list((struct ptr_list **)list);
+	if (ptr_list_size((struct ptr_list *) *list) == 0)
+		*list = NULL;
 	return count;
 }
 
-- 
2.13.2

