From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 23/28] testsuite: move up arg_file()
Date: Fri, 15 Sep 2017 09:13:53 +0200
Message-ID: <20170915071358.7312-24-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33845 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbdIOHQa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:30 -0400
Received: by mail-wm0-f65.google.com with SMTP id i131so1975129wma.1
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:29 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 1ef18f288..35138cb37 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -212,6 +212,23 @@ minmax_patterns()
 	return $?
 }
 
+##
+# arg_file(filename) - checks if filename exists
+arg_file()
+{
+	[ -z "$1" ] && {
+		do_usage
+		exit 1
+	}
+	[ -e "$1" ] || {
+		error "Can't open file $1"
+		exit 1
+	}
+	return 0
+}
+
+
+##
 do_usage()
 {
 echo "$prog_name - a tiny automatic testing script"
@@ -456,21 +473,6 @@ _EOF
 	return 0
 }
 
-##
-# arg_file(filename) - checks if filename exists
-arg_file()
-{
-	[ -z "$1" ] && {
-		do_usage
-		exit 1
-	}
-	[ -e "$1" ] || {
-		error "Can't open file $1"
-		exit 1
-	}
-	return 0
-}
