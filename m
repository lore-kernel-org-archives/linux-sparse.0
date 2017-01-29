From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] add helper: is_scalar_type()
Date: Sun, 29 Jan 2017 12:34:08 +0100
Message-ID: <20170129113409.9834-3-luc.vanoostenryck@gmail.com>
References: <20170129113409.9834-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34880 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbdA2PMa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 29 Jan 2017 10:12:30 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so2753103wmu.2
        for <linux-sparse@vger.kernel.org>; Sun, 29 Jan 2017 07:11:15 -0800 (PST)
In-Reply-To: <20170129113409.9834-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/symbol.h b/symbol.h
index 9b3f1604e..b0176bc5e 100644
--- a/symbol.h
+++ b/symbol.h
@@ -372,6 +372,28 @@ static inline int is_bool_type(struct symbol *type)
 	return type == &bool_ctype;
 }
 
+static inline int is_scalar_type(struct symbol *type)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	switch (type->type) {
+	case SYM_ENUM:
+	case SYM_BITFIELD:
+	case SYM_PTR:
+	case SYM_ARRAY:		// OK, will be a PTR after conversion
+	case SYM_FN:
+	case SYM_RESTRICT:	// OK, always integer types
+		return 1;
+	default:
+		break;
+	}
+	if (type->ctype.base_type == &int_type)
+		return 1;
+	if (type->ctype.base_type == &fp_type)
+		return 1;
+	return 0;
+}
+
 static inline int is_function(struct symbol *type)
 {
 	return type && type->type == SYM_FN;
-- 
2.11.0

