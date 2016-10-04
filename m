From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] sparse: make __builtin_object_size argument const
Date: Tue,  4 Oct 2016 10:54:45 +0200
Message-ID: <1475571285-18180-1-git-send-email-johannes@sipsolutions.net>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:40624 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753935AbcJDIys (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Oct 2016 04:54:48 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org

gcc clearly allows that, and this makes no difference since we
can still pass a non-const pointer without warnings.

Add a test for it, while at it.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
 lib.c                            |  2 +-
 validation/builtin_object_size.c | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 validation/builtin_object_size.c

diff --git a/lib.c b/lib.c
index 8dc5bcf9dc18..cade28c95a48 100644
--- a/lib.c
+++ b/lib.c
@@ -877,7 +877,7 @@ void declare_builtin_functions(void)
 	add_pre_buffer("extern int __builtin_isunordered(float, float);\n");
 
 	/* And some __FORTIFY_SOURCE ones.. */
-	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(void *, int);\n");
+	add_pre_buffer ("extern __SIZE_TYPE__ __builtin_object_size(const void *, int);\n");
 	add_pre_buffer ("extern void * __builtin___memcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
 	add_pre_buffer ("extern void * __builtin___memmove_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
 	add_pre_buffer ("extern void * __builtin___mempcpy_chk(void *, const void *, __SIZE_TYPE__, __SIZE_TYPE__);\n");
diff --git a/validation/builtin_object_size.c b/validation/builtin_object_size.c
new file mode 100644
index 000000000000..a7013a80e7fd
--- /dev/null
+++ b/validation/builtin_object_size.c
@@ -0,0 +1,13 @@
+static void fn(void)
+{
+	static int i;
+	const void *ptr = (void *)0;
+
+	i = __builtin_object_size(ptr, 0);
+}
+
+/*
+ * check-name: __builtin_object_size
+ * check-error-start
+ * check-error-end
+ */
-- 
2.8.1

