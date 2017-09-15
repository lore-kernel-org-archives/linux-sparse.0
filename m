From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 17/28] testsuite: extract disable()
Date: Fri, 15 Sep 2017 09:13:47 +0200
Message-ID: <20170915071358.7312-18-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34881 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdIOHQY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id e64so1971700wmi.2
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:23 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 9364b9d7f..84e359fb8 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -223,6 +223,14 @@ echo
 echo "    help                       prints usage"
 }
 
+disable()
+{
+	disabled_tests=$(($disabled_tests + 1))
+	if [ -z "$vquiet" ]; then
+		echo "     DISABLE $1 ($2)"
+	fi
+}
+
 ##
 # do_test(file) - tries to validate a test case
 #
@@ -259,8 +267,7 @@ do_test()
 	base_cmd=$1
 	for i in $disabled_cmds; do
 		if [ "$i" = "$base_cmd" ] ; then
-			disabled_tests=$(($disabled_tests + 1))
-			echo "     DISABLE $test_name ($file)"
+			disable "$test_name" "$file"
 			return 3
 		fi
 	done
-- 
2.14.0

