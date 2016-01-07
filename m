From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] Fix size calculation of unsized bool array
Date: Thu,  7 Jan 2016 02:47:09 +0100
Message-ID: <1452131229-29756-1-git-send-email-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36313 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbcAGBsA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 6 Jan 2016 20:48:00 -0500
Received: by mail-wm0-f41.google.com with SMTP id l65so79581027wmf.1
        for <linux-sparse@vger.kernel.org>; Wed, 06 Jan 2016 17:48:00 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This stops sparse from issuing the error message
	"error: cannot size expression"
for code like:
	static _Bool boolarray[] = {
		0,
		1,
	};
	static int n = sizeof(boolarray);

The fix consists of using array_element_offset() for calculating
the size of unsized arrays, like it is done elsewhere for sized ones.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 symbol.c                |  2 +-
 validation/bool-array.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 validation/bool-array.c

diff --git a/symbol.c b/symbol.c
index 0ceff628..92a7a625 100644
--- a/symbol.c
+++ b/symbol.c
@@ -393,7 +393,7 @@ static struct symbol * examine_node_type(struct symbol *sym)
 			int count = count_array_initializer(node_type, initializer);
 
 			if (node_type && node_type->bit_size >= 0)
-				bit_size = node_type->bit_size * count;
+				bit_size = array_element_offset(node_type->bit_size, count);
 		}
 	}
 	
diff --git a/validation/bool-array.c b/validation/bool-array.c
new file mode 100644
index 00000000..6c4c8723
--- /dev/null
+++ b/validation/bool-array.c
@@ -0,0 +1,47 @@
+static _Bool boolarray_d1[1];
+static _Bool boolarray_d8[8];
+static _Bool boolarray_i2[2] = {
+	0,
+	1,
+};
+static int nd1 = sizeof(boolarray_d1);
+static int nd8 = sizeof(boolarray_d8);
+static int ni2 = sizeof(boolarray_i2);
+
+
+static long longarray_u2[] = {
+	0,
+	1,
+};
+static int nl2 = sizeof(longarray_u2);
+
+/*
+ * Used to get "warning: excessive elements in array initializer"
+ * for all elements but the first one.
+ * Note: only occurs if nbr of elements is a multiple of 8
+ *       (if not, theer was another problem)
+ */
+static _Bool boolarray_u8[] = {
+	0,
+	1,
+	0,
+	1,
+	0,
+	1,
+	0,
+	1,
+};
+
+/*
+ * Used to get "error: cannot size expression" for the sizeof.
+ */
+static _Bool boolarray_u2[] = {
+	0,
+	1,
+};
+static int nu2 = sizeof(boolarray_u2);
+
+/*
+ * check-name: sizeof(bool array)
+ * check-command: sparse -Wno-sizeof-bool $file
+ */
-- 
2.7.0

