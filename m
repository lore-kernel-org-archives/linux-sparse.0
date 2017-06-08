From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] ret-void: add test case for toplevel asm
Date: Thu,  8 Jun 2017 04:47:35 +0200
Message-ID: <20170608024736.49780-2-luc.vanoostenryck@gmail.com>
References: <20170608024736.49780-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34104 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbdFHCry (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 7 Jun 2017 22:47:54 -0400
Received: by mail-wm0-f67.google.com with SMTP id 70so5113971wme.1
        for <linux-sparse@vger.kernel.org>; Wed, 07 Jun 2017 19:47:54 -0700 (PDT)
In-Reply-To: <20170608024736.49780-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Top-level asm is parsed as a fake anonymous function.
Obviously this fake function doesn't have a return type
and this create corner cases that need special handling.

For now, just add a test case with a top-leval asm to detect
possible problems in future code changes.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/asm-toplevel.c | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 validation/asm-toplevel.c

diff --git a/validation/asm-toplevel.c b/validation/asm-toplevel.c
new file mode 100644
index 000000000..8bdd7fc12
--- /dev/null
+++ b/validation/asm-toplevel.c
@@ -0,0 +1,7 @@
+__asm__("/* nothing */");
+/*
+ * check-name: asm-toplevel.c
+ * check-command: test-linearize $file
+ * check-output-ignore
+ * check-output-contains: asm *".. nothing .."
+ */
-- 
2.13.0

