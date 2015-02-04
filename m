From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/3] test-suite: add support for tests case involving several
 input files
Date: Wed, 4 Feb 2015 03:46:26 +0100
Message-ID: <20150204024625.GB7731@macpro.local>
References: <54C15E0E.4000008@de.ibm.com>
 <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
 <20150123222332.GB42179@macpro.local>
 <20150123223856.GB1489@cloud>
 <20150123235934.GA42931@macpro.local>
 <CANeU7Qn9ORJ=uH6szkW2FpTT8hFhdNETjxndBYa8347Z1iON0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:59392 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbBDCqb (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Feb 2015 21:46:31 -0500
Received: by mail-wg0-f43.google.com with SMTP id y19so47966779wgg.2
        for <linux-sparse@vger.kernel.org>; Tue, 03 Feb 2015 18:46:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qn9ORJ=uH6szkW2FpTT8hFhdNETjxndBYa8347Z1iON0Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>


These input files, instead of being stored in real files and thus polluting/confusing
the test framework are now placed in a serie of sections inside an unique test file.
These sections are delimited by new tags: input-file-1-start / input-file-1-end, / input-file-2-start/ ...

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Inspired-by: Josh Triplett <josh@joshtriplett.org>

---
 Documentation/test-suite           |  7 +++++++
 validation/.gitignore              |  1 +
 validation/preprocessor/counter3.c | 15 +++++++++++----
 validation/test-suite              |  9 +++++++++
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/test-suite b/Documentation/test-suite
index 6c4f24f6..e2ce7003 100644
--- a/Documentation/test-suite
+++ b/Documentation/test-suite
@@ -32,6 +32,10 @@ check-output-start / check-output-end (optional)
 check-known-to-fail (optional)
 	Mark the test as being known to fail.
 
+input-file-1-start / input-file-1-end, / input-file-2-start/ ... (optional)
+	The input files of check-command lies between those two tags.
+	It's only needed when a test requires several files.
+
 
 	Using test-suite
 	~~~~~~~~~~~~~~~~
@@ -58,6 +62,9 @@ name:
 cmd:
 	check-command value. If no cmd is provided, it defaults to
 	"sparse $file".
+	If the "input-file-1-start/..." tags are used those files are to be
+	referenced with "$file1", ... and the command need to be something like:
+	"sparse $file1 $file2"
 
 The output of the test-suite format command can be redirected into the
 test case to create a test-suite formated file.
diff --git a/validation/.gitignore b/validation/.gitignore
index 77276ba4..2a5f114b 100644
--- a/validation/.gitignore
+++ b/validation/.gitignore
@@ -2,3 +2,4 @@
 *.diff
 *.got
 *.expected
+*.input[1-9]
diff --git a/validation/preprocessor/counter3.c b/validation/preprocessor/counter3.c
index 1449b2d1..76635e82 100644
--- a/validation/preprocessor/counter3.c
+++ b/validation/preprocessor/counter3.c
@@ -1,13 +1,20 @@
+/* input-file-1-start */
+__COUNTER__
+__COUNTER__
+/* input-file-1-end */
+
+/* input-file-2-start */
+__COUNTER__
+/* input-file-2-end */
+
 /*
  * check-name: __COUNTER__ #3
- * check-command: sparse -Ipreprocessor -E preprocessor/counter1.c preprocessor/counter2.c
+ * check-command: sparse -E $file1 $file2
  *
  * check-output-start
 
 0
 1
-"preprocessor/counter2.c" 0
-"preprocessor/counter2.h" 1
-"preprocessor/counter2.c" 2
+0
  * check-output-end
  */
diff --git a/validation/test-suite b/validation/test-suite
index df5a7c60..97d4dd40 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -102,6 +102,15 @@ do_test()
 	fi
 	test_name=$last_result
 
+	# grab the input sections
+	input_nr=1
+	while grep -q "input-file-$input_nr-start" "$file"; do
+		sed -n "/input-file-$input_nr-start/,/input-file-$input_nr-end/p" "$file" \
+			| grep -v input-file > "$file".input$input_nr
+		eval "file$input_nr=$file.input$input_nr"
+		input_nr=$(($input_nr + 1))
+	done
+
 	# does the test provide a specific command ?
 	cmd=`eval echo $default_path/$default_cmd`
 	get_value "check-command" $file
-- 
2.2.0


