From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/5] testsuite: allow quieter error reporting
Date: Thu,  5 Jan 2017 06:16:31 +0100
Message-ID: <20170105051632.8392-5-luc.vanoostenryck@gmail.com>
References: <20170105051632.8392-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:32787 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759861AbdAEFT1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 5 Jan 2017 00:19:27 -0500
Received: by mail-wj0-f193.google.com with SMTP id kp2so77819808wjc.0
        for <linux-sparse@vger.kernel.org>; Wed, 04 Jan 2017 21:18:42 -0800 (PST)
In-Reply-To: <20170105051632.8392-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index fdb7cbc2..47015c61 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -126,7 +126,7 @@ verbose()
 # error(string[, die]) - prints an error and exits with value die if given
 error()
 {
-	echo "error: $1"
+	[ "$quiet" -ne 1 ] && echo "error: $1"
 	[ -n "$2" ] && exit $2
 	return 0
 }
@@ -223,7 +223,7 @@ do_test()
 		if [ "$?" -ne "0" ]; then
 			error "actual $stream text does not match expected $stream text."
 			error  "see $file.$stream.* for further investigation."
-			cat "$file".$stream.diff
+			[ $quiet -ne 1 ] && cat "$file".$stream.diff
 			test_failed=1
 		fi
 	done
-- 
2.11.0

