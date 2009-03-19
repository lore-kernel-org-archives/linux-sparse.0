From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] test-suite: new preprocessor test case
Date: Thu, 19 Mar 2009 18:56:11 +0100
Message-ID: <20090319175544.13691.42362.stgit@f10box.hanneseder.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:48111 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329AbZCSR61 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 13:58:27 -0400
Received: by fk-out-0910.google.com with SMTP id 18so268345fkq.5
        for <linux-sparse@vger.kernel.org>; Thu, 19 Mar 2009 10:57:34 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-sparse@vger.kernel.org

Sparse currently fails on this test.

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---

I discovered this while hunting down the sparse segfault when checking kernel/cred.c.

When preprocessing the file with gcc, gcc remains silent, but sparse
complains:

include/linux/skbuff.h:381:9: error: expected preprocessor identifier
include/linux/skbuff.h:381:9: error: expected preprocessor identifier
include/linux/skbuff.h:381:9: error: garbage at end: )
include/linux/skbuff.h:381:9: error: expected preprocessor identifier
include/linux/skbuff.h:381:9: error: expected preprocessor identifier
include/linux/skbuff.h:381:9: error: garbage at end: )

this is covered by the test case in a more abstract form.  Sparse
further complains about this, which is not yet covered in a test case:

kernel/cred.c:281:9: error: unmatched #endif in stream
kernel/cred.c:281:9: error: unmatched #endif in stream
kernel/cred.c:281:9: error: unmatched #endif in stream

 validation/preprocessor/preprocessor22.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)
 create mode 100644 validation/preprocessor/preprocessor22.c

diff --git a/validation/preprocessor/preprocessor22.c b/validation/preprocessor/preprocessor22.c
new file mode 100644
index 0000000..838479f
--- /dev/null
+++ b/validation/preprocessor/preprocessor22.c
@@ -0,0 +1,21 @@
+#define CONFIG_FOO 1
+
+#define define_struct(name, fields...) struct fields name;
+
+define_struct(a, {
+#ifdef CONFIG_FOO
+  int b;
+#endif
+});
+/*
+ * check-name: Preprocessor #22
+ * check-description: Sparse gets this wrong, should be fixed
+ * check-command: sparse -E $file
+ * check-known-to-fail
+ *
+ * check-output-start
+
+struct {
+int b; } a;;
+ * check-output-end
+ */

