From: Joe Perches <joe@perches.com>
Subject: [PATCH] compiler/compiler-gcc: Add __fallthrough
Date: Fri, 10 Feb 2017 09:08:35 -0800
Message-ID: <791a2621851fc989bc04dfe975ec29de15cbb557.1486746344.git.joe@perches.com>
References: <20170210144238.GC15066@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170210144238.GC15066@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Christopher Li <sparse@chrisli.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

gcc v7.0 can warn on missing break statements from case labels
using a special __attribute__((fallthrough))__ marker.

Add a __fallthrough convenience macro for gcc versions >= 7 and
make the generic use of __fallthrough a no-op.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/compiler-gcc.h | 7 +++++++
 include/linux/compiler.h     | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d5e1fedbad24..6af8d6448f10 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -304,6 +304,13 @@
 #define __no_sanitize_address __attribute__((no_sanitize_address))
 #endif
 
+#if GCC_VERSION >= 70000
+/*
+ * Tell the compiler not to warn when a switch/case fallthrough marker exists
+ */
+#define __fallthrough __attribute__ ((fallthrough))
+#endif
+
 #endif	/* gcc version >= 40000 specific checks */
 
 #if !defined(__noclone)
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 6e8e160b1e4b..16b6efc877f4 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -477,6 +477,12 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 #define __assume_aligned(a, ...)
 #endif
 
+/*
+ * switch/case fallthrough checking
+ */
+#ifndef __fallthrough
+#define __fallthrough
+#endif
 
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #ifndef __same_type
-- 
2.10.0.rc2.1.g053435c
