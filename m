From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: add new flag '-p' to subcommand 'format'
Date: Fri,  3 Jul 2020 02:06:55 +0200
Message-ID: <20200703000655.55894-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGCAHA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Jul 2020 20:07:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2846C08C5C1
        for <linux-sparse@vger.kernel.org>; Thu,  2 Jul 2020 17:06:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lx13so13260558ejb.4
        for <linux-sparse@vger.kernel.org>; Thu, 02 Jul 2020 17:06:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This flag facilitate the creation of testcases for preprocessing.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/validation/test-suite b/validation/test-suite
index d351ebf3c428..f7d992dc7c8c 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -458,6 +458,7 @@ echo "options:"
 echo "    -a                         append the created test to the input file"
 echo "    -f                         write a test known to fail"
 echo "    -l                         write a test for linearized code"
+echo "    -p                         write a test for pre-processing"
 echo
 echo "argument(s):"
 echo "    file                       file containing the test case(s)"
@@ -483,6 +484,9 @@ do_format()
 		-l)
 			def_cmd='test-linearize -Wno-decl $file'
 			linear=1 ;;
+		-p)
+			def_cmd='sparse -E $file' ;;
+
 		help|-*)
 			do_format_help
 			return 0
-- 
2.27.0
