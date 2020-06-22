From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: fix 'format help' / validate number of arguments
Date: Tue, 23 Jun 2020 01:34:52 +0200
Message-ID: <20200622233452.89993-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgFVXe6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jun 2020 19:34:58 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3B6C061573
        for <linux-sparse@vger.kernel.org>; Mon, 22 Jun 2020 16:34:57 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id k8so14990068edq.4
        for <linux-sparse@vger.kernel.org>; Mon, 22 Jun 2020 16:34:57 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The subcommand 'format help' is broken because the of the way
arguments are parsed without validating the number of arguments.

Fix this by parsing all arguments (even if there is only one)
and validate the number of arguments at the end of the loop.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index a22f70135fb3..d351ebf3c428 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -474,7 +474,7 @@ do_format()
 	linear=0
 	fail=0
 
-	while [ $# -gt 1 ] ; do
+	while [ $# -gt 0 ] ; do
 		case "$1" in
 		-a)
 			append=1 ;;
@@ -493,6 +493,11 @@ do_format()
 		continue
 	done
 
+	if [ $# -lt 1 -o $# -gt 3 ]; then
+		do_format_help
+		return 0
+	fi
+
 	arg_file "$1" || return 1
 
 	file="$1"
-- 
2.27.0
