From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/6] testsuite: avoid fork+execing basename
Date: Sun, 28 May 2017 21:29:06 +0200
Message-ID: <20170528192906.1023-7-luc.vanoostenryck@gmail.com>
References: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33418 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750851AbdE1T3S (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 May 2017 15:29:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id b84so12969732wmh.0
        for <linux-sparse@vger.kernel.org>; Sun, 28 May 2017 12:29:17 -0700 (PDT)
In-Reply-To: <20170528192906.1023-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Some testcase (the ones related to sparse-llvm) are disabled if
the needed support is not present. This is done by checking
the name of the command used by the testcase.

The previous possible presence of './' before the command meant
that the command was checked via the 'basename' command, which
need to ne fork+execed.
Since the './' have now been stripped from all command names
this is no more needed.

Change this by comparing directly the command name.

This speedup the testsuite by another 6%.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index da9d88159..3056fce90 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -189,11 +189,10 @@ do_test()
 	if [ "$check_command" = "" ]; then
 		check_command="$defaut_command"
 	fi
-	cmd=`eval echo $default_path/$check_command`
 
 	# check for disabled commands
-	set -- $cmd
-	base_cmd=`basename $1`
+	set -- $check_command
+	base_cmd=$1
 	for i in $disabled_cmds; do
 		if [ "$i" = "$base_cmd" ] ; then
 			disabled_tests=$(($disabled_tests + 1))
@@ -202,6 +201,8 @@ do_test()
 		fi
 	done
 
+	cmd=`eval echo $default_path/$check_command`
+
 	echo "     TEST    $test_name ($file)"
 
 	verbose "Using command       : $cmd"
-- 
2.13.0

