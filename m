From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 16/16] testsuite: add support for 'format -a'
Date: Fri,  8 Dec 2017 14:14:55 +0100
Message-ID: <20171208131455.7786-17-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43523 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbdLHNP0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:26 -0500
Received: by mail-wm0-f65.google.com with SMTP id n138so3250663wmg.2
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:25 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The 'format' command create the information needed for the testcase
from the input file and output this on stdout. The developper must
then add this to the input file.

Let's do this automatically by adding an option '-a' to the 'format'
command to directly append the infos to the input file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/validation/test-suite b/validation/test-suite
index 8c0453590..192fba300 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -429,6 +429,7 @@ do_format_help() {
 echo "Usage: $prog_name [option(s)] [--]format file [name [cmd]]"
 echo
 echo "options:"
+echo "    -a                         append the created test to the input file"
 echo "    -f                         write a test known to fail"
 echo "    -l                         write a test for linearized code"
 echo
@@ -443,11 +444,14 @@ echo "    cmd                        command to be used (defaults to 'sparse \$f
 do_format()
 {
 	def_cmd="$default_cmd"
+	append=0
 	linear=0
 	fail=0
 
 	while [ $# -gt 1 ] ; do
 		case "$1" in
+		-a)
+			append=1 ;;
 		-f)
 			fail=1 ;;
 		-l)
@@ -474,6 +478,7 @@ do_format()
 	cmd=`eval echo $default_path/$fcmd`
 	$cmd 1> $file.output.got 2> $file.error.got
 	fexit_value=$?
+	[ "append" != 0 ] && exec >> $file
 	cat <<_EOF
 
 /*
-- 
2.15.0

