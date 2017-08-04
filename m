From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 4/5] ptrlist: avoid iteration on NULL entries
Date: Fri,  4 Aug 2017 23:53:20 +0200
Message-ID: <20170804215321.66392-5-luc.vanoostenryck@gmail.com>
References: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33159 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbdHDVxe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 17:53:34 -0400
Received: by mail-wr0-f195.google.com with SMTP id y43so3757982wrd.0
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 14:53:33 -0700 (PDT)
In-Reply-To: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
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

