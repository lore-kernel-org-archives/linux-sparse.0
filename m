From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/9] dump-ir: rename -fdump-linearize to -fdump-ir
Date: Wed,  8 Nov 2017 11:28:00 +0100
Message-ID: <20171108102802.43987-8-luc.vanoostenryck@gmail.com>
References: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:50203 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751168AbdKHK2U (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Nov 2017 05:28:20 -0500
Received: by mail-wr0-f194.google.com with SMTP id p96so1933308wrb.7
        for <linux-sparse@vger.kernel.org>; Wed, 08 Nov 2017 02:28:19 -0800 (PST)
In-Reply-To: <20171108102802.43987-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

as it will be used for dumping the IR not only just after
linearization but after other passes too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 cgcc                                   | 2 +-
 lib.c                                  | 8 ++++----
 lib.h                                  | 2 +-
 linearize.c                            | 2 +-
 sparse.1                               | 2 +-
 test-linearize.c                       | 2 +-
 test-unssa.c                           | 2 +-
 validation/linear/bitfield-init-mask.c | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/cgcc b/cgcc
index 75eee26fe..4aeb2da65 100755
--- a/cgcc
+++ b/cgcc
@@ -103,7 +103,7 @@ sub check_only_option {
     my ($arg) = @_;
     return 1 if $arg =~ /^-W(no-?)?(address-space|bitwise|cast-to-as|cast-truncate|context|decl|default-bitfield-sign|designated-init|do-while|enum-mismatch|init-cstring|memcpy-max-count|non-pointer-null|old-initializer|one-bit-signed-bitfield|override-init-all|paren-string|ptr-subtraction-blows|return-void|sizeof-bool|sparse-all|sparse-error|transparent-union|typesign|undef|unknown-attribute)$/;
     return 1 if $arg =~ /^-v(no-?)?(entry|dead)$/;
-    return 1 if $arg =~ /^-f(dump-linearize|memcpy-max-count)(=\S*)?$/;
+    return 1 if $arg =~ /^-f(dump-ir|memcpy-max-count)(=\S*)?$/;
     return 1 if $arg =~ /^-f(mem2reg|optim)(-enable|-disable|=last)?$/;
     return 0;
 }
diff --git a/lib.c b/lib.c
index 6f8ee1e59..e7bdc0783 100644
--- a/lib.c
+++ b/lib.c
@@ -259,8 +259,8 @@ int dump_macro_defs = 0;
 int dbg_entry = 0;
 int dbg_dead = 0;
 
+int fdump_ir;
 int fmem_report = 0;
-int fdump_linearize;
 unsigned long long fmemcpy_max_count = 100000;
 unsigned long fpasses = ~0UL;
 
@@ -800,9 +800,9 @@ error:
 static int handle_fdump_ir(const char *arg, const char *opt, const struct flag *flag, int options)
 {
 	if (*opt == '\0')
-		fdump_linearize = 1;
+		fdump_ir = 1;
 	else if (!strcmp(opt, "=only"))
-		fdump_linearize = 2;
+		fdump_ir = 2;
 	else
 		die("error: wrong option \"%s\"", arg);
 
@@ -816,7 +816,7 @@ static int handle_fmemcpy_max_count(const char *arg, const char *opt, const stru
 }
 
 static struct flag fflags[] = {
-	{ "dump-linearize",	NULL,	handle_fdump_ir },
+	{ "dump-ir",		NULL,	handle_fdump_ir },
 	{ "mem-report",		&fmem_report },
 	{ "memcpy-max-count=",	NULL,	handle_fmemcpy_max_count },
 	{ "tabstop=",		NULL,	handle_ftabstop },
diff --git a/lib.h b/lib.h
index 5111a0eb9..bfcfd2a08 100644
--- a/lib.h
+++ b/lib.h
@@ -167,7 +167,7 @@ extern int dbg_entry;
 extern int dbg_dead;
 
 extern int fmem_report;
-extern int fdump_linearize;
+extern int fdump_ir;
 extern unsigned long long fmemcpy_max_count;
 extern unsigned long fpasses;
 
diff --git a/linearize.c b/linearize.c
index 4970771bc..8ab93e0b3 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2220,7 +2220,7 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 		add_one_insn(ep, insn);
 	}
 
-	if (fdump_linearize)
+	if (fdump_ir)
 		show_entry(ep);
 
 	/*
diff --git a/sparse.1 b/sparse.1
index bec8d6d73..810fb3219 100644
--- a/sparse.1
+++ b/sparse.1
@@ -357,7 +357,7 @@ normalized GNU triplet. (e.g. i386-linux-gnu).
 .
 .SH DEBUG OPTIONS
 .TP
-.B \-fdump-linearize[=only]
+.B \-fdump-ir[=only]
 Dump the IR code of a function directly after its linearization,
 before any simplifications is made. If the argument \fB=only\fR is
 also given no further processing is done on the function.
diff --git a/test-linearize.c b/test-linearize.c
index 284526781..c7122080e 100644
--- a/test-linearize.c
+++ b/test-linearize.c
@@ -47,7 +47,7 @@ static void clean_up_symbols(struct symbol_list *list)
 
 		expand_symbol(sym);
 		ep = linearize_symbol(sym);
-		if (fdump_linearize == 2)
+		if (fdump_ir == 2)
 			continue;
 		if (ep)
 			show_entry(ep);
diff --git a/test-unssa.c b/test-unssa.c
index ec5c93015..e0981802d 100644
--- a/test-unssa.c
+++ b/test-unssa.c
@@ -62,7 +62,7 @@ static int compile(struct symbol_list *list)
 		struct entrypoint *ep;
 		expand_symbol(sym);
 		ep = linearize_symbol(sym);
-		if (fdump_linearize == 2)
+		if (fdump_ir == 2)
 			continue;
 		if (ep)
 			output_fn(ep);
diff --git a/validation/linear/bitfield-init-mask.c b/validation/linear/bitfield-init-mask.c
index 94afa400c..f43605855 100644
--- a/validation/linear/bitfield-init-mask.c
+++ b/validation/linear/bitfield-init-mask.c
@@ -18,7 +18,7 @@ struct bfu bfu_init_20_23(int a)
 
 /*
  * check-name: bitfield initializer mask
- * check-command: test-linearize -fdump-linearize=only -Wno-decl $file
+ * check-command: test-linearize -fdump-ir=only -Wno-decl $file
  * check-output-ignore
  *
  * check-output-contains: and\\..*fffff800\$
-- 
2.14.0

