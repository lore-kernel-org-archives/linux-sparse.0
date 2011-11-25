From: Pekka Enberg <penberg@kernel.org>
Subject: [GIT PULL] Sparse LLVM backend
Date: Fri, 25 Nov 2011 09:46:06 +0200 (EET)
Message-ID: <alpine.LFD.2.02.1111250945120.7544@tux.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46218 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752371Ab1KYHqS (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Nov 2011 02:46:18 -0500
Received: by faas1 with SMTP id s1so1944531faa.19
        for <linux-sparse@vger.kernel.org>; Thu, 24 Nov 2011 23:46:17 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Jeff Garzik <jgarzik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sparse@vger.kernel.org

Hi Chris,

Please consider pulling latest LLVM backend code from:

   git://github.com/penberg/sparse-llvm.git for-chris

The backend is still work in progress but it already supports the following C
language features:

   - Arithmetic operations

   - Comparison operations

   - Logical operations

   - Bitwise operations

   - Loops

   - Casts

   - Structs and unions

The backend has been tested on i386 and x86-64. Some features have also been
tested on PPC against LLVM 2.6.

Please note that sparse uses 32-bit data type sizes by default so the generated
code on 64-bit is not correct. We'd need something like the following patch to
fix it:

   http://thread.gmane.org/gmane.comp.parsers.sparse/2654/focus=2655

 			Pekka

------------------>


The following changes since commit 65a4e2fc656aa6e99604358056d8599a1823a8bc:

   sparse 0.4.4 (2011-11-21 01:56:02 -0800)

are available in the git repository at:
   git://github.com/penberg/sparse-llvm.git for-chris

Christopher Li (1):
       Limit usage of g++ to llvm related programs.

Jeff Garzik (15):
       sparse, llvm: if-else code generation
       sparse-llvm: OP_SEL
       sparse-llvm: OP_SWITCH
       sparse-llvm: OP_LOAD
       sparse-llvm OP_PHISOURCE: replace copy with target=src pointer operation
       sparse, llvm: replace FIXME comment with assert(), following existing style
       sparse, llvm: implement OP_CALL
       sparse, llvm: move OP_PHI code from switch statement to separate function
       sparse, llvm: move OP_CAST code to separate func.  support FP casts.
       sparse, llvm: create helper for obtaining instruction's type
       sparse, llvm: store module-local functions on function reference list
       sparse, llvm: move OP_COPY support to separate function.  Add FP support.
       sparse, llvm: support OP_STORE
       sparse, llvm: Fix loops, by properly handling OP_PHI forward references
       sparse, llvm: add loop testcase

Kamil Dudka (2):
       cse: treat PHI-nodes as other instructions
       cse: update PHI users when throwing away an instruction

Pekka Enberg (59):
       sparse, llvm: Initial commit
       sparse, llvm: Fix assert() in sparse code
       sparse, llvm: Fix global variable initialization
       sparse, llvm: Fix 'sparsec' when it's not in PATH
       llvm, sparse: Separate entry and exit basic blocks
       sparse, llvm: Add switch statement to output_insn()
       sparse, llvm: OP_RET/PSEUDO_VAL code generation
       sparse, llvm: Add support for OP_RET/PSEUDO_ARG
       sparse, llvm: Introduce 'struct function' to clean up code
       sparse, llvm: Add output_op_binary() stub
       sparse, llvm: Implement OP_ADD
       sparse, llvm: Add support for more binary ops
       sparse, llvm: Implement some binary comparison ops
       sparse, llvm: Move binop tests to validation/backend
       sparse, llvm: Implement OP_CAST
       sparse, llvm: Floating point support for binops
       sparse, llvm: Reorganize code generation tests
       sparse, llvm: Bitwise not operator codegen
       sparse, llvm: Kill ifdef'd unssa() call
       sparse, llvm: Kill debugging code
       Merge pull request #1 from jgarzik/hacks
       Merge pull request #2 from jgarzik/hacks
       sparse, llvm: Warn the user when we fall back to GCC
       sparse, llvm: Code generation for string constants
       sparse, llvm: Cleanup output_data()
       sparse, llvm: Fix OP_CAST to use zero-extend
       sparse, llvm: Improve sparsec front-end
       sparse, llvm: Fix PSEUDO_OP code generation
       sparse, llvm: Don't redefine module local functions
       Revert "sparse, llvm: Don't redefine module local functions"
       sparse, llvm: Fix code generation for casts
       sparse, llvm: Fix pseudo_type() for PSEUDO_ARG
       Merge pull request #3 from jgarzik/hacks
       Merge branch 'master' of github.com:penberg/sparse-llvm
       llvm, sparse: Fix symbol_is_fp_type() goof
       Merge pull request #4 from jgarzik/hacks
       sparse, llvm: Fix code generation for 'long double' data type
       sparse, llvm: Add support for struct types
       sparse, llvm: Add support for symbol initializers
       sparse: Bump up sizeof(_Bool) to 8 bits
       sparse, llvm: Add support for logical ops
       sparse, llvm: Fix 'void *' pointer code generation
       sparse, llvm: Use new LLVM type system API for structs
       sparse, llvm: Fix struct code generation
       sparse, llvm: Fix symbol_type() for bitfields and enums
       sparse, llvm: Add support for array types
       sparse, llvm: Add support for union types
       sparse, llvm: Make 'sparsec' error handling more robust
       sparse, llvm: Function pointer code generation
       sparse, llvm: Fix symbol initializer code generation
       sparse, llvm: Fix 'extern' symbol code generation
       sparse, llvm: Make llc output to stdout in sparsec
       sparse, llvm: Pointer cast code generation
       sparse, llvm: OP_SET_B and OP_SET_A code generation
       sparse, llvm: More comparison ops code generation
       sparse, llvm: Simplify comparison op code generation
       sparse, llvm: FP comparison op code generation
       Merge pull request #6 from jgarzik/hacks
       sparse, llvm: Don't fail the build if LLVM is too old

  .gitignore                          |    1 +
  Makefile                            |   26 +-
  cse.c                               |   20 +-
  linearize.h                         |    2 +
  sparse-llvm.c                       | 1238 +++++++++++++++++++++++++++++++++++
  sparsec                             |   52 ++
  target.c                            |    2 +-
  validation/backend/arithmetic-ops.c |   94 +++
  validation/backend/array.c          |    6 +
  validation/backend/bitwise-ops.c    |   64 ++
  validation/backend/cast.c           |   47 ++
  validation/backend/cmp-ops.c        |   84 +++
  validation/backend/function-ptr.c   |   11 +
  validation/backend/hello.c          |   13 +
  validation/backend/logical-ops.c    |   24 +
  validation/backend/loop.c           |   21 +
  validation/backend/ptrcast.c        |    9 +
  validation/backend/struct.c         |   19 +
  validation/backend/union.c          |   12 +
  validation/sizeof-bool.c            |    6 +-
  20 files changed, 1737 insertions(+), 14 deletions(-)
  create mode 100644 sparse-llvm.c
  create mode 100755 sparsec
  create mode 100644 validation/backend/arithmetic-ops.c
  create mode 100644 validation/backend/array.c
  create mode 100644 validation/backend/bitwise-ops.c
  create mode 100644 validation/backend/cast.c
  create mode 100644 validation/backend/cmp-ops.c
  create mode 100644 validation/backend/function-ptr.c
  create mode 100644 validation/backend/hello.c
  create mode 100644 validation/backend/logical-ops.c
  create mode 100644 validation/backend/loop.c
  create mode 100644 validation/backend/ptrcast.c
  create mode 100644 validation/backend/struct.c
  create mode 100644 validation/backend/union.c

