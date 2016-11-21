From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 1/2] testsuite: allow commands to use pipes
Date: Mon, 21 Nov 2016 05:14:20 +0100
Message-ID: <20161121041421.34576-2-luc.vanoostenryck@gmail.com>
References: <20161121041421.34576-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35509 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbcKUEOc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Nov 2016 23:14:32 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so23515546wme.2
        for <linux-sparse@vger.kernel.org>; Sun, 20 Nov 2016 20:14:32 -0800 (PST)
In-Reply-To: <20161121041421.34576-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This can be usefull for filtering, transforming the normal
output in order to normalize it so that it can be compared
or to ignore things irrelevant to the test.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-pipe-cmd.c | 13 +++++++++++++
 validation/test-suite      |  6 +++---
 2 files changed, 16 insertions(+), 3 deletions(-)
 create mode 100644 validation/test-pipe-cmd.c

diff --git a/validation/test-pipe-cmd.c b/validation/test-pipe-cmd.c
new file mode 100644
index 00000000..8e86e9c3
--- /dev/null
+++ b/validation/test-pipe-cmd.c
@@ -0,0 +1,13 @@
+3
+2
+1
+/*
+ * check-name: test-pipe-cmd
+ * check-command: sparse $file | sort
+ * check-output-start
+
+1
+2
+3
+ * check-output-end
+ */
diff --git a/validation/test-suite b/validation/test-suite
index df5a7c60..9f4974c7 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -106,8 +106,8 @@ do_test()
 	cmd=`eval echo $default_path/$default_cmd`
 	get_value "check-command" $file
 	if [ "$?" -eq "0" ]; then
-		last_result=`echo $last_result | sed -e 's/^ *//'`
-		cmd=`eval echo $default_path/$last_result`
+		last_result=`echo "$last_result" | sed -e 's/^ *//'`
+		cmd=`eval echo "\"$default_path/$last_result\""`
 	fi
 
 	# check for disabled commands
@@ -142,7 +142,7 @@ do_test()
 
 
 	# grab the actual output & exit value
-	$cmd 1> $file.output.got 2> $file.error.got
+	eval $cmd 1> $file.output.got 2> $file.error.got
 	actual_exit_value=$?
 
 	for stream in output error; do
-- 
2.10.2

