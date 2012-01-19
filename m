From: Christopher Li <sparse@chrisli.org>
Subject: sparse-llvm has been merged
Date: Wed, 18 Jan 2012 18:00:22 -0800
Message-ID: <CANeU7Q=0U_47ZsKb6y6787S5mmiJnXjs_VK50u1OhXFiLamEYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51338 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab2ASCAW (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 18 Jan 2012 21:00:22 -0500
Received: by ghbg16 with SMTP id g16so3334282ghb.19
        for <linux-sparse@vger.kernel.org>; Wed, 18 Jan 2012 18:00:22 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>, Jeff Garzik <jeff@garzik.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

 Pekka's sparse-llvm has been merged at sparse chrisl branch.

http://git.kernel.org/?p=devel/sparse/chrisl/sparse.git;a=summary

The new llvm back end require llvm 3.0.

Chris

Merge branch 'sparse-llvm' of git://github.com/penberg/sparse-llvm.git

    'master' branch of git://github.com/penberg/sparse-llvm.git

        Revert "sparse: Bump up sizeof(_Bool) to 8 bits"
        sparse, llvm: Add test case for <stdbool.h> type
        sparse, llvm: Use LLVMInt1Type() in sym_basetype_type()
        sparse, llvm: Don't fail the build if LLVM is too old
        Merge pull request #6 from jgarzik/hacks
        sparse, llvm: add loop testcase
        sparse, llvm: Fix loops, by properly handling OP_PHI forward references
        sparse, llvm: FP comparison op code generation
        sparse, llvm: Simplify comparison op code generation
        sparse, llvm: More comparison ops code generation
        sparse, llvm: OP_SET_B and OP_SET_A code generation
        sparse, llvm: Pointer cast code generation
        sparse, llvm: Make llc output to stdout in sparsec
        sparse, llvm: Fix 'extern' symbol code generation
        sparse, llvm: Fix symbol initializer code generation
        sparse, llvm: Function pointer code generation
        sparse, llvm: Make 'sparsec' error handling more robust
        sparse, llvm: Add support for union types
        sparse, llvm: Add support for array types
        sparse, llvm: Fix symbol_type() for bitfields and enums
        sparse, llvm: Fix struct code generation
        sparse, llvm: Use new LLVM type system API for structs
        sparse, llvm: Fix 'void *' pointer code generation
        sparse, llvm: Add support for logical ops
        sparse: Bump up sizeof(_Bool) to 8 bits
        sparse, llvm: Add support for symbol initializers
        sparse, llvm: Add support for struct types
        sparse, llvm: Fix code generation for 'long double' data type
        Merge pull request #4 from jgarzik/hacks
        sparse, llvm: support OP_STORE
        sparse, llvm: move OP_COPY support to separate function.  Add
FP support.
        sparse, llvm: store module-local functions on function reference list
        llvm, sparse: Fix symbol_is_fp_type() goof
        Merge branch 'master' of github.com:penberg/sparse-llvm
