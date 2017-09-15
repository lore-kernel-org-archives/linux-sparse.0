From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 14/28] testsuite: allow --format & --single
Date: Fri, 15 Sep 2017 09:13:44 +0200
Message-ID: <20170915071358.7312-15-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33798 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbdIOHQV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id i131so1974904wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:20 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index c03348028..9364b9d7f 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -466,7 +466,7 @@ while true; do
 		do_test_suite
 		;;
 
-	single)
+	single|--single)
 		arg_file "$2"
 		do_test "$2"
 		case "$?" in
@@ -475,7 +475,7 @@ while true; do
 			2) echo "$2 can't be handled by $prog_name";;
 		esac
 		;;
-	format)
+	format|--format)
 		arg_file "$2"
 		do_format "$2" "$3" "$4"
 		;;
-- 
2.14.0

