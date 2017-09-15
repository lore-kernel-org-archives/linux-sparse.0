From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 24/28] testsuite: make do_format() more self-contained
Date: Fri, 15 Sep 2017 09:13:54 +0200
Message-ID: <20170915071358.7312-25-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38026 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbdIOHQb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id x17so1947484wmd.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:30 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 35138cb37..b4ba39f3f 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -244,7 +244,7 @@ echo "    file ...                   runs the test suite on the given file(s)"
 echo "    single file                runs the test in 'file'"
 echo "    format file [name [cmd]]   helps writing a new test case using cmd"
 echo
-echo "    help                       prints usage"
+echo "    [command] help             prints usage"
 }
 
 disable()
@@ -432,10 +432,34 @@ do_test_suite()
 	fi
 }
 
+##
+do_format_help() {
+echo "Usage: $prog_name [--]format file [name [cmd]]"
+echo
+echo "argument(s):"
+echo "    file                       file containing the test case(s)"
+echo "    name                       name for the test case (defaults to file)"
+echo "    cmd                        command to be used (defaults to 'sparse \$file')"
+}
+
 ##
 # do_format(file[, name[, cmd]]) - helps a test writer to format test-suite tags
 do_format()
 {
+	while [ $# -gt 1 ] ; do
+		case "$1" in
+		help|-*)
+			do_format_help
+			return 0
+			;;
+		*)	break ;;
+		esac
+		shift
+		continue
+	done
+
+	arg_file "$1" || return 1
+
 	if [ -z "$2" ]; then
 		fname="$1"
 		fcmd=$default_cmd
@@ -505,8 +529,8 @@ while true; do
 		esac
 		;;
 	format|--format)
-		arg_file "$2"
-		do_format "$2" "$3" "$4"
+		shift
+		do_format "$@"
 		;;
 	help | *)
 		do_usage
-- 
2.14.0

