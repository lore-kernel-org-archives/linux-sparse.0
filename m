From: Torsten Duwe <duwe@lst.de>
Subject: [PATCH v3 2/2] arm64: implement live patching
Date: Thu, 11 Aug 2016 18:36:40 +0200 (CEST)
Message-ID: <20160811163640.4CE7F68C44@newverein.lst.de>
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

straightforward on top of FTRACE_WITH_REGS.

Signed-off-by: Torsten Duwe <duwe@suse.de>
---
 arch/arm64/Kconfig                 |  3 +++
 arch/arm64/include/asm/livepatch.h | 37 +++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/entry-ftrace.S   | 13 +++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100644 arch/arm64/include/asm/livepatch.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 36a0e26..3aae199 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -80,6 +80,7 @@ config ARM64
 	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_LIVEPATCH
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
 	select HAVE_PATA_PLATFORM
@@ -1042,4 +1043,6 @@ if CRYPTO
 source "arch/arm64/crypto/Kconfig"
 endif
 
+source "kernel/livepatch/Kconfig"
+
 source "lib/Kconfig"
diff --git a/arch/arm64/include/asm/livepatch.h b/arch/arm64/include/asm/livepatch.h
new file mode 100644
index 0000000..6b9a3d1
--- /dev/null
+++ b/arch/arm64/include/asm/livepatch.h
@@ -0,0 +1,37 @@
+/*
+ * livepatch.h - arm64-specific Kernel Live Patching Core
+ *
+ * Copyright (C) 2016 SUSE
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef _ASM_ARM64_LIVEPATCH_H
+#define _ASM_ARM64_LIVEPATCH_H
+
+#include <linux/module.h>
+#include <linux/ftrace.h>
+
+#ifdef CONFIG_LIVEPATCH
+static inline int klp_check_compiler_support(void)
+{
+	return 0;
+}
+
+static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+{
+	regs->pc = ip;
+}
+#endif /* CONFIG_LIVEPATCH */
+
+#endif /* _ASM_ARM64_LIVEPATCH_H */
diff --git a/arch/arm64/kernel/entry-ftrace.S b/arch/arm64/kernel/entry-ftrace.S
index 3ebe791..2108f0e 100644
--- a/arch/arm64/kernel/entry-ftrace.S
+++ b/arch/arm64/kernel/entry-ftrace.S
@@ -204,6 +204,9 @@ ENTRY(ftrace_caller)
 	str	x9, [sp, #S_LR]
 	/* The program counter just after the ftrace call site */
 	str	lr, [sp, #S_PC]
+#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
+	mov	x19,lr          /* remember old return address */
+#endif
 	/* The stack pointer as it was on ftrace_caller entry... */
 	add	x29, sp, #S_FRAME_SIZE+16	/* ...is also our new FP */
 	str	x29, [sp, #S_SP]
@@ -219,6 +222,16 @@ ftrace_call:
 
 	bl	ftrace_stub
 
+#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
+	/* Is the trace function a live patcher an has messed with
+	 * the return address?
+	*/
+	ldr	x9, [sp, #S_PC]
+	cmp	x9, x19		/* compare with the value we remembered */
+	/* to not call graph tracer's "call" mechanism twice! */
+	b.ne	ftrace_regs_return
+#endif
+
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	.global ftrace_graph_call
 ftrace_graph_call:			// ftrace_graph_caller();
-- 
2.6.2
