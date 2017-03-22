From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/7] fix evaluation of a function or array symbol in conditionals
Date: Wed, 22 Mar 2017 18:32:56 +0100
Message-ID: <20170322173257.63019-7-luc.vanoostenryck@gmail.com>
References: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36649 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759029AbdCVRdQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 13:33:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id x124so11642712wmf.3
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 10:33:14 -0700 (PDT)
In-Reply-To: <20170322173257.63019-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

Functions and arrays degenerate as pointers in most context
but this wasn't done in the case of conditionals.

As a result the value of the conditional after linearization
was invalid.

Fix this by calling degenerate() in evaluate_conditional().

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 evaluate.c                |  1 +
 validation/cond-address.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 validation/cond-address.c

diff --git a/evaluate.c b/evaluate.c
index f2d95c79d..976857915 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -881,6 +881,7 @@ static struct symbol *evaluate_conditional(struct expression *expr, int iterator
 			ctype = NULL;
 		}
 	}
+	ctype = degenerate(expr);
 
 	return ctype;
 }
diff --git a/validation/cond-address.c b/validation/cond-address.c
new file mode 100644
index 000000000..2a69f4b92
--- /dev/null
+++ b/validation/cond-address.c
@@ -0,0 +1,14 @@
+extern void f(void);
+extern int a[];
+
+int foo(void) { if (f) return 1; return 0; }
+int bar(void) { if (a) return 1; return 0; }
+int qux(void) { if (f && a) return 1; return 0; }
+
+/*
+ * check-name: cond-address.c
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-excludes: VOID
+ */
-- 
2.12.0

