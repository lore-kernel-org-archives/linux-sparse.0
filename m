From: Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH v3 14/21] evaluate: recognize string literals as address constants
Date: Mon, 01 Feb 2016 03:41:24 +0100
Message-ID: <87wpqpgnjf.fsf@gmail.com>
References: <87lh75jh9l.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36425 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbcBACl0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 21:41:26 -0500
Received: by mail-wm0-f68.google.com with SMTP id 128so7030256wmz.3
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 18:41:26 -0800 (PST)
In-Reply-To: <87lh75jh9l.fsf@gmail.com> (Nicolai Stange's message of "Mon, 01
	Feb 2016 03:28:38 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nicolai Stange <nicstange@gmail.com>

Introduce support for recognizing string literals as address constants.

Make evaluate_string() unconditionally tag the *-preop wrapped symbol
expression as being an address constant.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
 evaluate.c                    | 1 +
 validation/constexpr-string.c | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 validation/constexpr-string.c

diff --git a/evaluate.c b/evaluate.c
index f31ba9c..7a4af39 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -108,6 +108,7 @@ static struct symbol *evaluate_string(struct expression *expr)
 	
 	addr->symbol = sym;
 	addr->ctype = &lazy_ptr_ctype;
+	addr->constexpr_flags = CONSTEXPR_FLAG_ADDR_CONST;
 
 	expr->type = EXPR_PREOP;
 	expr->op = '*';
diff --git a/validation/constexpr-string.c b/validation/constexpr-string.c
new file mode 100644
index 0000000..e641a83
--- /dev/null
+++ b/validation/constexpr-string.c
@@ -0,0 +1,9 @@
+static char *a = "foobar";	// OK
+
+/*
+ * check-name: string literal constness verification.
+ * check-command: sparse -Wconstexpr-not-const $file
+ *
+ * check-error-start
+ * check-error-end
+ */
-- 
2.7.0

