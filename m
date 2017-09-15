From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 2/8] dump-ir: allow to specify the passes to execute via cli's options
Date: Fri, 15 Sep 2017 09:40:28 +0200
Message-ID: <20170915074034.7785-3-luc.vanoostenryck@gmail.com>
References: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33655 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdIOHkn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:40:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id 187so2024401wmn.0
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:40:41 -0700 (PDT)
In-Reply-To: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/options.md | 18 ++++++++++++++++++
 cgcc                     |  1 +
 lib.c                    | 37 +++++++++++++++++++++++++++++++++++++
 lib.h                    |  1 +
 4 files changed, 57 insertions(+)
 create mode 100644 Documentation/options.md

diff --git a/Documentation/options.md b/Documentation/options.md
new file mode 100644
index 000000000..5677789e1
--- /dev/null
+++ b/Documentation/options.md
@@ -0,0 +1,18 @@
+# Options
+
+This file is a complement of man page for sparse but meant
+for options not to be used by sparse itself but by the other
+tools.
+
+## Developer options:
+
+### Select the passes
+
+* '-f\<name-of-the-pass\>[-disable|-enable|=last]'
+
+  If '=last' is used, all passes after the specified one are disabled.
+  By default all passes are enabled.
+
+  The passes currently understood are:
+  * 'mem2reg'
+  * 'optim'
diff --git a/cgcc b/cgcc
index a8d7b4f21..75eee26fe 100755
--- a/cgcc
+++ b/cgcc
@@ -104,6 +104,7 @@ sub check_only_option {
     return 1 if $arg =~ /^-W(no-?)?(address-space|bitwise|cast-to-as|cast-truncate|context|decl|default-bitfield-sign|designated-init|do-while|enum-mismatch|init-cstring|memcpy-max-count|non-pointer-null|old-initializer|one-bit-signed-bitfield|override-init-all|paren-string|ptr-subtraction-blows|return-void|sizeof-bool|sparse-all|sparse-error|transparent-union|typesign|undef|unknown-attribute)$/;
     return 1 if $arg =~ /^-v(no-?)?(entry|dead)$/;
     return 1 if $arg =~ /^-f(dump-linearize|memcpy-max-count)(=\S*)?$/;
+    return 1 if $arg =~ /^-f(mem2reg|optim)(-enable|-disable|=last)?$/;
     return 0;
 }
 
diff --git a/lib.c b/lib.c
index a03a94d69..a78926dfd 100644
--- a/lib.c
+++ b/lib.c
@@ -260,6 +260,7 @@ int dbg_dead = 0;
 int fmem_report = 0;
 int fdump_linearize;
 unsigned long long fmemcpy_max_count = 100000;
+unsigned long fpasses = ~0UL;
 
 int preprocess_only;
 
@@ -760,6 +761,40 @@ static int handle_ftabstop(const char *arg, const char *opt, const struct flag *
 	return 1;
 }
 
+static int handle_fpasses(const char *arg, const char *opt, const struct flag *flag, int options)
+{
+	unsigned long mask;
+
+	mask = flag->mask;
+	if (*opt == '\0') {
+		if (options & OPT_INVERSE)
+			fpasses &= ~mask;
+		else
+			fpasses |=  mask;
+		return 1;
+	}
+	if (options & OPT_INVERSE)
+		goto error;
+	if (!strcmp(opt, "-enable")) {
+		fpasses |= mask;
+		return 1;
+	}
+	if (!strcmp(opt, "-disable")) {
+		fpasses &= ~mask;
+		return 1;
+	}
+	if (!strcmp(opt, "=last")) {
+		// clear everything above
+		mask |= mask - 1;
+		fpasses &= mask;
+		return 1;
+	}
+	return 0;
+
+error:
+	die("error: wrong option \"%s\"", arg);
+}
+
 static int handle_fdump_ir(const char *arg, const char *opt, const struct flag *flag, int options)
 {
 	if (*opt == '\0')
@@ -783,6 +818,8 @@ static struct flag fflags[] = {
 	{ "mem-report",		&fmem_report },
 	{ "memcpy-max-count=",	NULL,	handle_fmemcpy_max_count },
 	{ "tabstop=",		NULL,	handle_ftabstop },
+	{ "mem2reg",		NULL,	handle_fpasses,	PASS_MEM2REG },
+	{ "optim",		NULL,	handle_fpasses,	PASS_OPTIM },
 	{ },
 };
 
diff --git a/lib.h b/lib.h
index 27c990251..5111a0eb9 100644
--- a/lib.h
+++ b/lib.h
@@ -169,6 +169,7 @@ extern int dbg_dead;
 extern int fmem_report;
 extern int fdump_linearize;
 extern unsigned long long fmemcpy_max_count;
+extern unsigned long fpasses;
 
 extern int arch_m64;
 extern int arch_msize_long;
-- 
2.14.0

