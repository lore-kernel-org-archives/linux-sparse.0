From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/7] add is_func_type()
Date: Wed, 22 Mar 2017 18:32:52 +0100
Message-ID: <20170322173257.63019-3-luc.vanoostenryck@gmail.com>
References: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35089 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759029AbdCVRdL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 13:33:11 -0400
Received: by mail-wr0-f196.google.com with SMTP id u108so27795037wrb.2
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 10:33:10 -0700 (PDT)
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
index 36f8345b5..ee17ba643 100644
--- a/symbol.h
+++ b/symbol.h
@@ -347,6 +347,13 @@ static inline int is_ptr_type(struct symbol *type)
 	return type->type == SYM_PTR || type->type == SYM_ARRAY || type->type == SYM_FN;
 }
 
+static inline int is_func_type(struct symbol *type)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	return type->type == SYM_FN;
+}
+
 static inline int is_float_type(struct symbol *type)
 {
 	if (type->type == SYM_NODE)
-- 
2.12.0

