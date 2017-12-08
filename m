From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 13/16] testsuite: change do_usage text
Date: Fri,  8 Dec 2017 14:14:52 +0100
Message-ID: <20171208131455.7786-14-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42799 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753385AbdLHNPX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:23 -0500
Received: by mail-wm0-f67.google.com with SMTP id l141so3260303wmg.1
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:22 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The text for the testsuite usage used 'none' as if it was an
option/keyword while it only meant the absence of arguments.

Make the text clearer by removing the 'none' and being explicit
about the absence of arguments.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/validation/test-suite b/validation/test-suite
index 410190bd3..854ad8add 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -233,16 +233,16 @@ echo "$prog_name - a tiny automatic testing script"
 echo "Usage: $prog_name [option(s)] [command] [arguments]"
 echo
 echo "options:"
-echo "    -a|--abort                 abort the tests as soon as one fails"
-echo "    -q|--quiet                 be extra quiet while running the tests"
+echo "    -a|--abort                 Abort the tests as soon as one fails."
+echo "    -q|--quiet                 Be extra quiet while running the tests."
 echo
 echo "commands:"
-echo "    none                       runs the whole test suite"
-echo "    file ...                   runs the test suite on the given file(s)"
-echo "    single file                runs the test in 'file'"
-echo "    format file [name [cmd]]   helps writing a new test case using cmd"
+echo "    [file ...]                 Runs the test suite on the given file(s)."
+echo "                               If no file is given, run the whole testsuite."
+echo "    single file                Run the test in 'file'."
+echo "    format file [name [cmd]]   Help writing a new test case using cmd."
 echo
-echo "    [command] help             prints usage"
+echo "    [command] help             Print usage."
 }
 
 disable()
-- 
2.15.0

