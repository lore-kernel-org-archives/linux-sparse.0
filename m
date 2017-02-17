From: Edward Cree <ecree@solarflare.com>
Subject: [RFC PATCH 2/2] Add test case for casts to restricted types
Date: Fri, 17 Feb 2017 15:11:51 +0000
Message-ID: <53bae853-faaf-ca28-3d7e-d65583279e45@solarflare.com>
References: <e8e65c94-4d07-b20e-1bdb-30c7a8d1108f@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nbfkord-smmo01.seg.att.com ([209.65.160.76]:7890 "EHLO
        nbfkord-smmo01.seg.att.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934151AbdBQPMG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 10:12:06 -0500
In-Reply-To: <e8e65c94-4d07-b20e-1bdb-30c7a8d1108f@solarflare.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Both implicit and explicit conversions from integer type to bitwise type
 are legal iff the source value is known to be 0.

Signed-off-by: Edward Cree <ecree@solarflare.com>
---
 validation/bitwise-cast.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 validation/bitwise-cast.c

diff --git a/validation/bitwise-cast.c b/validation/bitwise-cast.c
new file mode 100644
index 0000000..baeca29
--- /dev/null
+++ b/validation/bitwise-cast.c
@@ -0,0 +1,44 @@
+typedef unsigned int u32;
+typedef u32 __attribute__((bitwise)) __be32;
+
+/* Implicit casts of 0, legal */
+static __be32 foo(void)
+{
+       __be32 x = 0;
+
+       return 0;
+}
+
+/* Explicit cast of 0, legal */
+static __be32 bar(void)
+{
+       return (__be32)0;
+}
+
+/* Implicit casts of nonzero, bad */
+static __be32 baz(void)
+{
+       __be32 x = 0x2a;
+
+       return 99;
+}
+
+/* Explicit cast of nonzero, bad */
+static __be32 quux(void)
+{
+       return (__be32)1729;
+}
+
+/*
+ * check-name: conversions to bitwise types
+ * check-command: sparse -Wbitwise $file
+ * check-error-start
+bitwise-cast.c:21:20: warning: incorrect type in initializer (different base types)
+bitwise-cast.c:21:20:    expected restricted __be32 [usertype] x
+bitwise-cast.c:21:20:    got int
+bitwise-cast.c:23:16: warning: incorrect type in return expression (different base types)
+bitwise-cast.c:23:16:    expected restricted __be32
+bitwise-cast.c:23:16:    got int
+bitwise-cast.c:29:17: warning: cast to restricted __be32
+ * check-error-end
+ */
The information contained in this message is confidential and is intended for the addressee(s) only. If you have received this message in error, please notify the sender immediately and delete the message. Unless you are an addressee (or authorized to receive for an addressee), you may not use, copy or disclose to anyone this message or any information contained in this message. The unauthorized use, disclosure, copying or alteration of this message is strictly prohibited.
