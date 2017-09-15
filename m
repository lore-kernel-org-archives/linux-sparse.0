From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 28/28] testsuite: add support for 'format -l'
Date: Fri, 15 Sep 2017 09:13:58 +0200
Message-ID: <20170915071358.7312-29-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37405 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdIOHQf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:35 -0400
Received: by mail-wm0-f68.google.com with SMTP id f4so1958437wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:34 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index b5bd937d5..8cbfb94e9 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -438,6 +438,7 @@ echo "Usage: $prog_name [option(s)] [--]format file [name [cmd]]"
 echo
 echo "options:"
 echo "    -f                         write a test known to fail"
+echo "    -l                         write a test for linearized code"
 echo
 echo "argument(s):"
 echo "    file                       file containing the test case(s)"
@@ -449,12 +450,17 @@ echo "    cmd                        command to be used (defaults to 'sparse \$f
 # do_format([options,] file[, name[, cmd]]) - helps a test writer to format test-suite tags
 do_format()
 {
+	def_cmd="$default_cmd"
+	linear=0
 	fail=0
 
 	while [ $# -gt 1 ] ; do
 		case "$1" in
 		-f)
 			fail=1 ;;
+		-l)
+			def_cmd='test-linearize -Wno-decl $file'
+			linear=1 ;;
 		help|-*)
 			do_format_help
 			return 0
@@ -471,7 +477,7 @@ do_format()
 	fname="$2"
 	[ -z "$fname" ] && fname="$(basename "$1" .c)"
 	fcmd="$3"
-	[ -z "$fcmd" ] && fcmd=$default_cmd
+	[ -z "$fcmd" ] && fcmd="$def_cmd"
 
 	cmd=`eval echo $default_path/$fcmd`
 	$cmd 1> $file.output.got 2> $file.error.got
@@ -490,6 +496,12 @@ _EOF
 	if [ $fail != 0 ]; then
 		echo " * check-known-to-fail"
 	fi
+	if [ $linear != 0 ]; then
+		echo " *"
+		echo " * check-output-ignore"
+		echo " * check-output-contains: xyz\\\\."
+		echo " * check-output-excludes: \\\\."
+	fi
 	for stream in output error; do
 		if [ -s "$file.$stream.got" ]; then
 			echo " *"
-- 
2.14.0

