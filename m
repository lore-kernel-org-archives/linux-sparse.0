From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] define ident_list
Date: Tue,  4 Apr 2017 23:49:50 +0200
Message-ID: <20170404214955.47926-2-luc.vanoostenryck@gmail.com>
References: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36284 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754617AbdDDVuL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Apr 2017 17:50:11 -0400
Received: by mail-wm0-f67.google.com with SMTP id x124so8042444wmf.3
        for <linux-sparse@vger.kernel.org>; Tue, 04 Apr 2017 14:50:10 -0700 (PDT)
In-Reply-To: <20170404214955.47926-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 lib.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib.h b/lib.h
index 134e56040..19b5cb0b3 100644
--- a/lib.h
+++ b/lib.h
@@ -75,6 +75,7 @@ DECLARE_PTR_LIST(basic_block_list, struct basic_block);
 DECLARE_PTR_LIST(instruction_list, struct instruction);
 DECLARE_PTR_LIST(multijmp_list, struct multijmp);
 DECLARE_PTR_LIST(pseudo_list, struct pseudo);
+DECLARE_PTR_LIST(ident_list, struct ident);
 DECLARE_PTR_LIST(string_list, char);
 
 typedef struct pseudo *pseudo_t;
@@ -244,6 +245,11 @@ static inline void add_expression(struct expression_list **list, struct expressi
 	add_ptr_list(list, expr);
 }
 
+static inline void add_ident(struct ident_list **list, struct ident *ident)
+{
+	add_ptr_list(list, ident);
+}
+
 #define hashval(x) ((unsigned long)(x))
 
 #endif
-- 
2.12.0

