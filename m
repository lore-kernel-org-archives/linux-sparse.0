From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 10/28] testsuite: allow to parse several options
Date: Fri, 15 Sep 2017 09:13:40 +0200
Message-ID: <20170915071358.7312-11-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37310 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdIOHQQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:16 -0400
Received: by mail-wm0-f67.google.com with SMTP id f4so1957830wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:16 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 5dfe9e7f3..7a491dfb4 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -427,7 +427,8 @@ arg_file()
 	return 0
 }
 
-case "$1" in
+while true; do
+	case "$1" in
 	'')
 		tests_list=`find . -name '*.c' | sed -e 's#^\./\(.*\)#\1#' | sort`
 		do_test_suite
@@ -454,7 +455,9 @@ case "$1" in
 		do_usage
 		exit 1
 		;;
-esac
+	esac
+	break
+done
 
 exit $failed
 
-- 
2.14.0

