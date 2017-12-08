From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/16] testsuite: remove old ugly pattern syntax
Date: Fri,  8 Dec 2017 14:14:43 +0100
Message-ID: <20171208131455.7786-5-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40529 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbdLHNPO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:14 -0500
Received: by mail-wm0-f67.google.com with SMTP id f206so3123285wmf.5
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:14 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

It was too ugly (and a bit longish).

Remove it.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 903a2b908..07d9e7fc9 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -55,7 +55,6 @@ get_tag_value()
 	check_output_ignore=0
 	check_output_contains=0
 	check_output_excludes=0
-	check_output_pattern_obsolete=0
 	check_output_pattern=0
 	check_arch_ignore=""
 	check_arch_only=""
@@ -77,7 +76,6 @@ get_tag_value()
 		check-output-ignore)	check_output_ignore=1 ;;
 		check-output-contains:)	check_output_contains=1 ;;
 		check-output-excludes:)	check_output_excludes=1 ;;
-		check-output-pattern-)	check_output_pattern_obsolete=1 ;;
 		check-output-pattern)	check_output_pattern=1 ;;
 		check-arch-ignore:)	arch=$(uname -m)
 					check_arch_ignore="$val" ;;
@@ -149,29 +147,6 @@ has_none_patterns()
 	has_patterns "$1" "$2" "$4" -eq "$3"
 }
 
-##
-# nbr_patterns(ifile tag ofile) - does ofile contains the
-#                        the patterns given by ifile's tags
-#                        the right number of time?
-nbr_patterns()
-{
-	ifile="$1"
-	patt="$2"
-	ofile="$3"
-	grep "$patt-[0-9][0-9]*-times:" "$ifile" | \
-	sed -e "s/^.*$patt-\([0-9][0-9]*\)-times: *\(.*\)/\1 \2/" | \
-	while read nbr pat; do
-		n=$(grep -s "$pat" "$ofile" | wc -l)
-		if [ "$n" -ne "$nbr" ]; then
-			error "test '$ifile' failed"
-			error "	Pattern '$pat' expected $nbr times but got $n times"
-			return 1
-		fi
-	done
-
-	return $?
-}
