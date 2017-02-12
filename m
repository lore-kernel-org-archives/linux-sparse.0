From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 13/14] testsuite: allow quieter error reporting
Date: Mon, 13 Feb 2017 00:29:03 +0100
Message-ID: <20170212232904.49647-14-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36121 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdBLX3X (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:23 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so16526251wmd.3
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:23 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index fdb7cbc26..47015c61f 100755
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

