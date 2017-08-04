From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 4/5] ptrlist: avoid iteration on NULL entries
Date: Sat,  5 Aug 2017 00:17:41 +0200
Message-ID: <20170804221742.66665-5-luc.vanoostenryck@gmail.com>
References: <20170804221742.66665-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35746 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbdHDWR6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 18:17:58 -0400
Received: by mail-wr0-f196.google.com with SMTP id c24so3788786wra.2
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 15:17:57 -0700 (PDT)
In-Reply-To: <20170804221742.66665-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ptrlist.h b/ptrlist.h
index 74b80e220..1839b0f46 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -162,6 +162,8 @@ static inline void *last_ptr_list(struct ptr_list *list)
 			for (__nr = 0; __nr < __list->nr; __nr++) {			\
 				do {							\
 					ptr = PTR_ENTRY(__list,__nr);			\
+					if (list->rm && !ptr)				\
+						continue;				\
 					do {
 
 #define DO_END_FOR_EACH(ptr, __head, __list, __nr)					\
@@ -183,6 +185,8 @@ static inline void *last_ptr_list(struct ptr_list *list)
 			while (--__nr >= 0) {						\
 				do {							\
 					ptr = PTR_ENTRY(__list,__nr);			\
+					if (list->rm && !ptr)				\
+						continue;				\
 					do {
 
 
-- 
2.13.2

