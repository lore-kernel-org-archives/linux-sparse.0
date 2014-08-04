From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 02/10] sparse: add 'gnu_inline' to the ignored attributes
Date: Mon, 04 Aug 2014 19:33:42 +0100
Message-ID: <53DFD206.20002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:36675 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751259AbaHDSkM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Aug 2014 14:40:12 -0400
Received: from smtp.demon.co.uk (unknown [127.0.0.1])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 78CEDA64F9B
	for <linux-sparse@vger.kernel.org>; Mon,  4 Aug 2014 18:28:00 +0100 (BST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Add some more ignored attributes which are used in glibc header files,
along with a simple test case which includes all three inline attributes
(__gnu_inline__, __always_inline__ and __noinline__).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 parse.c                  |  2 ++
 validation/attr-inline.c | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 validation/attr-inline.c

diff --git a/parse.c b/parse.c
index 9767e59..69bcf82 100644
--- a/parse.c
+++ b/parse.c
@@ -536,6 +536,8 @@ const char *ignored_attributes[] = {
 	"__format__",
 	"format_arg",
 	"__format_arg__",
+	"gnu_inline",
+	"__gnu_inline__",
 	"hot",
 	"__hot__",
         "leaf",
diff --git a/validation/attr-inline.c b/validation/attr-inline.c
new file mode 100644
index 0000000..1b88ddb
--- /dev/null
+++ b/validation/attr-inline.c
@@ -0,0 +1,21 @@
+
+static inline __attribute__((__always_inline__)) int gt(int lhs, int rhs)
+{
+	return lhs > rhs;
+}
+
+extern inline __attribute__((__gnu_inline__)) int ge(int lhs, int rhs)
+{
+	return lhs >= rhs;
+}
+
+static __attribute__((__warning__("That's junk!"))) __attribute__((__unused__))
+__attribute__((__noinline__))
+void junk(void)
+{
+	__asm__("");
+}
+
+/*
+ * check-name: inline attributes
+ */
-- 
2.0.0
