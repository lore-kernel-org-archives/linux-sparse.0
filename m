From: Josh Triplett <josht@us.ibm.com>
Subject: [PATCH] "Initializer entry defined twice" should not trigger with
	zero-size fields
Date: Wed, 13 Sep 2006 15:30:49 -0700
Message-ID: <1158186650.5097.40.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:19087 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751232AbWIMWa3
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 13 Sep 2006 18:30:29 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8DMUT5Q031393
	for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2006 18:30:29 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id k8DMUSsO275276
	for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2006 16:30:28 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k8DMUSnA025987
	for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2006 16:30:28 -0600
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>, Paul McKenney <paulmck@us.ibm.com>

If a field of a structure has size 0 (which happens with an empty struct), the
subsequent field will have the same offset.  Assigning to both thus triggers
the "Initializer entry defined twice" error, which should not happen.  Change
verify_nonoverlapping to not warn about overlaps where the first field has
size 0.

Add a validation file (validation/initializer-entry-defined-twice.c) for this
warning, which covers two cases where it should trigger (same struct field
twice; two fields of a union) and this case where it should not.

This fixes numerous warnings in Linux which triggered on initialization
of structs containing empty structs; for example, this happens when
raw_spinlock_t has no members, spinlock_t has no members other than a
raw_spinlock_t, and a structure initializer initializes a spinlock_t
(with SPIN_LOCK_UNLOCKED or SPIN_LOCK_LOCKED) followed by other fields.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 expand.c                                     |   10 ++----
 validation/initializer-entry-defined-twice.c |   43 ++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/expand.c b/expand.c
index 1539446..58d41f9 100644
--- a/expand.c
+++ b/expand.c
@@ -872,12 +872,10 @@ static void verify_nonoverlapping(struct
 	struct expression *b;
 
 	FOR_EACH_PTR(*list, b) {
-		if (a) {
-			if (bit_offset(a) == bit_offset(b)) {
-				sparse_error(a->pos, "Initializer entry defined twice");
-				info(b->pos, "  also defined here");
-				return;
-			}
+		if (a && a->ctype->bit_size && bit_offset(a) == bit_offset(b)) {
+			sparse_error(a->pos, "Initializer entry defined twice");
+			info(b->pos, "  also defined here");
+			return;
 		}
 		a = b;
 	} END_FOR_EACH_PTR(b);
diff --git a/validation/initializer-entry-defined-twice.c b/validation/initializer-entry-defined-twice.c
new file mode 100644
index 0000000..80434f1
--- /dev/null
+++ b/validation/initializer-entry-defined-twice.c
@@ -0,0 +1,43 @@
+/* Tests for the "Initializer entry defined twice" warning. */
+
+/* Initializing a struct field twice should trigger the warning. */
+struct normal {
+	int field1;
+	int field2;
+};
+
+struct normal struct_error = {
+	.field1 = 0,
+	.field1 = 0
+};
+
+/* Initializing two different fields of a union should trigger the warning. */
+struct has_union {
+	int x;
+	union {
+		int a;
+		int b;
+	} y;
+	int z;
+};
+
+struct has_union union_error = {
+	.y = {
+		.a = 0,
+		.b = 0
+	}
+};
+
+/* Empty structures can make two fields have the same offset in a struct.
+ * Initialzing both should not trigger the warning. */
+struct empty { };
+
+struct same_offset {
+	struct empty field1;
+	int field2;
+};
+
+struct same_offset not_an_error = {
+	.field1 = { },
+	.field2 = 0
+};
-- 
1.4.1.1
