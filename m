From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 6/7] arch: add specificities for Blackfin
Date: Wed, 10 Jun 2020 22:27:34 +0200
Message-ID: <20200610202735.84968-7-luc.vanoostenryck@gmail.com>
References: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgFJU1t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Jun 2020 16:27:49 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807B3C03E96B
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:27:49 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id t21so2339350edr.12
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:27:49 -0700 (PDT)
In-Reply-To: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The real goal here is in fact to move the bfin-specfic
builtins out of the main builtins table.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile      |  1 +
 builtin.c     |  5 -----
 machine.h     |  1 +
 target-bfin.c | 26 ++++++++++++++++++++++++++
 target.c      |  2 ++
 target.h      |  1 +
 6 files changed, 31 insertions(+), 5 deletions(-)
 create mode 100644 target-bfin.c

diff --git a/Makefile b/Makefile
index 69fae4828e62..bee6a324b1c7 100644
--- a/Makefile
+++ b/Makefile
@@ -67,6 +67,7 @@ LIB_OBJS += symbol.o
 LIB_OBJS += target.o
 LIB_OBJS += target-arm.o
 LIB_OBJS += target-arm64.o
+LIB_OBJS += target-bfin.o
 LIB_OBJS += target-default.o
 LIB_OBJS += target-m68k.o
 LIB_OBJS += target-mips.o
diff --git a/builtin.c b/builtin.c
index 9442fb5b89ef..dd467db425df 100644
--- a/builtin.c
+++ b/builtin.c
@@ -573,11 +573,6 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__builtin_alpha_insql", &long_ctype, 0, { &long_ctype, &long_ctype }},
 	{ "__builtin_alpha_inswl", &long_ctype, 0, { &long_ctype, &long_ctype }},
 
-	// Blackfin-specific stuff
-	{ "__builtin_bfin_csync", &void_ctype, 0 },
-	{ "__builtin_bfin_ssync", &void_ctype, 0 },
-	{ "__builtin_bfin_norm_fr1x32", &int_ctype, 0, { &int_ctype }},
-
 	{ }
 };
 
diff --git a/machine.h b/machine.h
index a211345c80ce..b9f22850b9db 100644
--- a/machine.h
+++ b/machine.h
@@ -32,6 +32,7 @@ enum machine {
 	MACH_RISCV32,	MACH_RISCV64,
 	MACH_SPARC32,	MACH_SPARC64,
 	MACH_S390,	MACH_S390X,
+	MACH_BFIN,
 	MACH_M68K,
 	MACH_NIOS2,
 	MACH_UNKNOWN
diff --git a/target-bfin.c b/target-bfin.c
new file mode 100644
index 000000000000..b84cd5de8d54
--- /dev/null
+++ b/target-bfin.c
@@ -0,0 +1,26 @@
+#include "symbol.h"
+#include "target.h"
+#include "machine.h"
+#include "builtin.h"
+
+
+static void predefine_bfin(const struct target *self)
+{
+	predefine("__BFIN__", 1, "1");
+	predefine("__bfin__", 1, "1");
+}
+
+static const struct builtin_fn builtins_bfin[] = {
+	{ "__builtin_bfin_csync", &void_ctype, 0 },
+	{ "__builtin_bfin_ssync", &void_ctype, 0 },
+	{ "__builtin_bfin_norm_fr1x32", &int_ctype, 0, { &int_ctype }},
+	{ }
+};
+
+const struct target target_bfin = {
+	.mach = MACH_BFIN,
+	.bitness = ARCH_LP32,
+
+	.predefine = predefine_bfin,
+	.builtins = builtins_bfin,
+};
diff --git a/target.c b/target.c
index 0ef0eb5a14ae..1fd066da8639 100644
--- a/target.c
+++ b/target.c
@@ -60,6 +60,7 @@ static const struct target *targets[] = {
 	[MACH_ARM] =		&target_arm,
 	[MACH_ARM64] =		&target_arm64,
 	[MACH_I386] =		&target_i386,
+	[MACH_BFIN] =		&target_bfin,
 	[MACH_X86_64] =		&target_x86_64,
 	[MACH_MIPS32] =		&target_mips32,
 	[MACH_MIPS64] =		&target_mips64,
@@ -88,6 +89,7 @@ enum machine target_parse(const char *name)
 		{ "arm64",	MACH_ARM64,	64, },
 		{ "arm",	MACH_ARM,	32, },
 		{ "i386",	MACH_I386,	32, },
+		{ "bfin",	MACH_BFIN,	32, },
 		{ "m68k",	MACH_M68K,	32, },
 		{ "mips",	MACH_MIPS32,	0,  },
 		{ "nios2",	MACH_NIOS2,	32, },
diff --git a/target.h b/target.h
index 4c184d8f2fbe..9674d0995fd5 100644
--- a/target.h
+++ b/target.h
@@ -82,6 +82,7 @@ struct target {
 extern const struct target target_default;
 extern const struct target target_arm;
 extern const struct target target_arm64;
+extern const struct target target_bfin;
 extern const struct target target_m68k;
 extern const struct target target_mips32;
 extern const struct target target_mips64;
-- 
2.27.0
