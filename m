From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 11/16] testsuite: move do_test_suite out of the getopt loop
Date: Fri,  8 Dec 2017 14:14:50 +0100
Message-ID: <20171208131455.7786-12-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:45999 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753262AbdLHNPV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:21 -0500
Received: by mail-wm0-f65.google.com with SMTP id 9so3237797wme.4
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:20 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is a preparatory step to allow to run only a part
of the testsuite (a subdir).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index c16c7c843..72bee9dce 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -520,12 +520,10 @@ while true; do
 
 	'')
 		tests_list=`find . -name '*.c' | sed -e 's#^\./\(.*\)#\1#' | sort`
-		do_test_suite
 		break
 		;;
 	*.c)
 		tests_list="$@"
-		do_test_suite
 		break
 		;;
 
@@ -552,5 +550,6 @@ while true; do
 	break
 done
 
+do_test_suite
 exit $failed
 
-- 
2.15.0

