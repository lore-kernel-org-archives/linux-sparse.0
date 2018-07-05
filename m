From: Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH] compiler.h, sparse, smatch: Do not define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
Date: Thu,  5 Jul 2018 08:57:26 -0700
Message-ID: <20180705155726.26716-1-bart.vanassche@wdc.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Bart Van Assche <bart.vanassche@wdc.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Kees Cook <keescook@chromium.org>, Dan Carpenter <dan.carpenter@oracle.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, stable@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Both sparse and smatch identify themselves as gcc. However, neither
static analyzer supports any of the __builtin_*_overflow() functions.
Hence do not define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW for these
static checkers.

Fixes: f0907827a8a9 ("compiler.h: enable builtin overflow checkers and add fallback code")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/compiler-gcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index f1a7492a5cc8..15e55b89e952 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -344,6 +344,6 @@
  */
 #define uninitialized_var(x) x = x
 
-#if GCC_VERSION >= 50100
+#if GCC_VERSION >= 50100 && !defined(__CHECKER__)
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
-- 
2.18.0
