From: Pekka Enberg <penberg@kernel.org>
Subject: [PATCH 1/5] sparse: Show expected vs. actual output on test failure
Date: Mon, 22 Aug 2011 16:57:27 +0300
Message-ID: <1314021451-24808-1-git-send-email-penberg@kernel.org>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:47277 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1HVN5f (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Aug 2011 09:57:35 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Pekka Enberg <penberg@kernel.org>, Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>

This patch changes 'make check' output to show sparse output compared to
expected results upon unexpected test failure. For example,
static-forward-decl.c output would look like this if it would not be tagged as
"known to fail":

       TEST     static forward declaration (static-forward-decl.c)
  error: actual error text does not match expected error text.
  --- static-forward-decl.c.error.expected	2011-08-22 06:29:40.000000000 +0000
  +++ static-forward-decl.c.error.got	2011-08-22 06:29:40.000000000 +0000
  @@ -0,0 +1 @@
  +static-forward-decl.c:3:5: warning: symbol 'f' was not declared. Should it be static?
  error: see static-forward-decl.c.error.* for further investigation.
  info: test 'static-forward-decl.c' is known to fail

This makes it easier to detect and analyze test breakage.

Cc: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Pekka Enberg <penberg@kernel.org>
---
 validation/test-suite |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 42f7bd7..7549fd2 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -146,6 +146,8 @@ do_test()
 		if [ "$?" -eq "0" ]; then
 			echo "info: test '$file' is known to fail"
 			known_ko_tests=`expr $known_ko_tests + 1`
+		else
+			cat "$file".$stream.diff
 		fi
 		return 1
 	else
-- 
1.7.4.1

