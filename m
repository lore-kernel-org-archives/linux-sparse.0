From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 07/15] add test case storage specifier in struct member
Date: Fri, 15 Sep 2017 10:46:56 +0200
Message-ID: <20170915084704.39196-8-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36957 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdIOIrR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id f4so2151846wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:17 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/storage-struct-member.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 validation/storage-struct-member.c

diff --git a/validation/storage-struct-member.c b/validation/storage-struct-member.c
new file mode 100644
index 000000000..6bd958abc
--- /dev/null
+++ b/validation/storage-struct-member.c
@@ -0,0 +1,20 @@
+int foo(a)
+	register int a;
+{
+	return a;
+}
+
+struct s {
+	register int a;
+};
+
+/*
+ * check-name: storage in struct member
+ * check-command: sparse -Wno-decl $file
+ *
+ * check-known-to-fail
+ * check-error-start
+storage-struct-member.c:2:9: warning: non-ANSI definition of function 'foo'
+storage-struct-member.c:8:9: error: storage specifier in structure definition'
+ * check-error-end
+ */
-- 
2.14.0

