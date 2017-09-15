From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 18/28] testsuite: simplify documentation
Date: Fri, 15 Sep 2017 09:13:48 +0200
Message-ID: <20170915071358.7312-19-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33184 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdIOHQZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id 187so1975777wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:24 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/test-suite | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/test-suite b/Documentation/test-suite
index e2dda61d7..a745da850 100644
--- a/Documentation/test-suite
+++ b/Documentation/test-suite
@@ -7,13 +7,13 @@ Sparse has a number of test cases in its validation directory. The test-suite
 script aims at making automated checking of these tests possible. It works by
 embedding tags in C comments in the test cases.
 
-check-name: (mandatory)
-	Name of the test.
+check-name: <name>
+	Name of the test. This is the only mandatory tag.
 
-check-description: (optional)
+check-description: <description ...>
 	A description of what the test checks.
 
-check-command: (optional)
+check-command: <command arg ...>
 	There are different kinds of tests. Some can validate the sparse
 	preprocessor, while others will use sparse, cgcc, or even other backends
 	of the library. check-command allows you to give a custom command to
@@ -22,43 +22,43 @@ check-command: (optional)
 	run time.
 	It defaults to "sparse $file".
 
-check-exit-value: (optional)
+check-exit-value: <value>
 	The expected exit value of check-command. It defaults to 0.
 
-check-timeout: (optional)
+check-timeout: <timeout>
 	The maximum expected duration of check-command, in seconds.
 	It defaults to 1.
 
-check-output-start / check-output-end (optional)
+check-output-start / check-output-end
 	The expected output (stdout and stderr) of check-command lies between
 	those two tags. It defaults to no output.
 
-check-output-ignore / check-error-ignore (optional)
+check-output-ignore / check-error-ignore
 	Don't check the expected output (stdout or stderr) of check-command
 	(usefull when this output is not comparable or if you're only interested
 	in the exit value).
 	By default this check is done.
 
-check-known-to-fail (optional)
+check-known-to-fail
 	Mark the test as being known to fail.
 
-check-output-contains: <pattern> (optional)
+check-output-contains: <pattern>
 	Check that the output (stdout) contains the given pattern.
 	Several such tags can be given, in which case the output
 	must contains all the patterns.
 
-check-output-excludes: <pattern> (optional)
+check-output-excludes: <pattern>
 	Similar than the above one, but with opposite logic.
 	Check that the output (stdout) doesn't contain the given pattern.
 	Several such tags can be given, in which case the output
 	must contains none of the patterns.
 
-check-output-pattern-<nbr>-times: <pattern> (optional)
+check-output-pattern-<nbr>-times: <pattern>
 	Similar than the contains/excludes her above, but with full control
 	of the number of times the pattern should occurs in the output.
 
-check-output-pattern(eq,<nbr>): <pattern> (optional)
-check-output-pattern(<min>,<max>): <pattern> (optional)
+check-output-pattern(eq,<nbr>): <pattern>
+check-output-pattern(<min>,<max>): <pattern>
 	Similar than the contains/excludes her above, but with full control
 	of the number of times the pattern should occurs in the output.
 	If <min> or <max> is '-' the corresponding check is ignored.
-- 
2.14.0

