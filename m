From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Add a testsuite, call it on "make check"
Date: Mon, 06 Nov 2006 18:51:42 -0500
Message-ID: <20061106235142.27050.95901.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from static-72-92-88-10.phlapa.fios.verizon.net ([72.92.88.10]:40919
	"EHLO smtp.roinet.com") by vger.kernel.org with ESMTP
	id S1753762AbWKFXvo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 6 Nov 2006 18:51:44 -0500
Received: from dv.roinet.com (192.168.1.21 [192.168.1.21])
    by smtp.roinet.com with SMTP;
    for linux-sparse@vger.kernel.org;
    Mon, 06 Nov 2006 18:51:42 -0500 (EST)
    (envelope-from proski@gnu.org)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

From: Pavel Roskin <proski@gnu.org>

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Makefile             |    3 +
 validation/testsuite |  118 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 2dcd514..40e916b 100644
--- a/Makefile
+++ b/Makefile
@@ -138,4 +138,7 @@ pre-process.h:
 clean:
 	rm -f *.[oasi] core core.[0-9]* $(PROGRAMS) $(SLIB_FILE) pre-process.h
 
+check:
+	cd validation && ./testsuite
+
 % : SCCS/s.%s
diff --git a/validation/testsuite b/validation/testsuite
new file mode 100755
index 0000000..5498290
--- /dev/null
+++ b/validation/testsuite
@@ -0,0 +1,118 @@
+#! /bin/sh
+
+set -e
+
+: ${SPARSE=../sparse}
+: ${SPARSE_FLAGS=}
+
+# sparse should report a problem and it does
+BAD_EXP_BAD="
+bad-array-designated-initializer.c
+bad-assignment.c
+bad-cast.c
+bad-ternary-cond.c
+badtype2.c
+badtype3.c
+badtype4.c
+"
+
+# sparse should not report a problem and it doesn't
+OK_EXP_OK="
+bitfields.c
+field-overlap.c
+foul-bitwise.c
+init-char-array.c
+inline_compound_literals.c
+preprocessor16.c
+preprocessor17.c
+preprocessor6.c
+struct-as.c
+struct-ns1.c
+struct-ns2.c
+struct-size1.c
+test-be.c
+type1.c
+typeconvert.c
+varargs1.c
+phase3/comments
+"
+
+# sparse should report a problem but it doesn't
+# This needs to be fixed!
+BAD_EXP_OK="
+badtype1.c
+"
+
+# sparse should not report a problem but it does
+# This needs to be fixed!
+OK_EXP_BAD="
+builtin_safe1.c
+check_byte_count-ice.c
+choose_expr.c
+cond_expr.c
+context.c
+initializer-entry-defined-twice.c
+noderef.c
+preprocessor1.c
+preprocessor10.c
+preprocessor11.c
+preprocessor12.c
+preprocessor13.c
+preprocessor14.c
+preprocessor15.c
+preprocessor18.c
+preprocessor19.c
+preprocessor2.c
+preprocessor20.c
+preprocessor3.c
+preprocessor4.c
+preprocessor5.c
+preprocessor7.c
+preprocessor8.c
+preprocessor9.c
+phase2/backslash
+"
+
+unexp=0
+
+for t in $BAD_EXP_BAD; do
+	$SPARSE $SPARSE_FLAGS $t 2>test-err
+	if test -s test-err; then
+		echo "PASS: $t"
+	else
+		echo "UNEXPECTED FAIL: $t"
+		unexp=1
+	fi
+done
+
+for t in $OK_EXP_OK; do
+	$SPARSE $SPARSE_FLAGS $t 2>test-err
+	if test -s test-err; then
+		echo "UNEXPECTED FAIL: $t"
+		unexp=1
+	else
+		echo "PASS: $t"
+	fi
+done
+
+for t in $BAD_EXP_OK; do
+	$SPARSE $SPARSE_FLAGS $t 2>test-err
+	if test -s test-err; then
+		echo "UNEXPECTED PASS: $t"
+		unexp=1
+	else
+		echo "(known) FAIL: $t"
+	fi
+done
+
+for t in $OK_EXP_BAD; do
+	$SPARSE $SPARSE_FLAGS $t 2>test-err
+	if test -s test-err; then
+		echo "(known) FAIL: $t"
+	else
+		echo "UNEXPECTED PASS: $t"
+		unexp=1
+	fi
+done
+
+exit $unexp
