From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 08/14] testsuite: check patterns presence or absence in output
Date: Mon, 13 Feb 2017 00:28:58 +0100
Message-ID: <20170212232904.49647-9-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35672 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdBLX3T (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:19 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so16480522wmu.2
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:18 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently the test suite always check the exit value and the output
of the command used for the test. This is fine and allow use to catch
the most common situations:
- failure or crash (via the exit value)
- (un)expected output (like when testing the result of the preprocessor)
- (un)expected errors & warnings (like when testing sparse's warnings)

But sometimes, we're not interested in the output as such because it
can't be compared textually to some reference. This occurs systematically
when testing the output of test-linearize or test-unssa which emits
labels names which are in fact pointer values and which exact output
is very sensitive to any change in processing order, optimizations, ...
But useful tests can be easily made by just checking for the presence
or absence of some identifiers, or more generally some patterns.

This patch allow to do that by adding support for two  new tags
(check-output-contains & check-output-excludes), telling to test suite
to verifiy that the given patterns are effectively present ot absent
from the output of the tested file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/test-suite | 10 ++++++++++
 validation/test-suite    | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/Documentation/test-suite b/Documentation/test-suite
index 6936feeb1..a0f205f43 100644
--- a/Documentation/test-suite
+++ b/Documentation/test-suite
@@ -38,6 +38,16 @@ check-output-ignore / check-error-ignore (optional)
 check-known-to-fail (optional)
 	Mark the test as being known to fail.
 
+check-output-contains: <pattern> (optional)
+	Check that the output (stdout) contains the given pattern.
+	Several such tags can be given, in which case the output
+	must contains all the patterns.
+
+check-output-excludes: <pattern> (optional)
+	Similar than the above one, but with opposite logic.
+	Check that the output (stdout) doesn't contain the given pattern.
+	Several such tags can be given, in which case the output
+	must contains none of the patterns.
 
 	Using test-suite
 	~~~~~~~~~~~~~~~~
diff --git a/validation/test-suite b/validation/test-suite
index b6ec5655e..e5317109d 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -53,6 +53,46 @@ get_tag()
 	return $?
 }
 
+##
+# helper for has_(each|none)_patterns()
+has_patterns()
+{
+	ifile="$1"
+	patt="$2"
+	ofile="$3"
+	cmp="$4"
+	grep "$patt:" "$ifile" | \
+	sed -e "s/^.*$patt: *\(.*\)$/\1/" | \
+	while read val; do
+		grep -s -q "$val" "$ofile"
+		if [ "$?" $cmp 0 ]; then
+			return 1
+		fi
+	done
+
+	return $?
+}
+
+##
+# has_each_patterns(ifile tag ofile) - does ofile contains some
+#                        of the patterns given by ifile's tags?
+#
+# returns 0 if all present, 1 otherwise
+has_each_patterns()
+{
+	has_patterns "$1" "$2" "$3" -ne
+}
+
+##
+# has_none_patterns(ifile tag ofile) - does ofile contains some
+#                        of the patterns given by ifile's tags?
+#
+# returns 1 if any present, 0 otherwise
+has_none_patterns()
+{
+	has_patterns "$1" "$2" "$3" -eq
+}
+
 ##
 # verbose(string) - prints string if we are in verbose mode
 verbose()
@@ -169,6 +209,18 @@ do_test()
 		test_failed=1
 	fi
 
+	# verify the 'check-output-contains/excludes' tags
+	has_each_patterns "$file" 'check-output-contains' $file.output.got
+	if [ "$?" -ne "0" ]; then
+		error "Actual output doesn't contain some of the expected patterns."
+		test_failed=1
+	fi
+	has_none_patterns "$file" 'check-output-excludes' $file.output.got
+	if [ "$?" -ne "0" ]; then
+		error "Actual output contains some patterns which are not expected."
+		test_failed=1
+	fi
+
 	get_tag "check-known-to-fail" $file
 	must_fail=`expr "$?" = 0`
 	known_ko_tests=`expr $known_ko_tests + $must_fail`
-- 
2.11.0

