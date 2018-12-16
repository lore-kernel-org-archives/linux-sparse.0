From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2] x86, kbuild: revert macrofying inline assembly code
Date: Sun, 16 Dec 2018 11:50:32 +0900
Message-ID: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Richard Biener <rguenther@suse.de>, Masahiro Yamada <yamada.masahiro@socionext.com>, Nadav Amit <namit@vmware.com>, Segher Boessenkool <segher@kernel.crashing.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Michal Marek <michal.lkml@markovi.net>, linux-sparse@vger.kernel.org, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, linux-kbuild@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Revert the following 9 commits:

[1] 5bdcd510c2ac ("x86/jump-labels: Macrofy inline assembly code to
    work around GCC inlining bugs")

    This was partially reverted because it made good cleanups
    irrespective of the inlining issue; the error message is still
    unneeded, and the conversion to STATIC_BRANCH_{NOP,JUMP} should
    be kept.

[2] d5a581d84ae6 ("x86/cpufeature: Macrofy inline assembly code to
    work around GCC inlining bugs")

[3] 0474d5d9d2f7 ("x86/extable: Macrofy inline assembly code to work
    around GCC inlining bugs")

[4] 494b5168f2de ("x86/paravirt: Work around GCC inlining bugs when
    compiling paravirt ops")

[5] f81f8ad56fd1 ("x86/bug: Macrofy the BUG table section handling,
    to work around GCC inlining bugs")

[6] 77f48ec28e4c ("x86/alternatives: Macrofy lock prefixes to work
   around GCC inlining bugs")

[7] 9e1725b41059 ("x86/refcount: Work around GCC inlining bug")

    Resolved conflicts in arch/x86/include/asm/refcount.h caused by
    288e4521f0f6 ("x86/asm: 'Simplify' GEN_*_RMWcc() macros").

[8] c06c4d809051 ("x86/objtool: Use asm macros to work around GCC
    inlining bugs")

[9] 77b0bf55bc67 ("kbuild/Makefile: Prepare for using macros in inline
    assembly code to work around asm() related GCC inlining bugs")

A few days after those commits applied, discussion started to solve
the issue more elegantly with the help of compiler:

  https://lkml.org/lkml/2018/10/7/92

The new syntax "asm inline" was implemented by Segher Boessenkool, and
now queued up for GCC 9. (People were positive even for back-porting it
to older compilers).

Since the in-kernel workarounds merged, some issues have been reported:
breakage of building with distcc/icecc, breakage of distro packages for
module building. (More fundamentally, we cannot build external modules
after 'make clean'.)

I do not want to mess up the build system any more.

Given that this issue will be solved in a cleaner way sooner or later,
let's revert the in-kernel workarounds, and wait for GCC 9.

Reported-by: Logan Gunthorpe <logang@deltatee.com> # distcc
Reported-by: Sedat Dilek <sedat.dilek@gmail.com> # deb/rpm package
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
---

Please consider this for v4.20 release.
Currently, distro package build is broken.


Changes in v2:
  - Revive clean-ups made by 5bdcd510c2ac (per Peter Zijlstra)
  - Fix commit quoting style (per Peter Zijlstra)

 Makefile                               |  9 +---
 arch/x86/Makefile                      |  7 ---
 arch/x86/include/asm/alternative-asm.h | 20 +++----
 arch/x86/include/asm/alternative.h     | 11 +++-
 arch/x86/include/asm/asm.h             | 53 +++++++++++-------
 arch/x86/include/asm/bug.h             | 98 +++++++++++++++-------------------
 arch/x86/include/asm/cpufeature.h      | 82 ++++++++++++----------------
 arch/x86/include/asm/jump_label.h      | 22 ++++++--
 arch/x86/include/asm/paravirt_types.h  | 56 +++++++++----------
 arch/x86/include/asm/refcount.h        | 81 ++++++++++++----------------
 arch/x86/kernel/macros.S               | 16 ------
 include/asm-generic/bug.h              |  8 +--
 include/linux/compiler.h               | 56 +++++--------------
 scripts/Kbuild.include                 |  4 +-
 scripts/mod/Makefile                   |  2 -
 15 files changed, 224 insertions(+), 301 deletions(-)
 delete mode 100644 arch/x86/kernel/macros.S

diff --git a/Makefile b/Makefile
index f2c3423..4cf4c5b 100644
--- a/Makefile
+++ b/Makefile
@@ -1081,7 +1081,7 @@ scripts: scripts_basic scripts_dtc asm-generic gcc-plugins $(autoksyms_h)
 # version.h and scripts_basic is processed / created.
 
 # Listed in dependency order
-PHONY += prepare archprepare macroprepare prepare0 prepare1 prepare2 prepare3
+PHONY += prepare archprepare prepare0 prepare1 prepare2 prepare3
 
 # prepare3 is used to check if we are building in a separate output directory,
 # and if so do:
@@ -1104,9 +1104,7 @@ prepare2: prepare3 outputmakefile asm-generic
 prepare1: prepare2 $(version_h) $(autoksyms_h) include/generated/utsrelease.h
 	$(cmd_crmodverdir)
 
-macroprepare: prepare1 archmacros
-
-archprepare: archheaders archscripts macroprepare scripts_basic
+archprepare: archheaders archscripts prepare1 scripts_basic
 
 prepare0: archprepare gcc-plugins
 	$(Q)$(MAKE) $(build)=.
@@ -1174,9 +1172,6 @@ archheaders:
 PHONY += archscripts
 archscripts:
 
-PHONY += archmacros
-archmacros:
-
 PHONY += __headers
 __headers: $(version_h) scripts_basic uapi-asm-generic archheaders archscripts
 	$(Q)$(MAKE) $(build)=scripts build_unifdef
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 75ef499..85a66c4 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -232,13 +232,6 @@ archscripts: scripts_basic
 archheaders:
 	$(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all
 
-archmacros:
-	$(Q)$(MAKE) $(build)=arch/x86/kernel arch/x86/kernel/macros.s
-
-ASM_MACRO_FLAGS = -Wa,arch/x86/kernel/macros.s
-export ASM_MACRO_FLAGS
-KBUILD_CFLAGS += $(ASM_MACRO_FLAGS)
-
 ###
 # Kernel objects
 
diff --git a/arch/x86/include/asm/alternative-asm.h b/arch/x86/include/asm/alternative-asm.h
index 8e4ea39..31b627b 100644
--- a/arch/x86/include/asm/alternative-asm.h
+++ b/arch/x86/include/asm/alternative-asm.h
@@ -7,24 +7,16 @@
 #include <asm/asm.h>
 
 #ifdef CONFIG_SMP
-.macro LOCK_PREFIX_HERE
+	.macro LOCK_PREFIX
+672:	lock
 	.pushsection .smp_locks,"a"
 	.balign 4
-	.long 671f - .		# offset
+	.long 672b - .
 	.popsection
-671:
-.endm
-
-.macro LOCK_PREFIX insn:vararg
-	LOCK_PREFIX_HERE
-	lock \insn
-.endm
+	.endm
 #else
-.macro LOCK_PREFIX_HERE
-.endm
-
-.macro LOCK_PREFIX insn:vararg
-.endm
+	.macro LOCK_PREFIX
+	.endm
 #endif
 
 /*
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index d7faa16..4cd6a3b 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -31,8 +31,15 @@
  */
 
 #ifdef CONFIG_SMP
-#define LOCK_PREFIX_HERE "LOCK_PREFIX_HERE\n\t"
-#define LOCK_PREFIX "LOCK_PREFIX "
+#define LOCK_PREFIX_HERE \
+		".pushsection .smp_locks,\"a\"\n"	\
+		".balign 4\n"				\
+		".long 671f - .\n" /* offset */		\
+		".popsection\n"				\
+		"671:"
+
+#define LOCK_PREFIX LOCK_PREFIX_HERE "\n\tlock; "
+
 #else /* ! CONFIG_SMP */
 #define LOCK_PREFIX_HERE ""
 #define LOCK_PREFIX ""
diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 21b0867..6467757b 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -120,25 +120,12 @@
 /* Exception table entry */
 #ifdef __ASSEMBLY__
 # define _ASM_EXTABLE_HANDLE(from, to, handler)			\
-	ASM_EXTABLE_HANDLE from to handler
-
-.macro ASM_EXTABLE_HANDLE from:req to:req handler:req
-	.pushsection "__ex_table","a"
-	.balign 4
-	.long (\from) - .
-	.long (\to) - .
-	.long (\handler) - .
+	.pushsection "__ex_table","a" ;				\
+	.balign 4 ;						\
+	.long (from) - . ;					\
+	.long (to) - . ;					\
+	.long (handler) - . ;					\
 	.popsection
-.endm
-#else /* __ASSEMBLY__ */
-
-# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
-	"ASM_EXTABLE_HANDLE from=" #from " to=" #to		\
-	" handler=\"" #handler "\"\n\t"
-
-/* For C file, we already have NOKPROBE_SYMBOL macro */
-
-#endif /* __ASSEMBLY__ */
 
 # define _ASM_EXTABLE(from, to)					\
 	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
@@ -161,7 +148,6 @@
 	_ASM_PTR (entry);					\
 	.popsection
 
-#ifdef __ASSEMBLY__
 .macro ALIGN_DESTINATION
 	/* check for bad alignment of destination */
 	movl %edi,%ecx
@@ -185,7 +171,34 @@
 	_ASM_EXTABLE_UA(100b, 103b)
 	_ASM_EXTABLE_UA(101b, 103b)
 	.endm
-#endif /* __ASSEMBLY__ */
+
+#else
+# define _EXPAND_EXTABLE_HANDLE(x) #x
+# define _ASM_EXTABLE_HANDLE(from, to, handler)			\
+	" .pushsection \"__ex_table\",\"a\"\n"			\
+	" .balign 4\n"						\
+	" .long (" #from ") - .\n"				\
+	" .long (" #to ") - .\n"				\
+	" .long (" _EXPAND_EXTABLE_HANDLE(handler) ") - .\n"	\
+	" .popsection\n"
+
+# define _ASM_EXTABLE(from, to)					\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_default)
+
+# define _ASM_EXTABLE_UA(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_uaccess)
+
+# define _ASM_EXTABLE_FAULT(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_fault)
+
+# define _ASM_EXTABLE_EX(from, to)				\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_ext)
+
+# define _ASM_EXTABLE_REFCOUNT(from, to)			\
+	_ASM_EXTABLE_HANDLE(from, to, ex_handler_refcount)
+
+/* For C file, we already have NOKPROBE_SYMBOL macro */
+#endif
 
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index 5090035..6804d66 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -4,8 +4,6 @@
 
 #include <linux/stringify.h>
 
-#ifndef __ASSEMBLY__
-
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
  *
@@ -22,15 +20,53 @@
 
 #define LEN_UD2		2
 
+#ifdef CONFIG_GENERIC_BUG
+
+#ifdef CONFIG_X86_32
+# define __BUG_REL(val)	".long " __stringify(val)
+#else
+# define __BUG_REL(val)	".long " __stringify(val) " - 2b"
+#endif
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+
+#define _BUG_FLAGS(ins, flags)						\
+do {									\
+	asm volatile("1:\t" ins "\n"					\
+		     ".pushsection __bug_table,\"aw\"\n"		\
+		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
+		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
+		     "\t.word %c1"        "\t# bug_entry::line\n"	\
+		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
+		     "\t.org 2b+%c3\n"					\
+		     ".popsection"					\
+		     : : "i" (__FILE__), "i" (__LINE__),		\
+			 "i" (flags),					\
+			 "i" (sizeof(struct bug_entry)));		\
+} while (0)
+
+#else /* !CONFIG_DEBUG_BUGVERBOSE */
+
 #define _BUG_FLAGS(ins, flags)						\
 do {									\
-	asm volatile("ASM_BUG ins=\"" ins "\" file=%c0 line=%c1 "	\
-		     "flags=%c2 size=%c3"				\
-		     : : "i" (__FILE__), "i" (__LINE__),                \
-			 "i" (flags),                                   \
+	asm volatile("1:\t" ins "\n"					\
+		     ".pushsection __bug_table,\"aw\"\n"		\
+		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
+		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
+		     "\t.org 2b+%c1\n"					\
+		     ".popsection"					\
+		     : : "i" (flags),					\
 			 "i" (sizeof(struct bug_entry)));		\
 } while (0)
 
+#endif /* CONFIG_DEBUG_BUGVERBOSE */
+
+#else
+
+#define _BUG_FLAGS(ins, flags)  asm volatile(ins)
+
+#endif /* CONFIG_GENERIC_BUG */
+
 #define HAVE_ARCH_BUG
 #define BUG()							\
 do {								\
@@ -46,54 +82,4 @@ do {								\
 
 #include <asm-generic/bug.h>
 
-#else /* __ASSEMBLY__ */
-
-#ifdef CONFIG_GENERIC_BUG
-
-#ifdef CONFIG_X86_32
-.macro __BUG_REL val:req
-	.long \val
-.endm
-#else
-.macro __BUG_REL val:req
-	.long \val - 2b
-.endm
-#endif
-
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-
-.macro ASM_BUG ins:req file:req line:req flags:req size:req
-1:	\ins
-	.pushsection __bug_table,"aw"
-2:	__BUG_REL val=1b	# bug_entry::bug_addr
-	__BUG_REL val=\file	# bug_entry::file
-	.word \line		# bug_entry::line
-	.word \flags		# bug_entry::flags
-	.org 2b+\size
-	.popsection
-.endm
-
-#else /* !CONFIG_DEBUG_BUGVERBOSE */
-
-.macro ASM_BUG ins:req file:req line:req flags:req size:req
-1:	\ins
-	.pushsection __bug_table,"aw"
-2:	__BUG_REL val=1b	# bug_entry::bug_addr
-	.word \flags		# bug_entry::flags
-	.org 2b+\size
-	.popsection
-.endm
-
-#endif /* CONFIG_DEBUG_BUGVERBOSE */
-
-#else /* CONFIG_GENERIC_BUG */
-
-.macro ASM_BUG ins:req file:req line:req flags:req size:req
-	\ins
-.endm
-
-#endif /* CONFIG_GENERIC_BUG */
-
-#endif /* __ASSEMBLY__ */
-
 #endif /* _ASM_X86_BUG_H */
diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 7d44272..aced6c9 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -2,10 +2,10 @@
 #ifndef _ASM_X86_CPUFEATURE_H
 #define _ASM_X86_CPUFEATURE_H
 
-#ifdef __KERNEL__
-#ifndef __ASSEMBLY__
-
 #include <asm/processor.h>
+
+#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+
 #include <asm/asm.h>
 #include <linux/bitops.h>
 
@@ -161,10 +161,37 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
  */
 static __always_inline __pure bool _static_cpu_has(u16 bit)
 {
-	asm_volatile_goto("STATIC_CPU_HAS bitnum=%[bitnum] "
-			  "cap_byte=\"%[cap_byte]\" "
-			  "feature=%P[feature] t_yes=%l[t_yes] "
-			  "t_no=%l[t_no] always=%P[always]"
+	asm_volatile_goto("1: jmp 6f\n"
+		 "2:\n"
+		 ".skip -(((5f-4f) - (2b-1b)) > 0) * "
+			 "((5f-4f) - (2b-1b)),0x90\n"
+		 "3:\n"
+		 ".section .altinstructions,\"a\"\n"
+		 " .long 1b - .\n"		/* src offset */
+		 " .long 4f - .\n"		/* repl offset */
+		 " .word %P[always]\n"		/* always replace */
+		 " .byte 3b - 1b\n"		/* src len */
+		 " .byte 5f - 4f\n"		/* repl len */
+		 " .byte 3b - 2b\n"		/* pad len */
+		 ".previous\n"
+		 ".section .altinstr_replacement,\"ax\"\n"
+		 "4: jmp %l[t_no]\n"
+		 "5:\n"
+		 ".previous\n"
+		 ".section .altinstructions,\"a\"\n"
+		 " .long 1b - .\n"		/* src offset */
+		 " .long 0\n"			/* no replacement */
+		 " .word %P[feature]\n"		/* feature bit */
+		 " .byte 3b - 1b\n"		/* src len */
+		 " .byte 0\n"			/* repl len */
+		 " .byte 0\n"			/* pad len */
+		 ".previous\n"
+		 ".section .altinstr_aux,\"ax\"\n"
+		 "6:\n"
+		 " testb %[bitnum],%[cap_byte]\n"
+		 " jnz %l[t_yes]\n"
+		 " jmp %l[t_no]\n"
+		 ".previous\n"
 		 : : [feature]  "i" (bit),
 		     [always]   "i" (X86_FEATURE_ALWAYS),
 		     [bitnum]   "i" (1 << (bit & 7)),
@@ -199,44 +226,5 @@ static __always_inline __pure bool _static_cpu_has(u16 bit)
 #define CPU_FEATURE_TYPEVAL		boot_cpu_data.x86_vendor, boot_cpu_data.x86, \
 					boot_cpu_data.x86_model
 
-#else /* __ASSEMBLY__ */
-
-.macro STATIC_CPU_HAS bitnum:req cap_byte:req feature:req t_yes:req t_no:req always:req
-1:
-	jmp 6f
-2:
-	.skip -(((5f-4f) - (2b-1b)) > 0) * ((5f-4f) - (2b-1b)),0x90
-3:
-	.section .altinstructions,"a"
-	.long 1b - .		/* src offset */
-	.long 4f - .		/* repl offset */
-	.word \always		/* always replace */
-	.byte 3b - 1b		/* src len */
-	.byte 5f - 4f		/* repl len */
-	.byte 3b - 2b		/* pad len */
-	.previous
-	.section .altinstr_replacement,"ax"
-4:
-	jmp \t_no
-5:
-	.previous
-	.section .altinstructions,"a"
-	.long 1b - .		/* src offset */
-	.long 0			/* no replacement */
-	.word \feature		/* feature bit */
-	.byte 3b - 1b		/* src len */
-	.byte 0			/* repl len */
-	.byte 0			/* pad len */
-	.previous
-	.section .altinstr_aux,"ax"
-6:
-	testb \bitnum,\cap_byte
-	jnz \t_yes
-	jmp \t_no
-	.previous
-.endm
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* __KERNEL__ */
+#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
 #endif /* _ASM_X86_CPUFEATURE_H */
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index a5fb34f..cf88ebf 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -20,9 +20,15 @@
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("STATIC_BRANCH_NOP l_yes=\"%l[l_yes]\" key=\"%c0\" "
-			  "branch=\"%c1\""
-			: :  "i" (key), "i" (branch) : : l_yes);
+	asm_volatile_goto("1:"
+		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
+		".pushsection __jump_table,  \"aw\" \n\t"
+		_ASM_ALIGN "\n\t"
+		".long 1b - ., %l[l_yes] - . \n\t"
+		_ASM_PTR "%c0 + %c1 - .\n\t"
+		".popsection \n\t"
+		: :  "i" (key), "i" (branch) : : l_yes);
+
 	return false;
 l_yes:
 	return true;
@@ -30,8 +36,14 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("STATIC_BRANCH_JMP l_yes=\"%l[l_yes]\" key=\"%c0\" "
-			  "branch=\"%c1\""
+	asm_volatile_goto("1:"
+		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
+		"2:\n\t"
+		".pushsection __jump_table,  \"aw\" \n\t"
+		_ASM_ALIGN "\n\t"
+		".long 1b - ., %l[l_yes] - . \n\t"
+		_ASM_PTR "%c0 + %c1 - .\n\t"
+		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
 	return false;
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 26942ad..488c596 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -348,11 +348,23 @@ extern struct paravirt_patch_template pv_ops;
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
+/*
+ * Generate some code, and mark it as patchable by the
+ * apply_paravirt() alternate instruction patcher.
+ */
+#define _paravirt_alt(insn_string, type, clobber)	\
+	"771:\n\t" insn_string "\n" "772:\n"		\
+	".pushsection .parainstructions,\"a\"\n"	\
+	_ASM_ALIGN "\n"					\
+	_ASM_PTR " 771b\n"				\
+	"  .byte " type "\n"				\
+	"  .byte 772b-771b\n"				\
+	"  .short " clobber "\n"			\
+	".popsection\n"
+
 /* Generate patchable code, with the default asm parameters. */
-#define paravirt_call							\
-	"PARAVIRT_CALL type=\"%c[paravirt_typenum]\""			\
-	" clobber=\"%c[paravirt_clobber]\""				\
-	" pv_opptr=\"%c[paravirt_opptr]\";"
+#define paravirt_alt(insn_string)					\
+	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
 
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
@@ -373,6 +385,16 @@ unsigned native_patch(u8 type, void *ibuf, unsigned long addr, unsigned len);
 int paravirt_disable_iospace(void);
 
 /*
+ * This generates an indirect call based on the operation type number.
+ * The type number, computed in PARAVIRT_PATCH, is derived from the
+ * offset into the paravirt_patch_template structure, and can therefore be
+ * freely converted back into a structure offset.
+ */
+#define PARAVIRT_CALL					\
+	ANNOTATE_RETPOLINE_SAFE				\
+	"call *%c[paravirt_opptr];"
+
+/*
  * These macros are intended to wrap calls through one of the paravirt
  * ops structs, so that they can be later identified and patched at
  * runtime.
@@ -509,7 +531,7 @@ int paravirt_disable_iospace(void);
 		/* since this condition will never hold */		\
 		if (sizeof(rettype) > sizeof(unsigned long)) {		\
 			asm volatile(pre				\
-				     paravirt_call			\
+				     paravirt_alt(PARAVIRT_CALL)	\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -519,7 +541,7 @@ int paravirt_disable_iospace(void);
 			__ret = (rettype)((((u64)__edx) << 32) | __eax); \
 		} else {						\
 			asm volatile(pre				\
-				     paravirt_call			\
+				     paravirt_alt(PARAVIRT_CALL)	\
 				     post				\
 				     : call_clbr, ASM_CALL_CONSTRAINT	\
 				     : paravirt_type(op),		\
@@ -546,7 +568,7 @@ int paravirt_disable_iospace(void);
 		PVOP_VCALL_ARGS;					\
 		PVOP_TEST_NULL(op);					\
 		asm volatile(pre					\
-			     paravirt_call				\
+			     paravirt_alt(PARAVIRT_CALL)		\
 			     post					\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
@@ -664,26 +686,6 @@ struct paravirt_patch_site {
 extern struct paravirt_patch_site __parainstructions[],
 	__parainstructions_end[];
 
-#else	/* __ASSEMBLY__ */
-
-/*
- * This generates an indirect call based on the operation type number.
- * The type number, computed in PARAVIRT_PATCH, is derived from the
- * offset into the paravirt_patch_template structure, and can therefore be
- * freely converted back into a structure offset.
- */
-.macro PARAVIRT_CALL type:req clobber:req pv_opptr:req
-771:	ANNOTATE_RETPOLINE_SAFE
-	call *\pv_opptr
-772:	.pushsection .parainstructions,"a"
-	_ASM_ALIGN
-	_ASM_PTR 771b
-	.byte \type
-	.byte 772b-771b
-	.short \clobber
-	.popsection
-.endm
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* _ASM_X86_PARAVIRT_TYPES_H */
diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
index a8b5e1e..dbaed55 100644
--- a/arch/x86/include/asm/refcount.h
+++ b/arch/x86/include/asm/refcount.h
@@ -4,41 +4,6 @@
  * x86-specific implementation of refcount_t. Based on PAX_REFCOUNT from
  * PaX/grsecurity.
  */
-
-#ifdef __ASSEMBLY__
-
-#include <asm/asm.h>
-#include <asm/bug.h>
-
-.macro REFCOUNT_EXCEPTION counter:req
-	.pushsection .text..refcount
-111:	lea \counter, %_ASM_CX
-112:	ud2
-	ASM_UNREACHABLE
-	.popsection
-113:	_ASM_EXTABLE_REFCOUNT(112b, 113b)
-.endm
-
-/* Trigger refcount exception if refcount result is negative. */
-.macro REFCOUNT_CHECK_LT_ZERO counter:req
-	js 111f
-	REFCOUNT_EXCEPTION counter="\counter"
-.endm
-
-/* Trigger refcount exception if refcount result is zero or negative. */
-.macro REFCOUNT_CHECK_LE_ZERO counter:req
-	jz 111f
-	REFCOUNT_CHECK_LT_ZERO counter="\counter"
-.endm
-
-/* Trigger refcount exception unconditionally. */
-.macro REFCOUNT_ERROR counter:req
-	jmp 111f
-	REFCOUNT_EXCEPTION counter="\counter"
-.endm
-
-#else /* __ASSEMBLY__ */
-
 #include <linux/refcount.h>
 #include <asm/bug.h>
 
@@ -50,12 +15,35 @@
  * central refcount exception. The fixup address for the exception points
  * back to the regular execution flow in .text.
  */
+#define _REFCOUNT_EXCEPTION				\
+	".pushsection .text..refcount\n"		\
+	"111:\tlea %[var], %%" _ASM_CX "\n"		\
+	"112:\t" ASM_UD2 "\n"				\
+	ASM_UNREACHABLE					\
+	".popsection\n"					\
+	"113:\n"					\
+	_ASM_EXTABLE_REFCOUNT(112b, 113b)
+
+/* Trigger refcount exception if refcount result is negative. */
+#define REFCOUNT_CHECK_LT_ZERO				\
+	"js 111f\n\t"					\
+	_REFCOUNT_EXCEPTION
+
+/* Trigger refcount exception if refcount result is zero or negative. */
+#define REFCOUNT_CHECK_LE_ZERO				\
+	"jz 111f\n\t"					\
+	REFCOUNT_CHECK_LT_ZERO
+
+/* Trigger refcount exception unconditionally. */
+#define REFCOUNT_ERROR					\
+	"jmp 111f\n\t"					\
+	_REFCOUNT_EXCEPTION
 
 static __always_inline void refcount_add(unsigned int i, refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "addl %1,%0\n\t"
-		"REFCOUNT_CHECK_LT_ZERO counter=\"%[counter]\""
-		: [counter] "+m" (r->refs.counter)
+		REFCOUNT_CHECK_LT_ZERO
+		: [var] "+m" (r->refs.counter)
 		: "ir" (i)
 		: "cc", "cx");
 }
@@ -63,32 +51,31 @@ static __always_inline void refcount_add(unsigned int i, refcount_t *r)
 static __always_inline void refcount_inc(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "incl %0\n\t"
-		"REFCOUNT_CHECK_LT_ZERO counter=\"%[counter]\""
-		: [counter] "+m" (r->refs.counter)
+		REFCOUNT_CHECK_LT_ZERO
+		: [var] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
 
 static __always_inline void refcount_dec(refcount_t *r)
 {
 	asm volatile(LOCK_PREFIX "decl %0\n\t"
-		"REFCOUNT_CHECK_LE_ZERO counter=\"%[counter]\""
-		: [counter] "+m" (r->refs.counter)
+		REFCOUNT_CHECK_LE_ZERO
+		: [var] "+m" (r->refs.counter)
 		: : "cc", "cx");
 }
 
 static __always_inline __must_check
 bool refcount_sub_and_test(unsigned int i, refcount_t *r)
 {
-
 	return GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
-					 "REFCOUNT_CHECK_LT_ZERO counter=\"%[var]\"",
+					 REFCOUNT_CHECK_LT_ZERO,
 					 r->refs.counter, e, "er", i, "cx");
 }
 
 static __always_inline __must_check bool refcount_dec_and_test(refcount_t *r)
 {
 	return GEN_UNARY_SUFFIXED_RMWcc(LOCK_PREFIX "decl",
-					"REFCOUNT_CHECK_LT_ZERO counter=\"%[var]\"",
+					REFCOUNT_CHECK_LT_ZERO,
 					r->refs.counter, e, "cx");
 }
 
@@ -106,8 +93,8 @@ bool refcount_add_not_zero(unsigned int i, refcount_t *r)
 
 		/* Did we try to increment from/to an undesirable state? */
 		if (unlikely(c < 0 || c == INT_MAX || result < c)) {
-			asm volatile("REFCOUNT_ERROR counter=\"%[counter]\""
-				     : : [counter] "m" (r->refs.counter)
+			asm volatile(REFCOUNT_ERROR
+				     : : [var] "m" (r->refs.counter)
 				     : "cc", "cx");
 			break;
 		}
@@ -122,6 +109,4 @@ static __always_inline __must_check bool refcount_inc_not_zero(refcount_t *r)
 	return refcount_add_not_zero(1, r);
 }
 
-#endif /* __ASSEMBLY__ */
-
 #endif
diff --git a/arch/x86/kernel/macros.S b/arch/x86/kernel/macros.S
deleted file mode 100644
index 161c950..0000000
--- a/arch/x86/kernel/macros.S
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-/*
- * This file includes headers whose assembly part includes macros which are
- * commonly used. The macros are precompiled into assmebly file which is later
- * assembled together with each compiled file.
- */
-
-#include <linux/compiler.h>
-#include <asm/refcount.h>
-#include <asm/alternative-asm.h>
-#include <asm/bug.h>
-#include <asm/paravirt.h>
-#include <asm/asm.h>
-#include <asm/cpufeature.h>
-#include <asm/jump_label.h>
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index cdafa5e..20561a6 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -17,8 +17,10 @@
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 
-struct bug_entry {
+#ifdef CONFIG_BUG
+
 #ifdef CONFIG_GENERIC_BUG
+struct bug_entry {
 #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
 	unsigned long	bug_addr;
 #else
@@ -33,10 +35,8 @@ struct bug_entry {
 	unsigned short	line;
 #endif
 	unsigned short	flags;
-#endif	/* CONFIG_GENERIC_BUG */
 };
-
-#ifdef CONFIG_BUG
+#endif	/* CONFIG_GENERIC_BUG */
 
 /*
  * Don't use BUG() or BUG_ON() unless there's really no way out; one
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
diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index bb01555..3d09844 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -115,9 +115,7 @@ __cc-option = $(call try-run,\
 
 # Do not attempt to build with gcc plugins during cc-option tests.
 # (And this uses delayed resolution so the flags will be up to date.)
-# In addition, do not include the asm macros which are built later.
-CC_OPTION_FILTERED = $(GCC_PLUGINS_CFLAGS) $(ASM_MACRO_FLAGS)
-CC_OPTION_CFLAGS = $(filter-out $(CC_OPTION_FILTERED),$(KBUILD_CFLAGS))
+CC_OPTION_CFLAGS = $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS))
 
 # cc-option
 # Usage: cflags-y += $(call cc-option,-march=winchip-c6,-march=i586)
diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index a5b4af4..42c5d50 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -4,8 +4,6 @@ OBJECT_FILES_NON_STANDARD := y
 hostprogs-y	:= modpost mk_elfconfig
 always		:= $(hostprogs-y) empty.o
 
-CFLAGS_REMOVE_empty.o := $(ASM_MACRO_FLAGS)
-
 modpost-objs	:= modpost.o file2alias.o sumversion.o
 
 devicetable-offsets-file := devicetable-offsets.h
-- 
2.7.4
