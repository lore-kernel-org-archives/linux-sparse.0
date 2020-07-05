From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] arch: add minimal support for microblaze
Date: Mon,  6 Jul 2020 01:23:02 +0200
Message-ID: <20200705232302.61646-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgGEXXJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 19:23:09 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAC8C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 16:23:09 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e15so33222111edr.2
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 16:23:09 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, kernel test robot <lkp@intel.com>

The Kernel Test Robot reports a problem on microblaze.

The cause is that __MICROBLAZEEL__ is not defined. However, the real
problem is that sparse has no support at all for this architecture.

So, add the minimal support for microblaze.

Link: https://lore.kernel.org/lkml/202007060542.hNfoTcsC%25lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile            |  1 +
 machine.h           |  1 +
 target-microblaze.c | 25 +++++++++++++++++++++++++
 target.c            |  2 ++
 target.h            |  1 +
 5 files changed, 30 insertions(+)
 create mode 100644 target-microblaze.c

diff --git a/Makefile b/Makefile
index a292e42aabf3..0b62e2094249 100644
--- a/Makefile
+++ b/Makefile
@@ -72,6 +72,7 @@ LIB_OBJS += target-arm64.o
 LIB_OBJS += target-bfin.o
 LIB_OBJS += target-default.o
 LIB_OBJS += target-m68k.o
+LIB_OBJS += target-microblaze.o
 LIB_OBJS += target-mips.o
 LIB_OBJS += target-nios2.o
 LIB_OBJS += target-ppc.o
diff --git a/machine.h b/machine.h
index 02a7f90e5362..7407e71627e1 100644
--- a/machine.h
+++ b/machine.h
@@ -35,6 +35,7 @@ enum machine {
 	MACH_ALPHA,
 	MACH_BFIN,
 	MACH_M68K,
+	MACH_MICROBLAZE,
 	MACH_NIOS2,
 	MACH_UNKNOWN
 };
diff --git a/target-microblaze.c b/target-microblaze.c
new file mode 100644
index 000000000000..1fbeef3c168d
--- /dev/null
+++ b/target-microblaze.c
@@ -0,0 +1,25 @@
+#include "symbol.h"
+#include "target.h"
+#include "machine.h"
+
+
+static void predefine_microblaze(const struct target *self)
+{
+	predefine("__MICROBLAZE__", 1, "1");
+	predefine("__microblaze__", 1, "1");
+
+	if (arch_big_endian)
+		predefine("__MICROBLAZEEB__", 1, "1");
+	else
+		predefine("__MICROBLAZEEL__", 1, "1");
+}
+
+const struct target target_microblaze = {
+	.mach = MACH_MICROBLAZE,
+	.bitness = ARCH_LP32,
+	.big_endian = true,
+
+	.bits_in_longdouble = 64,
+
+	.predefine = predefine_microblaze,
+};
diff --git a/target.c b/target.c
index 07c298128da4..6776c3a1cbb0 100644
--- a/target.c
+++ b/target.c
@@ -63,6 +63,7 @@ static const struct target *targets[] = {
 	[MACH_I386] =		&target_i386,
 	[MACH_BFIN] =		&target_bfin,
 	[MACH_X86_64] =		&target_x86_64,
+	[MACH_MICROBLAZE] =	&target_microblaze,
 	[MACH_MIPS32] =		&target_mips32,
 	[MACH_MIPS64] =		&target_mips64,
 	[MACH_NIOS2] =		&target_nios2,
@@ -93,6 +94,7 @@ enum machine target_parse(const char *name)
 		{ "i386",	MACH_I386,	32, },
 		{ "bfin",	MACH_BFIN,	32, },
 		{ "m68k",	MACH_M68K,	32, },
+		{ "microblaze",	MACH_MICROBLAZE,32, },
 		{ "mips",	MACH_MIPS32,	0,  },
 		{ "nios2",	MACH_NIOS2,	32, },
 		{ "powerpc",	MACH_PPC32,	0,  },
diff --git a/target.h b/target.h
index 3ef0d520f83c..8f79426c096a 100644
--- a/target.h
+++ b/target.h
@@ -86,6 +86,7 @@ extern const struct target target_arm;
 extern const struct target target_arm64;
 extern const struct target target_bfin;
 extern const struct target target_m68k;
+extern const struct target target_microblaze;
 extern const struct target target_mips32;
 extern const struct target target_mips64;
 extern const struct target target_nios2;
-- 
2.27.0
