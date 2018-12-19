From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 00/12] x86, kbuild: revert macrofying inline assembly
 code
Date: Wed, 19 Dec 2018 12:20:28 +0100
Message-ID: <20181219112028.GA38175@gmail.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Richard Biener <rguenther@suse.de>, Segher Boessenkool <segher@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, virtualization@lists.linux-foundation.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alok Kataria <akataria@vmware.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jann Horn <jannh@google.com>, linux-arch@vger.kernel.org, Alexey Dobriyan <adobriy>
List-Id: linux-sparse@vger.kernel.org


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> This series reverts the in-kernel workarounds for inlining issues.
> 
> The commit description of 77b0bf55bc67 mentioned
> "We also hope that GCC will eventually get fixed,..."
> 
> Now, GCC provides a solution.
> 
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html
> explains the new "asm inline" syntax.
> 
> The performance issue will be eventually solved.
> 
> [About Code cleanups]
> 
> I know Nadam Amit is opposed to the full revert.
> He also claims his motivation for macrofying was not only
> performance, but also cleanups.
> 
> IIUC, the criticism addresses the code duplication between C and ASM.
> 
> If so, I'd like to suggest a different approach for cleanups.
> Please see the last 3 patches.
> IMHO, preprocessor approach is more straight-forward, and readable.
> Basically, this idea should work because it is what we already do for
> __ASM_FORM() etc.
> 
> [Quick Test of "asm inline" of GCC 9]
> 
> If you want to try "asm inline" feature, the patch is available:
> https://lore.kernel.org/patchwork/patch/1024590/
> 
> The number of symbols for arch/x86/configs/x86_64_defconfig:
> 
>                             nr_symbols
>   [1]    v4.20-rc7       :   96502
>   [2]    [1]+full revert :   96705   (+203)
>   [3]    [2]+"asm inline":   96568   (-137)
> 
> [3]: apply my patch, then replace "asm" -> "asm_inline"
>     for _BUG_FLAGS(), refcount_add(), refcount_inc(), refcount_dec(),
>         annotate_reachable(), annotate_unreachable()
> 
> 
> Changes in v3:
>   - Split into per-commit revert (per Nadav Amit)
>   - Add some cleanups with preprocessor approach
> 
> Changes in v2:
>   - Revive clean-ups made by 5bdcd510c2ac (per Peter Zijlstra)
>   - Fix commit quoting style (per Peter Zijlstra)
> 
> Masahiro Yamada (12):
>   Revert "x86/jump-labels: Macrofy inline assembly code to work around
>     GCC inlining bugs"
>   Revert "x86/cpufeature: Macrofy inline assembly code to work around
>     GCC inlining bugs"
>   Revert "x86/extable: Macrofy inline assembly code to work around GCC
>     inlining bugs"
>   Revert "x86/paravirt: Work around GCC inlining bugs when compiling
>     paravirt ops"
>   Revert "x86/bug: Macrofy the BUG table section handling, to work
>     around GCC inlining bugs"
>   Revert "x86/alternatives: Macrofy lock prefixes to work around GCC
>     inlining bugs"
>   Revert "x86/refcount: Work around GCC inlining bug"
>   Revert "x86/objtool: Use asm macros to work around GCC inlining bugs"
>   Revert "kbuild/Makefile: Prepare for using macros in inline assembly
>     code to work around asm() related GCC inlining bugs"
>   linux/linkage: add ASM() macro to reduce duplication between C/ASM
>     code
>   x86/alternatives: consolidate LOCK_PREFIX macro
>   x86/asm: consolidate ASM_EXTABLE_* macros
> 
>  Makefile                                  |  9 +--
>  arch/x86/Makefile                         |  7 ---
>  arch/x86/include/asm/alternative-asm.h    | 22 +------
>  arch/x86/include/asm/alternative-common.h | 47 +++++++++++++++
>  arch/x86/include/asm/alternative.h        | 30 +---------
>  arch/x86/include/asm/asm.h                | 46 +++++----------
>  arch/x86/include/asm/bug.h                | 98 +++++++++++++------------------
>  arch/x86/include/asm/cpufeature.h         | 82 +++++++++++---------------
>  arch/x86/include/asm/jump_label.h         | 22 +++++--
>  arch/x86/include/asm/paravirt_types.h     | 56 +++++++++---------
>  arch/x86/include/asm/refcount.h           | 81 +++++++++++--------------
>  arch/x86/kernel/macros.S                  | 16 -----
>  include/asm-generic/bug.h                 |  8 +--
>  include/linux/compiler.h                  | 56 ++++--------------
>  include/linux/linkage.h                   |  8 +++
>  scripts/Kbuild.include                    |  4 +-
>  scripts/mod/Makefile                      |  2 -
>  17 files changed, 249 insertions(+), 345 deletions(-)
>  create mode 100644 arch/x86/include/asm/alternative-common.h
>  delete mode 100644 arch/x86/kernel/macros.S

I absolutely agree that this needs to be resolved in v4.20.

So I did the 1-9 reverts manually myself as well, because I think the 
first commit should be reverted fully to get as close to the starting 
point as possible (we are late in the cycle) - and came to the attached 
interdiff between your series and mine.

Does this approach look OK to you, or did I miss something?

Thanks,

	Ingo

=============>

 entry/calling.h          |    2 -
 include/asm/jump_label.h |   50 ++++++++++++++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 25e5a6bda8c3..20d0885b00fb 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -352,7 +352,7 @@ For 32-bit we have the following conventions - kernel is built with
 .macro CALL_enter_from_user_mode
 #ifdef CONFIG_CONTEXT_TRACKING
 #ifdef HAVE_JUMP_LABEL
-	STATIC_BRANCH_JMP l_yes=.Lafter_call_\@, key=context_tracking_enabled, branch=1
+	STATIC_JUMP_IF_FALSE .Lafter_call_\@, context_tracking_enabled, def=0
 #endif
 	call enter_from_user_mode
 .Lafter_call_\@:
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index cf88ebf9a4ca..21efc9d07ed9 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -2,6 +2,19 @@
 #ifndef _ASM_X86_JUMP_LABEL_H
 #define _ASM_X86_JUMP_LABEL_H
 
+#ifndef HAVE_JUMP_LABEL
+/*
+ * For better or for worse, if jump labels (the gcc extension) are missing,
+ * then the entire static branch patching infrastructure is compiled out.
+ * If that happens, the code in here will malfunction.  Raise a compiler
+ * error instead.
+ *
+ * In theory, jump labels and the static branch patching infrastructure
+ * could be decoupled to fix this.
+ */
+#error asm/jump_label.h included on a non-jump-label kernel
+#endif
+
 #define JUMP_LABEL_NOP_SIZE 5
 
 #ifdef CONFIG_X86_64
@@ -53,26 +66,37 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 
 #else	/* __ASSEMBLY__ */
 
-.macro STATIC_BRANCH_NOP l_yes:req key:req branch:req
-.Lstatic_branch_nop_\@:
-	.byte STATIC_KEY_INIT_NOP
-.Lstatic_branch_no_after_\@:
+.macro STATIC_JUMP_IF_TRUE target, key, def
+.Lstatic_jump_\@:
+	.if \def
+	/* Equivalent to "jmp.d32 \target" */
+	.byte		0xe9
+	.long		\target - .Lstatic_jump_after_\@
+.Lstatic_jump_after_\@:
+	.else
+	.byte		STATIC_KEY_INIT_NOP
+	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	.long		.Lstatic_branch_nop_\@ - ., \l_yes - .
-	_ASM_PTR        \key + \branch - .
+	.long		.Lstatic_jump_\@ - ., \target - .
+	_ASM_PTR	\key - .
 	.popsection
 .endm
 
-.macro STATIC_BRANCH_JMP l_yes:req key:req branch:req
-.Lstatic_branch_jmp_\@:
-	.byte 0xe9
-	.long \l_yes - .Lstatic_branch_jmp_after_\@
-.Lstatic_branch_jmp_after_\@:
+.macro STATIC_JUMP_IF_FALSE target, key, def
+.Lstatic_jump_\@:
+	.if \def
+	.byte		STATIC_KEY_INIT_NOP
+	.else
+	/* Equivalent to "jmp.d32 \target" */
+	.byte		0xe9
+	.long		\target - .Lstatic_jump_after_\@
+.Lstatic_jump_after_\@:
+	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	.long		.Lstatic_branch_jmp_\@ - ., \l_yes - .
-	_ASM_PTR	\key + \branch - .
+	.long		.Lstatic_jump_\@ - ., \target - .
+	_ASM_PTR	\key + 1 - .
 	.popsection
 .endm
 
