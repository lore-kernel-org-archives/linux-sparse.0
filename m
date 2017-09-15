From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 06/28] testsuite: saner checking of pattern occurences
Date: Fri, 15 Sep 2017 09:13:36 +0200
Message-ID: <20170915071358.7312-7-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37269 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751207AbdIOHQN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:13 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so1957706wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:12 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/test-suite |  6 ++++++
 validation/test-suite    | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/Documentation/test-suite b/Documentation/test-suite
index a288c81a5..e2dda61d7 100644
--- a/Documentation/test-suite
+++ b/Documentation/test-suite
@@ -57,6 +57,12 @@ check-output-pattern-<nbr>-times: <pattern> (optional)
 	Similar than the contains/excludes her above, but with full control
 	of the number of times the pattern should occurs in the output.
 
+check-output-pattern(eq,<nbr>): <pattern> (optional)
+check-output-pattern(<min>,<max>): <pattern> (optional)
+	Similar than the contains/excludes her above, but with full control
+	of the number of times the pattern should occurs in the output.
+	If <min> or <max> is '-' the corresponding check is ignored.
+
 	Using test-suite
 	~~~~~~~~~~~~~~~~
 
diff --git a/validation/test-suite b/validation/test-suite
index bdc1424f4..8b2e0c85a 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -46,6 +46,7 @@ get_tag_value()
 	check_output_contains=0
 	check_output_excludes=0
 	check_output_pattern=0
+	check_output_pattern_minmax=0
 
 	lines=$(grep 'check-[a-z-]*' $1 | \
 		sed -e 's/^.*\(check-[a-z-]*:*\) *\(.*\)$/\1 \2/')
@@ -65,6 +66,7 @@ get_tag_value()
 		check-output-contains:)	check_output_contains=1 ;;
 		check-output-excludes:)	check_output_excludes=1 ;;
 		check-output-pattern-)	check_output_pattern=1 ;;
+		check-output-pattern)	check_output_pattern_minmax=1 ;;
 		esac
 	done << EOT
 	$lines
@@ -154,6 +156,46 @@ nbr_patterns()
 	return $?
 }
 
+##
+# minmax_patterns(ifile tag ofile) - does ofile contains the
+#                        the patterns given by ifile's tags
+#                        the right number of time?
+minmax_patterns()
+{
+	ifile="$1"
+	patt="$2"
+	ofile="$3"
+	grep "$patt([0-9a-z-]*, *[0-9-]*):" "$ifile" | \
+	sed -e "s/^.*$patt(\([0-9a-z-]*\), *\([0-9-]*\)): *\(.*\)/\1 \2 \3/" | \
+	while read min max pat; do
+		n=$(grep -s "$pat" "$ofile" | wc -l)
+		if [ "$min" = 'eq' ]; then
+		    if [ "$n" -ne "$max" ]; then
+			error "test '$ifile' failed"
+			error "	Pattern '$pat' expected $max times but got $n times"
+			return 1
+		    fi
+		    continue
+		fi
+		if [ "$min" != '-' ]; then
+		    if [ "$n" -lt "$min" ]; then
+			error "test '$ifile' failed"
+			error "	Pattern '$pat' expected min $nbr times but got $n times"
+			return 1
+		    fi
+		fi
+		if [ "$max" != '-' ]; then
+		    if [ "$n" -gt "$max" ]; then
+			error "test '$ifile' failed"
+			error "	Pattern '$pat' expected max $nbr times but got $n times"
+			return 1
+		    fi
+		fi
+	done
+
+	return $?
+}
+
 do_usage()
 {
 echo "$prog_name - a tiny automatic testing script"
@@ -277,6 +319,13 @@ do_test()
 			test_failed=1
 		fi
 	fi
+	if [ $check_output_pattern_minmax -eq 1 ]; then
+		# verify the 'check-output-pattern(...)' tags
+		minmax_patterns "$file" 'check-output-pattern' $file.output.got
+		if [ "$?" -ne "0" ]; then
+			test_failed=1
+		fi
+	fi
 
 	[ "$test_failed" -eq "$must_fail" ] || failed=1
 
-- 
2.14.0

