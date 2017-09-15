From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 01/15] add test case for using multiple input files
Date: Fri, 15 Sep 2017 10:46:50 +0200
Message-ID: <20170915084704.39196-2-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38716 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdIOIrL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id x17so2140328wmd.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:11 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

GCC can be called with several input files in a single invocation
but these files are processed individually.

There is so no reasons to warn about a symbol being already defined
in a previous file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/multi-input.c | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 validation/multi-input.c

diff --git a/validation/multi-input.c b/validation/multi-input.c
new file mode 100644
index 000000000..2443d49fd
--- /dev/null
+++ b/validation/multi-input.c
@@ -0,0 +1,11 @@
+int a = 1;
+int foo(void) {}
+
+static int b = 1;
+static int bar(void) {}
+
+/*
+ * check-name: multi-input
+ * check-command: sparse -Wno-decl $file $file
+ * check-known-to-fail
+ */
-- 
2.14.0

