From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] testsuite: allow default args from environment for test commands
Date: Sun, 17 Dec 2017 16:03:46 +0100
Message-ID: <20171217150346.9240-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35157 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbdLQPDx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 17 Dec 2017 10:03:53 -0500
Received: by mail-wm0-f41.google.com with SMTP id f9so25306303wmh.0
        for <linux-sparse@vger.kernel.org>; Sun, 17 Dec 2017 07:03:52 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

During testing it's sometimes useful to force some default arguments
for all commands. An example of this is using '-m32' which essentially
allow to run the tessuite on an 64bit machine as-if run a 32-bit one.

Allow this by using the environment variable 'SPARSE_TEST_ARGS' to
hole default arguments for the test commands.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index f1d3301a6..3abf69d46 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -6,6 +6,7 @@ cd $(dirname "$0")
 
 default_path=".."
 default_cmd="sparse \$file"
+default_args="$SPARSE_TEST_ARGS"
 tests_list=""
 prog_name=`basename $0`
 
@@ -320,7 +321,7 @@ do_test()
 	shift
 	# launch the test command and
 	# grab the actual output & exit value
-	eval $pre_cmd $default_path/$base_cmd "$@" \
+	eval $pre_cmd $default_path/$base_cmd $default_args "$@" \
 		1> $file.output.got 2> $file.error.got
 	actual_exit_value=$?
 
-- 
2.15.0

