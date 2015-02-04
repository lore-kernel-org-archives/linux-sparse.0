From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/3] test-suite: allow filename expansion of the input
 sections
Date: Wed, 4 Feb 2015 04:11:45 +0100
Message-ID: <20150204031144.GA8049@macpro.local>
References: <54C15E0E.4000008@de.ibm.com>
 <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
 <20150123222332.GB42179@macpro.local>
 <20150123223856.GB1489@cloud>
 <20150123235934.GA42931@macpro.local>
 <CANeU7Qn9ORJ=uH6szkW2FpTT8hFhdNETjxndBYa8347Z1iON0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:61987 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbBDDLu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Feb 2015 22:11:50 -0500
Received: by mail-wi0-f177.google.com with SMTP id r20so723379wiv.4
        for <linux-sparse@vger.kernel.org>; Tue, 03 Feb 2015 19:11:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn9ORJ=uH6szkW2FpTT8hFhdNETjxndBYa8347Z1iON0Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Suggested-by: Josh Triplett <josh@joshtriplett.org>
---
 Documentation/test-suite               |  4 ++++
 validation/test-suite                  |  2 ++
 validation/test-suite-file-expansion.c | 22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 validation/test-suite-file-expansion.c

diff --git a/Documentation/test-suite b/Documentation/test-suite
index e2ce7003..86bee335 100644
--- a/Documentation/test-suite
+++ b/Documentation/test-suite
@@ -35,6 +35,10 @@ check-known-to-fail (optional)
 input-file-1-start / input-file-1-end, / input-file-2-start/ ... (optional)
 	The input files of check-command lies between those two tags.
 	It's only needed when a test requires several files.
+	The '$file1', '$file2', ... strings are special. They will be expanded
+	at run time to the name of each of these files. These strings can be used
+	inside these input sections themselves, the check-command or the
+	check-output section.
 
 
 	Using test-suite
diff --git a/validation/test-suite b/validation/test-suite
index 97d4dd40..8b0cd5e4 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -106,6 +106,7 @@ do_test()
 	input_nr=1
 	while grep -q "input-file-$input_nr-start" "$file"; do
 		sed -n "/input-file-$input_nr-start/,/input-file-$input_nr-end/p" "$file" \
+			| sed "s:\\\$file\\([1-9]\\):$(basename $file).input\\1:" \
 			| grep -v input-file > "$file".input$input_nr
 		eval "file$input_nr=$file.input$input_nr"
 		input_nr=$(($input_nr + 1))
@@ -136,6 +137,7 @@ do_test()
 
 	# grab the expected output
 	sed -n '/check-output-start/,/check-output-end/p' $file \
+		| sed "s:\\\$file\\([1-9]\\):$file.input\\1:" \
 		| grep -v check-output > "$file".output.expected
 	sed -n '/check-error-start/,/check-error-end/p' $file \
 		| grep -v check-error > "$file".error.expected
diff --git a/validation/test-suite-file-expansion.c b/validation/test-suite-file-expansion.c
new file mode 100644
index 00000000..fc4ff8d5
--- /dev/null
+++ b/validation/test-suite-file-expansion.c
@@ -0,0 +1,22 @@
+/* input-file-1-start */
+const char file = __FILE__;
+/* input-file-1-end */
+
+/* input-file-2-start */
+int val = 0;
+#include "$file1"
+const char file = __FILE__;
+/* input-file-2-end */
+
+/*
+ * check-name: test-suite $file* expansion
+ * check-command: sparse -E $file1 $file2
+ *
+ * check-output-start
+
+const char file = "$file1";
+int val = 0;
+const char file = "$file1";
+const char file = "$file2";
+ * check-output-end
+ */
-- 
2.2.0


