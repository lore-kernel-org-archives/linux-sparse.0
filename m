From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 4/6] testsuite: respect command line's quotes & whitespaces
Date: Wed, 13 Dec 2017 18:15:29 +0100
Message-ID: <20171213171531.43707-5-luc.vanoostenryck@gmail.com>
References: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37797 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753154AbdLMRPs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Dec 2017 12:15:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id f140so6556203wmd.2
        for <linux-sparse@vger.kernel.org>; Wed, 13 Dec 2017 09:15:47 -0800 (PST)
In-Reply-To: <20171213171531.43707-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently the testsuite use 'eval echo $cmd' to expand
the name of the test file to be given on the command line.

This has the annoying consequence to go a bit too far in
the expansion of variables and to destroy any quotes and
whitespaces escaping that would have done.

Fix this by doing the eval later, when effectively executing
the command.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/self-quote-args.c |  1 -
 validation/test-suite        | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/validation/self-quote-args.c b/validation/self-quote-args.c
index acac41d7d..be9873d23 100644
--- a/validation/self-quote-args.c
+++ b/validation/self-quote-args.c
@@ -3,6 +3,5 @@
  * check-description: This is testing that the test-suite
  *	respect the quoting of the command's arguments.
  * check-command: sparse '-foption with-spaces' empty-file
- * check-known-to-fail
  * check-output-ignore
  */
diff --git a/validation/test-suite b/validation/test-suite
index 192fba300..dba8fd50c 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -308,25 +308,25 @@ do_test()
 		fi
 	fi
 
-	cmd=`eval echo $default_path/$check_command`
-
 	if [ -z "$vquiet" ]; then
 		echo "  TEST    $test_name ($file)"
 	fi
 
-	verbose "Using command       : $cmd"
+	verbose "Using command       : $(echo "$@")"
 
 	# grab the expected exit value
 	expected_exit_value=$check_exit_value
 	verbose "Expecting exit value: $expected_exit_value"
 
 	# do we want a timeout?
+	pre=""
 	if [ $check_timeout -ne 0 ]; then
-		cmd="timeout -k 1s $check_timeout $cmd"
+		pre="timeout -k 1s $check_timeout"
 	fi
 
 	# grab the actual output & exit value
-	$cmd 1> $file.output.got 2> $file.error.got
+	shift
+	eval $pre ../$base_cmd "$@" 1> $file.output.got 2> $file.error.got
 	actual_exit_value=$?
 
 	must_fail=$check_known_to_fail
-- 
2.15.0

