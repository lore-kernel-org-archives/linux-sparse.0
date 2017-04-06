From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/4] add test case for linearize_initializer() of bitfields
Date: Fri,  7 Apr 2017 01:00:28 +0200
Message-ID: <20170406230029.11384-4-luc.vanoostenryck@gmail.com>
References: <20170406230029.11384-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33085 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753077AbdDFXAj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 6 Apr 2017 19:00:39 -0400
Received: by mail-wr0-f194.google.com with SMTP id g19so15333602wrb.0
        for <linux-sparse@vger.kernel.org>; Thu, 06 Apr 2017 16:00:39 -0700 (PDT)
In-Reply-To: <20170406230029.11384-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

In linearize_initializer(), 'ad->bit_size' & 'ad->bit_offset' were
never set, making the correct initialization impossible (a bit_size of
zero being especially bad, resulting in a mask of -1 instead of 0).

This is now fixed since 'bit_size' & 'bit_offset' are taken directly
from 'result_type'.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/linear/bitfield-init-mask.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 validation/linear/bitfield-init-mask.c

diff --git a/validation/linear/bitfield-init-mask.c b/validation/linear/bitfield-init-mask.c
new file mode 100644
index 000000000..94afa400c
--- /dev/null
+++ b/validation/linear/bitfield-init-mask.c
@@ -0,0 +1,27 @@
+struct bfu {
+	unsigned int a:11;
+	unsigned int f:9;
+	unsigned int z:3;
+};
+
+struct bfu bfu_init_00_11(int a)
+{
+	struct bfu bfu = { .a = a, };
+	return bfu;
+}
+
+struct bfu bfu_init_20_23(int a)
+{
+	struct bfu bfu = { .z = a, };
+	return bfu;
+}
+
+/*
+ * check-name: bitfield initializer mask
+ * check-command: test-linearize -fdump-linearize=only -Wno-decl $file
+ * check-output-ignore
+ *
+ * check-output-contains: and\\..*fffff800\$
+ * check-output-contains: shl\\..* \\$20
+ * check-output-contains: and\\..*ff8fffff\$
+ */
-- 
2.12.0

