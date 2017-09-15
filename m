From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 25/28] testsuite: format: saner defaults handling
Date: Fri, 15 Sep 2017 09:13:55 +0200
Message-ID: <20170915071358.7312-26-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33854 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOHQc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id i131so1975179wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:31 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index b4ba39f3f..599f5e7e6 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -460,17 +460,12 @@ do_format()
 
 	arg_file "$1" || return 1
 
-	if [ -z "$2" ]; then
-		fname="$1"
-		fcmd=$default_cmd
-	elif [ -z "$3" ]; then
-		fname="$2"
-		fcmd=$default_cmd
-	else
-		fname="$2"
-		fcmd="$3"
-	fi
 	file="$1"
+	fname="$2"
+	[ -z "$fname" ] && fname="$1"
+	fcmd="$3"
+	[ -z "$fcmd" ] && fcmd=$default_cmd
+
 	cmd=`eval echo $default_path/$fcmd`
 	$cmd 1> $file.output.got 2> $file.error.got
 	fexit_value=$?
-- 
2.14.0

