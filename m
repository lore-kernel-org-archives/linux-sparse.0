From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 16/25] constexpr: recognize string literals as address constants
Date: Fri, 31 Mar 2017 03:44:50 +0200
Message-ID: <20170331014459.9351-17-luc.vanoostenryck@gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34254 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934889AbdCaBqp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Mar 2017 21:46:45 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so16583251wrb.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Mar 2017 18:46:43 -0700 (PDT)
In-Reply-To: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Nicolai Stange <nicstange@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Nicolai Stange <nicstange@gmail.com>

Introduce support for recognizing string literals as address constants.

Make evaluate_string() unconditionally tag the *-preop wrapped symbol
expression as being an address constant.

Signed-off-by: Nicolai Stange <nicstange@gmail.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                    | 1 +
 validation/constexpr-string.c | 9 +++++++++
 2 files changed, 10 insertions(+)
 create mode 100644 validation/constexpr-string.c

diff --git a/evaluate.c b/evaluate.c
index 9a7d432b8..cdbc08ef2 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -108,6 +108,7 @@ static struct symbol *evaluate_string(struct expression *expr)
 	
 	addr->symbol = sym;
 	addr->ctype = &lazy_ptr_ctype;
+	addr->flags = CEF_ADDR;
 
 	expr->type = EXPR_PREOP;
 	expr->op = '*';
diff --git a/validation/constexpr-string.c b/validation/constexpr-string.c
new file mode 100644
index 000000000..e641a83eb
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
2.12.0

