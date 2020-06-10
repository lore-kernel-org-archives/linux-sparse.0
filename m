From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 7/7] arch: add specificities for Alpha
Date: Wed, 10 Jun 2020 22:27:35 +0200
Message-ID: <20200610202735.84968-8-luc.vanoostenryck@gmail.com>
References: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgFJU1v (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 10 Jun 2020 16:27:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C8AC03E96B
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:27:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m21so2333011eds.13
        for <linux-sparse@vger.kernel.org>; Wed, 10 Jun 2020 13:27:50 -0700 (PDT)
In-Reply-To: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The real goal here is in fact to move the alpha-specfic
builtins out of the main builtins table.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile       |  1 +
 builtin.c      |  9 ---------
 machine.h      |  3 +++
 target-alpha.c | 30 ++++++++++++++++++++++++++++++
 target.c       |  2 ++
 target.h       |  1 +
 6 files changed, 37 insertions(+), 9 deletions(-)
 create mode 100644 target-alpha.c

diff --git a/Makefile b/Makefile
index bee6a324b1c7..e1831a1d259b 100644
--- a/Makefile
+++ b/Makefile
@@ -65,6 +65,7 @@ LIB_OBJS += stats.o
 LIB_OBJS += storage.o
 LIB_OBJS += symbol.o
 LIB_OBJS += target.o
+LIB_OBJS += target-alpha.o
 LIB_OBJS += target-arm.o
 LIB_OBJS += target-arm64.o
 LIB_OBJS += target-bfin.o
diff --git a/builtin.c b/builtin.c
index dd467db425df..2038de5730e3 100644
--- a/builtin.c
+++ b/builtin.c
@@ -564,15 +564,6 @@ static const struct builtin_fn builtins_common[] = {
 	{ "__sync_val_compare_and_swap", &int_ctype, 1, { &ptr_ctype }},
 	{ "__sync_xor_and_fetch", &int_ctype, 1, { &ptr_ctype }},
 
-	// Alpha-specific
-	{ "__builtin_alpha_cmpbge", &long_ctype, 0, { &long_ctype, &long_ctype }},
-	{ "__builtin_alpha_extbl", &long_ctype, 0, { &long_ctype, &long_ctype }},
-	{ "__builtin_alpha_extwl", &long_ctype, 0, { &long_ctype, &long_ctype }},
-	{ "__builtin_alpha_insbl", &long_ctype, 0, { &long_ctype, &long_ctype }},
-	{ "__builtin_alpha_inslh", &long_ctype, 0, { &long_ctype, &long_ctype }},
-	{ "__builtin_alpha_insql", &long_ctype, 0, { &long_ctype, &long_ctype }},
-	{ "__builtin_alpha_inswl", &long_ctype, 0, { &long_ctype, &long_ctype }},
-
 	{ }
 };
 
diff --git a/machine.h b/machine.h
index b9f22850b9db..02a7f90e5362 100644
--- a/machine.h
+++ b/machine.h
@@ -32,6 +32,7 @@ enum machine {
 	MACH_RISCV32,	MACH_RISCV64,
 	MACH_SPARC32,	MACH_SPARC64,
 	MACH_S390,	MACH_S390X,
+	MACH_ALPHA,
 	MACH_BFIN,
 	MACH_M68K,
 	MACH_NIOS2,
@@ -40,6 +41,8 @@ enum machine {
 
 #if defined(__aarch64__)
 #define MACH_NATIVE	MACH_ARM64
+#elif defined(__alpha__) || defined(__alpha)
+#define	MACH_NATIVE	MACH_ALPHA
 #elif defined(__arm__)
 #define	MACH_NATIVE	MACH_ARM
 #elif defined(__x86_64__) || defined(__x86_64)
diff --git a/target-alpha.c b/target-alpha.c
new file mode 100644
index 000000000000..3f582997eb96
--- /dev/null
+++ b/target-alpha.c
@@ -0,0 +1,30 @@
+#include "symbol.h"
+#include "target.h"
+#include "machine.h"
+#include "builtin.h"
+
+
+static void predefine_alpha(const struct target *self)
+{
+	predefine("__alpha__", 1, "1");
+	predefine("__alpha", 1, "1");
+}
+
+static const struct builtin_fn builtins_alpha[] = {
+	{ "__builtin_alpha_cmpbge", &long_ctype, 0, { &long_ctype, &long_ctype }},
+	{ "__builtin_alpha_extbl", &long_ctype, 0, { &long_ctype, &long_ctype }},
+	{ "__builtin_alpha_extwl", &long_ctype, 0, { &long_ctype, &long_ctype }},
+	{ "__builtin_alpha_insbl", &long_ctype, 0, { &long_ctype, &long_ctype }},
+	{ "__builtin_alpha_inslh", &long_ctype, 0, { &long_ctype, &long_ctype }},
+	{ "__builtin_alpha_insql", &long_ctype, 0, { &long_ctype, &long_ctype }},
+	{ "__builtin_alpha_inswl", &long_ctype, 0, { &long_ctype, &long_ctype }},
+	{ }
+};
+
+const struct target target_alpha = {
+	.mach = MACH_ALPHA,
+	.bitness = ARCH_LP64,
+
+	.predefine = predefine_alpha,
+	.builtins = builtins_alpha,
+};
diff --git a/target.c b/target.c
index 1fd066da8639..07c298128da4 100644
--- a/target.c
+++ b/target.c
@@ -57,6 +57,7 @@ int enum_alignment = 4;
 
 
 static const struct target *targets[] = {
+	[MACH_ALPHA] =		&target_alpha,
 	[MACH_ARM] =		&target_arm,
 	[MACH_ARM64] =		&target_arm64,
 	[MACH_I386] =		&target_i386,
@@ -85,6 +86,7 @@ enum machine target_parse(const char *name)
 		enum machine mach;
 		char bits;
 	} archs[] = {
+		{ "alpha",	MACH_ALPHA,	64, },
 		{ "aarch64",	MACH_ARM64,	64, },
 		{ "arm64",	MACH_ARM64,	64, },
 		{ "arm",	MACH_ARM,	32, },
diff --git a/target.h b/target.h
index 9674d0995fd5..8640026cc6d4 100644
--- a/target.h
+++ b/target.h
@@ -80,6 +80,7 @@ struct target {
 };
 
 extern const struct target target_default;
+extern const struct target target_alpha;
 extern const struct target target_arm;
 extern const struct target target_arm64;
 extern const struct target target_bfin;
-- 
2.27.0
