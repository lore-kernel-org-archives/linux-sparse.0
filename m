From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 05/28] testsuite: better message for pattern absence/presence
Date: Fri, 15 Sep 2017 09:13:35 +0200
Message-ID: <20170915071358.7312-6-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35808 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOHQM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id e64so1971338wmi.2
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:11 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 953b7637e..bdc1424f4 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -96,11 +96,14 @@ has_patterns()
 	patt="$2"
 	ofile="$3"
 	cmp="$4"
+	msg="$5"
 	grep "$patt:" "$ifile" | \
 	sed -e "s/^.*$patt: *\(.*\)$/\1/" | \
 	while read val; do
 		grep -s -q "$val" "$ofile"
 		if [ "$?" $cmp 0 ]; then
+			error "test '$ifile' failed"
+			error "	Pattern '$val' unexpectedly $msg"
 			return 1
 		fi
 	done
@@ -115,7 +118,7 @@ has_patterns()
 # returns 0 if all present, 1 otherwise
 has_each_patterns()
 {
-	has_patterns "$1" "$2" "$3" -ne
+	has_patterns "$1" "$2" "$4" -ne "$3"
 }
 
 ##
@@ -125,7 +128,7 @@ has_each_patterns()
 # returns 1 if any present, 0 otherwise
 has_none_patterns()
 {
-	has_patterns "$1" "$2" "$3" -eq
+	has_patterns "$1" "$2" "$4" -eq "$3"
 }
 
 ##
@@ -256,16 +259,14 @@ do_test()
 
 	# verify the 'check-output-contains/excludes' tags
 	if [ $check_output_contains -eq 1 ]; then
-		has_each_patterns "$file" 'check-output-contains' $file.output.got
+		has_each_patterns "$file" 'check-output-contains' absent $file.output.got
 		if [ "$?" -ne "0" ]; then
-			error "Actual output doesn't contain some of the expected patterns."
 			test_failed=1
 		fi
 	fi
 	if [ $check_output_excludes -eq 1 ]; then
-		has_none_patterns "$file" 'check-output-excludes' $file.output.got
+		has_none_patterns "$file" 'check-output-excludes' present $file.output.got
 		if [ "$?" -ne "0" ]; then
-			error "Actual output contains some patterns which are not expected."
 			test_failed=1
 		fi
 	fi
-- 
2.14.0

