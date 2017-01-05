From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/5] testsuite: check the nbr of times a pattern should be present
Date: Thu,  5 Jan 2017 06:16:28 +0100
Message-ID: <20170105051632.8392-2-luc.vanoostenryck@gmail.com>
References: <20170105051632.8392-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f196.google.com ([209.85.210.196]:36788 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759805AbdAEFT1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 5 Jan 2017 00:19:27 -0500
Received: by mail-wj0-f196.google.com with SMTP id j10so77968044wjb.3
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 21:18:40 -0800 (PST)
In-Reply-To: <20170105051632.8392-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Complement the 'check-output-contains/excludes' tags to also
be able to specify the number of times a given pattern should
occurs in the output.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/test-suite |  4 ++++
 validation/test-suite    | 28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/Documentation/test-suite b/Documentation/test-suite
index a0f205f4..2e786bbf 100644
--- a/Documentation/test-suite
+++ b/Documentation/test-suite
@@ -49,6 +49,10 @@ check-output-excludes: <pattern> (optional)
 	Several such tags can be given, in which case the output
 	must contains none of the patterns.
 
+check-output-pattern-<nbr>-times: <pattern> (optional)
+	Similar than the contains/excludes her above, but with full control
+	of the number of times the pattern should occurs in the output.
+
 	Using test-suite
 	~~~~~~~~~~~~~~~~
 
diff --git a/validation/test-suite b/validation/test-suite
index e5317109..c14a4c5a 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -93,6 +93,27 @@ has_none_patterns()
 	has_patterns "$1" "$2" "$3" -eq
 }
 
+##
+# nbr_patterns(ifile tag ofile) - does ofile contains the
+#                        the patterns given by ifile's tags
+#                        the right number of time?
+nbr_patterns()
+{
+	ifile="$1"
+	patt="$2"
+	ofile="$3"
+	grep "$patt-[0-9][0-9]*-times:" "$ifile" | \
+	sed -e "s/^.*$patt-\([0-9][0-9]*\)-times: *\(.*\)/\1 \2/" | \
+	while read nbr pat; do
+		n=$(grep -s "$pat" "$ofile" | wc -l)
+		if [ "$n" -ne "$nbr" ]; then
+			return 1
+		fi
+	done
+
+	return $?
+}
+
 ##
 # verbose(string) - prints string if we are in verbose mode
 verbose()
@@ -221,6 +242,13 @@ do_test()
 		test_failed=1
 	fi
 
+	# verify the 'check-output-pattern-X-times' tags
+	nbr_patterns "$file" 'check-output-pattern' $file.output.got
+	if [ "$?" -ne "0" ]; then
+		error "Actual output doesn't contain the pattern the expected number."
+		test_failed=1
+	fi
+
 	get_tag "check-known-to-fail" $file
 	must_fail=`expr "$?" = 0`
 	known_ko_tests=`expr $known_ko_tests + $must_fail`
-- 
2.11.0

