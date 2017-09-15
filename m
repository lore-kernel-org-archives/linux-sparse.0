From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/28] testsuite: add support for -q|--quiet
Date: Fri, 15 Sep 2017 09:13:41 +0200
Message-ID: <20170915071358.7312-12-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37320 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOHQS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so1957926wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:17 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 7a491dfb4..9371130d9 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -31,6 +31,7 @@ known_ko_tests=0
 
 # defaults to not verbose
 [ -z "$V" ] && V=0
+vquiet=""
 
 ##
 # get_tag_value(file) - get the 'check-<...>' tags & values
@@ -199,7 +200,10 @@ minmax_patterns()
 do_usage()
 {
 echo "$prog_name - a tiny automatic testing script"
-echo "Usage: $prog_name [command] [command arguments]"
+echo "Usage: $prog_name [option(s)] [command] [arguments]"
+echo
+echo "options:"
+echo "    -q|--quiet                 be extra quiet while running the tests"
 echo
 echo "commands:"
 echo "    none                       runs the whole test suite"
@@ -254,7 +258,9 @@ do_test()
 
 	cmd=`eval echo $default_path/$check_command`
 
-	echo "     TEST    $test_name ($file)"
+	if [ -z "$vquiet" ]; then
+		echo "     TEST    $test_name ($file)"
+	fi
 
 	verbose "Using command       : $cmd"
 
@@ -329,6 +335,7 @@ do_test()
 
 	if [ "$must_fail" -eq "1" ]; then
 		if [ "$test_failed" -eq "1" ]; then
+			[ -z "$vquiet" ] && \
 			echo "info: test '$file' is known to fail"
 		else
 			echo "error: test '$file' is known to fail but succeed!"
@@ -429,6 +436,12 @@ arg_file()
 
 while true; do
 	case "$1" in
+	-q|--quiet)
+		vquiet=1
+		shift
+		continue
+		;;
+
 	'')
 		tests_list=`find . -name '*.c' | sed -e 's#^\./\(.*\)#\1#' | sort`
 		do_test_suite
-- 
2.14.0

