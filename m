From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 00/12] x86, kbuild: revert macrofying inline assembly code
Date: Tue, 18 Dec 2018 01:03:15 +0900
Message-ID: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Nadav Amit <namit@vmware.com>, Jan Beulich <JBeulich@suse.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, linux-sparse@vger.kernel.org, Yonghong Song <yhs@fb.com>, Alexey Dobriyan <adobriyan@gmail.com>, Kees Cook <keescook@chromium.org>, Segher Boessenkool <segher@kernel.crashing.org>, Jann Horn <jannh@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Alok Kataria <akataria@vmware.com>, Juergen Gross <jgross@suse.com>, Michal Marek <michal.lkml@markovi.net>, Richard Biener <rguenther@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-kernel@vger.kernel.org, David
List-Id: linux-sparse@vger.kernel.org

This series reverts the in-kernel workarounds for inlining issues.

The commit description of 77b0bf55bc67 mentioned
"We also hope that GCC will eventually get fixed,..."

Now, GCC provides a solution.

https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html
explains the new "asm inline" syntax.

The performance issue will be eventually solved.

[About Code cleanups]

I know Nadam Amit is opposed to the full revert.
He also claims his motivation for macrofying was not only
performance, but also cleanups.

IIUC, the criticism addresses the code duplication between C and ASM.

If so, I'd like to suggest a different approach for cleanups.
Please see the last 3 patches.
IMHO, preprocessor approach is more straight-forward, and readable.
Basically, this idea should work because it is what we already do for
__ASM_FORM() etc.

[Quick Test of "asm inline" of GCC 9]

If you want to try "asm inline" feature, the patch is available:
https://lore.kernel.org/patchwork/patch/1024590/

The number of symbols for arch/x86/configs/x86_64_defconfig:

                            nr_symbols
  [1]    v4.20-rc7       :   96502
  [2]    [1]+full revert :   96705   (+203)
  [3]    [2]+"asm inline":   96568   (-137)

[3]: apply my patch, then replace "asm" -> "asm_inline"
    for _BUG_FLAGS(), refcount_add(), refcount_inc(), refcount_dec(),
        annotate_reachable(), annotate_unreachable()


Changes in v3:
  - Split into per-commit revert (per Nadav Amit)
  - Add some cleanups with preprocessor approach

Changes in v2:
  - Revive clean-ups made by 5bdcd510c2ac (per Peter Zijlstra)
  - Fix commit quoting style (per Peter Zijlstra)

Masahiro Yamada (12):
  Revert "x86/jump-labels: Macrofy inline assembly code to work around
    GCC inlining bugs"
  Revert "x86/cpufeature: Macrofy inline assembly code to work around
    GCC inlining bugs"
  Revert "x86/extable: Macrofy inline assembly code to work around GCC
    inlining bugs"
  Revert "x86/paravirt: Work around GCC inlining bugs when compiling
    paravirt ops"
  Revert "x86/bug: Macrofy the BUG table section handling, to work
    around GCC inlining bugs"
  Revert "x86/alternatives: Macrofy lock prefixes to work around GCC
    inlining bugs"
  Revert "x86/refcount: Work around GCC inlining bug"
  Revert "x86/objtool: Use asm macros to work around GCC inlining bugs"
  Revert "kbuild/Makefile: Prepare for using macros in inline assembly
    code to work around asm() related GCC inlining bugs"
  linux/linkage: add ASM() macro to reduce duplication between C/ASM
    code
  x86/alternatives: consolidate LOCK_PREFIX macro
  x86/asm: consolidate ASM_EXTABLE_* macros

 Makefile                                  |  9 +--
 arch/x86/Makefile                         |  7 ---
 arch/x86/include/asm/alternative-asm.h    | 22 +------
 arch/x86/include/asm/alternative-common.h | 47 +++++++++++++++
 arch/x86/include/asm/alternative.h        | 30 +---------
 arch/x86/include/asm/asm.h                | 46 +++++----------
 arch/x86/include/asm/bug.h                | 98 +++++++++++++------------------
 arch/x86/include/asm/cpufeature.h         | 82 +++++++++++---------------
 arch/x86/include/asm/jump_label.h         | 22 +++++--
 arch/x86/include/asm/paravirt_types.h     | 56 +++++++++---------
 arch/x86/include/asm/refcount.h           | 81 +++++++++++--------------
 arch/x86/kernel/macros.S                  | 16 -----
 include/asm-generic/bug.h                 |  8 +--
 include/linux/compiler.h                  | 56 ++++--------------
 include/linux/linkage.h                   |  8 +++
 scripts/Kbuild.include                    |  4 +-
 scripts/mod/Makefile                      |  2 -
 17 files changed, 249 insertions(+), 345 deletions(-)
 create mode 100644 arch/x86/include/asm/alternative-common.h
 delete mode 100644 arch/x86/kernel/macros.S

-- 
2.7.4
