From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 15/28] testsuite: remove useless selftest
Date: Fri, 15 Sep 2017 09:13:45 +0200
Message-ID: <20170915071358.7312-16-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33163 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOHQW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id 187so1975687wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:21 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/testsuite-selfcheck1.c | 10 ----------
 validation/testsuite-selfcheck2.c | 10 ----------
 validation/testsuite-selfcheck3.c | 10 ----------
 3 files changed, 30 deletions(-)
 delete mode 100644 validation/testsuite-selfcheck1.c
 delete mode 100644 validation/testsuite-selfcheck2.c
 delete mode 100644 validation/testsuite-selfcheck3.c

diff --git a/validation/testsuite-selfcheck1.c b/validation/testsuite-selfcheck1.c
deleted file mode 100644
index d927f9961..000000000
--- a/validation/testsuite-selfcheck1.c
+++ /dev/null
@@ -1,10 +0,0 @@
-good
-
-/*
- * check-name: selfcheck1
- * check-command: sparse -E $file
- * check-output-ignore
- *
- * check-output-contains: good
- * check-output-excludes: evil
- */
diff --git a/validation/testsuite-selfcheck2.c b/validation/testsuite-selfcheck2.c
deleted file mode 100644
index 5309e32f3..000000000
--- a/validation/testsuite-selfcheck2.c
+++ /dev/null
@@ -1,10 +0,0 @@
-evil
-
-/*
- * check-name: selfcheck2
- * check-command: sparse -E $file
- * check-output-ignore
- * check-known-to-fail
- *
- * check-output-contains: good
- */
diff --git a/validation/testsuite-selfcheck3.c b/validation/testsuite-selfcheck3.c
deleted file mode 100644
index 6d834e68d..000000000
--- a/validation/testsuite-selfcheck3.c
+++ /dev/null
@@ -1,10 +0,0 @@
-evil
