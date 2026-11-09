Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256411;
	b=nyuZ0bNuPF48E/3nqhEbnqsyWa7n2wGE9D8iwZMY6E6HYPDUIt9Xl2xlJR5v7Nn8P1u0
	 wg5yrjIrH7/na54bMi2VgLpHYOMp+CU7IOaniVpMh8C969pk4OVzf3ah/+Z0bWOx8/9tz
	 1ej/QesZPs55WEsidR2JegLSn8n+mWqWIWvV962SbYNZk/rCIs1UPFcWuE18OiTyI9UmA
	 puzNDjJjLJ5SFrXYy2miVtfLWofZJLTJJSanGxV3iYi8lnP/Bog5CRKBr370o4Rl8gNOe
	 MNaQzjQz2gFcorN+FQQ2LS+sR5awjTrgHbhZNYWFB6D26WZjRAiEp3AbVaQyc7aFrIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256411;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/TTKv5il7HfLbJayxOVB5tObhpYGKm35DpwOsSXURsY=;
	b=VDuGG7rKub6IhC5X7rAYNibxnOFu95SiwufHcfh1ERI5NsKuZc9r2gK7XfqYfQp+VnHy
	 fNRw2Te5Tf2MbmLLm4K1JtS4zZU+ZVPtGEb+VWkUo3u9lgYeUsUMsVM73adcxZ5Ck1Haf
	 3G1DxxD1Wtmb6iGoXsU1Y05xEN4488oKc9sIHRhwdkdTTWPpySx01eQCKO/A8Z+P1AiWk
	 KWkV/tHzRTaaylG3SXhW2Vl6nqIavEzK8JQyEUsUtgOhEAaZ04XwplRiPWZBOk40dOgHM
	 eKcegD7lpPPrU5TtNMFSp/e31qoO0EKPLlpk2qP3HbKvBJWJEEJN5nv1tPEgiYsSiLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=zT7vLsIg;
	arc=none smtp.remote-ip=199.89.1.14
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1738606A31C
	for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1738606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=zT7vLsIg
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jNhLy3RkZz1XMYJS;
	Mon,  9 Nov 2026 20:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1794256404; x=1796848405; bh=/TTKv5il7HfLbJayxOVB5tObhpYGKm35Dpw
	OsSXURsY=; b=zT7vLsIgjIe3LsyKRskhFovJCZVHBEA8x+OHy9ssp6hoFxdjJqj
	lmW0h5rZ1T4sx4CiqBXD1x4lPh0Ha5dIL14ZFfHqqcqkOPbNMxCjvqqtDCQ83RWy
	oPFnx+sCpTqo+ga6eMe0FzOTDyJ9U0hXWCV8WAuUY6+aqxA5qUV+/S1Dt5Q4iEId
	kWGu1QeNyjlop4/nFUBXvLCcRF1QrOjckY5SQ0X6eAouAyPyoQxtk27xIsEM3EtA
	Jaf0b9A/mMoV9kbP+0sHc0+cV+b6+UreF/IgUb/LywC9GSuj2W7tleX7j8OQ7psZ
	WGWcZnnt/zat3RfjS0WtKBPSnpJ20KMKZ7A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9vjcTAuS3aFQ; Mon,  9 Nov 2026 20:33:24 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (57.237.82.34.bc.googleusercontent.com [34.82.237.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jNhLr24kYz1XM5kD;
	Mon,  9 Nov 2026 20:33:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: linux-sparse@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Subject: 
Date: Mon,  9 Nov 2026 12:31:46 -0800
Message-ID: <20261109203259.362845-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Post: <mailto:linux-sparse@vger.kernel.org>
List-Help: <mailto:linux-sparse+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sparse+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From ddb88c610711c6494c57b2a9df205b2acf9b3cbc Mon Sep 17 00:00:00 2001
From: Bart Van Assche <bvanassche@acm.org>
Date: Mon, 9 Nov 2026 12:27:28 -0800
Subject: [PATCH 00/73] Support more C23 features

Hi,

If nobody objects I will publish this patch series two weeks from now to
the master branch at kernel.org.

The changes fall into five major functional themes:

1. C23 Standard & Preprocessor Support (~25 commits)
Major upgrade adding comprehensive ISO C23 and GNU C23 standard features:
* Preprocessor directives & macros:
  - Add #elifdef and #elifndef.
  - Add __has_include and __has_include_next.
  - Add #embed directive and __has_embed.
  - Add __has_c_attribute.
  - Add __VA_OPT__ for variadic macro expansion.
* C23 Language Features:
  - Keywords & Constants: bool, true, false, nullptr / nullptr_t,
    static_assert, alignas, alignof, thread_local, typeof_unqual, and
    u8 character constants / string literals.
  - Types & Syntax:
    * Support _BitInt(N).
    * Support standard [[]] attribute syntax.
    * Support fixed-underlying-type enumerations (enum foo : int).
    * Support constexpr object specifiers and auto type inference.
    * Support digit separators in numeric literals (e.g. 1'000'000).
    * Support empty initializer braces ({}).
    * Support storage-class specifiers in compound literals.
  - Functions & Statements:
    * Support labels before declarations and at block ends.
    * Support unnamed parameters in function definitions.
    * Support variadic functions without named parameters (void f(...)).
    * Treat empty parameter list () as (void) and reject K&R functions.
* Options:
  - Add -std=3Dc23, -std=3Dc2x, and -std=3Dgnu23.

2. Linux Kernel Compatibility, Builtins & Attributes (~10 commits)
Enable Sparse to parse modern Linux kernel code and headers cleanly:
* Support __attribute__((cleanup(...))):
  - Integrate with linearize and -Wcontext to track lock/unlock semantics
    with scope-based resource management (RAII / guard() / scoped_guard()=
).
* Builtin Functions:
  - Add __builtin_has_attribute().
  - Add __builtin_infer_alloc_token() as a size_t integer constant.
  - Add kernel builtins (__builtin_object_size, __builtin_counted_by_ref,
    __builtin_get_counted_by).
  - Suppress evaluation of __builtin_clz(0) and __builtin_ctz(0).
* Attributes & Types:
  - Support __attribute__((packed)) and machine mode attributes on enums.
  - Accept conditional expressions with only one void side.
  - Ignore top-level non-array address space in compare_types().
  - Support long token and string expansions dynamically.
  - Undefine conflicting bitness macros when parsing -m flags on x86.

3. Bitwise Types & Conditional Context (Linus Torvalds Series, ~7 commits=
)
Incorporate and harden Linus Torvalds's patch series:
* Context tracking:
  - Add conditional context increment model (context(0, -1)) for trylock
    functions, with multi-attribute call handling and check_context()
    definition validation.
* Bitwise Types (SYM_RESTRICT):
  - Simplify signed constants early (-5, +5, ~0) during type evaluation.
  - Allow all-bits-set (~0, -1) as valid bitwise constants alongside 0.
  - Allow ordered comparisons (<, <=3D, >, >=3D) between unsigned restric=
ted
    types and unrestricted constants (0, ~0).
  - Keep unrestricted constants unrestricted across regular and __force
    casts.
  - Preserve MOD_SPECIFIER on bitwise types to retain MOD_UNSIGNED on
    bitwise typedefs.

4. Hardening, Memory Safety & Bug Fixes (~30 commits)
Eliminate crashes, undefined behavior, and potential overflows:
* Allocators & Tokenizer:
  - Harden slab allocation bounds, zeroing checks, and mmap fallbacks.
  - Support 4096-byte identifiers and fix string escape bounds.
* Parser & AST:
  - Guard against recursive symbols in c2xml.
  - Harden warning and format string buffers in lib.c.
  - Fix attribute propagation, enum overflow, and AST column counting.
* Evaluation, Inlining & Optimization:
  - Fix pointer arithmetic, incomplete types, and qualifiers in
    evaluate.c.
  - Fix generic expression duplication in inline.c and VLA bound copying.
  - Guard against LLONG_MIN overflow on negation in simplify.c.
  - Fix instruction traversal order in memops.c and skip mixed-size SSA.
  - Fix dead store elimination (DSE) and asm operands in linearize/flow.
  - Cast pointers to uintptr_t before relational comparisons in cse.c.
* Backends & Tools:
  - Use LLVMCreateBuilderForModule() for LLVM 24+.
  - Support arbitrary struct member counts and operand types in
    sparse-llvm.
  - Fix buffer bounds and unsigned comparisons in compile-i386.c.
  - Fix ctags, dissect, graph, and scheck helper utilities.

5. Tooling & CI Automation (2 commits)
* Add a comprehensive .clang-format configuration file.
* Add GitHub Actions workflow and test script to build the Linux kernel
  with Sparse.
 =20
Thanks,

Bart.

Bart Van Assche (66):
  Makefile: Pass '--' to rm in clean target to handle dash-prefixed
    files
  sparse-llvm: Use LLVMCreateBuilderForModule() with LLVM 24 and later
  typeof_unqual: Strip qualifiers and address space from types and
    arrays
  bitfield: Pack consecutive _Bool bitfields into byte containers
  allocate: Harden slab allocation bounds, zeroing, and mmap checks
  tokenize: Support 4096-byte identifiers and fix escape bounds
  pre-process: Fix macro expansion and include directive handling
  options, lib: Harden warning buffers and command-line option parsing
  builtin: Fix atomic builtin type checking and object_size bounds
  parse, show-parse: Fix attribute propagation, enum overflow, and
    bounds
  target-openrisc: Set target_openrisc.mach to MACH_OPENRISC
  evaluate: Fix pointer arithmetic, incomplete types, and qualifiers
  expand: Fix static initializer folding and floating-point casts
  inline: Copy union cast types and VLA bounds when inlining
  linearize, flow: Fix asm operands, switch case bounds, and DSE
  memops, ssa: Walk parent insns in reverse and skip mixed-size SSA
  simplify: Prevent overflow on LLONG_MIN negation and fix
    simplifications
  sparse: Gate context failure warning on Wcontext and catch underflow
  ast-model: Return AST_N_COLUMNS and inspect child nodes lazily
  c2xml: Guard against recursive symbols and free xmlGetProp() string
  compile-i386: Fix buffer bounds, unsigned '<=3D' codegen, and null
    checks
  ctags: Fix line comparison order and handle SYM_RESTRICT and SYM_LABEL
  dissect: Unwrap array element type via base_type()
  example: Fix show_op() rotating buffer dimensions
  graph: Check PSEUDO_SYM before dereferencing insn->func->sym
  scheck: Fix slice() upper bit index calculation
  sparse-llvm: Support arbitrary struct member counts and fix operand
    types
  inline: Duplicate generic expressions instead of evaluating them
  lib: Avoid mutating fmt before va_start() in warning()
  cse, canon: Cast pointers to uintptr_t before relational comparison
  clang-format: Add .clang-format configuration file
  options: Add support for -std=3Dc23, -std=3Dc2x and -std=3Dgnu23
  preprocessor: Add support for #elifdef and #elifndef
  preprocessor: Add support for __has_include and __has_include_next
  c23: Add support for static_assert, alignas, alignof, thread_local
  c23: Add support for bool, true, and false keywords
  c23: Add support for nullptr and nullptr_t
  c23: Add support for digit separators in numeric literals
  c23: Support unnamed parameters in function definitions
  c23: Support variadic functions without named parameters
  c23: Support labels before declarations and at block ends
  c23: Support auto type inference
  c23: Support constexpr object specifier
  c23: Support enumerations with fixed underlying types
  c23: Support standard [[]] attribute syntax
  preprocessor: Add support for __has_c_attribute
  c23: Support empty initializer braces {}
  preprocessor: Add support for __has_embed
  preprocessor: Add support for #embed directive
  c23: Add support for u8 character constants and string literals
  preprocessor: Add support for __VA_OPT__
  c23: Treat empty parameter list () as (void) and reject K&R functions
  c23: Support storage-class specifiers in compound literals
  c23: Add support for _BitInt(N)
  enum: Support machine mode attributes on enumeration types
  enum: Support __attribute__((packed)) on enumeration types
  expand: Ignore top-level non-array address space in compare_types()
  builtin: Support __builtin_infer_alloc_token() as a size_t ICE
  builtin: Add support for Linux kernel compiler builtins
  builtin: Add support for __builtin_has_attribute()
  cleanup: Support __attribute__((cleanup(...))) in linearize and
    -Wcontext
  builtin: Do not evaluate __builtin_clz(0) and __builtin_ctz(0)
  pre-process: Support long token and string expansions dynamically
  x86: Undefine conflicting bitness macros when parsing -m flags
  evaluate: Accept conditional expressions with only one void side
  ci: Add Linux kernel GitHub Actions workflow and build script

Linus Torvalds (7):
  context: Add "conditional context increment" model
  expand: Simplify signed constants early
  bitwise: Allow all-bits-set as a restricted value
  bitwise: Allow restricted ordered compares with unrestricted values
  bitwise: Keep unrestricted values unrestricted after a cast
  bitwise: Don't remove MOD_SPECIFIER from 'bitwise' types
  bitwise: Allow both regular casts and forced casts for restricted
    values

 .clang-format                                 |  125 ++
 .../build-linux-kernel-with-sparse.yml        |   28 +
 Documentation/types.rst                       |    2 +-
 Makefile                                      |    2 +-
 allocate.c                                    |   45 +-
 allocate.h                                    |    1 +
 ast-inspect.c                                 |    1 +
 ast-model.c                                   |    9 +-
 builtin.c                                     |  249 ++-
 c2xml.c                                       |   55 +-
 char.c                                        |  146 +-
 ci/build-linux-kernel-with-sparse.sh          |   23 +
 compat/mmap-blob.c                            |    4 +-
 compile-i386.c                                |   76 +-
 cse.c                                         |   17 +-
 ctags.c                                       |    4 +-
 dissect.c                                     |    6 +-
 evaluate.c                                    |  918 ++++++++-
 example.c                                     |    2 +-
 expand.c                                      |  696 ++++++-
 expand.h                                      |    3 +
 expression.c                                  |  482 ++++-
 expression.h                                  |   14 +-
 flow.c                                        |    3 +
 gcc-attr-list.h                               |    2 -
 graph.c                                       |   33 +-
 ident-list.h                                  |   33 +-
 inline.c                                      |  343 +++-
 lib.c                                         |   30 +-
 linearize.c                                   |  624 +++++-
 linearize.h                                   |    6 +-
 memops.c                                      |    4 +-
 options.c                                     |   84 +-
 options.h                                     |    2 +
 parse.c                                       | 1620 ++++++++++++---
 parse.h                                       |    5 +
 pre-process.c                                 | 1824 +++++++++++++++--
 predefine.c                                   |    8 +
 scheck.c                                      |    3 +-
 show-parse.c                                  |  128 +-
 simplify.c                                    |  230 ++-
 simplify.h                                    |    1 +
 sparse-llvm.c                                 |  183 +-
 sparse.c                                      |  207 +-
 ssa.c                                         |    6 +
 storage.c                                     |    5 +-
 symbol.c                                      |  314 ++-
 symbol.h                                      |  150 +-
 target-openrisc.c                             |    2 +-
 token.h                                       |   13 +-
 tokenize.c                                    |  242 ++-
 validation/arch/x86-bitness-override.c        |   17 +
 validation/arch/x86-bitness-undef.c           |   16 +
 validation/atomic-builtins-const.c            |   67 +
 validation/atomic-builtins-types.c            |   47 +
 validation/attr_in_parameter.c                |    2 +
 .../backend/c23-compound-literal-storage.c    |   27 +
 validation/backend/c23-empty-init.c           |   24 +
 validation/backend/c23-nullptr.c              |   21 +
 validation/backend/struct-large-members.c     |   83 +
 validation/bitfield-bool-layout.c             |    9 +-
 validation/bitwise-all-bits-and-casts.c       |  100 +
 validation/builtin-clz-ctz-zero.c             |   11 +
 validation/builtin-counted-by-ref-err.c       |   20 +
 validation/builtin-has-attribute-err.c        |   19 +
 validation/builtin-has-attribute-more.c       |  157 ++
 validation/builtin-has-attribute-nonstring.c  |   35 +
 validation/builtin-infer-alloc-token.c        |   28 +
 validation/builtin-object-size-cycle.c        |   44 +
 validation/builtins-kernel.c                  |   73 +
 validation/c11-c23-keywords-ident.c           |   19 +
 validation/c11-va-start-error.c               |   20 +
 validation/c23-alignof-pedantic.c             |   20 +
 validation/c23-attributes-error.c             |   20 +
 validation/c23-attributes-pedantic.c          |   10 +
 validation/c23-attributes.c                   |  152 ++
 validation/c23-auto-error.c                   |   71 +
 validation/c23-auto.c                         |  107 +
 validation/c23-bitint-error.c                 |   61 +
 validation/c23-bitint-pedantic.c              |   13 +
 validation/c23-bitint.c                       |  214 ++
 validation/c23-bool-error.c                   |   23 +
 validation/c23-bool.c                         |   45 +
 .../c23-compound-literal-register-addr.c      |   17 +
 .../c23-compound-literal-storage-error.c      |   37 +
 .../c23-compound-literal-storage-pedantic.c   |   10 +
 validation/c23-compound-literal-storage.c     |   27 +
 validation/c23-constexpr-error.c              |   92 +
 validation/c23-constexpr-self-init.c          |   41 +
 validation/c23-constexpr.c                    |  100 +
 validation/c23-digit-separators-error.c       |   36 +
 validation/c23-digit-separators-pedantic.c    |   12 +
 validation/c23-digit-separators.c             |   29 +
 validation/c23-empty-init-error.c             |   19 +
 validation/c23-empty-init-pedantic.c          |   14 +
 validation/c23-empty-init.c                   |   64 +
 validation/c23-empty-parameters.c             |   29 +
 validation/c23-empty-params-error.c           |   47 +
 validation/c23-enum-type-cast.c               |   70 +
 validation/c23-enum-type-error.c              |   40 +
 validation/c23-enum-type.c                    |  116 ++
 validation/c23-keywords-error.c               |   48 +
 validation/c23-keywords.c                     |   30 +
 validation/c23-knr-error.c                    |   14 +
 validation/c23-labels-error.c                 |   48 +
 validation/c23-labels-gnu.c                   |   15 +
 validation/c23-labels-pedantic.c              |   15 +
 validation/c23-labels.c                       |   67 +
 validation/c23-nullptr-assign.c               |   35 +
 validation/c23-nullptr-error.c                |  107 +
 validation/c23-nullptr.c                      |  107 +
 validation/c23-param-attribute.c              |   28 +
 validation/c23-stdc-version.c                 |   11 +
 validation/c23-typeof-unqual.c                |  113 +
 validation/c23-u8-char-error.c                |   16 +
 validation/c23-u8-char-pedantic.c             |   10 +
 validation/c23-u8-char-warn.c                 |   14 +
 validation/c23-u8-char.c                      |   37 +
 validation/c23-unnamed-params-error.c         |   27 +
 validation/c23-unnamed-params-pedantic.c      |   12 +
 validation/c23-unnamed-params.c               |   47 +
 validation/c23-va-opt.c                       |   36 +
 validation/c23-variadic-error.c               |   41 +
 validation/c23-variadic-no-named.c            |   47 +
 validation/c2xml-recursive-types.c            |   15 +
 validation/cleanup-context.c                  |  161 ++
 validation/cleanup-errors.c                   |   77 +
 validation/cleanup-inline-loop.c              |   31 +
 validation/cond-err-expand.c                  |    9 -
 validation/cond-one-void-pedantic.c           |   39 +
 validation/cond-one-void.c                    |   47 +
 validation/context-fixes.c                    |   41 +
 validation/context.c                          |  101 +-
 validation/enum+mode.c                        |   26 +-
 validation/enum-packed.c                      |   85 +
 validation/eval-expand-inline-fixes.c         |   49 +
 validation/eval-ptr-incomplete-and-inline.c   |   70 +
 validation/eval-type-checks.c                 |   89 +
 validation/expand-bitint.c                    |   49 +
 validation/expand-const-and-float.c           |   73 +
 validation/inline-generic.c                   |   25 +
 validation/linear/bitfield-bool.c             |   44 +
 validation/linear/c23-nullptr.c               |   20 +
 validation/linear/c23-unnamed-params.c        |   27 +
 validation/linear/c23-va-start.c              |   22 +
 validation/linear/cleanup-control-flow.c      |   62 +
 validation/linear/cleanup-stmt-expr-asm.c     |   48 +
 validation/linear/cond-one-void.c             |   24 +
 validation/linear/control-flow-fixes.c        |   44 +
 validation/long-string-expansion.c            |   30 +
 validation/optim/simplify-memops-ssa-fixes.c  |  103 +
 validation/optim/volatile-dse-and-cfg.c       |   53 +
 validation/parser-enum-overflow.c             |   13 +
 validation/parser-type-fixes.c                |   93 +
 validation/preprocessor/c23-elifdef-error.c   |   35 +
 validation/preprocessor/c23-elifdef.c         |   44 +
 validation/preprocessor/c23-embed-error.c     |   19 +
 validation/preprocessor/c23-embed-pedantic.c  |   12 +
 validation/preprocessor/c23-embed.c           |   72 +
 validation/preprocessor/c23-has-c-attribute.c |   60 +
 validation/preprocessor/c23-has-embed.c       |   69 +
 .../preprocessor/c23-has-include-error.c      |   18 +
 validation/preprocessor/c23-has-include.c     |   51 +
 validation/preprocessor/c23-va-opt-error.c    |   31 +
 validation/preprocessor/c23-va-opt.c          |   73 +
 .../preprocessor/preprocess-crash-fixes.c     |   25 +
 .../preprocess-errors-and-limits.c            |   33 +
 validation/struct-packed-aligned-layout.c     |  135 ++
 validation/types-compatible-address-space.c   |   39 +
 validation/weak-const-no-fold.c               |   15 +
 170 files changed, 13517 insertions(+), 1097 deletions(-)
 create mode 100644 .clang-format
 create mode 100644 .github/workflows/build-linux-kernel-with-sparse.yml
 create mode 100755 ci/build-linux-kernel-with-sparse.sh
 create mode 100644 validation/arch/x86-bitness-override.c
 create mode 100644 validation/arch/x86-bitness-undef.c
 create mode 100644 validation/atomic-builtins-const.c
 create mode 100644 validation/atomic-builtins-types.c
 create mode 100644 validation/backend/c23-compound-literal-storage.c
 create mode 100644 validation/backend/c23-empty-init.c
 create mode 100644 validation/backend/c23-nullptr.c
 create mode 100644 validation/backend/struct-large-members.c
 create mode 100644 validation/bitwise-all-bits-and-casts.c
 create mode 100644 validation/builtin-clz-ctz-zero.c
 create mode 100644 validation/builtin-counted-by-ref-err.c
 create mode 100644 validation/builtin-has-attribute-err.c
 create mode 100644 validation/builtin-has-attribute-more.c
 create mode 100644 validation/builtin-has-attribute-nonstring.c
 create mode 100644 validation/builtin-infer-alloc-token.c
 create mode 100644 validation/builtin-object-size-cycle.c
 create mode 100644 validation/builtins-kernel.c
 create mode 100644 validation/c11-c23-keywords-ident.c
 create mode 100644 validation/c11-va-start-error.c
 create mode 100644 validation/c23-alignof-pedantic.c
 create mode 100644 validation/c23-attributes-error.c
 create mode 100644 validation/c23-attributes-pedantic.c
 create mode 100644 validation/c23-attributes.c
 create mode 100644 validation/c23-auto-error.c
 create mode 100644 validation/c23-auto.c
 create mode 100644 validation/c23-bitint-error.c
 create mode 100644 validation/c23-bitint-pedantic.c
 create mode 100644 validation/c23-bitint.c
 create mode 100644 validation/c23-bool-error.c
 create mode 100644 validation/c23-bool.c
 create mode 100644 validation/c23-compound-literal-register-addr.c
 create mode 100644 validation/c23-compound-literal-storage-error.c
 create mode 100644 validation/c23-compound-literal-storage-pedantic.c
 create mode 100644 validation/c23-compound-literal-storage.c
 create mode 100644 validation/c23-constexpr-error.c
 create mode 100644 validation/c23-constexpr-self-init.c
 create mode 100644 validation/c23-constexpr.c
 create mode 100644 validation/c23-digit-separators-error.c
 create mode 100644 validation/c23-digit-separators-pedantic.c
 create mode 100644 validation/c23-digit-separators.c
 create mode 100644 validation/c23-empty-init-error.c
 create mode 100644 validation/c23-empty-init-pedantic.c
 create mode 100644 validation/c23-empty-init.c
 create mode 100644 validation/c23-empty-parameters.c
 create mode 100644 validation/c23-empty-params-error.c
 create mode 100644 validation/c23-enum-type-cast.c
 create mode 100644 validation/c23-enum-type-error.c
 create mode 100644 validation/c23-enum-type.c
 create mode 100644 validation/c23-keywords-error.c
 create mode 100644 validation/c23-keywords.c
 create mode 100644 validation/c23-knr-error.c
 create mode 100644 validation/c23-labels-error.c
 create mode 100644 validation/c23-labels-gnu.c
 create mode 100644 validation/c23-labels-pedantic.c
 create mode 100644 validation/c23-labels.c
 create mode 100644 validation/c23-nullptr-assign.c
 create mode 100644 validation/c23-nullptr-error.c
 create mode 100644 validation/c23-nullptr.c
 create mode 100644 validation/c23-param-attribute.c
 create mode 100644 validation/c23-stdc-version.c
 create mode 100644 validation/c23-typeof-unqual.c
 create mode 100644 validation/c23-u8-char-error.c
 create mode 100644 validation/c23-u8-char-pedantic.c
 create mode 100644 validation/c23-u8-char-warn.c
 create mode 100644 validation/c23-u8-char.c
 create mode 100644 validation/c23-unnamed-params-error.c
 create mode 100644 validation/c23-unnamed-params-pedantic.c
 create mode 100644 validation/c23-unnamed-params.c
 create mode 100644 validation/c23-va-opt.c
 create mode 100644 validation/c23-variadic-error.c
 create mode 100644 validation/c23-variadic-no-named.c
 create mode 100644 validation/c2xml-recursive-types.c
 create mode 100644 validation/cleanup-context.c
 create mode 100644 validation/cleanup-errors.c
 create mode 100644 validation/cleanup-inline-loop.c
 create mode 100644 validation/cond-one-void-pedantic.c
 create mode 100644 validation/cond-one-void.c
 create mode 100644 validation/context-fixes.c
 create mode 100644 validation/enum-packed.c
 create mode 100644 validation/eval-expand-inline-fixes.c
 create mode 100644 validation/eval-ptr-incomplete-and-inline.c
 create mode 100644 validation/eval-type-checks.c
 create mode 100644 validation/expand-bitint.c
 create mode 100644 validation/expand-const-and-float.c
 create mode 100644 validation/linear/bitfield-bool.c
 create mode 100644 validation/linear/c23-nullptr.c
 create mode 100644 validation/linear/c23-unnamed-params.c
 create mode 100644 validation/linear/c23-va-start.c
 create mode 100644 validation/linear/cleanup-control-flow.c
 create mode 100644 validation/linear/cleanup-stmt-expr-asm.c
 create mode 100644 validation/linear/cond-one-void.c
 create mode 100644 validation/linear/control-flow-fixes.c
 create mode 100644 validation/long-string-expansion.c
 create mode 100644 validation/optim/simplify-memops-ssa-fixes.c
 create mode 100644 validation/optim/volatile-dse-and-cfg.c
 create mode 100644 validation/parser-enum-overflow.c
 create mode 100644 validation/parser-type-fixes.c
 create mode 100644 validation/preprocessor/c23-elifdef-error.c
 create mode 100644 validation/preprocessor/c23-elifdef.c
 create mode 100644 validation/preprocessor/c23-embed-error.c
 create mode 100644 validation/preprocessor/c23-embed-pedantic.c
 create mode 100644 validation/preprocessor/c23-embed.c
 create mode 100644 validation/preprocessor/c23-has-c-attribute.c
 create mode 100644 validation/preprocessor/c23-has-embed.c
 create mode 100644 validation/preprocessor/c23-has-include-error.c
 create mode 100644 validation/preprocessor/c23-has-include.c
 create mode 100644 validation/preprocessor/c23-va-opt-error.c
 create mode 100644 validation/preprocessor/c23-va-opt.c
 create mode 100644 validation/preprocessor/preprocess-crash-fixes.c
 create mode 100644 validation/preprocessor/preprocess-errors-and-limits.=
c
 create mode 100644 validation/struct-packed-aligned-layout.c
 create mode 100644 validation/types-compatible-address-space.c
 create mode 100644 validation/weak-const-no-fold.c

