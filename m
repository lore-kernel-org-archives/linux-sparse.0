From: Christopher Li <sparse@chrisli.org>
Subject: [PATCH V2 2/2] Documents: project ideas
Date: Thu, 10 Aug 2017 16:28:46 -0400
Message-ID: <CANeU7Q=Q9YoJPZyBxz9uHAYRuT6JLh6D9VNiB2YYpSvcfoieVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34583 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753183AbdHJU2r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 16:28:47 -0400
Received: by mail-yw0-f193.google.com with SMTP id t139so1131519ywg.1
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 13:28:47 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Randy Dunlap <rdunlap@infradead.org>

Adding project ideas to improve sparse.

Signed-off-by: Christopher Li <sparse@chrisli.org>
---
 Documentation/project-ideas.md | 52 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/project-ideas.md

diff --git a/Documentation/project-ideas.md b/Documentation/project-ideas.md
new file mode 100644
index 0000000..380f850
--- /dev/null
+++ b/Documentation/project-ideas.md
@@ -0,0 +1,52 @@
+Why hacking on sparse
+=====================
+
+1. sparse is small.
+   The full project compiles in less than 10 seconds on old and not
performing laptop.
+2. sparse is fast.
+   Typically, sparse can check a C file 1/10 of time it takes for gcc
to generate object files.
+3. sparse can digest the full kernel source files.
+   With sparse-llvm, sparse uses llvm as back end to emit real machine code.
+
+New developer hacking on sparse
+==============================
+
+
+* All sparse warning messages should include the option how
+   to disable it.
+       e.g. "pre-process.c:20*:28: warning: Variable length array is used."
+       should be something like
+        "pre-process.c:20*:28: warning: Variable length array is
+used. (-Wno-vla)"
+* extend test-inspect to inspect more AST fields.
+* extend test-inspect to inspect instructions.
+* adding architecture handling in sparse similar to cgcc
+* parallel processing of test-suite
+* Howto: fix the kernel rcu related checker warnings
+* option to disable AST level inline.
+* debug: debug version of sparse do all the verification double check
+* test suite: verify and compare IR (suggested by Dibyendu Majumdar)
+* checker error output database
+
+For experienced developers
+==========================
+
+* merge C type on incremental declare of C type and function prototype.
+* move attribute out of ctype to allow easier to add new attribute.
+* serialize, general object walking driven by data structures.
+* serialize, write sparse byte code into file
+* serialize, load sparse byte code from file.
+* symbol index/linker, know which symbol in which byte code file.
+* inline function in instruction level
+* cross function checking
+* debug: optimization step by step log
+* debug: fancy animation of CFG
+* phi node location (Luc has patch)
+* revisit crazy programmer warning, invalid SSA form.
+* ptrlist, looping while modify inside the loop.
+* dead code elimination using ssa
+* constant propagation using ssa.
+* x86/arm back end instruction set define
+* register allocation.
+* emit x86/arm machine level code
+
-- 
2.13.3
