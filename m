From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/16] testsuite: fix a few more incorrect check-commands
Date: Fri,  8 Dec 2017 14:14:41 +0100
Message-ID: <20171208131455.7786-3-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:44119 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbdLHNPN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:13 -0500
Received: by mail-wm0-f68.google.com with SMTP id t8so3244644wmc.3
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:12 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The exact syntax for commands is:
	'check-command: ' <command> <args>...
and the command itself must *not* be prefixed with './'.

Fix the last three that had it wrong.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/fp-ops.c            | 2 +-
 validation/option-parsing-00.c | 2 +-
 validation/option-parsing-01.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/validation/fp-ops.c b/validation/fp-ops.c
index 7f58a72fc..71cb9848b 100644
--- a/validation/fp-ops.c
+++ b/validation/fp-ops.c
@@ -7,7 +7,7 @@ _Bool  ftst(double x)           { return !x; }
 
 /*
  * check-name: floating-point ops
- * check-command: ./test-linearize -Wno-decl $file
+ * check-command: test-linearize -Wno-decl $file
 
  * check-output-start
 fadd:
diff --git a/validation/option-parsing-00.c b/validation/option-parsing-00.c
index 9b85943c1..9dceab7fa 100644
--- a/validation/option-parsing-00.c
+++ b/validation/option-parsing-00.c
@@ -1,5 +1,5 @@
 
 /*
  * check-name: option parsing 00
- * check-command sparse -foptimize-xyz $file
+ * check-command: sparse -foptimize-xyz $file
  */
diff --git a/validation/option-parsing-01.c b/validation/option-parsing-01.c
index e33a2ef0b..a2875bd15 100644
--- a/validation/option-parsing-01.c
+++ b/validation/option-parsing-01.c
@@ -1,5 +1,5 @@
 
 /*
  * check-name: option parsing 01
- * check-command sparse -fno-optimize-xyz $file
+ * check-command: sparse -fno-optimize-xyz $file
  */
-- 
2.15.0

