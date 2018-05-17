From: Nadav Amit <namit@vmware.com>
Subject: [PATCH 1/6] x86: objtool: use asm macro for better compiler decisions
Date: Thu, 17 May 2018 09:13:57 -0700
Message-ID: <20180517161402.78089-2-namit@vmware.com>
References: <20180517161402.78089-1-namit@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517161402.78089-1-namit@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: nadav.amit@gmail.com, Nadav Amit <namit@vmware.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

GCC considers the number of statements in inlined assembly blocks,
according to new-lines and semicolons, as an indication to the cost of
the block in time and space. This data is distorted by the kernel code,
which puts information in alternative sections. As a result, the
compiler may perform incorrect inlining and branch optimizations.

In the case of objtool, this distortion is extreme, since anyhow the
annotations of objtool are discarded during linkage.

The solution is to set an assembly macro and call it from the inlinedv
assembly block. As a result GCC considers the inline assembly block as
a single instruction.

This patch slightly increases the kernel size.

   text    data     bss     dec     hex filename
18126699 10066728 2936832 31130259 1db0293 ./vmlinux before
18126824 10067268 2936832 31130924 1db052c ./vmlinux after (+665)

But allows more aggressive inlining. Static text symbols:
Before: 40033
After: 40015 (-18)

Cc: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Signed-off-by: Nadav Amit <namit@vmware.com>
---
 include/linux/compiler.h | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ab4711c63601..6cbabc6b195a 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -97,19 +97,40 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
  * These macros help objtool understand GCC code flow for unreachable code.
  * The __COUNTER__ based labels are a hack to make each instance of the macros
  * unique, to convince GCC not to merge duplicate inline asm statements.
+ *
+ * The annotation logic is encapsulated within assembly macros, which are then
+ * called on each annotation. This hack is necessary to prevent GCC from
+ * considering the inline assembly blocks as costly in time and space, which can
+ * prevent function inlining and lead to other bad compilation decisions. GCC
+ * computes inline assembly cost according to the number of perceived number of
+ * assembly instruction, based on the number of new-lines and semicolons in the
+ * assembly block. Since the annotations will be discarded during linkage, the
+ * macros make the annotations to be considered "cheap" and let GCC to emit
+ * better code.
  */
+asm(".macro __annotate_reachable counter:req\n"
+    "\\counter:\n\t"
+    ".pushsection .discard.reachable\n\t"
+    ".long \\counter\\()b -.\n\t"
+    ".popsection\n\t"
+    ".endm");
+
 #define annotate_reachable() ({						\
-	asm volatile("%c0:\n\t"						\
-		     ".pushsection .discard.reachable\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+	asm volatile("__annotate_reachable %c0" : : "i" (__COUNTER__));	\
 })
+
+asm(".macro __annotate_unreachable counter:req\n"
+    "\\counter:\n\t"
+    ".pushsection .discard.unreachable\n\t"
+    ".long \\counter\\()b -.\n\t"
+    ".popsection\n\t"
+    ".endm");
+
 #define annotate_unreachable() ({					\
-	asm volatile("%c0:\n\t"						\
-		     ".pushsection .discard.unreachable\n\t"		\
-		     ".long %c0b - .\n\t"				\
-		     ".popsection\n\t" : : "i" (__COUNTER__));		\
+	asm volatile("__annotate_unreachable %c0" : :			\
+		     "i" (__COUNTER__));				\
 })
+
 #define ASM_UNREACHABLE							\
 	"999:\n\t"							\
 	".pushsection .discard.unreachable\n\t"				\
-- 
2.17.0
