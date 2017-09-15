From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 04/28] testsuite: better message for pattern nbr checking
Date: Fri, 15 Sep 2017 09:13:34 +0200
Message-ID: <20170915071358.7312-5-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37238 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbdIOHQK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id f4so1957648wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:10 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index 5f63a23bb..953b7637e 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -142,6 +142,8 @@ nbr_patterns()
 	while read nbr pat; do
 		n=$(grep -s "$pat" "$ofile" | wc -l)
 		if [ "$n" -ne "$nbr" ]; then
+			error "test '$ifile' failed"
+			error "	Pattern '$pat' expected $nbr times but got $n times"
 			return 1
 		fi
 	done
@@ -271,7 +273,6 @@ do_test()
 		# verify the 'check-output-pattern-X-times' tags
 		nbr_patterns "$file" 'check-output-pattern' $file.output.got
 		if [ "$?" -ne "0" ]; then
-			error "Actual output doesn't contain the pattern the expected number."
 			test_failed=1
 		fi
 	fi
-- 
2.14.0

