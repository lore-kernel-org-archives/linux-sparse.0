From: Nadav Amit <namit@vmware.com>
Subject: [PATCH v2 2/9] x86: objtool: use asm macro for better compiler decisions
Date: Mon, 4 Jun 2018 04:21:24 -0700
Message-ID: <20180604112131.59100-3-namit@vmware.com>
References: <20180604112131.59100-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180604112131.59100-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: Nadav Amit <namit@vmware.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

GCC considers the number of statements in inlined assembly blocks,
according to new-lines and semicolons, as an indication to the cost of
the block in time and space. This data is distorted by the kernel code,
which puts information in alternative sections. As a result, the
compiler may perform incorrect inlining and branch optimizations.

In the case of objtool, this distortion is extreme, since anyhow the
annotations of objtool are discarded during linkage.

The solution is to set an assembly macro and call it from the inline
assembly block. As a result GCC considers the inline assembly block as
a single instruction.

This patch slightly increases the kernel size.

   text	   data	    bss	    dec	    hex	filename
18140829 10224724 2957312 31322865 1ddf2f1 ./vmlinux before
18140970 10225412 2957312 31323694 1ddf62e ./vmlinux after (+829)

Static text symbols:
Before:	40321
After:	40302	(-19)

Cc: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 arch/x86/kernel/macros.S |  2 ++
 include/linux/compiler.h | 60 +++++++++++++++++++++++++++++++---------
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index cfc1c7d1a6eb..cee28c3246dc 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -5,3 +5,5 @@
  * commonly used. The macros are precompiled into assmebly file which is later
  * assembled together with each compiled file.
  */
+
+#include <linux/compiler.h>
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ab4711c63601..d10e752036c4 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -91,6 +91,10 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 # define barrier_before_unreachable() do { } while (0)
 #endif
 
+/* A wrapper to clearly document when a macro is used */
+#define __ASM_MACRO(name, ...)		__stringify(name) __stringify(__VA_ARGS__)
+#define ASM_MACRO(name, ...)		__ASM_MACRO(name, __VA_ARGS__) "\n\t"
+
 /* Unreachable code */
 #ifdef CONFIG_STACK_VALIDATION
 /*
@@ -99,22 +103,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * unique, to convince GCC not to merge duplicate inline asm statements.
  */
 #define annotate_reachable() ({						\
-	asm volatile("%c0:\n\t"						\
-		     ".pushsection .discard.reachable\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+	asm volatile("ANNOTATE_REACHABLE counter=%c0"			\
+		     : : "i" (__COUNTER__));				\
 })
 #define annotate_unreachable() ({					\
-	asm volatile("%c0:\n\t"						\
-		     ".pushsection .discard.unreachable\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+	asm volatile("ANNOTATE_UNREACHABLE counter=%c0"		\
+		     : : "i" (__COUNTER__));				\
 })
-#define ASM_UNREACHABLE							\
-	"999:\n\t"							\
-	".pushsection .discard.unreachable\n\t"				\
-	".long 999b - .\n\t"						\
-	".popsection\n\t"
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
@@ -280,6 +275,45 @@ unsigned long read_word_at_a_time(const void *addr)
 
 #endif /* __KERNEL__ */
 
+#else /* __ASSEMBLY__ */
+
+#ifdef __KERNEL__
+#ifndef LINKER_SCRIPT
+
+#ifdef CONFIG_STACK_VALIDATION
+.macro ANNOTATE_UNREACHABLE counter:req
+\counter:
+	.pushsection .discard.unreachable
+	.long \counter\()b -.
+	.popsection
+.endm
+
+.macro ANNOTATE_REACHABLE counter:req
+\counter:
+	.pushsection .discard.reachable
+	.long \counter\()b -.
+	.popsection
+.endm
+
+.macro ASM_UNREACHABLE
+999:
+	.pushsection .discard.unreachable
+	.long 999b - .
+	.popsection
+.endm
+#else /* CONFIG_STACK_VALIDATION */
+.macro ANNOTATE_UNREACHABLE counter:req
+.endm
+
+.macro ANNOTATE_UNREACHABLE counter:req
+.endm
+
+.macro ASM_UNREACHABLE
+.endm /* CONFIG_STACK_VALIDATION */
+#endif
+
+#endif /* LINKER_SCRIPT */
+#endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 
 #ifndef __optimize
-- 
2.17.0
