From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/16] testsuite: allow to test only a subdir
Date: Fri,  8 Dec 2017 14:14:53 +0100
Message-ID: <20171208131455.7786-15-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38367 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbdLHNPX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:23 -0500
Received: by mail-wm0-f68.google.com with SMTP id 64so3141616wme.3
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:23 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

During development, it is very useful to be able to run only
some of the tests, maybe a whole class.

Help this by allowing to run the testsuite on only a subdir
of the 'validation/' directory.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 854ad8add..098cc7869 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -238,6 +238,7 @@ echo "    -q|--quiet                 Be extra quiet while running the tests."
 echo
 echo "commands:"
 echo "    [file ...]                 Runs the test suite on the given file(s)."
+echo "                               If a directory is given, run only those files."
 echo "                               If no file is given, run the whole testsuite."
 echo "    single file                Run the test in 'file'."
 echo "    format file [name [cmd]]   Help writing a new test case using cmd."
@@ -517,10 +518,6 @@ while [ "$#" -gt "0" ]; do
 		shift
 		continue
 		;;
-	*.c)
-		tests_list="$@"
-		break
-		;;
 
 	single|--single)
 		arg_file "$2"
@@ -537,10 +534,25 @@ while [ "$#" -gt "0" ]; do
 		do_format "$@"
 		exit 0
 		;;
-	help | *)
+	help)
 		do_usage
 		exit 1
 		;;
+
+	*.c)
+		tests_list="$tests_list $1"
+		shift
+		continue
+		;;
+	*)
+		if [ ! -d "$1" ]; then
+			do_usage
+			exit 1
+		fi
+		tests_list="$tests_list $(find "$1" -name '*.c' | sort)"
+		shift
+		continue
+		;;
 	esac
 	break
 done
-- 
2.15.0

