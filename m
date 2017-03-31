From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 17/25] constexpr: recognize references to labels as address constants
Date: Fri, 31 Mar 2017 03:44:51 +0200
Message-ID: <20170331014459.9351-18-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34258 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935019AbdCaBqq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:46 -0400
Received: by mail-wr0-f193.google.com with SMTP id w43so16583279wrb.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:44 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

As an extension, GCC allows labels to be referenced a la
  label1:
  ...

  void *ptr = &&label1;

Tag these label references as being address constants allowing them
to be used as initializers for objects of static storage duration.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 expression.c                    |  1 +
 validation/constexpr-labelref.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 validation/constexpr-labelref.c

diff --git a/expression.c b/expression.c
index 00edd1f99..241ab7bad 100644
--- a/expression.c
+++ b/expression.c
@@ -681,6 +681,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 				sym->ctype.modifiers |= MOD_ADDRESSABLE;
 				add_symbol(&function_computed_target_list, sym);
 			}
+			label->flags = CEF_ADDR;
 			label->label_symbol = sym;
 			*tree = label;
 			return token->next->next;
diff --git a/validation/constexpr-labelref.c b/validation/constexpr-labelref.c
new file mode 100644
index 000000000..15b5293ae
--- /dev/null
+++ b/validation/constexpr-labelref.c
@@ -0,0 +1,14 @@
+static void a(void)
+{
+label1:
+	;
+	static void *b = &&label1;
+}
+
+/*
+ * check-name: label reference constness verification.
+ * check-command: sparse -Wconstexpr-not-const $file
+ *
+ * check-error-start
+ * check-error-end
+ */
-- 
2.12.0

