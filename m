From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] add test case for builtin bswap with constant args
Date: Wed, 23 Nov 2016 21:38:55 +0100
Message-ID: <20161123203855.14957-1-luc.vanoostenryck@gmail.com>
References: <CANeU7QkABOFTdUCdabWL1YwHb3Qf4huVL115AHqZBNcqUytmhg@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36810 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933402AbcKWUjD (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Nov 2016 15:39:03 -0500
Received: by mail-wj0-f196.google.com with SMTP id jb2so1857726wjb.3
        for <linux-sparse@vger.kernel.org>; Wed, 23 Nov 2016 12:39:02 -0800 (PST)
In-Reply-To: <CANeU7QkABOFTdUCdabWL1YwHb3Qf4huVL115AHqZBNcqUytmhg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

---
 validation/builtin-constant-eval.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 validation/builtin-constant-eval.c

diff --git a/validation/builtin-constant-eval.c b/validation/builtin-constant-eval.c
new file mode 100644
index 00000000..63e586e9
--- /dev/null
+++ b/validation/builtin-constant-eval.c
@@ -0,0 +1,28 @@
+unsigned short bswap16(void);
+unsigned short bswap16(void)
+{
+	return __builtin_bswap16(0x1234);
+}
+
+unsigned int bswap32(void);
+unsigned int bswap32(void)
+{
+	return __builtin_bswap32(0x12345678);
+}
+
+unsigned long long bswap64(void);
+unsigned long long bswap64(void)
+{
+	return __builtin_bswap64(0x123456789abcdef0ULL);
+}
+
+/*
+ * check-name: builtin-eval
+ * check-command: test-linearize $file
+ *
+ * check-output-ignore
+ * check-output-excludes: __builtin_bswap
+ * check-output-contains:ret.16 *.0x3412
+ * check-output-contains:ret.32 *.0x78563412
+ * check-output-contains:ret.64 *.0xf0debc9a78563412
+ */
-- 
2.10.2

