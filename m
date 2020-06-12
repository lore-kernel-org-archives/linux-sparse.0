From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: add release notes for incoming v0.6.2
Date: Sat, 13 Jun 2020 00:13:31 +0200
Message-ID: <20200612221331.12278-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLWNg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 12 Jun 2020 18:13:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF91CC03E96F
        for <linux-sparse@vger.kernel.org>; Fri, 12 Jun 2020 15:13:35 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k11so11548725ejr.9
        for <linux-sparse@vger.kernel.org>; Fri, 12 Jun 2020 15:13:35 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Currently, the release notes are kept on the wiki which
contains nothing else but a small intro.

The docs are certainly as good as this wiki to keep these
release notes. So, let try this for now.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/index.rst                |   7 ++
 Documentation/release-notes/index.rst  |   8 ++
 Documentation/release-notes/v0.6.2.rst | 100 +++++++++++++++++++++++++
 3 files changed, 115 insertions(+)
 create mode 100644 Documentation/release-notes/index.rst
 create mode 100644 Documentation/release-notes/v0.6.2.rst

diff --git a/Documentation/index.rst b/Documentation/index.rst
index 5dd87e43d264..eb3de63c9ca7 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -39,6 +39,13 @@ Documentation
 
    doc-guide
 
+Release Notes
+-------------
+.. toctree::
+   :maxdepth: 1
+
+   release-notes/index
+
 Indices and tables
 ==================
 
diff --git a/Documentation/release-notes/index.rst b/Documentation/release-notes/index.rst
new file mode 100644
index 000000000000..c55ed09a04cd
--- /dev/null
+++ b/Documentation/release-notes/index.rst
@@ -0,0 +1,8 @@
+*************
+Release Notes
+*************
+
+.. toctree::
+   :maxdepth: 1
+
+   v0.6.2
diff --git a/Documentation/release-notes/v0.6.2.rst b/Documentation/release-notes/v0.6.2.rst
new file mode 100644
index 000000000000..0ef67fc5ad6c
--- /dev/null
+++ b/Documentation/release-notes/v0.6.2.rst
@@ -0,0 +1,100 @@
+V0.6.2
+======
+
+* add a new tool: sindex - the semantic utility
+    Sindex is a simple to use cscope-like tool but understanding
+    how symbols are used and which can track struct members.
+
+* add support for GCC's __auto_type
+
+* add support for _Generic
+
+* fully propagate declarations downward
+  For exemple, it means that code like:
+
+        static int foo(void);
+        int foo(void) { return 0; }
+
+  now behaves as expected: foo() is effectively static
+
+* multi-arch:
+  * allow a single sparse executable to be used for multiple architectures
+  * add support for -mcmodel & -f{pic,PIC,pie,PIE}, mainly for RISC-V
+  * add new option, --arch=$ARCH, to specify the target architecture
+  * move all arch-specifc code in separated files (target-$ARCH.c) 
+  * try to support the various floating-point ABIs on ARM
+  * fix wchar_t & wint_t for openbsd
+  * add missing predefines for PPC
+  * add missing predfines: __amd64 & __amd64__
+  * sparc32 on SunOS/Solaris uses 128-bit long double
+  * fix wchar_t & wint_t on SunOS/Solaris
+  * teach sparse about -fshort-wchar
+  * keep cygwin specifics with i386/x86-64 specifics
+  * keep BSD & Darwin specifics with i386/x86-64 specifics
+  * fix the signedness of plain chars
+  * add support for s390 (ILP32)
+  * add predefine for __mips__
+  * predefine "i386" if needed
+  * pre-define __unix__ and friends
+  * add necessary defined for sunos-derived systems
+  * improved detection of the native OS
+
+* warnings
+  * improve diagnostic message about wrong redeclaration
+  * conditionally accept { 0 } without warnings
+  * add -Wexternal-function-has-definition
+  * display the bitfield name in error messages
+  * oversized bitfields are now errors
+  * add an option to suppress warning 'no newline at EOF'
+  * warn when jumping into statement expressions
+  * warn when using undefined labels
+  * warn on defined but unused labels
+
+* attributes:
+  * allows '__<attribute-name>__' for all attributes.
+  * improve handling of function attributes
+  * separate modifiers into type/declaration
+  * add support for attributes 'unused' & 'gnu_inline'
+  * simplify parsing of inline/__tls/__visible
+  * better handle function-only attributes
+  * teach sparse about gnu_inline
+
+* typeof:
+  * ensure that typeofs are evaluated before using show_typename()
+  * use a single way to expand typeofs
+
+* cgcc:
+  * use -fshort-char for Cygwin
+  * add support for riscv32 & riscv64
+  * don't define __CYGWIN32__ on 64-bit
+  * filter-out sparse-specific -msize-long & -msize-llp64
+  * use -mfloat-abi=hard for armhf
+  * define _BIG_ENDIAN when needed
+  * remove definition of _STRING_ARCH_unaligned (defined by glibc)
+  * removed unneeded predefines for integers (now defined by sparse)
+  * better mult-arch support by using --arch=$ARCH
+
+* testsuite:
+  * avoid standard includes in the tests
+  * fix testcase with non-constant initializer
+    
+* IR
+  * add support for the linearization of builtins
+  * generate OP_UNREACH from  __builtin_unreachable()
+  * add OP_UNREACH after calls to __noreturn functions
+
+* doc:
+  * do not use obsolete sphinx's AutodocReporter
+  * add basic doc about the type system
+  * doc is now accessible as: https://sparse.docs.kernel.org
+
+* misc:
+  * add support for '-std=c17/c18'
+  * simplify testng of which version of the standard is used
+  * various improvements to the 'dissect' tool
+  * simplify the parsing of type specifiers
+  * improve diagnostic messages concerning bitfields
+  * fix premature examination of dereferenced object
+  * various fixes for the expansion of constant symbols
+  * fix type compatibility of _Atomic types
+
-- 
2.27.0
