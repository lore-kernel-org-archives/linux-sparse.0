From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/16] testsuite: early return in getopt loop
Date: Fri,  8 Dec 2017 14:14:49 +0100
Message-ID: <20171208131455.7786-11-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:43505 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbdLHNPU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:20 -0500
Received: by mail-wm0-f65.google.com with SMTP id n138so3250193wmg.2
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:19 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is a preparatory step to allow to run only a part
of the testsuite (a subdir).

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/validation/test-suite b/validation/test-suite
index d50a3bfa2..c16c7c843 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -521,10 +521,12 @@ while true; do
 	'')
 		tests_list=`find . -name '*.c' | sed -e 's#^\./\(.*\)#\1#' | sort`
 		do_test_suite
+		break
 		;;
 	*.c)
 		tests_list="$@"
 		do_test_suite
+		break
 		;;
 
 	single|--single)
@@ -535,10 +537,12 @@ while true; do
 			1) echo "$2 failed !";;
 			2) echo "$2 can't be handled by $prog_name";;
 		esac
+		exit $failed
 		;;
 	format|--format)
 		shift
 		do_format "$@"
+		exit 0
 		;;
 	help | *)
 		do_usage
-- 
2.15.0

