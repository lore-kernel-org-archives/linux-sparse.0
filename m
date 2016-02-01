From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 15/21] expression: recognize references to labels as address constants
Date: Mon, 01 Feb 2016 03:42:10 +0100
Message-ID: <87si1dgni5.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36780 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbcBACmN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:42:13 -0500
Received: by mail-wm0-f67.google.com with SMTP id 128so7032223wmz.3
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:42:12 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

As an extension, GCC allows labels to be referenced a la
  label1:
  ...

  void *ptr = &&label1;

Tag these label references as being address constants allowing them
to be used as initializers for objects of static storage duration.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 expression.c                    |  1 +
 validation/constexpr-labelref.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 validation/constexpr-labelref.c

diff --git a/expression.c b/expression.c
index 11fb9cd..ac6cf43 100644
--- a/expression.c
+++ b/expression.c
@@ -687,6 +687,7 @@ static struct token *unary_expression(struct token *token, struct expression **t
 				sym->ctype.modifiers |= MOD_ADDRESSABLE;
 				add_symbol(&function_computed_target_list, sym);
 			}
+			label->constexpr_flags = CONSTEXPR_FLAG_ADDR_CONST;
 			label->label_symbol = sym;
 			*tree = label;
 			return token->next->next;
diff --git a/validation/constexpr-labelref.c b/validation/constexpr-labelref.c
new file mode 100644
index 0000000..c51f9c8
--- /dev/null
+++ b/validation/constexpr-labelref.c
@@ -0,0 +1,15 @@
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
+
-- 
2.7.0

