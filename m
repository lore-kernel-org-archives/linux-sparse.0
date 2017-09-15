From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 02/28] testsuite: allow to test a few cases at once
Date: Fri, 15 Sep 2017 09:13:32 +0200
Message-ID: <20170915071358.7312-3-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33054 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbdIOHQJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:09 -0400
Received: by mail-wm0-f68.google.com with SMTP id 187so1975260wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:08 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Sometimes we want to only launch a few tests, not the whole
testsuite. the 'single' option allow to test a single case
but it's too restrictive.

Changes this by allowing arbirary arguments as files to be tested.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index 53cd30190..9e30ed937 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -6,7 +6,7 @@ cd $(dirname "$0")
 
 default_path=".."
 default_cmd="sparse \$file"
-tests_list=`find . -name '*.c' | sed -e 's#^\./\(.*\)#\1#' | sort`
+tests_list=""
 prog_name=`basename $0`
 
 if [ ! -x "$default_path/sparse-llvm" ]; then
@@ -156,6 +156,7 @@ echo "Usage: $prog_name [command] [command arguments]"
 echo
 echo "commands:"
 echo "    none                       runs the whole test suite"
+echo "    file ...                   runs the test suite on the given file(s)"
 echo "    single file                runs the test in 'file'"
 echo "    format file [name [cmd]]   helps writing a new test case using cmd"
 echo
@@ -370,8 +371,14 @@ arg_file()
 
 case "$1" in
 	'')
+		tests_list=`find . -name '*.c' | sed -e 's#^\./\(.*\)#\1#' | sort`
 		do_test_suite
 		;;
+	*.c)
+		tests_list="$@"
+		do_test_suite
+		;;
+
 	single)
 		arg_file "$2"
 		do_test "$2"
-- 
2.14.0

