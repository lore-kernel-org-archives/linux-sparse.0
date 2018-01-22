From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: editing fixes in test-suite
Date: Sun, 21 Jan 2018 21:38:39 -0800
Message-ID: <5bf3731a-c3be-e94e-2aaf-4c443e6ed870@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:34957 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbeAVFip (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 22 Jan 2018 00:38:45 -0500
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix typos, grammar, punctuation, and spelling in Documentation/test-suite.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>
---
 Documentation/test-suite |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- sprs-2018-0119.orig/Documentation/test-suite
+++ sprs-2018-0119/Documentation/test-suite
@@ -35,7 +35,7 @@ check-output-start / check-output-end (o
 
 check-output-ignore / check-error-ignore (optional)
 	Don't check the expected output (stdout or stderr) of check-command
-	(usefull when this output is not comparable or if you're only interested
+	(useful when this output is not comparable or if you're only interested
 	in the exit value).
 	By default this check is done.
 
@@ -54,8 +54,8 @@ check-output-excludes: <pattern> (option
 	must contains none of the patterns.
 
 check-output-pattern-<nbr>-times: <pattern> (optional)
-	Similar than the contains/excludes her above, but with full control
-	of the number of times the pattern should occurs in the output.
+	Similar to the contains/excludes above, but with full control
+	of the number of times the pattern should occur in the output.
 
 	Using test-suite
 	~~~~~~~~~~~~~~~~
@@ -84,7 +84,7 @@ cmd:
 	"sparse $file".
 
 The output of the test-suite format command can be redirected into the
-test case to create a test-suite formated file.
+test case to create a test-suite formatted file.
 
 $ ./test-suite format bad-assignment.c Assignment >> bad-assignment.c
 $ cat !$


