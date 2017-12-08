From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 15/16] testsuite: default to shift in the getopt loop
Date: Fri,  8 Dec 2017 14:14:54 +0100
Message-ID: <20171208131455.7786-16-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:44150 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753457AbdLHNPY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id t8so3245605wmc.3
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:24 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The getopt loop used to bear by default and only some
options had to explicitly call 'shift' and 'continue'
to process further elements.

Change this to a 'normal' loop, shifting the next arg by default
and breaking of the loop when needed.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 098cc7869..8c0453590 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -510,13 +510,9 @@ while [ "$#" -gt "0" ]; do
 	case "$1" in
 	-a|--abort)
 		abort=1
-		shift
-		continue
 		;;
 	-q|--quiet)
 		vquiet=1
-		shift
-		continue
 		;;
 
 	single|--single)
@@ -541,8 +537,6 @@ while [ "$#" -gt "0" ]; do
 
 	*.c)
 		tests_list="$tests_list $1"
-		shift
-		continue
 		;;
 	*)
 		if [ ! -d "$1" ]; then
@@ -550,11 +544,9 @@ while [ "$#" -gt "0" ]; do
 			exit 1
 		fi
 		tests_list="$tests_list $(find "$1" -name '*.c' | sort)"
-		shift
-		continue
 		;;
 	esac
-	break
+	shift
 done
 
 if [ -z "$tests_list" ]; then
-- 
2.15.0

