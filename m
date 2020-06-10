From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: plain chars are never compatible with [un]signed chars
Date: Wed, 10 Jun 2020 22:36:54 +0200
Message-ID: <20200610203654.85136-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJUhA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Jun 2020 16:37:00 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680DCC03E96B
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:37:00 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s28so306641edw.11
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:37:00 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In standard C, plain chars are either signed or unsigned but are only
compatible with themselves, not with signed chars nor with unsigned ones.

However, Sparse has this wrong and make them compatible with the
corresponding sign-qualified chars.

So, add a testcase for this.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/plain-char-compatibility.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 validation/plain-char-compatibility.c

diff --git a/validation/plain-char-compatibility.c b/validation/plain-char-compatibility.c
new file mode 100644
index 000000000000..cdfe1a31574f
--- /dev/null
+++ b/validation/plain-char-compatibility.c
@@ -0,0 +1,19 @@
+static int sfoo(void)
+{
+	return __builtin_types_compatible_p(char, signed char);
+}
+
+static int ufoo(void)
+{
+	return __builtin_types_compatible_p(char, unsigned char);
+}
+
+/*
+ * check-name: plain-char-compatibility
+ * check-command: test-linearize $file
+ * check-known-to-fail
+ *
+ * check-output-ignore
+ * check-output-pattern(2): ret.*\\$0
+ * check-output-excludes: ret.*\\$1
+ */
-- 
2.27.0
