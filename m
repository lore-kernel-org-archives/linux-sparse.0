From: Joe Perches <joe@perches.com>
Subject: [PATCH V2] compiler*.h: Add '__' prefix and suffix to all
 __attribute__ #defines
Date: Mon, 28 Oct 2019 11:17:43 -0700
Message-ID: <07d3b90307f85267c7467fd329043a8790a2c332.camel@perches.com>
References: <7a15bc8ad7437dc3a044a4f9cd283500bd0b5f36.camel@perches.com>
         <CANiq72=B6XKwfkC9L4=+OxWtjxCp-94TWRG1a=pC=y636gzckA@mail.gmail.com>
         <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19fd23e98bab65a1ee624445193bd2ed86108881.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: linux-sparse@vger.kernel.org

To avoid macro name collisions and improve portability use a
double underscore prefix and suffix on all __attribute__ #defines.

There are __CHECKER__ exceptions to these uses of attribute types
because sparse as of version 0.6.1 and earlier do not recognize
a few __<type>__ attributes.

Signed-off-by: Joe Perches <joe@perches.com>
---

v2: Do not modify the __CHECKER__ attribute #defines
    Add a comment describing why to the __CHECKER__ block.

 include/linux/compiler-clang.h |  2 +-
 include/linux/compiler-gcc.h   | 10 +++++-----
 include/linux/compiler_types.h | 11 ++++++++---
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 333a66..26d655f 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -19,7 +19,7 @@
 /* emulate gcc's __SANITIZE_ADDRESS__ flag */
 #define __SANITIZE_ADDRESS__
 #define __no_sanitize_address \
-		__attribute__((no_sanitize("address", "hwaddress")))
+		__attribute__((__no_sanitize__("address", "hwaddress")))
 #else
 #define __no_sanitize_address
 #endif
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c..7a2dee 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -76,7 +76,7 @@
 #define __compiletime_error(message) __attribute__((__error__(message)))
 
 #if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
-#define __latent_entropy __attribute__((latent_entropy))
+#define __latent_entropy __attribute__((__latent_entropy__))
 #endif
 
 /*
@@ -101,8 +101,8 @@
 	} while (0)
 
 #if defined(RANDSTRUCT_PLUGIN) && !defined(__CHECKER__)
-#define __randomize_layout __attribute__((randomize_layout))
-#define __no_randomize_layout __attribute__((no_randomize_layout))
+#define __randomize_layout __attribute__((__randomize_layout__))
+#define __no_randomize_layout __attribute__((__no_randomize_layout__))
 /* This anon struct can add padding, so only enable it under randstruct. */
 #define randomized_struct_fields_start	struct {
 #define randomized_struct_fields_end	} __randomize_layout;
@@ -140,7 +140,7 @@
 #endif
 
 #if __has_attribute(__no_sanitize_address__)
-#define __no_sanitize_address __attribute__((no_sanitize_address))
+#define __no_sanitize_address __attribute__((__no_sanitize_address__))
 #else
 #define __no_sanitize_address
 #endif
@@ -171,4 +171,4 @@
 #define __diag_GCC_8(s)
 #endif
 
-#define __no_fgcse __attribute__((optimize("-fno-gcse")))
+#define __no_fgcse __attribute__((__optimize__("-fno-gcse")))
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 72393a..506b3a 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -5,6 +5,11 @@
 #ifndef __ASSEMBLY__
 
 #ifdef __CHECKER__
+/*
+ * sparse as of v0.6.1 does not understand several double underscore
+ * prefix and suffix forms of attribute types, so do not use them when
+ * sparse checking is enabled
+ */
 # define __user		__attribute__((noderef, address_space(1)))
 # define __kernel	__attribute__((address_space(0)))
 # define __safe		__attribute__((safe))
@@ -25,7 +30,7 @@ extern void __chk_io_ptr(const volatile void __iomem *);
 # define ACCESS_PRIVATE(p, member) (*((typeof((p)->member) __force *) &(p)->member))
 #else /* __CHECKER__ */
 # ifdef STRUCTLEAK_PLUGIN
-#  define __user __attribute__((user))
+#  define __user __attribute__((__user__))
 # else
 #  define __user
 # endif
@@ -111,9 +116,9 @@ struct ftrace_likely_data {
 #endif
 
 #if defined(CC_USING_HOTPATCH)
-#define notrace			__attribute__((hotpatch(0, 0)))
+#define notrace			__attribute__((__hotpatch__(0, 0)))
 #elif defined(CC_USING_PATCHABLE_FUNCTION_ENTRY)
-#define notrace			__attribute__((patchable_function_entry(0, 0)))
+#define notrace			__attribute__((__patchable_function_entry__(0, 0)))
 #else
 #define notrace			__attribute__((__no_instrument_function__))
 #endif
