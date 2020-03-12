From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC] cpp: remove extra newlines during macro expansion
Date: Thu, 12 Mar 2020 21:25:33 +0100
Message-ID: <20200312202533.52465-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm1-f42.google.com ([209.85.128.42]:52047 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLUZk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 12 Mar 2020 16:25:40 -0400
Received: by mail-wm1-f42.google.com with SMTP id a132so7580786wme.1
        for <linux-sparse@vger.kernel.org>; Thu, 12 Mar 2020 13:25:40 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

During macro expansion, Sparse doesn't strip newlines from
the arguments as required by 6.10.3p10 and done by gcc & clang.

So, remove these newlines.

Note: the current behaviour may make the preprocessed output
      more readable (and so may be considered as a feature).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 pre-process.c                           |  1 +
 validation/preprocessor/expand-and-nl.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 validation/preprocessor/expand-and-nl.c

diff --git a/pre-process.c b/pre-process.c
index 479c8d225602..2893c3ab65d4 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -306,6 +306,7 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
 		next->pos.stream = pos->stream;
 		next->pos.line = pos->line;
 		next->pos.pos = pos->pos;
+		next->pos.newline = 0;
 		p = &next->next;
 	}
 	*p = &eof_token_entry;
diff --git a/validation/preprocessor/expand-and-nl.c b/validation/preprocessor/expand-and-nl.c
new file mode 100644
index 000000000000..06f6ab5cd91b
--- /dev/null
+++ b/validation/preprocessor/expand-and-nl.c
@@ -0,0 +1,14 @@
+#define M(X) X-X
+
+M(a
+b)
+/*
+ * check-name: expand-and-nl
+ * check-command: sparse -E $file
+ * check-known-to-fail
+ *
+ * check-output-start
+
+a b-a b
+ * check-output-end
+ */
-- 
2.25.1
