From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/15] add test case bitfields in K&R decl
Date: Fri, 15 Sep 2017 10:46:55 +0200
Message-ID: <20170915084704.39196-7-luc.vanoostenryck@gmail.com>
References: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32879 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdIOIrQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 04:47:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so2169330wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 01:47:16 -0700 (PDT)
In-Reply-To: <20170915084704.39196-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Reported-by: Lance Richardson <lrichard@redhat.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/bitfield-kr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 validation/bitfield-kr.c

diff --git a/validation/bitfield-kr.c b/validation/bitfield-kr.c
new file mode 100644
index 000000000..ba66c5cd7
--- /dev/null
+++ b/validation/bitfield-kr.c
@@ -0,0 +1,14 @@
+static int foo(b)
+	int b: 4;
+{
+      return 0;
+}
+
+/*
+ * check-name: bitfield in K&R
+ *
+ * check-known-to-fail
+ * check-error-start
+bitfield-kr.c:2:9: error: bitfield in K&R declaration of 'foo'
+ * check-error-end
+ */
-- 
2.14.0

