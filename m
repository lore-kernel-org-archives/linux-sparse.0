From: Torsten Duwe <duwe@lst.de>
Subject: [PATCH v3 1/2] arm64: implement FTRACE_WITH_REGS
Date: Thu, 11 Aug 2016 18:36:35 +0200 (CEST)
Message-ID: <20160811163635.277C868C43@newverein.lst.de>
References: <20160811163451.D455C68C43@newverein.lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160811163451.D455C68C43@newverein.lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, takahiro.akashi@linaro.org, Jungseok Lee <jungseoklee85@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Li Bin <huawei.libin@huawei.com>
Cc: linux-arch@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org, andrew.wafaa@arm.com, linux-sparse@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, live-patching@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

Once gcc is enhanced to optionally generate NOPs at the beginning
of each function, like the concept proven in
https://gcc.gnu.org/ml/gcc-patches/2016-04/msg01671.html
(sans the "fprintf (... pad_size);", which spoils the data structure
for kernel use), the generated pads can nicely be used to reroute
function calls for tracing/profiling, or live patching.

The pads look like
fffffc00081335f0 <hrtimer_init>:
fffffc00081335f0:       d503201f        nop
fffffc00081335f4:       d503201f        nop
fffffc00081335f8:       a9bd7bfd        stp     x29, x30, [sp,#-48]!
fffffc00081335fc:       910003fd        mov     x29, sp
[...]

This patch gets the pad locations from the compiler-generated
__prolog_pads_loc into the _mcount_loc array, and provides the
code patching functions to turn the pads at runtime into

fffffc00081335f0     mov     x9, x30
fffffc00081335f4     bl      0xfffffc00080a08c0 <ftrace_caller>
fffffc00081335f8     stp     x29, x30, [sp,#-48]!
fffffc00081335fc     mov     x29, sp

as well as an ftrace_caller that can handle these call sites.
Now ARCH_SUPPORTS_FTRACE_OPS as a benefit, and the graph caller
still works, too.

Signed-off-by: Li Bin <huawei.libin@huawei.com>
Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/arm64/Kconfig                |  1 +
 arch/arm64/Makefile               |  9 ++++
 arch/arm64/include/asm/ftrace.h   |  8 ++++
 arch/arm64/kernel/Makefile        |  6 +--
 arch/arm64/kernel/entry-ftrace.S  | 89 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ftrace.c        | 45 ++++++++++++++++++--
 include/asm-generic/vmlinux.lds.h |  2 +-
 include/linux/compiler.h          |  4 ++
 8 files changed, 156 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5a0a691..36a0e26 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -72,6 +72,7 @@ config ARM64
 	select HAVE_DMA_API_DEBUG
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 648a32c..4a86955 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -55,6 +55,15 @@ ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
 KBUILD_LDFLAGS_MODULE	+= -T $(srctree)/arch/arm64/kernel/module.lds
 endif
 
+ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+  CC_FLAGS_FTRACE := -fprolog-pad=2
+  KBUILD_CPPFLAGS += -DCC_USING_PROLOG_PAD
+  ifeq ($(call cc-option,-fprolog-pad=2),)
+    $(warning Cannot use CONFIG_DYNAMIC_FTRACE_WITH_REGS: \
+             -fprolog-pad not supported by compiler)
+  endif
+endif
+
 # Default value
 head-y		:= arch/arm64/kernel/head.o
 
diff --git a/arch/arm64/include/asm/ftrace.h b/arch/arm64/include/asm/ftrace.h
index caa955f..a569666 100644
--- a/arch/arm64/include/asm/ftrace.h
+++ b/arch/arm64/include/asm/ftrace.h
@@ -16,6 +16,14 @@
 #define MCOUNT_ADDR		((unsigned long)_mcount)
 #define MCOUNT_INSN_SIZE	AARCH64_INSN_SIZE
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+#define ARCH_SUPPORTS_FTRACE_OPS 1
+#define REC_IP_BRANCH_OFFSET 4
+#define FTRACE_REGS_ADDR FTRACE_ADDR
+#else
+#define REC_IP_BRANCH_OFFSET 0
+#endif
+
 #ifndef __ASSEMBLY__
 #include <linux/compat.h>
 
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 2173149..c26f3f8 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -6,9 +6,9 @@ CPPFLAGS_vmlinux.lds	:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 AFLAGS_head.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
 CFLAGS_armv8_deprecated.o := -I$(src)
 
-CFLAGS_REMOVE_ftrace.o = -pg
-CFLAGS_REMOVE_insn.o = -pg
-CFLAGS_REMOVE_return_address.o = -pg
+CFLAGS_REMOVE_ftrace.o = -pg $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_insn.o = -pg $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_return_address.o = -pg $(CC_FLAGS_FTRACE)
 
 # Object file lists.
 arm64-obj-y		:= debug-monitors.o entry.o irq.o fpsimd.o		\
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 0f03a8f..3ebe791 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -12,6 +12,8 @@
 #include <linux/linkage.h>
 #include <asm/ftrace.h>
 #include <asm/insn.h>
+#include <asm/asm-offsets.h>
+#include <asm/assembler.h>
 
 /*
  * Gcc with -pg will put the following code in the beginning of each function:
@@ -132,6 +134,7 @@ skip_ftrace_call:
 ENDPROC(_mcount)
 
 #else /* CONFIG_DYNAMIC_FTRACE */
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 /*
  * _mcount() is used to build the kernel with -pg option, but all the branch
  * instructions to _mcount() are replaced to NOP initially at kernel start up,
@@ -171,6 +174,84 @@ ftrace_graph_call:			// ftrace_graph_caller();
 
 	mcount_exit
 ENDPROC(ftrace_caller)
+#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
+ENTRY(_mcount)
+	mov     x10, lr
+	mov     lr, x9
+	ret     x10
+ENDPROC(_mcount)
+
+ENTRY(ftrace_caller)
+	stp	x29, x9, [sp, #-16]!
+	sub	sp, sp, #S_FRAME_SIZE
+
+	stp	x0, x1, [sp]
+	stp	x2, x3, [sp, #16]
+	stp	x4, x5, [sp, #32]
+	stp	x6, x7, [sp, #48]
+	stp	x8, x9, [sp, #64]
+	stp	x10, x11, [sp, #80]
+	stp	x12, x13, [sp, #96]
+	stp	x14, x15, [sp, #112]
+	stp	x16, x17, [sp, #128]
+	stp	x18, x19, [sp, #144]
+	stp	x20, x21, [sp, #160]
+	stp	x22, x23, [sp, #176]
+	stp	x24, x25, [sp, #192]
+	stp	x26, x27, [sp, #208]
+	stp	x28, x29, [sp, #224]
+	/* The link Register at callee entry */
+	str	x9, [sp, #S_LR]
+	/* The program counter just after the ftrace call site */
+	str	lr, [sp, #S_PC]
+	/* The stack pointer as it was on ftrace_caller entry... */
+	add	x29, sp, #S_FRAME_SIZE+16	/* ...is also our new FP */
+	str	x29, [sp, #S_SP]
+
+	adrp    x0, function_trace_op
+	ldr     x2, [x0, #:lo12:function_trace_op]
+	mov	x1, x9		/* saved LR == parent IP */
+	sub	x0, lr, #8	/* prolog pad start == IP */
+	mov	x3, sp		/* complete pt_regs are @sp */
+
+	.global ftrace_call
+ftrace_call:
+
+	bl	ftrace_stub
+
+#ifdef CONFIG_FUNCTION_GRAPH_TRACER
+	.global ftrace_graph_call
+ftrace_graph_call:			// ftrace_graph_caller();
+	nop				// If enabled, this will be replaced
+					// "b ftrace_graph_caller"
+#endif
+
+ftrace_regs_return:
+	ldp	x0, x1, [sp]
+	ldp	x2, x3, [sp, #16]
+	ldp	x4, x5, [sp, #32]
+	ldp	x6, x7, [sp, #48]
+	ldp	x8, x9, [sp, #64]
+	ldp	x10, x11, [sp, #80]
+	ldp	x12, x13, [sp, #96]
+	ldp	x14, x15, [sp, #112]
+	ldp	x16, x17, [sp, #128]
+	ldp	x18, x19, [sp, #144]
+	ldp	x20, x21, [sp, #160]
+	ldp	x22, x23, [sp, #176]
+	ldp	x24, x25, [sp, #192]
+	ldp	x26, x27, [sp, #208]
+	ldp	x28, x29, [sp, #224]
+
+	ldr	x9, [sp, #S_PC]
+	ldr	lr, [sp, #S_LR]
+	add	sp, sp, #S_FRAME_SIZE+16
+
+	ret	x9
+
+ENDPROC(ftrace_caller)
+
+#endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 ENTRY(ftrace_stub)
@@ -206,12 +287,20 @@ ENDPROC(ftrace_stub)
  * and run return_to_handler() later on its exit.
  */
 ENTRY(ftrace_graph_caller)
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 	mcount_get_lr_addr	  x0	//     pointer to function's saved lr
 	mcount_get_pc		  x1	//     function's pc
 	mcount_get_parent_fp	  x2	//     parent's fp
 	bl	prepare_ftrace_return	// prepare_ftrace_return(&lr, pc, fp)
 
 	mcount_exit
+#else
+	add	x0, sp, #S_LR	/* address of (LR pointing into caller) */
+	ldr	x1, [sp, #S_PC]
+	ldr	x2, [sp, #232]	/* caller's frame pointer */
+	bl	prepare_ftrace_return
+	b	ftrace_regs_return
+#endif
 ENDPROC(ftrace_graph_caller)
 
 /*
diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index ebecf9a..5b9843d 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -68,28 +68,65 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
  */
 int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 {
-	unsigned long pc = rec->ip;
+	unsigned long pc = rec->ip+REC_IP_BRANCH_OFFSET;
+	int ret;
 	u32 old, new;
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 	old = aarch64_insn_gen_nop();
+	new = 0xaa1e03e9;	/* mov x9,x30 */
+	ret = ftrace_modify_code(pc-REC_IP_BRANCH_OFFSET, old, new, true);
+	if (ret)
+		return ret;
+	smp_wmb();
+#endif
 	new = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
 
 	return ftrace_modify_code(pc, old, new, true);
 }
 
+int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
+		unsigned long addr)
+{
+	unsigned long pc = rec->ip+REC_IP_BRANCH_OFFSET;
+	u32 old, new;
+
+	old = aarch64_insn_gen_branch_imm(pc, old_addr, true);
+	new = aarch64_insn_gen_branch_imm(pc, addr, true);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
 /*
  * Turn off the call to ftrace_caller() in instrumented function
  */
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 		    unsigned long addr)
 {
-	unsigned long pc = rec->ip;
+	unsigned long pc = rec->ip+REC_IP_BRANCH_OFFSET;
 	u32 old, new;
-
+	int ret;
+
+#ifdef CC_USING_PROLOG_PAD
+	/* -fprolog-pad= does not generate a profiling call
+	   initially; the NOPs are already there.
+	*/
+	if (addr == MCOUNT_ADDR)
+		return 0;
+#endif
 	old = aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
 	new = aarch64_insn_gen_nop();
 
-	return ftrace_modify_code(pc, old, new, true);
+	ret = ftrace_modify_code(pc, old, new, true);
+	if (ret)
+		return ret;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
+	smp_wmb();
+	old = 0xaa1e03e9;	/* mov x9,x30 */
+	new = aarch64_insn_gen_nop();
+	ret = ftrace_modify_code(pc-REC_IP_BRANCH_OFFSET, old, new, true);
+#endif
+	return ret;
 }
 
 void arch_ftrace_update_code(int command)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 081d0f2..62cd714 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -89,7 +89,7 @@
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 #define MCOUNT_REC()	. = ALIGN(8);				\
 			VMLINUX_SYMBOL(__start_mcount_loc) = .; \
-			*(__mcount_loc)				\
+			*(__mcount_loc) *(__prolog_pads_loc)	\
 			VMLINUX_SYMBOL(__stop_mcount_loc) = .;
 #else
 #define MCOUNT_REC()
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 793c082..46289c2 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -63,8 +63,12 @@ extern void __chk_io_ptr(const volatile void __iomem *);
 #if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
 #define notrace __attribute__((hotpatch(0,0)))
 #else
+#ifdef CC_USING_PROLOG_PAD
+#define notrace __attribute__((prolog_pad(0)))
+#else
 #define notrace __attribute__((no_instrument_function))
 #endif
+#endif
 
 /* Intel compiler defines __GNUC__. So we will overwrite implementations
  * coming from above header files here
-- 
2.6.2
