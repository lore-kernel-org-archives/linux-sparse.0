From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 07/10] Add support for multiarch system header files
Date: Mon, 04 Aug 2014 19:39:12 +0100
Message-ID: <53DFD350.6080701@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:52765 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751046AbaHDSpR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Aug 2014 14:45:17 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>


Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 Makefile |  3 +++
 cgcc     | 10 ++++++++++
 lib.c    | 18 +++++++++++++++++-
 sparse.1 |  6 ++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1795905..36061e3 100644
--- a/Makefile
+++ b/Makefile
@@ -36,6 +36,9 @@ HAVE_LLVM:=$(shell $(LLVM_CONFIG) --version >/dev/null 2>&1 && echo 'yes')
 GCC_BASE = $(shell $(CC) --print-file-name=)
 BASIC_CFLAGS = -DGCC_BASE=\"$(GCC_BASE)\"
 
+MULTIARCH_TRIPLET = $(shell $(CC) -print-multiarch 2>/dev/null)
+BASIC_CFLAGS += -DMULTIARCH_TRIPLET=\"$(MULTIARCH_TRIPLET)\"
+
 ifeq ($(HAVE_GCC_DEP),yes)
 BASIC_CFLAGS += -Wp,-MD,$(@D)/.$(@F).d
 endif
diff --git a/cgcc b/cgcc
index c075e5f..ed35e39 100755
--- a/cgcc
+++ b/cgcc
@@ -11,6 +11,7 @@ my $gendeps = 0;
 my $do_check = 0;
 my $do_compile = 1;
 my $gcc_base_dir;
+my $multiarch_dir;
 my $verbose = 0;
 
 while (@ARGV) {
@@ -44,6 +45,12 @@ while (@ARGV) {
         next;
     }
 
+    if (/^-multiarch-dir$/) {
+        $multiarch_dir = shift @ARGV;
+        die ("$0: missing argument for -multiarch-dir option") if !$multiarch_dir;
+        next;
+    }
+
     # If someone adds "-E", don't pre-process twice.
     $do_compile = 0 if $_ eq '-E';
 
@@ -66,8 +73,11 @@ if ($do_check) {
     }
 
     $gcc_base_dir = qx($cc -print-file-name=) if !$gcc_base_dir;
+    chomp($gcc_base_dir);  # possibly remove '\n' from compiler
     $check .= " -gcc-base-dir " . $gcc_base_dir if $gcc_base_dir;
 
+    $check .= " -multiarch-dir " . $multiarch_dir if $multiarch_dir;
+
     print "$check\n" if $verbose;
     if ($do_compile) {
 	system ($check);
diff --git a/lib.c b/lib.c
index 9c7767e..0b62dcb 100644
--- a/lib.c
+++ b/lib.c
@@ -59,6 +59,7 @@ int gcc_minor = __GNUC_MINOR__;
 int gcc_patchlevel = __GNUC_PATCHLEVEL__;
 
 static const char *gcc_base_dir = GCC_BASE;
+static const char *multiarch_dir = MULTIARCH_TRIPLET;
 
 struct token *skip_to(struct token *token, int op)
 {
@@ -363,6 +364,14 @@ static char **handle_switch_M(char *arg, char **next)
 	return next;
 }
 
+static char **handle_multiarch_dir(char *arg, char **next)
+{
+	multiarch_dir = *++next;
+	if (!multiarch_dir)
+		die("missing argument for -multiarch-dir option");
+	return next;
+}
+
 static char **handle_switch_m(char *arg, char **next)
 {
 	if (!strcmp(arg, "m64")) {
@@ -371,7 +380,8 @@ static char **handle_switch_m(char *arg, char **next)
 		arch_m64 = 0;
 	} else if (!strcmp(arg, "msize-long")) {
 		arch_msize_long = 1;
-	}
+	} else if (!strcmp(arg, "multiarch-dir"))
+		return handle_multiarch_dir(arg, next);
 	return next;
 }
 
@@ -881,6 +891,12 @@ void create_builtin_stream(void)
 	add_pre_buffer("#weak_define __GNUC_MINOR__ %d\n", gcc_minor);
 	add_pre_buffer("#weak_define __GNUC_PATCHLEVEL__ %d\n", gcc_patchlevel);
 
+	/* add the multiarch include directories, if any */
+	if (multiarch_dir && *multiarch_dir) {
+		add_pre_buffer("#add_system \"/usr/include/%s\"\n", multiarch_dir);
+		add_pre_buffer("#add_system \"/usr/local/include/%s\"\n", multiarch_dir);
+	}
+
 	/* We add compiler headers path here because we have to parse
 	 * the arguments to get it, falling back to default. */
 	add_pre_buffer("#add_system \"%s/include\"\n", gcc_base_dir);
diff --git a/sparse.1 b/sparse.1
index 54da09b..a305a21 100644
--- a/sparse.1
+++ b/sparse.1
@@ -335,6 +335,12 @@ Sparse does not issue these warnings by default.
 .B \-gcc-base-dir \fIdir\fR
 Look for compiler-provided system headers in \fIdir\fR/include/ and \fIdir\fR/include-fixed/.
 .
+.TP
+.B \-multiarch-dir \fIdir\fR
+Look for system headers in the multiarch subdirectory \fIdir\fR.
+The \fIdir\fR name would normally take the form of the target's
+normalized GNU triplet. (e.g. i386-linux-gnu).
+.
 .SH OTHER OPTIONS
 .TP
 .B \-ftabstop=WIDTH
-- 
2.0.0
