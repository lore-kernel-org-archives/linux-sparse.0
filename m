From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse test failures on ppc32le (and other not so common archs)
Date: Sat, 9 Sep 2017 23:02:15 +0200
Message-ID: <20170909210215.2mjxhsw76ee6eeqy@taurus.defre.kleine-koenig.org>
References: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
 <c1cfea1b-c9e6-0df2-855e-cf66e25c9ccc@ramsayjones.plus.com>
 <20170830173652.2s26nti2s2mgupnd@taurus.defre.kleine-koenig.org>
 <CANeU7QmV0z58dGW2NTE+qH33OqW+WWCHZARF=h=XiiwhnS5jPg@mail.gmail.com>
 <20170831205514.vxmirle2yoc3rm44@taurus.defre.kleine-koenig.org>
 <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5ailwiket2nk6crx"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:43633 "EHLO
        arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750923AbdIIVCW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 9 Sep 2017 17:02:22 -0400
Content-Disposition: inline
In-Reply-To: <CANeU7QkBF=uw_EVBe7-zLadUU=cgCvFS7uKxdRk_vq=6SO7W5Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>


--5ailwiket2nk6crx
Content-Type: multipart/mixed; boundary="47mliyxh6kgspn6h"
Content-Disposition: inline


--47mliyxh6kgspn6h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2017 at 08:47:55PM -0400, Christopher Li wrote:
> On Thu, Aug 31, 2017 at 4:55 PM, Uwe Kleine-K=F6nig <uwe@kleine-> Yes
> that works. So to address the Debian bug I can do:
> >
> >  - move sparse to /usr/lib
> >  - teach cgcc about the move of sparse
> >  - make /usr/bin/sparse call cgcc -no-compile "$@"
>=20
> I don't like that. It means the user can't invoke sparse directly.
>=20
> >
> > or is it easier to teach sparse about the architecture stuff?
>=20
> First of all. It is not very trivial to teach sparse about the architectu=
re
> stuff. To my mind, we need to move all the cgcc logic into sparse.
>=20
> For this case, I think it is easier to teach the sparse validation
> code to use cgcc on those back end testing. Most validation don't
> need to include system header file at all so it does not have
> this problem.
>=20
> How about this patch?
> I know my patch is white space damaged in email.
> Git branch is at:
> https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=3Dll=
vm-cgcc
>=20
> Please let me know if that fix your problem. It pass check
> on my local machine running x86_64. I don't have ppc64 to
> test with.
>=20
> Chris
>=20
> diff --git a/sparsec b/sparsec
> index 9dc96c9..2990d26 100755
> --- a/sparsec
> +++ b/sparsec
> @@ -32,7 +32,8 @@ done
>  TMPLLVM=3D`mktemp -t tmp.XXXXXX`".llvm"
>  TMPFILE=3D`mktemp -t tmp.XXXXXX`".o"
>=20
> -$DIRNAME/sparse-llvm $SPARSEOPTS > $TMPLLVM
> +env CHECK=3D$DIRNAME/sparse-llvm $DIRNAME/cgcc -no-compile \
> +       $SPARSEOPTS > $TMPLLVM
>=20
>  LLC=3D`"${LLVM_CONFIG:-llvm-config}" --bindir`/llc
>=20
> diff --git a/sparsei b/sparsei
> index 3431a9f..3abd00f 100755
> --- a/sparsei
> +++ b/sparsei
> @@ -10,4 +10,4 @@ if [ $# -eq 0 ]; then
>    exit 1
>  fi
>=20
> -$DIRNAME/sparse-llvm $@ | $LLI
> +env CHECK=3D$DIRNAME/sparse-llvm $DIRNAME/cgcc -no-compile $@ | $LLI

I tried this on ppc64le and it fixes 2 tests, so were at

	Out of 287 tests, 273 passed, 14 failed (10 of them are known to fail)

The repaired tests are:

	backend/hello.c
	backend/sum.c

unexpected failures are:

	backend/arithmetic-ops.c
	backend/cmp-ops.c
	backend/int-cond.c
	backend/logical-ops.c

These are not about missing preprocessor tokens as there are no system
includes used, but the error there is

	Error: unrecognized opcode: `...`

=2E I didn't look into what the problem is there, but attached the test
log.

I did a build test on a few other Debian machines, arm64 was fine, mips
and mipx64el had 15 failures, ppc64 (i.e. big endian) had 12. I didn't
look in more detail and suggest to tackle one after the other :-)

Best regards
Uwe

--47mliyxh6kgspn6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=buildlog

I: Started sh -c make && make check
O: make: Nothing to be done for 'all'.
O:      TEST    Woverride-init-def (Woverride-init-def.c)
O:      TEST    Woverride-init-no (Woverride-init-no.c)
O:      TEST    Woverride-init-yes (Woverride-init-yes.c)
O:      TEST    warn-unknown-attribute (Wunknown-attribute-def.c)
O:      TEST    warn-unknown-attribute-no (Wunknown-attribute-no.c)
O:      TEST    warn-unknown-attribute-yes (Wunknown-attribute-yes.c)
O:      TEST    __func__ (__func__.c)
O:      TEST    abstract array declarator static (abstract-array-declarator-static.c)
O:      TEST    address_space attribute (address_space.c)
O:      TEST    alias distinct symbols (alias-distinct.c)
O:      TEST    alias symbol/pointer (alias-mixed.c)
O:      TEST    alias same symbols (alias-same.c)
O:      TEST    attribute __alloc_align__ (alloc-align.c)
O:      TEST    alternate keywords (alternate-keywords.c)
O:      TEST    test anonymous union initializer (anon-union.c)
O:      TEST    Asm with goto labels. (asm-empty-clobber.c)
O:      TEST    Asm with goto labels. (asm-goto-lables.c)
O:      TEST    asm-toplevel.c (asm-toplevel.c)
O:      TEST    inline attributes (attr-inline.c)
O:      TEST    attribute no_sanitize_address (attr-no_sanitize_address.c)
O:      TEST    attribute noclone (attr-noclone.c)
O:      TEST    optimize attributes (attr-optimize.c)
O:      TEST    attribute warning (attr-warning.c)
O:      TEST    attribute assume_aligned (attr_aligned.c)
O:      TEST    attribute after ( in direct-declarator (attr_in_parameter.c)
O:      TEST    attribute vector_size (attr_vector_size.c)
O:      TEST    Arithmetic operator code generation (backend/arithmetic-ops.c)
O: error: actual error text does not match expected error text.
O: error: see backend/arithmetic-ops.c.error.* for further investigation.
O: --- backend/arithmetic-ops.c.error.expected	2017-09-09 20:44:47.964306005 +0000
O: +++ backend/arithmetic-ops.c.error.got	2017-09-09 20:44:47.960305943 +0000
O: @@ -0,0 +1,10 @@
O: +{standard input}: Assembler messages:
O: +{standard input}:38: Error: unrecognized opcode: `xsaddsp'
O: +{standard input}:52: Error: unrecognized opcode: `xsadddp'
O: +{standard input}:94: Error: unrecognized opcode: `xssubsp'
O: +{standard input}:108: Error: unrecognized opcode: `xssubdp'
O: +{standard input}:150: Error: unrecognized opcode: `xsmulsp'
O: +{standard input}:164: Error: unrecognized opcode: `xsmuldp'
O: +{standard input}:206: Error: unrecognized opcode: `xsdivsp'
O: +{standard input}:220: Error: unrecognized opcode: `xsdivdp'
O: +mv: cannot stat '/tmp/tmp.8axUUC.o': No such file or directory
O:      TEST    Array code generation (backend/array.c)
O:      TEST    Bitwise operator code generation (backend/bitwise-ops.c)
O:      TEST    Boolean type code generation (backend/bool-test.c)
O:      TEST    Cast code generation (backend/cast.c)
O:      TEST    Comparison operator code generation (backend/cmp-ops.c)
O: error: actual error text does not match expected error text.
O: error: see backend/cmp-ops.c.error.* for further investigation.
O: --- backend/cmp-ops.c.error.expected	2017-09-09 20:44:48.320311523 +0000
O: +++ backend/cmp-ops.c.error.got	2017-09-09 20:44:48.316311461 +0000
O: @@ -0,0 +1,18 @@
O: +{standard input}: Assembler messages:
O: +{standard input}:13: Error: unrecognized opcode: `isel'
O: +{standard input}:29: Error: unrecognized opcode: `isel'
O: +{standard input}:46: Error: unrecognized opcode: `isel'
O: +{standard input}:63: Error: unrecognized opcode: `isel'
O: +{standard input}:79: Error: unrecognized opcode: `isel'
O: +{standard input}:95: Error: unrecognized opcode: `isel'
O: +{standard input}:112: Error: unrecognized opcode: `isel'
O: +{standard input}:129: Error: unrecognized opcode: `isel'
O: +{standard input}:145: Error: unrecognized opcode: `isel'
O: +{standard input}:161: Error: unrecognized opcode: `isel'
O: +{standard input}:178: Error: unrecognized opcode: `isel'
O: +{standard input}:194: Error: unrecognized opcode: `isel'
O: +{standard input}:211: Error: unrecognized opcode: `isel'
O: +{standard input}:228: Error: unrecognized opcode: `isel'
O: +{standard input}:245: Error: unrecognized opcode: `isel'
O: +{standard input}:262: Error: unrecognized opcode: `isel'
O: +mv: cannot stat '/tmp/tmp.DoTA0H.o': No such file or directory
O:      TEST    Extern symbol code generation (backend/extern.c)
O:      TEST    Function pointer code generation (backend/function-ptr.c)
O:      TEST    'hello, world' code generation (backend/hello.c)
O:      TEST    Non-bool condition values in branch/select (backend/int-cond.c)
O: error: actual error text does not match expected error text.
O: error: see backend/int-cond.c.error.* for further investigation.
O: --- backend/int-cond.c.error.expected	2017-09-09 20:44:48.572315429 +0000
O: +++ backend/int-cond.c.error.got	2017-09-09 20:44:48.568315367 +0000
O: @@ -0,0 +1,4 @@
O: +{standard input}: Assembler messages:
O: +{standard input}:11: Error: unrecognized opcode: `isel'
O: +{standard input}:26: Error: unrecognized opcode: `isel'
O: +mv: cannot stat '/tmp/tmp.ytNQ13.o': No such file or directory
O:      TEST    Type of loaded objects (backend/load-type.c)
O:      TEST    Logical operator code generation (backend/logical-ops.c)
O: error: actual error text does not match expected error text.
O: error: see backend/logical-ops.c.error.* for further investigation.
O: --- backend/logical-ops.c.error.expected	2017-09-09 20:44:48.696317351 +0000
O: +++ backend/logical-ops.c.error.got	2017-09-09 20:44:48.692317289 +0000
O: @@ -0,0 +1,4 @@
O: +{standard input}: Assembler messages:
O: +{standard input}:14: Error: unrecognized opcode: `isel'
O: +{standard input}:32: Error: unrecognized opcode: `isel'
O: +mv: cannot stat '/tmp/tmp.onWlTP.o': No such file or directory
O:      TEST    Loops (backend/loop.c)
O:      TEST    Loops with unused counter (backend/loop2.c)
O:      TEST    Pointer cast code generation (backend/ptrcast.c)
O:      TEST    Type of stored objects (backend/store-type.c)
O:      TEST    struct access code generation (backend/struct-access.c)
O:      TEST    Struct code generation (backend/struct.c)
O:      TEST    sum from 1 to n (backend/sum.c)
O:      TEST    Union code generation (backend/union.c)
O:      TEST    void return type code generation (backend/void-return-type.c)
O:      TEST    Bad array designated initializer (bad-array-designated-initializer.c)
O:      TEST    bad assignment (bad-assignment.c)
O:      TEST    Bad cast syntax (bad-cast.c)
O:      TEST    Bad ternary syntax (bad-ternary-cond.c)
O:      TEST    Bad typeof syntax segfault (bad-typeof.c)
O:      TEST    enum not in scope (badtype1.c)
O: info: test 'badtype1.c' is known to fail
O:      TEST    missing type (badtype2.c)
O:      TEST    missing type in argument list (badtype3.c)
O:      TEST    switch(bad_type) {...} segfault (badtype4.c)
O:      TEST    badtype5.c (badtype5.c)
O:      TEST    binary constant (binary-constant.c)
O:      TEST    bitfield size (bitfield-size.c)
O:      TEST    bitfield to integer promotion (bitfields.c)
O:      TEST    conversions to bitwise types (bitwise-cast.c)
O:      TEST    sizeof(bool array) (bool-array.c)
O:      TEST    bool-cast-bad.c (bool-cast-bad.c)
O:      TEST    bool-cast-explicit (bool-cast-explicit.c)
O:      TEST    bool-cast-implicit (bool-cast-implicit.c)
O:      TEST    bool-cast-restricted.c (bool-cast-restricted.c)
O:      TEST    constant folding in bswap builtins (bswap-constant-folding.c)
O:      TEST    inlining switch statement (bug_inline_switch.c)
O:      TEST    builtin-args-checking (builtin-args-checking.c)
O:      TEST    builtin-bswap-constant (builtin-bswap-constant.c)
O:      TEST    builtin-bswap (builtin-bswap-variable.c)
O:      TEST    __builtin_atomic (builtin_atomic.c)
O:      TEST    __builtin_bswap (builtin_bswap.c)
O:      TEST    __builtin INFINITY / nan() (builtin_inf.c)
O:      TEST    __builtin_safe (builtin_safe1.c)
O:      TEST    __builtin_unreachable() (builtin_unreachable.c)
O:      TEST    __builtin_va_arg_pack() (builtin_va_arg_pack.c)
O:      TEST    c11-alignas (c11-alignas.c)
O:      TEST    c11-alignof (c11-alignof.c)
O:      TEST    c11-noreturn (c11-noreturn.c)
O:      TEST    c11-stdc-version (c11-stdc-version.c)
O:      TEST    c11-thread-local (c11-thread-local.c)
O:      TEST    C99 for-loop declarations (c99-for-loop-decl.c)
O:      TEST    C99 for loop variable declaration (c99-for-loop.c)
O:      TEST    Calling convention attributes (calling-convention-attributes.c)
O:      TEST    cast-constant-to-float (cast-constant-to-float.c)
O:      TEST    cast-constants.c (cast-constants.c)
O:      TEST    cast-kinds (cast-kinds.c)
O:      TEST    Segfault in check_byte_count after syntax error (check_byte_count-ice.c)
O:      TEST    choose expr builtin (choose_expr.c)
O:      TEST    Comma and array decay (comma.c)
O:      TEST    Compare null pointer constant to int (compare-null-to-int.c)
O:      TEST    compound-assign-type (compound-assign-type.c)
O:      TEST    cond-address-array.c (cond-address-array.c)
O:      TEST    cond-address-function (cond-address-function.c)
O:      TEST    cond-address.c (cond-address.c)
O:      TEST    cond-err-expand.c (cond-err-expand.c)
O:      TEST    Two-argument conditional expression types (cond_expr.c)
O:      TEST    type of conditional expression (cond_expr2.c)
O:      TEST    result type of relational and logical operators (cond_expr3.c)
O:      TEST    conditional-type (conditional-type.c)
O:      TEST    address of static object's member constness verification. (constexpr-addr-of-static-member.c)
O:      TEST    address of static object constness verification. (constexpr-addr-of-static.c)
O:      TEST    Expression constness propagation in binops and alike (constexpr-binop.c)
O:      TEST    Expression constness propagation in casts (constexpr-cast.c)
O:      TEST    compound literal address constness verification (constexpr-compound-literal.c)
O:      TEST    Expression constness propagation in conditional expressions (constexpr-conditional.c)
O:      TEST    static storage object initializer constness verification. (constexpr-init.c)
O:      TEST    label reference constness verification. (constexpr-labelref.c)
O:      TEST    __builtin_offsetof() constness verification. (constexpr-offsetof.c)
O:      TEST    pointer arithmetic constness verification. (constexpr-pointer-arith.c)
O:      TEST    integer literal cast to pointer type constness verification. (constexpr-pointer-cast.c)
O:      TEST    Expression constness propagation in preops (constexpr-preop.c)
O:      TEST    constness of pure/const builtins (constexpr-pure-builtin.c)
O:      TEST    string literal constness verification. (constexpr-string.c)
O:      TEST    __builtin_types_compatible_p() constness verification. (constexpr-types-compatible-p.c)
O:      TEST    Check -Wcontext (context.c)
O:      TEST    crash add-doms (crash-add-doms.c)
O:      TEST    crash bb_target (crash-bb_target.c)
O:      TEST    crash ep->active (crash-ep-active.c)
O:      TEST    crash ptrlist (crash-ptrlist.c)
O:      TEST    crash rewrite_branch (crash-rewrite-branch.c)
O:      TEST    crazy02-not-so.c (crazy02-not-so.c)
O:      TEST    crazy03.c (crazy03.c)
O:      TEST    declaration after statement (ANSI) (declaration-after-statement-ansi.c)
O:      TEST    declaration after statement (C89) (declaration-after-statement-c89.c)
O:      TEST    declaration after statement (C99) (declaration-after-statement-c99.c)
O:      TEST    declaration after statement (default) (declaration-after-statement-default.c)
O:      TEST    finding definitions (definitions.c)
O:      TEST    designated_init attribute (designated-init.c)
O:      TEST    discarded-label-statement (discarded-label-statement.c)
O:      TEST    division constants (div.c)
O:      TEST    Double semicolon in struct (double-semicolon.c)
O:      TEST    Dubious bitwise operation on !x (dubious-bitwise-with-not.c)
O:      TEST    endian-big.c (endian-big.c)
O:      TEST    endian-little.c (endian-little.c)
O:      TEST    enum-mismatch (enum-mismatch.c)
O:      TEST    enumeration constants' scope [6.2.1p7] (enum_scope.c)
O:      TEST    Character escape sequences (escapes.c)
O:      TEST    duplicate extern array (extern-array.c)
O:      TEST    extern inline function (extern-inline.c)
O:      TEST    field overlap (field-overlap.c)
O:      TEST    field-override (field-override.c)
O:      TEST    Forced function argument type. (fored_arg.c)
O:      TEST    foul bitwise (foul-bitwise.c)
O:      TEST    fp-vs-ptrcast (fp-vs-ptrcast.c)
O:      TEST    Function pointer inheritance (function-pointer-inheritance.c)
O:      TEST    function-redecl (function-redecl.c)
O:      TEST    goto labels (goto-label.c)
O:      TEST    identifier-list parsing (identifier_list.c)
O:      TEST    implicit-ret-type.c (implicit-ret-type.c)
O:      TEST    implicit-type.c (implicit-type.c)
O:      TEST    internal infinite loop (0) (infinite-loop0.c)
O:      TEST    infinite loop 02 (infinite-loop02.c)
O:      TEST    infinite loop 03 (infinite-loop03.c)
O:      TEST    char array initializers (init-char-array.c)
O:      TEST    parenthesized string initializer (init-char-array1.c)
O:      TEST    -Winit-cstring option (init_cstring.c)
O:      TEST    Initializer entry defined twice (initializer-entry-defined-twice.c)
O:      TEST    inline compound literals (inline_compound_literals.c)
O:      TEST    int128 (int128.c)
O:      TEST    Integer promotions (integer-promotions.c)
O:      TEST    integer constant & conditional expression (ioc-typecheck.c)
O: info: test 'ioc-typecheck.c' is known to fail
O:      TEST    kill-casts (kill-casts.c)
O:      TEST    kill-computedgoto (kill-computedgoto.c)
O:      TEST    kill-cse (kill-cse.c)
O:      TEST    kill insert-branch (kill-insert-branch.c)
O:      TEST    kill-load (kill-load.c)
O:      TEST    kill-phi-node (kill-phi-node.c)
O:      TEST    kill-phi-ttsbb (kill-phi-ttsbb.c)
O:      TEST    kill-phi-ttsbb2 (kill-phi-ttsbb2.c)
O:      TEST    kill-phisrc (kill-phisrc.c)
O:      TEST    kill-pure-call (kill-pure-call.c)
O:      TEST    kill-replaced-insn (kill-replaced-insn.c)
O:      TEST    kill-rewritten-load (kill-rewritten-load.c)
O:      TEST    kill-select (kill-select.c)
O:      TEST    kill-slice (kill-slice.c)
O:      TEST    kill-store (kill-store.c)
O:      TEST    kill-unreachable-phi (kill-unreachable-phi.c)
O:      TEST    Label followed by __asm__ (label-asm.c)
O:      TEST    Label attribute (label-attr.c)
O:      TEST    label-expr (label-expr.c)
O:      TEST    __label__ scope (label-scope.c)
O:      TEST    bitfield initializer mask (linear/bitfield-init-mask.c)
O:      TEST    bitfield implicit init zero (linear/bitfield-init-zero.c)
O:      TEST    missing instruction's size (linear/missing-insn-size.c)
O:      TEST    struct implicit init zero not needed (linear/struct-init-full.c)
O: info: test 'linear/struct-init-full.c' is known to fail
O:      TEST    struct implicit init zero needed (linear/struct-init-partial.c)
O:      TEST    Local label (local-label.c)
O:      TEST    Logical and/or (logical.c)
O:      TEST    loop-linearization (loop-linearization.c)
O:      TEST    Expansion of typeof when dealing with member of struct (member_of_typeof.c)
O:      TEST    memops-volatile (memops-volatile.c)
O:      TEST    handling of identifier-less declarations (missing-ident.c)
O:      TEST    typedefs with many declarators (multi_typedef.c)
O:      TEST    nested declarator vs. parameters (nested-declarator.c)
O:      TEST    more on handling of ( in direct-declarator (nested-declarator2.c)
O:      TEST    nocast.c (nocast.c)
O:      TEST    noderef attribute (noderef.c)
O:      TEST    Using plain integer as NULL pointer (non-pointer-null.c)
O:      TEST    Old initializer with -Wno-old-initializer (old-initializer-nowarn.c)
O:      TEST    Old initializer (old-initializer.c)
O:      TEST    double-unop (optim/binops-same-args.c)
O:      TEST    bool-context (optim/bool-context.c)
O:      TEST    bool-same-args (optim/bool-same-args.c)
O:      TEST    bool-simplify (optim/bool-simplify.c)
O:      TEST    cse-commutativity (optim/cse-commutativity.c)
O:      TEST    cse-dual-compare (optim/cse-dual-compare.c)
O: info: test 'optim/cse-dual-compare.c' is known to fail
O:      TEST    double-unop (optim/double-unop.c)
O:      TEST    fpcast-nop (optim/fpcast-nop.c)
O:      TEST    muldiv-by-one (optim/muldiv-by-one.c)
O:      TEST    muldiv-by-zero (optim/muldiv-by-zero.c)
O:      TEST    muldiv-minus-one (optim/muldiv-minus-one.c)
O:      TEST    optim/setcc-setcc (optim/setcc-setcc.c)
O:      TEST    optim/setcc-seteq (optim/setcc-seteq.c)
O:      TEST    optim/setcc-setne (optim/setcc-setne.c)
O:      TEST    Ignore VOID in if-convert (optim/void-if-convert.c)
O:      TEST    There is no scope boundary between global and file scope (outer-scope.c)
O:      TEST    #pragma once (pragma-once.c)
O:      TEST    __COUNTER__ #1 (preprocessor/counter1.c)
O:      TEST    __COUNTER__ #2 (preprocessor/counter2.c)
O:      TEST    __COUNTER__ #3 (preprocessor/counter3.c)
O:      TEST    dump-macros with empty file (preprocessor/dump-macros-empty.c)
O:      TEST    dump-macros with multiple files (preprocessor/dump-macros-multi.c)
O:      TEST    dump-macros (preprocessor/dump-macros.c)
O:      TEST    early-escape (preprocessor/early-escape.c)
O:      TEST    predefined __<type>_BIT__ (preprocessor/predef-char-bit.c)
O:      TEST    predefined __<type>_MAX__ (preprocessor/predef-max.c)
O:      TEST    predefined __SIZEOF_<type>__ (preprocessor/predef-sizeof.c)
O:      TEST    Preprocessor #1 (preprocessor/preprocessor1.c)
O:      TEST    Preprocessor #10 (preprocessor/preprocessor10.c)
O:      TEST    Preprocessor #11 (preprocessor/preprocessor11.c)
O:      TEST    Preprocessor #12 (preprocessor/preprocessor12.c)
O:      TEST    Preprocessor #13 (preprocessor/preprocessor13.c)
O:      TEST    Preprocessor #14 (preprocessor/preprocessor14.c)
O:      TEST    Preprocessor #15 (preprocessor/preprocessor15.c)
O:      TEST    Preprocessor #16 (preprocessor/preprocessor16.c)
O:      TEST    Preprocessor #17 (preprocessor/preprocessor17.c)
O:      TEST    Preprocessor #18 (preprocessor/preprocessor18.c)
O:      TEST    Preprocessor #19 (preprocessor/preprocessor19.c)
O:      TEST    Preprocessor #2 (preprocessor/preprocessor2.c)
O:      TEST    Preprocessor #20 (preprocessor/preprocessor20.c)
O:      TEST    Preprocessor #21 (preprocessor/preprocessor21.c)
O:      TEST    Preprocessor #22 (preprocessor/preprocessor22.c)
O:      TEST    Preprocessor #23 (preprocessor/preprocessor23.c)
O:      TEST    Preprocessor #3 (preprocessor/preprocessor3.c)
O:      TEST    Preprocessor #4 (preprocessor/preprocessor4.c)
O:      TEST    Preprocessor #5 (preprocessor/preprocessor5.c)
O:      TEST    Preprocessor #6 (preprocessor/preprocessor6.c)
O:      TEST    Preprocessor #7 (preprocessor/preprocessor7.c)
O:      TEST    Preprocessor #8 (preprocessor/preprocessor8.c)
O:      TEST    Preprocessor #9 (preprocessor/preprocessor9.c)
O:      TEST    Preprocessor #14 (preprocessor/stringify.c)
O:      TEST    wide char token-pasting (preprocessor/wide.c)
O:      TEST    Compile skip function prototype (prototype.c)
O:      TEST    ptr-inherit.c (ptr-inherit.c)
O:      TEST    Pure function attribute (pure-function.c)
O:      TEST    const et.al. are reserved identifiers (reserved.c)
O:      TEST    restrict array attribute (restrict-array.c)
O:      TEST    typeof with bitwise types (restricted-typeof.c)
O:      TEST    sizeof(_Bool) is valid (sizeof-bool.c)
O:      TEST    Handling of sizeof compound-literal . member (sizeof-compound-postfix.c)
O:      TEST    valid specifier combinations (specifiers1.c)
O:      TEST    invalid specifier combinations (specifiers2.c)
O:      TEST    static forward declaration (static-forward-decl.c)
O:      TEST    static assertion (static_assert.c)
O:      TEST    Address space of a struct member (struct-as.c)
O:      TEST    struct attribute placement (struct-attribute-placement.c)
O:      TEST    struct namespaces #1 (struct-ns1.c)
O:      TEST    struct not in scope (struct-ns2.c)
O: info: test 'struct-ns2.c' is known to fail
O:      TEST    struct size (struct-size1.c)
O:      TEST    tautological-compare (tautological-compare.c)
O:      TEST    binary operations (test-be.c)
O:      TEST    selfcheck1 (testsuite-selfcheck1.c)
O:      TEST    selfcheck2 (testsuite-selfcheck2.c)
O: info: test 'testsuite-selfcheck2.c' is known to fail
O:      TEST    selfcheck3 (testsuite-selfcheck3.c)
O: info: test 'testsuite-selfcheck3.c' is known to fail
O:      TEST    Transparent union attribute. (transparent-union.c)
O:      TEST    "char []" to "char *" demotion (type1.c)
O:      TEST    typedef shadowing (typedef_shadow.c)
O:      TEST    typeof-addresspace.c (typeof-addresspace.c)
O: info: test 'typeof-addresspace.c' is known to fail
O:      TEST    Rusty Russell's typeof attribute casting. (typeof-attribute.c)
O:      TEST    typeof-mods (typeof-mods.c)
O:      TEST    typeof-noderef (typeof-noderef.c)
O: info: test 'typeof-noderef.c' is known to fail
O:      TEST    typeof-safe (typeof-safe.c)
O: info: test 'typeof-safe.c' is known to fail
O:      TEST    -Wtypesign (typesign.c)
O:      TEST    Varargs bogus warning regression test #1 (varargs1.c)
O:      TEST    wide character constants (wide.c)
E: make: *** [check] Error 1
O: Out of 287 tests, 273 passed, 14 failed (10 of them are known to fail)
O: Makefile:232: recipe for target 'check' failed
I: Finished with exitcode 2

--47mliyxh6kgspn6h--

--5ailwiket2nk6crx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlm0VtMACgkQwfwUeK3K
7AlOoQf/ZTMrUwC4C85aUJUMD3/vQZZO6iEbD9u78fPyVE/d8z4Pv3HG6ZfEfa9t
DP+cjd0oxGU0PyfAhyR3YiC9HTWQ/x1w9b/RcPwr5Zr+jw1FsxKx46zYGp3OgD7p
v0rpXKUYEUCMMAn4URojjWZfJrPWYHaTbwl+L6SHwAVyuV885py1K9LrvUSFK35V
oQb2QLq6A8tKBA09xl0sOc1m8AEMC4Kg82XLJNwHYMa24j5IwuI9gBTteu6v/r55
xqBXkk87dZOXijQzWu82i0Vv2fD+TngIZrQVMvPip7LMdE7GkNon6T3zZhe/3BtK
jZaG3gx9JMFZ5/rkFkED01eU8QWhyA==
=30jB
-----END PGP SIGNATURE-----

--5ailwiket2nk6crx--
