From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/7] add is_array_type()
Date: Wed, 22 Mar 2017 18:32:54 +0100
Message-ID: <20170322173257.63019-5-luc.vanoostenryck@gmail.com>
References: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35591 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759029AbdCVRdO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 13:33:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id z133so11691426wmb.2
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 10:33:12 -0700 (PDT)
In-Reply-To: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/symbol.h b/symbol.h
index ee17ba643..512a2f69f 100644
--- a/symbol.h
+++ b/symbol.h
@@ -354,6 +354,13 @@ static inline int is_func_type(struct symbol *type)
 	return type->type == SYM_FN;
 }
 
+static inline int is_array_type(struct symbol *type)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	return type->type == SYM_ARRAY;
+}
+
 static inline int is_float_type(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
-- 
2.12.0

