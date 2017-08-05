From: Christopher Li <sparse@chrisli.org>
Subject: Upcoming sparse release RC5
Date: Sat, 5 Aug 2017 11:46:05 -0400
Message-ID: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:33739 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdHEPqG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 11:46:06 -0400
Received: by mail-pg0-f49.google.com with SMTP id u5so18749756pgn.0
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 08:46:06 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

All the code I want is already in sparse-next. A little bit more testing
I will soon release the RC5.

I want to add two documents.

1) Something similar to the linux kernel submiting-patches.rst
     Especially we need to have some document for the purpose of the
     Signed-off-by: tag. Sparse has different open source license t(MIT) han
     linux kernel (GPL). Any one want to submit a patch?

2) I want to have a document for small project can be done on sparse.
    Thing we want to happen is sparse. The goal of this document is to
     invite more developer to join sparse development.

    We can discuss what we want to see in sparse in the future.
    I especially want some beginner friendly projects. Project that
    don't require too much detail knowledge of internal sparse to work on.

    A little bit of motion speech why you should try sparse if you are
    looking for compiler hacking or teaching compilers in course.
    - sparse is small. The full project compiles in less than 10 seconds on my
      old and not performing laptop.
    - sparse is fast. Typically, sparse can check on C file 1/10 of
time it take for
      gcc to generate object files.
    - sparse can digest  the full kernel source file. With sparse-llvm, sparse
       use llvm as back end to emit real machine code.

     Here is some brain dump, you are welcome to add yours or discuss/disagree
     with some of the projects.

     Project that are relative easy, does not require a lot of back
ground to work on:

     - Sparse all sparse warning message should include the option how
to disable it.
       e.g. "pre-process.c:2019:28: warning: Variable length array is used."
       should be something like
        "pre-process.c:2019:28: warning: Variable length array is
used. (-Wno-vla)"
     - extend test-inspect to inspect more AST fields.
     - Addd inspect to inspect instructions.
     - adding architecture handling in sparse similar to cgcc
     - parallel processing of test-suit
     - Howto: fix the kernel rcu related checker warnings
     - option to disable AST level inline.

    The harder project for more experienced sparse developers:
     - incremental declare on C type and function prototype.
     - move attribute out of ctype to allow easier to add new attribute.
     - serialize, general object walking driven by data structures.
     - serialize, write sparse byte code into file
     - serialize, load sparse byte code from file.
     - symbol index/linker, know which symbol in which byte code file.
     - inline function in instruction level
     - cross function checking
     - checker error output database
     - debug version of sparse do all the verification double
check.(might belong to easy)
     - debug: optimization step by step log
     - debug: fancy animation of CFG

     - phi node location (Luc has patch)
     - revisit crazy programmer warning, invalid ssa form.
     - ptrlist, looping while modify inside the loop.
     - dead code eliminate using ssa
     - constant propagation using ssa.
     - x86/arm back end instruction set define
     - register allocation.
     - emit x86/arm machine level code.

I think that should keep us busy for a while.

Chris
