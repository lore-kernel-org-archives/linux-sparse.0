From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2 05/14] testsuite: add tag to ignore the output/error
Date: Mon, 13 Feb 2017 00:28:55 +0100
Message-ID: <20170212232904.49647-6-luc.vanoostenryck@gmail.com>
References: <20170208222805.c77ilwchxpg2vnx4@macpro.local>
 <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34485 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdBLX3Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Feb 2017 18:29:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id c85so16482188wmi.1
        for <linux-sparse@vger.kernel.org>; Sun, 12 Feb 2017 15:29:15 -0800 (PST)
In-Reply-To: <20170212232904.49647-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently the test suite always check the exit value and the output
of the command used for the test. This is fine and allow use to catch
the most common situations:
- failure or crash (via the exit value)
- (un)expected output (like when testing the result of the preprocessor)
- (un)expected errors & warnings (like when testing sparse's warnings)

But sometimes, we're not interested in the output or the output (as is)
is simply not meaningful for the test or can't be compared textually
to some reference.

This patch add two new tags (check-output-ignore & check-error-ignore),
telling to test suite to ignore the content of stdout or stderr when
testing this file.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/test-suite | 6 ++++++
 validation/test-suite    | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/test-suite b/Documentation/test-suite
index 6c4f24f65..6936feeb1 100644
--- a/Documentation/test-suite
+++ b/Documentation/test-suite
@@ -29,6 +29,12 @@ check-output-start / check-output-end (optional)
 	The expected output (stdout and stderr) of check-command lies between
 	those two tags. It defaults to no output.
 
+check-output-ignore / check-error-ignore (optional)
+	Don't check the expected output (stdout or stderr) of check-command
+	(usefull when this output is not comparable or if you're only interested
+	in the exit value).
+	By default this check is done.
+
 check-known-to-fail (optional)
 	Mark the test as being known to fail.
 
diff --git a/validation/test-suite b/validation/test-suite
index df5a7c60d..0d874e075 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -146,6 +146,8 @@ do_test()
 	actual_exit_value=$?
 
 	for stream in output error; do
+		grep -s -q "check-$stream-ignore" $file && continue
+
 		diff -u "$file".$stream.expected "$file".$stream.got > "$file".$stream.diff
 		if [ "$?" -ne "0" ]; then
 			error "actual $stream text does not match expected $stream text."
-- 
2.11.0

