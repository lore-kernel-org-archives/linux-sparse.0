From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/29] add helper to test if a variable is "simple"
Date: Wed, 16 Aug 2017 17:34:35 +0200
Message-ID: <20170816153455.97693-10-luc.vanoostenryck@gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33974 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbdHPPfZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 11:35:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id x43so3697232wrb.1
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 08:35:24 -0700 (PDT)
In-Reply-To: <20170816153455.97693-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Here by 'simple' we really mean 'worth of putting in a register'.

We select all scalar types as well as struct and unions with a
size not bigger than a long (register).

Global and static variables, variables which address have been
taken and volatiles variables are never selected.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/symbol.h b/symbol.h
index 327449611..3f075c5bc 100644
--- a/symbol.h
+++ b/symbol.h
@@ -407,6 +407,39 @@ static inline int is_scalar_type(struct symbol *type)
 	return 0;
 }
 
+static inline int is_simple_type(struct symbol *type)
+{
+	if (type->type == SYM_NODE)
+		type = type->ctype.base_type;
+	switch (type->type) {
+	case SYM_ENUM:
+	case SYM_BITFIELD:
+	case SYM_PTR:
+	case SYM_RESTRICT:	// OK, always integer types
+		return 1;
+	case SYM_STRUCT:
+	case SYM_UNION:
+		return type->bit_size <= long_ctype.bit_size;
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
+static inline int is_simple_var(struct symbol *var)
+{
+	if (!is_simple_type(var))
+		return 0;
+#define	MOD_NONREG	(MOD_STATIC|MOD_NONLOCAL|MOD_ADDRESSABLE|MOD_VOLATILE)
+	if (var->ctype.modifiers & MOD_NONREG)
+		return 0;
+	return 1;
+}
+
 static inline int is_function(struct symbol *type)
 {
 	return type && type->type == SYM_FN;
-- 
2.14.0

