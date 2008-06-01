From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Expand initializers when testing them for being constant
Date: Sun, 01 Jun 2008 19:26:18 -0400
Message-ID: <20080601232618.32306.5330.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:6763 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbYFAX0W (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 1 Jun 2008 19:26:22 -0400
Received: from dv.roinet.com (static-72-92-88-10.phlapa.fios.verizon.net [72.92.88.10])
	by relay.cesmail.net (Postfix) with ESMTP id 443A9619058
	for <linux-sparse@vger.kernel.org>; Sun,  1 Jun 2008 19:26:21 -0400 (EDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 expand.c                        |    2 ++
 validation/array-size-known.c   |    9 +++++++++
 validation/array-size-unknown.c |   14 ++++++++++++++
 3 files changed, 25 insertions(+), 0 deletions(-)
 create mode 100644 validation/array-size-known.c
 create mode 100644 validation/array-size-unknown.c

diff --git a/expand.c b/expand.c
index 032f0c5..bbe8d6c 100644
--- a/expand.c
+++ b/expand.c
@@ -620,6 +620,8 @@ static int expand_dereference(struct expression *expr)
 
 		/* Const symbol with a constant initializer? */
 		if (value) {
+			expand_expression(value);
+
 			/* FIXME! We should check that the size is right! */
 			if (value->type == EXPR_VALUE) {
 				expr->type = EXPR_VALUE;
diff --git a/validation/array-size-known.c b/validation/array-size-known.c
new file mode 100644
index 0000000..8f4603a
--- /dev/null
+++ b/validation/array-size-known.c
@@ -0,0 +1,9 @@
+void foo(void);
+void foo(void) {
+	const int len = 32 + 32;
+	int buf[len];
+	buf[0] = 0;
+}
+/*
+ * check-name: Array size known at the compile time
+ */
diff --git a/validation/array-size-unknown.c b/validation/array-size-unknown.c
new file mode 100644
index 0000000..825accb
--- /dev/null
+++ b/validation/array-size-unknown.c
@@ -0,0 +1,14 @@
+extern int extra;
+void foo(void);
+void foo(void) {
+	const int len = 32 + extra;
+	int buf[len];
+	buf[0] = 0;
+}
+/*
+ * check-name: Array size unknown at the compile time
+ *
+ * check-error-start
+array-size-unknown.c:5:10: error: bad constant expression
+ * check-error-end
+ */
