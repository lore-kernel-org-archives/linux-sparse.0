From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v3 3/5] ptrlist: add MARK_CURRENT_DELETED
Date: Fri,  4 Aug 2017 23:53:19 +0200
Message-ID: <20170804215321.66392-4-luc.vanoostenryck@gmail.com>
References: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36964 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752535AbdHDVxb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 17:53:31 -0400
Received: by mail-wm0-f68.google.com with SMTP id t138so7035386wmt.4
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 14:53:31 -0700 (PDT)
In-Reply-To: <20170804215321.66392-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ptrlist.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ptrlist.h b/ptrlist.h
index d8203cf0b..74b80e220 100644
--- a/ptrlist.h
+++ b/ptrlist.h
@@ -287,6 +287,14 @@ extern void split_ptr_list_head(struct ptr_list *);
 #define REPLACE_CURRENT_PTR(ptr, new_ptr)						\
 	do { *THIS_ADDRESS(ptr) = (new_ptr); } while (0)
 
+#define DO_MARK_CURRENT_DELETED(ptr, __list) do {	\
+		REPLACE_CURRENT_PTR(ptr, NULL);		\
+		__list->rm++;				\
+	} while (0)
+
+#define MARK_CURRENT_DELETED(ptr) \
+	DO_MARK_CURRENT_DELETED(ptr, __list##ptr)
+
 extern void pack_ptr_list(struct ptr_list **);
 
 #define PACK_PTR_LIST(x) pack_ptr_list((struct ptr_list **)(x))
-- 
2.13.2

