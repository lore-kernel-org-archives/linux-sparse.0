From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 27/28] testsuite: add support for 'format -f'
Date: Fri, 15 Sep 2017 09:13:57 +0200
Message-ID: <20170915071358.7312-28-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37399 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOHQe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:34 -0400
Received: by mail-wm0-f66.google.com with SMTP id f4so1958408wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:34 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 5821f4428..b5bd937d5 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -434,7 +434,10 @@ do_test_suite()
 
 ##
 do_format_help() {
-echo "Usage: $prog_name [--]format file [name [cmd]]"
+echo "Usage: $prog_name [option(s)] [--]format file [name [cmd]]"
+echo
+echo "options:"
+echo "    -f                         write a test known to fail"
 echo
 echo "argument(s):"
 echo "    file                       file containing the test case(s)"
@@ -443,11 +446,15 @@ echo "    cmd                        command to be used (defaults to 'sparse \$f
 }
 
 ##
-# do_format(file[, name[, cmd]]) - helps a test writer to format test-suite tags
+# do_format([options,] file[, name[, cmd]]) - helps a test writer to format test-suite tags
 do_format()
 {
+	fail=0
+
 	while [ $# -gt 1 ] ; do
 		case "$1" in
+		-f)
+			fail=1 ;;
 		help|-*)
 			do_format_help
 			return 0
@@ -480,6 +487,9 @@ _EOF
 	if [ "$fexit_value" -ne "0" ]; then
 		echo " * check-exit-value: $fexit_value"
 	fi
+	if [ $fail != 0 ]; then
+		echo " * check-known-to-fail"
+	fi
 	for stream in output error; do
 		if [ -s "$file.$stream.got" ]; then
 			echo " *"
-- 
2.14.0

