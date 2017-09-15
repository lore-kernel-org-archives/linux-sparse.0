From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 8/8] dump-ir: make it more flexible
Date: Fri, 15 Sep 2017 09:40:34 +0200
Message-ID: <20170915074034.7785-9-luc.vanoostenryck@gmail.com>
References: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37736 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbdIOHks (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:40:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id f4so2006141wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:40:47 -0700 (PDT)
In-Reply-To: <20170915074034.7785-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/options.md               | 11 ++++++
 lib.c                                  | 70 ++++++++++++++++++++++++++++++----
 lib.h                                  |  2 +-
 linearize.c                            |  2 +-
 sparse.1                               |  6 ---
 test-linearize.c                       |  2 +-
 test-unssa.c                           |  2 +-
 validation/linear/bitfield-init-mask.c |  2 +-
 8 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/Documentation/options.md b/Documentation/options.md
index 5677789e1..14698a981 100644
--- a/Documentation/options.md
+++ b/Documentation/options.md
@@ -16,3 +16,14 @@ tools.
   The passes currently understood are:
   * 'mem2reg'
   * 'optim'
+
+### Internal Representation
+
+* '-fdump-ir[=\<pass\>[,\<pass\>...]]'
+
+  Dump the IR at each of the given passes.
+
+  The passes currently understood are:
+  * 'linearize'
+  * 'mem2reg'
+  * 'final'
diff --git a/lib.c b/lib.c
index e7bdc0783..03250c9e9 100644
--- a/lib.c
+++ b/lib.c
@@ -259,7 +259,7 @@ int dump_macro_defs = 0;
 int dbg_entry = 0;
 int dbg_dead = 0;
 
-int fdump_ir;
+unsigned long fdump_ir;
 int fmem_report = 0;
 unsigned long long fmemcpy_max_count = 100000;
 unsigned long fpasses = ~0UL;
@@ -487,6 +487,57 @@ const char *match_option(const char *arg, const char *prefix)
 }
 
 
+struct mask_map {
+	const char *name;
+	unsigned long mask;
+};
+
+static int apply_mask(unsigned long *val, const char *str, unsigned len, const struct mask_map *map, int neg)
+{
+	const char *name;
+
+	for (;(name = map->name); map++) {
+		if (!strncmp(name, str, len) && !name[len]) {
+			if (neg == 0)
+				*val |= map->mask;
+			else
+				*val &= ~map->mask;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static int handle_suboption_mask(const char *arg, const char *opt, const struct mask_map *map, unsigned long *flag)
+{
+	if (*opt == '\0') {
+		apply_mask(flag, "", 0, map, 0);
+		return 1;
+	}
+	if (*opt++ != '=')
+		return 0;
+	while (1) {
+		unsigned int len = strcspn(opt, ",+");
+		int neg = 0;
+		if (len == 0)
+			goto end;
+		if (!strncmp(opt, "no-", 3)) {
+			opt += 3;
+			len -= 3;
+			neg = 1;
+		}
+		if (apply_mask(flag, opt, len, map, neg))
+			die("error: wrong option '%.*s' for \'%s\'", len, opt, arg);
+
+end:
+		opt += len;
+		if (*opt++ == '\0')
+			break;
+	}
+	return 1;
+}
+
+
 #define OPT_INVERSE	1
 struct flag {
 	const char *name;
@@ -799,14 +850,15 @@ error:
 
 static int handle_fdump_ir(const char *arg, const char *opt, const struct flag *flag, int options)
 {
-	if (*opt == '\0')
-		fdump_ir = 1;
-	else if (!strcmp(opt, "=only"))
-		fdump_ir = 2;
-	else
-		die("error: wrong option \"%s\"", arg);
+	static const struct mask_map dump_ir_options[] = {
+		{ "",			PASS_LINEARIZE },
+		{ "linearize",		PASS_LINEARIZE },
+		{ "mem2reg",		PASS_MEM2REG },
+		{ "final",		PASS_FINAL },
+		{ },
+	};
 
-	return 1;
+	return handle_suboption_mask(arg, opt, dump_ir_options, &fdump_ir);
 }
 
 static int handle_fmemcpy_max_count(const char *arg, const char *opt, const struct flag *flag, int options)
@@ -1405,6 +1457,8 @@ struct symbol_list *sparse_initialize(int argc, char **argv, struct string_list
 	handle_switch_v_finalize();
 
 	handle_arch_finalize();
+	if (fdump_ir == 0)
+		fdump_ir = PASS_FINAL;
 
 	list = NULL;
 	if (!ptr_list_empty(filelist)) {
diff --git a/lib.h b/lib.h
index bfcfd2a08..8d3c67a0d 100644
--- a/lib.h
+++ b/lib.h
@@ -167,7 +167,7 @@ extern int dbg_entry;
 extern int dbg_dead;
 
 extern int fmem_report;
-extern int fdump_ir;
+extern unsigned long fdump_ir;
 extern unsigned long long fmemcpy_max_count;
 extern unsigned long fpasses;
 
diff --git a/linearize.c b/linearize.c
index 8ab93e0b3..212a5feaf 100644
--- a/linearize.c
+++ b/linearize.c
@@ -2220,7 +2220,7 @@ static struct entrypoint *linearize_fn(struct symbol *sym, struct symbol *base_t
 		add_one_insn(ep, insn);
 	}
 
-	if (fdump_ir)
+	if (fdump_ir & PASS_LINEARIZE)
 		show_entry(ep);
 
 	/*
diff --git a/sparse.1 b/sparse.1
index 810fb3219..377d1d3cb 100644
--- a/sparse.1
+++ b/sparse.1
@@ -356,12 +356,6 @@ The \fIdir\fR name would normally take the form of the target's
 normalized GNU triplet. (e.g. i386-linux-gnu).
 .
 .SH DEBUG OPTIONS
-.TP
-.B \-fdump-ir[=only]
-Dump the IR code of a function directly after its linearization,
-before any simplifications is made. If the argument \fB=only\fR is
-also given no further processing is done on the function.
-.
 .B \-fmem-report
 Report some statistics about memory allocation used by the tool.
 .
diff --git a/test-linearize.c b/test-linearize.c
index c7122080e..e6d1ee3cd 100644
--- a/test-linearize.c
+++ b/test-linearize.c
@@ -47,7 +47,7 @@ static void clean_up_symbols(struct symbol_list *list)
 
 		expand_symbol(sym);
 		ep = linearize_symbol(sym);
-		if (fdump_ir == 2)
+		if (!(fdump_ir & PASS_FINAL))
 			continue;
 		if (ep)
 			show_entry(ep);
diff --git a/test-unssa.c b/test-unssa.c
index e0981802d..80752f432 100644
--- a/test-unssa.c
+++ b/test-unssa.c
@@ -62,7 +62,7 @@ static int compile(struct symbol_list *list)
 		struct entrypoint *ep;
 		expand_symbol(sym);
 		ep = linearize_symbol(sym);
-		if (fdump_ir == 2)
+		if (!(fdump_ir & PASS_FINAL))
 			continue;
 		if (ep)
 			output_fn(ep);
diff --git a/validation/linear/bitfield-init-mask.c b/validation/linear/bitfield-init-mask.c
index f43605855..aac21e614 100644
--- a/validation/linear/bitfield-init-mask.c
+++ b/validation/linear/bitfield-init-mask.c
@@ -18,7 +18,7 @@ struct bfu bfu_init_20_23(int a)
 
 /*
  * check-name: bitfield initializer mask
- * check-command: test-linearize -fdump-ir=only -Wno-decl $file
+ * check-command: test-linearize -fdump-ir=linearize -Wno-decl $file
  * check-output-ignore
  *
  * check-output-contains: and\\..*fffff800\$
-- 
2.14.0

