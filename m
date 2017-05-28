From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/6] testsuite: grep the expected output only when needed
Date: Sun, 28 May 2017 21:29:02 +0200
Message-ID: <20170528192906.1023-3-luc.vanoostenryck@gmail.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34489 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdE1T3O (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 15:29:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id d127so12947066wmf.1
        for <linux-sparse@vger.kernel.org>; Sun, 28 May 2017 12:29:14 -0700 (PDT)
In-Reply-To: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently the testsuite always try to extract the expected
output from the test case description.
This is done with grep & sed.

But in some case we're not interested to compare the actual
output with the expected one. And in those cases the grep & sed
are just wasted CPU cycles.

Fix this by extracting the expected output only when we know
that it won't be ignored.

This speedup the testsuite by a modest 1%.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index fa4cd36cf..ce2ca454c 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -206,12 +206,6 @@ do_test()
 
 	verbose "Using command       : $cmd"
 
-	# grab the expected output
-	sed -n '/check-output-start/,/check-output-end/p' $file \
-		| grep -v check-output > "$file".output.expected
-	sed -n '/check-error-start/,/check-error-end/p' $file \
-		| grep -v check-error > "$file".error.expected
