From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 3/3] test-suite: consolidate tests that require include files
 into single test files
Date: Wed, 4 Feb 2015 03:51:04 +0100
Message-ID: <20150204025103.GD7731@macpro.local>
References: <54C15E0E.4000008@de.ibm.com>
 <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
 <20150123222332.GB42179@macpro.local>
 <20150123223856.GB1489@cloud>
 <20150123235934.GA42931@macpro.local>
 <CANeU7Qn9ORJ=uH6szkW2FpTT8hFhdNETjxndBYa8347Z1iON0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:50280 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbbBDCvI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Feb 2015 21:51:08 -0500
Received: by mail-wg0-f50.google.com with SMTP id b13so47784707wgh.9
        for <linux-sparse@vger.kernel.org>; Tue, 03 Feb 2015 18:51:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn9ORJ=uH6szkW2FpTT8hFhdNETjxndBYa8347Z1iON0Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/pragma-once.c                 | 13 ++++++++++++-
 validation/preprocessor/counter2.c       | 16 +++++++++++-----
 validation/preprocessor/counter2.h       |  1 -
 validation/preprocessor/preprocessor20.c | 18 +++++++++++++++---
 validation/preprocessor/preprocessor20.h |  6 ------
 5 files changed, 38 insertions(+), 16 deletions(-)
 delete mode 100644 validation/preprocessor/counter2.h
 delete mode 100644 validation/preprocessor/preprocessor20.h

diff --git a/validation/pragma-once.c b/validation/pragma-once.c
index 5e8b8254..83c0f9f9 100644
--- a/validation/pragma-once.c
+++ b/validation/pragma-once.c
@@ -1,5 +1,16 @@
+/* input-file-1-start */
 #pragma once
-#include "pragma-once.c"
+
+struct s {
+	int i;
+};
+/* input-file-1-end */
+
+/* input-file-2-start */
+#include "$file1"
+#include "$file1"
+/* input-file-2-end */
 /*
  * check-name: #pragma once
+ * check-command: sparse $file2
  */
diff --git a/validation/preprocessor/counter2.c b/validation/preprocessor/counter2.c
index 9883b682..fa15d954 100644
--- a/validation/preprocessor/counter2.c
+++ b/validation/preprocessor/counter2.c
@@ -1,14 +1,20 @@
+/* input-file-1-start */
 __FILE__ __COUNTER__
-#include <counter2.h>
+/* input-file-1-end */
+
+/* input-file-2-start */
 __FILE__ __COUNTER__
+#include "$file1"
+__FILE__ __COUNTER__
+/* input-file-2-end */
 /*
  * check-name: __COUNTER__ #2
- * check-command: sparse -Ipreprocessor -E $file
+ * check-command: sparse -E $file2
  *
  * check-output-start
 
-"preprocessor/counter2.c" 0
-"preprocessor/counter2.h" 1
-"preprocessor/counter2.c" 2
+"$file2" 0
+"$file1" 1
+"$file2" 2
  * check-output-end
  */
diff --git a/validation/preprocessor/counter2.h b/validation/preprocessor/counter2.h
deleted file mode 100644
index 447b70ab..00000000
--- a/validation/preprocessor/counter2.h
+++ /dev/null
@@ -1 +0,0 @@
-__FILE__ __COUNTER__
diff --git a/validation/preprocessor/preprocessor20.c b/validation/preprocessor/preprocessor20.c
index 90e93f37..679a9737 100644
--- a/validation/preprocessor/preprocessor20.c
+++ b/validation/preprocessor/preprocessor20.c
@@ -1,10 +1,22 @@
-#include "preprocessor20.h"
+/* input-file-1-start */
+#ifdef X
+B
+#endif
+#ifndef Y
+A
+#endif
+/* input-file-1-end */
+
+/* input-file-2-start */
+#include "$file1"
 #define X
 #define Y
-#include "preprocessor20.h"
+#include "$file1"
+/* input-file-2-end */
+
 /*
  * check-name: Preprocessor #20
- * check-command: sparse -E $file
+ * check-command: sparse -E $file2
  *
  * check-output-start
 
diff --git a/validation/preprocessor/preprocessor20.h b/validation/preprocessor/preprocessor20.h
deleted file mode 100644
index 322c543a..00000000
--- a/validation/preprocessor/preprocessor20.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifdef X
-B
-#endif
-#ifndef Y
-A
-#endif
-- 
2.2.0


