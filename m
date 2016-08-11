From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] byteswap: don't use __builtin_bswap*() with sparse
Date: Thu, 11 Aug 2016 13:15:02 +0200
Message-ID: <1470914102-26389-1-git-send-email-johannes@sipsolutions.net>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from s3.sipsolutions.net ([5.9.151.49]:52177 "EHLO sipsolutions.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752011AbcHKLPM (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 11 Aug 2016 07:15:12 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-sparse@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

Although sparse declares __builtin_bswap*(), it can't actually
do constant folding inside them (yet). As such, things like

  switch (protocol) {
  case htons(ETH_P_IP):
          break;
  }

which we do all over the place cause sparse to warn that it
expects a constant instead of a function call.

Disable __HAVE_BUILTIN_BSWAP*__ if __CHECKER__ is defined to
avoid this.

Cc: Arnd Bergmann <arnd@arndb.de>
Fixes: 7322dd755e7d ("byteswap: try to avoid __builtin_constant_p gcc bug")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/compiler-gcc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e2949397c19b..8dbc8929a6a0 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -242,7 +242,11 @@
  */
 #define asm_volatile_goto(x...)	do { asm goto(x); asm (""); } while (0)
 
-#ifdef CONFIG_ARCH_USE_BUILTIN_BSWAP
+/*
+ * sparse (__CHECKER__) pretends to be gcc, but can't do constant
+ * folding in __builtin_bswap*() (yet), so don't set these for it.
+ */
+#if defined(CONFIG_ARCH_USE_BUILTIN_BSWAP) && !defined(__CHECKER__)
 #if GCC_VERSION >= 40400
 #define __HAVE_BUILTIN_BSWAP32__
 #define __HAVE_BUILTIN_BSWAP64__
@@ -250,7 +254,7 @@
 #if GCC_VERSION >= 40800
 #define __HAVE_BUILTIN_BSWAP16__
 #endif
-#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP */
+#endif /* CONFIG_ARCH_USE_BUILTIN_BSWAP && !__CHECKER__ */
 
 #if GCC_VERSION >= 50000
 #define KASAN_ABI_VERSION 4
-- 
2.8.1

