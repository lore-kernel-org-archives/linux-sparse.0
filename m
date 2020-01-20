From: john.levon@joyent.com
Subject: [PATCH] correct sparcv9 defines
Date: Mon, 20 Jan 2020 02:38:24 -0800
Message-ID: <20200120103824.20746-1-john.levon@joyent.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from [8.12.47.4] ([8.12.47.4]:48577 "EHLO jlevon"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbgATKrT (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 20 Jan 2020 05:47:19 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Toomas Soome <tsoome@me.com>

From: Toomas Soome <tsoome@me.com>

The SPARCV9 compile check needs to look for __sparcv9 on some systems,
and should also define "sparc".
---
 lib.c     | 13 ++++++++-----
 machine.h |  2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/lib.c b/lib.c
index 711e8fbe..14e51979 100644
--- a/lib.c
+++ b/lib.c
@@ -1587,15 +1587,18 @@ static void predefined_macros(void)
 		predefine("__s390__", 1, "1");
 		break;
 	case MACH_SPARC64:
-		predefine("__sparc_v9__", 1, "1");
-		predefine("__sparcv9__", 1, "1");
-		predefine("__sparcv9", 1, "1");
-		predefine("__sparc64__", 1, "1");
-		predefine("__arch64__", 1, "1");
+		if (arch_m64 != ARCH_LP32) {
+			predefine("__sparc_v9__", 1, "1");
+			predefine("__sparcv9__", 1, "1");
+			predefine("__sparcv9", 1, "1");
+			predefine("__sparc64__", 1, "1");
+			predefine("__arch64__", 1, "1");
+		}
 		/* fall-through */
 	case MACH_SPARC32:
 		predefine("__sparc__", 1, "1");
 		predefine("__sparc", 1, "1");
+		predefine("sparc", 1, "1");
 		break;
 	case MACH_X86_64:
 		if (arch_m64 != ARCH_LP32) {
diff --git a/machine.h b/machine.h
index 6eba448c..3389579c 100644
--- a/machine.h
+++ b/machine.h
@@ -56,7 +56,7 @@ enum machine {
 #define	MACH_NATIVE	MACH_RISCV64
 #elif defined(__riscv) && (__riscv_xlen == 32)
 #define	MACH_NATIVE	MACH_RISCV32
-#elif defined(__sparc_v9__)
+#elif defined(__sparc_v9__) || defined(__sparcv9)
 #define	MACH_NATIVE	MACH_SPARC64
 #elif defined(__sparc__) || defined(__sparc)
 #define	MACH_NATIVE	MACH_SPARC32
-- 
2.23.0
