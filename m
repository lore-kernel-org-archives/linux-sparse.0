From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 08/12] Revert "x86/objtool: Use asm macros to work around GCC inlining bugs"
Date: Tue, 18 Dec 2018 01:03:23 +0900
Message-ID: <1545062607-8599-9-git-send-email-yamada.masahiro@socionext.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Richard Biener <rguenther@suse.de>, Segher Boessenkool <segher@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, Nadav Amit <namit@vmware.com>
List-Id: linux-sparse@vger.kernel.org

This reverts commit c06c4d8090513f2974dfdbed2ac98634357ac475.

The in-kernel workarounds will be replaced with GCC's new
"asm inline" syntax.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/kernel/macros.S |  2 --
 include/linux/compiler.h | 56 +++++++++++-------------------------------------
 2 files changed, 13 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
index cee28c3..cfc1c7d 100644
--- a/arch/x86/kernel/macros.S
+++ b/arch/x86/kernel/macros.S
@@ -5,5 +5,3 @@
  * commonly used. The macros are precompiled into assmebly file which is later
  * assembled together with each compiled file.
  */
-
-#include <linux/compiler.h>
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 06396c1..fc5004a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -99,13 +99,22 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * unique, to convince GCC not to merge duplicate inline asm statements.
  */
 #define annotate_reachable() ({						\
-	asm volatile("ANNOTATE_REACHABLE counter=%c0"			\
-		     : : "i" (__COUNTER__));				\
+	asm volatile("%c0:\n\t"						\
+		     ".pushsection .discard.reachable\n\t"		\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__));		\
 })
 #define annotate_unreachable() ({					\
-	asm volatile("ANNOTATE_UNREACHABLE counter=%c0"			\
-		     : : "i" (__COUNTER__));				\
+	asm volatile("%c0:\n\t"						\
+		     ".pushsection .discard.unreachable\n\t"		\
+		     ".long %c0b - .\n\t"				\
+		     ".popsection\n\t" : : "i" (__COUNTER__));		\
 })
+#define ASM_UNREACHABLE							\
+	"999:\n\t"							\
+	".pushsection .discard.unreachable\n\t"				\
+	".long 999b - .\n\t"						\
+	".popsection\n\t"
 #else
 #define annotate_reachable()
 #define annotate_unreachable()
@@ -293,45 +302,6 @@ static inline void *offset_to_ptr(const int *off)
 	return (void *)((unsigned long)off + *off);
 }
 
-#else /* __ASSEMBLY__ */
-
-#ifdef __KERNEL__
-#ifndef LINKER_SCRIPT
-
-#ifdef CONFIG_STACK_VALIDATION
-.macro ANNOTATE_UNREACHABLE counter:req
-\counter:
-	.pushsection .discard.unreachable
-	.long \counter\()b -.
-	.popsection
-.endm
-
-.macro ANNOTATE_REACHABLE counter:req
-\counter:
-	.pushsection .discard.reachable
-	.long \counter\()b -.
-	.popsection
-.endm
-
-.macro ASM_UNREACHABLE
-999:
-	.pushsection .discard.unreachable
-	.long 999b - .
-	.popsection
-.endm
-#else /* CONFIG_STACK_VALIDATION */
-.macro ANNOTATE_UNREACHABLE counter:req
-.endm
-
-.macro ANNOTATE_REACHABLE counter:req
-.endm
-
-.macro ASM_UNREACHABLE
-.endm
-#endif /* CONFIG_STACK_VALIDATION */
-
-#endif /* LINKER_SCRIPT */
-#endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
 
 /* Compile time object size, -1 for unknown */
-- 
2.7.4
