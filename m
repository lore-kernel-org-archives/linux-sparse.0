From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 12/28] testsuite: add support for -a|--abort
Date: Fri, 15 Sep 2017 09:13:42 +0200
Message-ID: <20170915071358.7312-13-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37967 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdIOHQS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id x17so1947187wmd.5
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:18 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/validation/test-suite b/validation/test-suite
index 9371130d9..49b3e0c24 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -32,6 +32,7 @@ known_ko_tests=0
 # defaults to not verbose
 [ -z "$V" ] && V=0
 vquiet=""
+abort=0
 
 ##
 # get_tag_value(file) - get the 'check-<...>' tags & values
@@ -203,6 +204,7 @@ echo "$prog_name - a tiny automatic testing script"
 echo "Usage: $prog_name [option(s)] [command] [arguments]"
 echo
 echo "options:"
+echo "    -a|--abort                 abort the tests as soon as one fails"
 echo "    -q|--quiet                 be extra quiet while running the tests"
 echo
 echo "commands:"
@@ -343,6 +345,7 @@ do_test()
 	fi
 
 	if [ "$test_failed" -ne "$must_fail" ]; then
+		[ $abort -eq 1 ] && exit 1
 		test_failed=1
 		failed=1
 	fi
@@ -436,6 +439,11 @@ arg_file()
 
 while true; do
 	case "$1" in
+	-a|--abort)
+		abort=1
+		shift
+		continue
+		;;
 	-q|--quiet)
 		vquiet=1
 		shift
-- 
2.14.0

