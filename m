From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/4] add test case for boolean negation on float
Date: Tue, 28 Mar 2017 16:18:27 +0200
Message-ID: <20170328141829.21421-3-luc.vanoostenryck@gmail.com>
References: <20170328141829.21421-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34680 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbdC1O2C (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 10:28:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id w43so20398002wrb.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 07:27:55 -0700 (PDT)
In-Reply-To: <20170328141829.21421-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/bool-float.c | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 validation/bool-float.c

diff --git a/validation/bool-float.c b/validation/bool-float.c
new file mode 100644
index 000000000..eadf4cf09
--- /dev/null
+++ b/validation/bool-float.c
@@ -0,0 +1,9 @@
+int ftst(double a)  { return !a; }
+
+/*
+ * check-name: not-operator on float
+ * check-command: test-linearize -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-excludes: \\$0
+ */
-- 
2.12.0

