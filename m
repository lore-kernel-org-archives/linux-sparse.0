From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] implement constant-folding in __builtin_bswap*()
Date: Thu, 17 Nov 2016 10:55:03 +0100
Message-ID: <20161117095503.8754-1-johannes@sipsolutions.net>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:42466 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752826AbcKQJzH (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Nov 2016 04:55:07 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

Since gcc does this, it's apparently valid to write

 switch (x) {
 case __builtin_bswap16(12):
   break;
 }

but sparse will flag it as an error today.

The constant folding used to be done in the kernel's htons() and
friends, but due to gcc bugs that isn't done anymore since
commit 7322dd755e7d ("byteswap: try to avoid __builtin_constant_p
gcc bug").

To get rid of the sparse errors on every such instance now, just
add constant folding to __builtin_bswap*() in sparse.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 lib.c                               | 35 ++++++++++++++++++++++++++++++++---
 validation/bswap-constant-folding.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 3 deletions(-)
 create mode 100644 validation/bswap-constant-folding.c

diff --git a/lib.c b/lib.c
index d5b56b012a21..aa2af68bf8d2 100644
--- a/lib.c
+++ b/lib.c
@@ -818,9 +818,38 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern int __builtin_popcountll(unsigned long long);\n");
 
 	/* And byte swaps.. */
-	add_pre_buffer("extern unsigned short __builtin_bswap16(unsigned short);\n");
-	add_pre_buffer("extern unsigned int __builtin_bswap32(unsigned int);\n");
-	add_pre_buffer("extern unsigned long long __builtin_bswap64(unsigned long long);\n");
+	add_pre_buffer("extern unsigned short ____builtin_bswap16(unsigned short);\n");
+	add_pre_buffer("extern unsigned int ____builtin_bswap32(unsigned int);\n");
+	add_pre_buffer("extern unsigned long long ____builtin_bswap64(unsigned long long);\n");
+	add_pre_buffer("#define __sparse_constant_swab16(x) ((unsigned short)("
+		       "	(((unsigned short)(x) & (unsigned short)0x00ffU) << 8) |"
+		       "	(((unsigned short)(x) & (unsigned short)0xff00U) >> 8)))\n");
+	add_pre_buffer("#define __sparse_constant_swab32(x) ((unsigned int)("
+		       "	(((unsigned int)(x) & (unsigned int)0x000000ffUL) << 24) |"
+		       "	(((unsigned int)(x) & (unsigned int)0x0000ff00UL) <<  8) |"
+		       "	(((unsigned int)(x) & (unsigned int)0x00ff0000UL) >>  8) |"
+		       "	(((unsigned int)(x) & (unsigned int)0xff000000UL) >> 24)))\n");
+	add_pre_buffer("#define __sparse_constant_swab64(x) ((unsigned long long)("
+		       "	(((unsigned long long)(x) & (unsigned long long)0x00000000000000ffULL) << 56) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x000000000000ff00ULL) << 40) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x0000000000ff0000ULL) << 24) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x00000000ff000000ULL) <<  8) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x000000ff00000000ULL) >>  8) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x0000ff0000000000ULL) >> 24) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0x00ff000000000000ULL) >> 40) |"
+		       "	(((unsigned long long)(x) & (unsigned long long)0xff00000000000000ULL) >> 56)))\n");
+	add_pre_buffer("#define __builtin_bswap16(x)"
+		       "	(__builtin_constant_p((unsigned short)(x)) ?"
+		       "	__sparse_constant_swab16(x) :"
+		       "	____builtin_bswap16(x))\n");
+	add_pre_buffer("#define __builtin_bswap32(x)"
+		       "	(__builtin_constant_p((unsigned int)(x)) ?"
+		       "	__sparse_constant_swab32(x) :"
+		       "	____builtin_bswap32(x))\n");
+	add_pre_buffer("#define __builtin_bswap64(x)"
+		       "	(__builtin_constant_p((unsigned long long)(x)) ?"
+		       "	__sparse_constant_swab64(x) :"
+		       "	____builtin_bswap64(x))\n");
 
 	/* And atomic memory access functions.. */
 	add_pre_buffer("extern int __sync_fetch_and_add(void *, ...);\n");
diff --git a/validation/bswap-constant-folding.c b/validation/bswap-constant-folding.c
new file mode 100644
index 000000000000..c6511fe62041
--- /dev/null
+++ b/validation/bswap-constant-folding.c
@@ -0,0 +1,28 @@
+typedef unsigned short __be16;
+typedef unsigned short __u16;
+typedef unsigned short u16;
+#define __force
+
+#define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
+/* the test behaves as though it's always on a little-endian machine */
+#define __cpu_to_be16(x) ((__force __be16)__swab16((x)))
+#define ___htons(x) __cpu_to_be16(x)
+#define htons(x) ___htons(x)
+
+#define ETH_P_IPV6 0x86DD
+
+static u16 protocol;
+
+static void test(void)
+{
+	switch (protocol) {
+	case htons(ETH_P_IPV6):
+		break;
+	}
+}
+
+/*
+ * check-name: constant folding in bswap builtins
+ * check-error-start
+ * check-error-end
+ */
-- 
2.9.3

