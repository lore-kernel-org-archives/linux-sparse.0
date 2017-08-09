From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v4 1/9] testsuite: add support for commands with timeout
Date: Wed,  9 Aug 2017 21:37:58 +0200
Message-ID: <20170809193806.30975-2-luc.vanoostenryck@gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36582 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbdHITi7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 15:38:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id d40so611487wma.3
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 12:38:58 -0700 (PDT)
In-Reply-To: <20170809193806.30975-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Tests taking a huge or infinite amout of time is
a problem for the testsuite. Furthermore, it's most
often the sign of a problem somewhere.

Fix this by adding some support to use an optional
timeout for each testcase command.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/test-suite    |  4 ++++
 validation/infinite-loop0.c | 12 ++++++++++++
 validation/test-suite       |  7 +++++++
 3 files changed, 23 insertions(+)
 create mode 100644 validation/infinite-loop0.c

diff --git a/Documentation/test-suite b/Documentation/test-suite
index 2e786bbf3..a288c81a5 100644
--- a/Documentation/test-suite
+++ b/Documentation/test-suite
@@ -25,6 +25,10 @@ check-command: (optional)
 check-exit-value: (optional)
 	The expected exit value of check-command. It defaults to 0.
 
+check-timeout: (optional)
+	The maximum expected duration of check-command, in seconds.
+	It defaults to 1.
+
 check-output-start / check-output-end (optional)
 	The expected output (stdout and stderr) of check-command lies between
 	those two tags. It defaults to no output.
diff --git a/validation/infinite-loop0.c b/validation/infinite-loop0.c
new file mode 100644
index 000000000..a28492307
--- /dev/null
+++ b/validation/infinite-loop0.c
@@ -0,0 +1,12 @@
+void foo(void)
+{
+        int a = a || 0;
+        if (a) ;
+}
+
+/*
+ * check-name: internal infinite loop (0)
+ * check-command: sparse -Wno-decl $file
+ * check-timeout:
+ * check-known-to-fail
+ */
diff --git a/validation/test-suite b/validation/test-suite
index 3056fce90..cf151a361 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -39,6 +39,7 @@ get_tag_value()
 	check_name=""
 	check_command="$default_cmd"
 	check_exit_value=0
+	check_timeout=0
 	check_known_to_fail=0
 	check_error_ignore=0
 	check_output_ignore=0
@@ -56,6 +57,8 @@ get_tag_value()
 		check-name:)		check_name="$val" ;;
 		check-command:)		check_command="$val" ;;
 		check-exit-value:)	check_exit_value="$val" ;;
+		check-timeout:)		[ -z "$val" ] && val=1
+					check_timeout="$val" ;;
 		check-known-to-fail)	check_known_to_fail=1 ;;
 		check-error-ignore)	check_error_ignore=1 ;;
 		check-output-ignore)	check_output_ignore=1 ;;
@@ -211,6 +214,10 @@ do_test()
 	expected_exit_value=$check_exit_value
 	verbose "Expecting exit value: $expected_exit_value"
 
+	# do we want a timeout?
+	if [ $check_timeout -ne 0 ]; then
+		cmd="timeout -k 1s $check_timeout $cmd"
+	fi
 
 	# grab the actual output & exit value
 	$cmd 1> $file.output.got 2> $file.error.got
-- 
2.14.0

