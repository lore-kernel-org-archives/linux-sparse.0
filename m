From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: respect command line's quotes & whitespaces
Date: Mon, 18 Sep 2017 15:52:27 +0200
Message-ID: <20170918135227.65141-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37599 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753836AbdIRNwe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 18 Sep 2017 09:52:34 -0400
Received: by mail-wr0-f193.google.com with SMTP id u48so388666wrf.4
        for <linux-sparse@vger.kernel.org>; Mon, 18 Sep 2017 06:52:33 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently the testsuite use 'eval echo $cmd' to expand
the name of the test file to be given on the command line.

This as the annoying consequence to go a bit too far in
the expansion of variables and to destroy any quotes and
whitespaces escaping that would have done.

Fix this by doing the eval later, when effectively executing
the command.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

The patch is also available for review & testing in the git repository at:
  git://github.com/lucvoo/sparse.git testsuite-fix-quotes-cmdline

 validation/preprocessor/arg-cli-ko.c | 1 -
 validation/test-suite                | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/validation/preprocessor/arg-cli-ko.c b/validation/preprocessor/arg-cli-ko.c
index d4e2803c0..104bb8b0f 100644
--- a/validation/preprocessor/arg-cli-ko.c
+++ b/validation/preprocessor/arg-cli-ko.c
@@ -6,7 +6,6 @@ M2(0,1)
  * check-command: sparse -E '-DM1(X)=X' '-DM2(X, Y)=B Y S X T' $file
  *
  * check-description: this is a failure of the testsuite.
- * check-known-to-fail
  *
  * check-output-start
 
diff --git a/validation/test-suite b/validation/test-suite
index 055eecc21..bd92e14a4 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -309,13 +309,13 @@ do_test()
 		fi
 	fi
 
-	cmd=`eval echo $default_path/$check_command`
+	cmd="$default_path/$check_command"
 
 	if [ -z "$vquiet" ]; then
 		echo "  TEST	$test_name ($file)"
 	fi
 
-	verbose "Using command       : $cmd"
+	verbose "Using command       : $(eval echo $cmd)"
 
 	# grab the expected exit value
 	expected_exit_value=$check_exit_value
@@ -327,7 +327,7 @@ do_test()
 	fi
 
 	# grab the actual output & exit value
-	$cmd 1> $file.output.got 2> $file.error.got
+	eval $cmd 1> $file.output.got 2> $file.error.got
 	actual_exit_value=$?
 
 	must_fail=$check_known_to_fail
-- 
2.14.0

