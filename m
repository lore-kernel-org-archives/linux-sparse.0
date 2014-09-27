From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH v2 06/10] don't run sparse{c,i} tests when sparse-llvm is
 disabled
Date: Sat, 27 Sep 2014 21:37:25 +0100
Message-ID: <54272005.4050100@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:45304 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751651AbaI0Uha (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 27 Sep 2014 16:37:30 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Chris,

I decided to have a quick attempt at one of the different approaches
to this patch that I mentioned this afternoon. So, although I have
labelled this as 'v2', its really an alternative to the 'v1' patch.

Note that I renamed sparse{c,i} to sparse{c,i}-in. It may have been
better to name then sparse{c,i}.sh, since they are not really templates
to be 'processed' to create a build product. dunno.

The Makefile changes were done in a hurry ... (I was more interested in
the test-suite changes.)

I'm not sure if this approach is any better ... what do you think?
Any other ideas?

ATB,
Ramsay Jones



 .gitignore            |  2 ++
 Makefile              | 10 ++++++++++
 sparsec => sparsec-in |  0
 sparsei => sparsei-in |  0
 validation/test-suite | 17 +++++++++++++++--
 5 files changed, 27 insertions(+), 2 deletions(-)
 rename sparsec => sparsec-in (100%)
 rename sparsei => sparsei-in (100%)

diff --git a/.gitignore b/.gitignore
index d32d063..a237767 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,8 @@
 pre-process.h
 sparse.pc
 version.h
+sparsec
+sparsei
 
 # programs
 test-inspect
diff --git a/Makefile b/Makefile
index 1b69a73..2f87507 100644
--- a/Makefile
+++ b/Makefile
@@ -87,11 +87,20 @@ PROGRAMS += $(LLVM_PROGS)
 INST_PROGRAMS += sparse-llvm sparsec
 sparse-llvm.o: BASIC_CFLAGS += $(LLVM_CFLAGS)
 sparse-llvm_EXTRA_OBJS := $(LLVM_LIBS) $(LLVM_LDFLAGS)
+ifneq ($(MAKECMDGOALS),clean)
+ifeq ($(wildcard sparse?),)
+$(info $(shell cp sparsec-in sparsec && echo '     GEN      sparsec'))
+$(info $(shell cp sparsei-in sparsei && echo '     GEN      sparsei'))
+endif
+endif
 else
 $(warning LLVM 3.0 or later required. Your system has version $(LLVM_VERSION) installed.)
 endif
 else
 $(warning Your system does not have llvm, disabling sparse-llvm)
+ifneq ($(wildcard sparse?),)
+junk := $(shell rm -f sparsec sparsei)
+endif
 endif
 
 LIB_H=    token.h parse.h lib.h symbol.h scope.h expression.h target.h \
@@ -196,6 +205,7 @@ compat-cygwin.o: $(LIB_H)
 
 clean: clean-check
 	rm -f *.[oa] .*.d *.so $(PROGRAMS) $(SLIB_FILE) pre-process.h sparse.pc
+	rm -f sparsec sparsei
 
 dist:
 	@if test "$(SPARSE_VERSION)" != "v$(VERSION)" ; then \
diff --git a/sparsec b/sparsec-in
similarity index 100%
rename from sparsec
rename to sparsec-in
diff --git a/sparsei b/sparsei-in
similarity index 100%
rename from sparsei
rename to sparsei-in
diff --git a/validation/test-suite b/validation/test-suite
index 3c011c6..05a2b2f 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -9,10 +9,12 @@ prog_name=`basename $0`
 
 # counts:
 #	- tests that have not been converted to test-suite format
+#	- tests that are disabled
 #	- tests that passed
 #	- tests that failed
 #	- tests that failed but are known to fail
 unhandled_tests=0
+disabled_tests=0
 ok_tests=0
 ko_tests=0
 known_ko_tests=0
@@ -80,6 +82,7 @@ echo "    help                       prints usage"
 #	- 0 if the test passed,
 #	- 1 if it failed,
 #	- 2 if it is not a "test-suite" test.
+#	- 3 if the test is disabled.
 do_test()
 {
 	test_failed=0
@@ -95,8 +98,6 @@ do_test()
 	fi
 	test_name=$last_result
 
-	echo "     TEST    $test_name ($file)"
-
 	# does the test provide a specific command ?
 	cmd=`eval echo $default_path/$default_cmd`
 	get_value "check-command" $file
@@ -104,6 +105,15 @@ do_test()
 		last_result=`echo $last_result | sed -e 's/^ *//'`
 		cmd=`eval echo $default_path/$last_result`
 	fi
+
+	# check for disabled commands
+	prog=`echo $cmd | sed -e 's/^\([^ ]*\) .*$/\1/'`
+	if [ ! -x "$prog" ]; then
+		disabled_tests=`expr $disabled_tests + 1`
+		return 3
+	fi
+	echo "     TEST    $test_name ($file)"
+
 	verbose "Using command       : $cmd"
 
 	# grab the expected exit value
@@ -168,6 +178,9 @@ do_test_suite()
 	if [ "$unhandled_tests" -ne "0" ]; then
 		echo "$unhandled_tests tests could not be handled by $prog_name"
 	fi
+	if [ "$disabled_tests" -ne "0" ]; then
+		echo "$disabled_tests tests were disabled"
+	fi
 }
 
 ##
-- 
2.1.0
