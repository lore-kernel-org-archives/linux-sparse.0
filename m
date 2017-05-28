From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/6] testsuite: get all tags in once
Date: Sun, 28 May 2017 21:29:01 +0200
Message-ID: <20170528192906.1023-2-luc.vanoostenryck@gmail.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36023 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbdE1T3N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 15:29:13 -0400
Received: by mail-wm0-f50.google.com with SMTP id 7so32324336wmo.1
        for <linux-sparse@vger.kernel.org>; Sun, 28 May 2017 12:29:13 -0700 (PDT)
In-Reply-To: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The test cases contain annotations with the following:
	check-<tagname>[: <value>]
These are extracted with grep & sed but this is done
separately for each tags which means that we need fork+exec
two processes for each possible tags.

Change this by trying to get all the tag+value in once by storing
the result in a variables instead of doing the grep & sed thing
at each time we need to check the tag.

This speedup the testsuite by around 30% for me.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 77 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 34 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 904a2dbbd..fa4cd36cf 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -33,24 +33,39 @@ known_ko_tests=0
 [ -z "$V" ] && V=0
 
 ##
-# get_value(key, file) - gets the value of a (key, value) pair in file.
-#
-# returns 0 on success, 1 if the file does not have the key
-get_value()
-{
-	last_result=`grep $1: $2 | sed -e "s/^.*$1:\(.*\)$/\1/"`
-	[ -z "$last_result" ] && return 1
-	return 0
-}
-
-##
-# get_tag(key, file) - does file has the tag key in it ?
-#
-# returns 0 if present, 1 otherwise
-get_tag()
+# get_tag_value(file) - get the 'check-<...>' tags & values
+get_tag_value()
 {
-	last_result=`grep $1 $2`
-	return $?
+	check_name=""
+	check_command="$default_cmd"
+	check_exit_value=0
+	check_known_to_fail=0
+	check_error_ignore=0
+	check_output_ignore=0
+	check_output_contains=0
+	check_output_excludes=0
+	check_output_pattern=0
+
+	lines=$(grep 'check-[a-z-]*' $1 | \
+		sed -e 's/^.*\(check-[a-z-]*:*\) *\(.*\)$/\1 \2/')
+
+	while read tag val; do
+		#echo "-> tag: '$tag'"
+		#echo "-> val: '$val'"
+		case $tag in
+		check-name:)		check_name="$val" ;;
+		check-command:)		check_command="$val" ;;
+		check-exit-value:)	check_exit_value="$val" ;;
+		check-known-to-fail)	check_known_to_fail=1 ;;
+		check-error-ignore)	check_error_ignore=1 ;;
+		check-output-ignore)	check_output_ignore=1 ;;
+		check-output-contains:)	check_output_contains=1 ;;
+		check-output-excludes:)	check_output_excludes=1 ;;
+		check-output-pattern-)	check_output_pattern=1 ;;
+		esac
+	done << EOT
+	$lines
+EOT
 }
 
 ##
@@ -159,23 +174,22 @@ do_test()
 	test_failed=0
 	file="$1"
 
+	get_tag_value $file
+
 	# can this test be handled by test-suite ?
 	# (it has to have a check-name key in it)
-	get_value "check-name" $file
-	if [ "$?" -eq 1 ]; then
+	if [ "$check_name" = "" ]; then
 		echo "warning: test '$file' unhandled"
 		unhandled_tests=`expr $unhandled_tests + 1`
 		return 2
 	fi
-	test_name=$last_result
+	test_name="$check_name"
 
 	# does the test provide a specific command ?
-	cmd=`eval echo $default_path/$default_cmd`
-	get_value "check-command" $file
-	if [ "$?" -eq "0" ]; then
-		last_result=`echo $last_result | sed -e 's/^ *//'`
-		cmd=`eval echo $default_path/$last_result`
+	if [ "$check_command" = "" ]; then
+		check_command="$defaut_command"
 	fi
+	cmd=`eval echo $default_path/$check_command`
 
 	# check for disabled commands
 	set -- $cmd
@@ -199,12 +213,7 @@ do_test()
 		| grep -v check-error > "$file".error.expected
 
 	# grab the expected exit value
-	get_value "check-exit-value" $file
-	if [ "$?" -eq "0" ]; then
-		expected_exit_value=`echo $last_result | tr -d ' '`
-	else
-		expected_exit_value=0
-	fi
+	expected_exit_value=$check_exit_value
 	verbose "Expecting exit value: $expected_exit_value"
 
 
@@ -212,14 +221,14 @@ do_test()
 	$cmd 1> $file.output.got 2> $file.error.got
 	actual_exit_value=$?
 
-	get_tag "check-known-to-fail" $file
-	must_fail=`expr "$?" = 0`
+	must_fail=$check_known_to_fail
 	quiet=0
 	[ $must_fail -eq 1 ] && [ $V -eq 0 ] && quiet=1
 	known_ko_tests=`expr $known_ko_tests + $must_fail`
 
 	for stream in output error; do
-		grep -s -q "check-$stream-ignore" $file && continue
+		eval ignore=\$check_${stream}_ignore
+		[ $ignore -eq 1 ] && continue
 
 		diff -u "$file".$stream.expected "$file".$stream.got > "$file".$stream.diff
 		if [ "$?" -ne "0" ]; then
-- 
2.13.0

