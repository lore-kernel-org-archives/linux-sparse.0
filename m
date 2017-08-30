From: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Bug#873508: sparse test failures on ppc32le (and other not so common archs)
Date: Wed, 30 Aug 2017 18:14:42 +0200
Message-ID: <20170830161435.krq44m5zub4mq43x@taurus.defre.kleine-koenig.org>
References: <150392922734.24087.13050909898214597041.reportbug@curie.anarc.at>
Reply-To: Uwe =?UTF-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>, 873508@bugs.debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b2wgqps352tkjbkb"
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.873508.B873508.15041096888869@bugs.debian.org>
Content-Disposition: inline
List-URL: <https://lists.debian.org/debian-bugs-dist/>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: linux-sparse@vger.kernel.org
Cc: 873508@bugs.debian.org, Antoine Beaupre <anarcat@debian.org>
List-Id: linux-sparse@vger.kernel.org


--b2wgqps352tkjbkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Antoine Beaupre (on Cc:) noticed that sparse doesn't work on some not so
common architectures like ppc32le, s390x, ppc64 and sparc64[1]. This is
nicely catched by the testsuite, e.g.:

	ukleinek@plummer:~/sparse$ git rev-parse HEAD
	958c11c35d98417eb6b948bffe2dffed14eb3320
	ukleinek@plummer:~/sparse$ uname -a
	Linux plummer 4.9.0-3-powerpc64le #1 SMP Debian 4.9.30-2+deb9u3 (2017-08-0=
6) ppc64le GNU/Linux
	ukleinek@plummer:~/sparse$ make check V=3D1
	cd validation && ./test-suite
	     TEST    Woverride-init-def (Woverride-init-def.c)
		Using command       : ../sparse Woverride-init-def.c
		Expecting exit value: 0
	     TEST    Woverride-init-no (Woverride-init-no.c)
		Using command       : ../sparse -Wno-override-init Woverride-init-no.c
		Expecting exit value: 0
	     TEST    Woverride-init-yes (Woverride-init-yes.c)
		Using command       : ../sparse -Woverride-init Woverride-init-yes.c
		Expecting exit value: 0
	     TEST    warn-unknown-attribute (Wunknown-attribute-def.c)
		Using command       : ../sparse Wunknown-attribute-def.c
		Expecting exit value: 0
	     TEST    warn-unknown-attribute-no (Wunknown-attribute-no.c)
		Using command       : ../sparse -Wno-unknown-attribute Wunknown-attribute=
-no.c
		Expecting exit value: 0
	     TEST    warn-unknown-attribute-yes (Wunknown-attribute-yes.c)
		Using command       : ../sparse -Wunknown-attribute Wunknown-attribute-ye=
s.c
		Expecting exit value: 0
	     TEST    __func__ (__func__.c)
		Using command       : ../sparse -Wall __func__.c
		Expecting exit value: 0
	     TEST    abstract array declarator static (abstract-array-declarator-s=
tatic.c)
		Using command       : ../sparse abstract-array-declarator-static.c
		Expecting exit value: 0
	     TEST    address_space attribute (address_space.c)
		Using command       : ../sparse address_space.c
		Expecting exit value: 0
	     TEST    alias distinct symbols (alias-distinct.c)
		Using command       : ../test-linearize alias-distinct.c
		Expecting exit value: 0
	     TEST    alias symbol/pointer (alias-mixed.c)
		Using command       : ../test-linearize alias-mixed.c
		Expecting exit value: 0
	     TEST    alias same symbols (alias-same.c)
		Using command       : ../test-linearize alias-same.c
		Expecting exit value: 0
	     TEST    attribute __alloc_align__ (alloc-align.c)
		Using command       : ../sparse alloc-align.c
		Expecting exit value: 0
	     TEST    alternate keywords (alternate-keywords.c)
		Using command       : ../sparse alternate-keywords.c
		Expecting exit value: 0
	     TEST    test anonymous union initializer (anon-union.c)
		Using command       : ../sparse anon-union.c
		Expecting exit value: 0
	     TEST    Asm with goto labels. (asm-empty-clobber.c)
		Using command       : ../sparse asm-empty-clobber.c
		Expecting exit value: 0
	     TEST    Asm with goto labels. (asm-goto-lables.c)
		Using command       : ../sparse asm-goto-lables.c
		Expecting exit value: 0
	     TEST    asm-toplevel.c (asm-toplevel.c)
		Using command       : ../test-linearize asm-toplevel.c
		Expecting exit value: 0
	     TEST    inline attributes (attr-inline.c)
		Using command       : ../sparse attr-inline.c
		Expecting exit value: 0
	     TEST    attribute no_sanitize_address (attr-no_sanitize_address.c)
		Using command       : ../sparse attr-no_sanitize_address.c
		Expecting exit value: 0
	     TEST    attribute noclone (attr-noclone.c)
		Using command       : ../sparse attr-noclone.c
		Expecting exit value: 0
	     TEST    optimize attributes (attr-optimize.c)
		Using command       : ../sparse attr-optimize.c
		Expecting exit value: 0
	     TEST    attribute warning (attr-warning.c)
		Using command       : ../sparse attr-warning.c
		Expecting exit value: 0
	     TEST    attribute assume_aligned (attr_aligned.c)
		Using command       : ../sparse attr_aligned.c
		Expecting exit value: 0
	     TEST    attribute after ( in direct-declarator (attr_in_parameter.c)
		Using command       : ../sparse attr_in_parameter.c
		Expecting exit value: 0
	     TEST    attribute vector_size (attr_vector_size.c)
		Using command       : ../sparse attr_vector_size.c
		Expecting exit value: 0
	     TEST    Arithmetic operator code generation (backend/arithmetic-ops.c)
		Using command       : ../sparsec -c backend/arithmetic-ops.c -o tmp.o
		Expecting exit value: 0
	error: actual error text does not match expected error text.
	error: see backend/arithmetic-ops.c.error.* for further investigation.
	--- backend/arithmetic-ops.c.error.expected	2017-08-30 16:02:05.100096386 =
+0000
	+++ backend/arithmetic-ops.c.error.got	2017-08-30 16:02:05.096096330 +0000
	@@ -0,0 +1,10 @@
	+{standard input}: Assembler messages:
	+{standard input}:38: Error: unrecognized opcode: `xsaddsp'
	+{standard input}:52: Error: unrecognized opcode: `xsadddp'
	+{standard input}:94: Error: unrecognized opcode: `xssubsp'
	+{standard input}:108: Error: unrecognized opcode: `xssubdp'
	+{standard input}:150: Error: unrecognized opcode: `xsmulsp'
	+{standard input}:164: Error: unrecognized opcode: `xsmuldp'
	+{standard input}:206: Error: unrecognized opcode: `xsdivsp'
	+{standard input}:220: Error: unrecognized opcode: `xsdivdp'
	+mv: cannot stat '/tmp/tmp.RyRzUr.o': No such file or directory
	     TEST    Array code generation (backend/array.c)
		Using command       : ../sparsec -c backend/array.c -o tmp.o
		Expecting exit value: 0
	     TEST    Bitwise operator code generation (backend/bitwise-ops.c)
		Using command       : ../sparsec -c backend/bitwise-ops.c -o tmp.o
		Expecting exit value: 0
	     TEST    Boolean type code generation (backend/bool-test.c)
		Using command       : ../sparsec -c backend/bool-test.c -o tmp.o
		Expecting exit value: 0
	     TEST    Cast code generation (backend/cast.c)
		Using command       : ../sparsec -c backend/cast.c -o tmp.o
		Expecting exit value: 0
	     TEST    Comparison operator code generation (backend/cmp-ops.c)
		Using command       : ../sparsec -c backend/cmp-ops.c -o tmp.o
		Expecting exit value: 0
	error: actual error text does not match expected error text.
	error: see backend/cmp-ops.c.error.* for further investigation.
	--- backend/cmp-ops.c.error.expected	2017-08-30 16:02:05.392100473 +0000
	+++ backend/cmp-ops.c.error.got	2017-08-30 16:02:05.384100361 +0000
	@@ -0,0 +1,18 @@
	+{standard input}: Assembler messages:
	+{standard input}:13: Error: unrecognized opcode: `isel'
	+{standard input}:29: Error: unrecognized opcode: `isel'
	+{standard input}:46: Error: unrecognized opcode: `isel'
	+{standard input}:63: Error: unrecognized opcode: `isel'
	+{standard input}:79: Error: unrecognized opcode: `isel'
	+{standard input}:95: Error: unrecognized opcode: `isel'
	+{standard input}:112: Error: unrecognized opcode: `isel'
	+{standard input}:129: Error: unrecognized opcode: `isel'
	+{standard input}:145: Error: unrecognized opcode: `isel'
	+{standard input}:161: Error: unrecognized opcode: `isel'
	+{standard input}:178: Error: unrecognized opcode: `isel'
	+{standard input}:194: Error: unrecognized opcode: `isel'
	+{standard input}:211: Error: unrecognized opcode: `isel'
	+{standard input}:228: Error: unrecognized opcode: `isel'
	+{standard input}:245: Error: unrecognized opcode: `isel'
	+{standard input}:262: Error: unrecognized opcode: `isel'
	+mv: cannot stat '/tmp/tmp.ui73QJ.o': No such file or directory
	     TEST    Extern symbol code generation (backend/extern.c)
		Using command       : ../sparsec -c backend/extern.c -o tmp.o
		Expecting exit value: 0
	     TEST    Function pointer code generation (backend/function-ptr.c)
		Using command       : ../sparsec -c backend/function-ptr.c -o tmp.o
		Expecting exit value: 0
	     TEST    'hello, world' code generation (backend/hello.c)
		Using command       : ../sparsec -c backend/hello.c -o tmp.o
		Expecting exit value: 0
	error: actual error text does not match expected error text.
	error: see backend/hello.c.error.* for further investigation.
	--- backend/hello.c.error.expected	2017-08-30 16:02:05.528102376 +0000
	+++ backend/hello.c.error.got	2017-08-30 16:02:05.496101928 +0000
	@@ -0,0 +1 @@
	+/usr/include/powerpc64le-linux-gnu/gnu/stubs.h:8:12: error: unable to ope=
n 'gnu/stubs-32.h'
	     TEST    Non-bool condition values in branch/select (backend/int-cond.=
c)
		Using command       : ../sparsec -c backend/int-cond.c -o tmp.o
		Expecting exit value: 0
	error: actual error text does not match expected error text.
	error: see backend/int-cond.c.error.* for further investigation.
	--- backend/int-cond.c.error.expected	2017-08-30 16:02:05.576103048 +0000
	+++ backend/int-cond.c.error.got	2017-08-30 16:02:05.572102992 +0000
	@@ -0,0 +1,4 @@
	+{standard input}: Assembler messages:
	+{standard input}:11: Error: unrecognized opcode: `isel'
	+{standard input}:26: Error: unrecognized opcode: `isel'
	+mv: cannot stat '/tmp/tmp.M5YFeP.o': No such file or directory
	     TEST    Type of loaded objects (backend/load-type.c)
		Using command       : ../sparsec -c backend/load-type.c -o tmp.o
		Expecting exit value: 0
	     TEST    Logical operator code generation (backend/logical-ops.c)
		Using command       : ../sparsec -c backend/logical-ops.c -o tmp.o
		Expecting exit value: 0
	error: actual error text does not match expected error text.
	error: see backend/logical-ops.c.error.* for further investigation.
	--- backend/logical-ops.c.error.expected	2017-08-30 16:02:05.668104336 +00=
00
	+++ backend/logical-ops.c.error.got	2017-08-30 16:02:05.664104280 +0000
	@@ -0,0 +1,4 @@
	+{standard input}: Assembler messages:
	+{standard input}:14: Error: unrecognized opcode: `isel'
	+{standard input}:32: Error: unrecognized opcode: `isel'
	+mv: cannot stat '/tmp/tmp.gKQ3me.o': No such file or directory
	     TEST    Loops (backend/loop.c)
		Using command       : ../sparsec -c backend/loop.c -o tmp.o
		Expecting exit value: 0
	     TEST    Loops with unused counter (backend/loop2.c)
		Using command       : ../sparsec -c backend/loop2.c -o tmp.o
		Expecting exit value: 0
	     TEST    Pointer cast code generation (backend/ptrcast.c)
		Using command       : ../sparsec -c backend/ptrcast.c -o tmp.o
		Expecting exit value: 0
	     TEST    Type of stored objects (backend/store-type.c)
		Using command       : ../sparsec -c backend/store-type.c -o tmp.o
		Expecting exit value: 0
	     TEST    struct access code generation (backend/struct-access.c)
		Using command       : ../sparsec -c backend/struct-access.c -o tmp.o
		Expecting exit value: 0
	     TEST    Struct code generation (backend/struct.c)
		Using command       : ../sparsec -c backend/struct.c -o tmp.o
		Expecting exit value: 0
	     TEST    sum from 1 to n (backend/sum.c)
		Using command       : ../sparsei backend/sum.c
		Expecting exit value: 0
	     TEST    Union code generation (backend/union.c)
		Using command       : ../sparsec -c backend/union.c -o tmp.o
		Expecting exit value: 0
	     TEST    void return type code generation (backend/void-return-type.c)
		Using command       : ../sparsec -c backend/void-return-type.c -o tmp.o
		Expecting exit value: 0
	     TEST    Bad array designated initializer (bad-array-designated-initia=
lizer.c)
		Using command       : ../sparse bad-array-designated-initializer.c
		Expecting exit value: 0
	     TEST    bad assignment (bad-assignment.c)
		Using command       : ../sparse bad-assignment.c
		Expecting exit value: 0
	     TEST    Bad cast syntax (bad-cast.c)
		Using command       : ../sparse bad-cast.c
		Expecting exit value: 0
	     TEST    Bad ternary syntax (bad-ternary-cond.c)
		Using command       : ../sparse bad-ternary-cond.c
		Expecting exit value: 0
	     TEST    Bad typeof syntax segfault (bad-typeof.c)
		Using command       : ../sparse bad-typeof.c
		Expecting exit value: 0
	     TEST    enum not in scope (badtype1.c)
		Using command       : ../sparse badtype1.c
		Expecting exit value: 0
	error: actual error text does not match expected error text.
	error: see badtype1.c.error.* for further investigation.
	--- badtype1.c.error.expected	2017-08-30 16:02:06.144110998 +0000
	+++ badtype1.c.error.got	2017-08-30 16:02:06.140110942 +0000
	@@ -1 +0,0 @@
	-badtype1.c:1:22: warning: bad scope for 'enum bar'
	info: test 'badtype1.c' is known to fail
	     TEST    missing type (badtype2.c)
		Using command       : ../sparse badtype2.c
		Expecting exit value: 0
	     TEST    missing type in argument list (badtype3.c)
		Using command       : ../sparse badtype3.c
		Expecting exit value: 0
	     TEST    switch(bad_type) {...} segfault (badtype4.c)
		Using command       : ../sparse badtype4.c
		Expecting exit value: 0
	     TEST    badtype5.c (badtype5.c)
		Using command       : ../sparse badtype5.c
		Expecting exit value: 0
	     TEST    binary constant (binary-constant.c)
		Using command       : ../sparse binary-constant.c
		Expecting exit value: 0
	     TEST    bitfield size (bitfield-size.c)
		Using command       : ../test-linearize -Wno-decl bitfield-size.c
		Expecting exit value: 0
	     TEST    bitfield to integer promotion (bitfields.c)
		Using command       : ../sparse bitfields.c
		Expecting exit value: 0
	     TEST    conversions to bitwise types (bitwise-cast.c)
		Using command       : ../sparse -Wbitwise bitwise-cast.c
		Expecting exit value: 0
	     TEST    sizeof(bool array) (bool-array.c)
		Using command       : ../sparse -Wno-sizeof-bool bool-array.c
		Expecting exit value: 0
	     TEST    bool-cast-bad.c (bool-cast-bad.c)
		Using command       : ../sparse bool-cast-bad.c
		Expecting exit value: 0
	     TEST    bool-cast-explicit (bool-cast-explicit.c)
		Using command       : ../test-linearize -m64 bool-cast-explicit.c
		Expecting exit value: 0
	     TEST    bool-cast-implicit (bool-cast-implicit.c)
		Using command       : ../test-linearize -m64 bool-cast-implicit.c
		Expecting exit value: 0
	     TEST    bool-cast-restricted.c (bool-cast-restricted.c)
		Using command       : ../sparse -Wno-decl bool-cast-restricted.c
		Expecting exit value: 0
	     TEST    constant folding in bswap builtins (bswap-constant-folding.c)
		Using command       : ../sparse bswap-constant-folding.c
		Expecting exit value: 0
	     TEST    inlining switch statement (bug_inline_switch.c)
		Using command       : ../sparse bug_inline_switch.c
		Expecting exit value: 0
	     TEST    builtin-args-checking (builtin-args-checking.c)
		Using command       : ../sparse builtin-args-checking.c
		Expecting exit value: 0
	     TEST    builtin-bswap-constant (builtin-bswap-constant.c)
		Using command       : ../test-linearize builtin-bswap-constant.c
		Expecting exit value: 0
	     TEST    builtin-bswap (builtin-bswap-variable.c)
		Using command       : ../test-linearize builtin-bswap-variable.c
		Expecting exit value: 0
	     TEST    __builtin_atomic (builtin_atomic.c)
		Using command       : ../sparse builtin_atomic.c
		Expecting exit value: 0
	     TEST    __builtin_bswap (builtin_bswap.c)
		Using command       : ../sparse builtin_bswap.c
		Expecting exit value: 0
	     TEST    __builtin INFINITY / nan() (builtin_inf.c)
		Using command       : ../sparse builtin_inf.c
		Expecting exit value: 0
	     TEST    __builtin_safe (builtin_safe1.c)
		Using command       : ../sparse builtin_safe1.c
		Expecting exit value: 0
	     TEST    __builtin_unreachable() (builtin_unreachable.c)
		Using command       : ../sparse builtin_unreachable.c
		Expecting exit value: 0
	     TEST    __builtin_va_arg_pack() (builtin_va_arg_pack.c)
		Using command       : ../sparse builtin_va_arg_pack.c
		Expecting exit value: 0
	     TEST    c11-alignas (c11-alignas.c)
		Using command       : ../test-linearize -std=3Dc11 c11-alignas.c
		Expecting exit value: 0
	     TEST    c11-alignof (c11-alignof.c)
		Using command       : ../test-linearize -std=3Dc11 c11-alignof.c
		Expecting exit value: 0
	     TEST    c11-noreturn (c11-noreturn.c)
		Using command       : ../test-parsing -std=3Dc11 c11-noreturn.c
		Expecting exit value: 0
	     TEST    c11-stdc-version (c11-stdc-version.c)
		Using command       : ../sparse -E -std=3Dc11 c11-stdc-version.c
		Expecting exit value: 0
	     TEST    c11-thread-local (c11-thread-local.c)
		Using command       : ../test-parsing -std=3Dc11 c11-thread-local.c
		Expecting exit value: 0
	     TEST    C99 for-loop declarations (c99-for-loop-decl.c)
		Using command       : ../sparse c99-for-loop-decl.c
		Expecting exit value: 0
	     TEST    C99 for loop variable declaration (c99-for-loop.c)
		Using command       : ../test-linearize c99-for-loop.c
		Expecting exit value: 0
	     TEST    Calling convention attributes (calling-convention-attributes.=
c)
		Using command       : ../sparse calling-convention-attributes.c
		Expecting exit value: 0
	     TEST    cast-constant-to-float (cast-constant-to-float.c)
		Using command       : ../test-linearize -Wno-decl cast-constant-to-float.c
		Expecting exit value: 0
	     TEST    cast-constants.c (cast-constants.c)
		Using command       : ../test-linearize -m64 cast-constants.c
		Expecting exit value: 0
	     TEST    cast-kinds (cast-kinds.c)
		Using command       : ../test-linearize -m64 cast-kinds.c
		Expecting exit value: 0
	     TEST    Segfault in check_byte_count after syntax error (check_byte_c=
ount-ice.c)
		Using command       : ../sparse check_byte_count-ice.c
		Expecting exit value: 0
	     TEST    choose expr builtin (choose_expr.c)
		Using command       : ../sparse choose_expr.c
		Expecting exit value: 0
	     TEST    Comma and array decay (comma.c)
		Using command       : ../sparse comma.c
		Expecting exit value: 0
	     TEST    Compare null pointer constant to int (compare-null-to-int.c)
		Using command       : ../sparse compare-null-to-int.c
		Expecting exit value: 0
	     TEST    compound-assign-type (compound-assign-type.c)
		Using command       : ../test-linearize -m64 compound-assign-type.c
		Expecting exit value: 0
	     TEST    cond-address-array.c (cond-address-array.c)
		Using command       : ../test-linearize -Wno-decl -Waddress cond-address-=
array.c
		Expecting exit value: 0
	     TEST    cond-address-function (cond-address-function.c)
		Using command       : ../test-linearize -Wno-decl -Waddress cond-address-=
function.c
		Expecting exit value: 0
	     TEST    cond-address.c (cond-address.c)
		Using command       : ../test-linearize -Wno-decl cond-address.c
		Expecting exit value: 0
	     TEST    cond-err-expand.c (cond-err-expand.c)
		Using command       : ../test-linearize -Wno-decl cond-err-expand.c
		Expecting exit value: 0
	     TEST    Two-argument conditional expression types (cond_expr.c)
		Using command       : ../sparse cond_expr.c
		Expecting exit value: 0
	     TEST    type of conditional expression (cond_expr2.c)
		Using command       : ../sparse cond_expr2.c
		Expecting exit value: 0
	     TEST    result type of relational and logical operators (cond_expr3.c)
		Using command       : ../sparse cond_expr3.c
		Expecting exit value: 0
	     TEST    conditional-type (conditional-type.c)
		Using command       : ../sparse conditional-type.c
		Expecting exit value: 0
	     TEST    address of static object's member constness verification. (co=
nstexpr-addr-of-static-member.c)
		Using command       : ../sparse -Wconstexpr-not-const constexpr-addr-of-s=
tatic-member.c
		Expecting exit value: 0
	     TEST    address of static object constness verification. (constexpr-a=
ddr-of-static.c)
		Using command       : ../sparse -Wconstexpr-not-const constexpr-addr-of-s=
tatic.c
		Expecting exit value: 0
	     TEST    Expression constness propagation in binops and alike (constex=
pr-binop.c)
		Using command       : ../sparse constexpr-binop.c
		Expecting exit value: 0
	     TEST    Expression constness propagation in casts (constexpr-cast.c)
		Using command       : ../sparse constexpr-cast.c
		Expecting exit value: 0
	     TEST    compound literal address constness verification (constexpr-co=
mpound-literal.c)
		Using command       : ../sparse -Wconstexpr-not-const constexpr-compound-=
literal.c
		Expecting exit value: 0
	     TEST    Expression constness propagation in conditional expressions (=
constexpr-conditional.c)
		Using command       : ../sparse constexpr-conditional.c
		Expecting exit value: 0
	     TEST    static storage object initializer constness verification. (co=
nstexpr-init.c)
		Using command       : ../sparse -Wconstexpr-not-const constexpr-init.c
		Expecting exit value: 0
	     TEST    label reference constness verification. (constexpr-labelref.c)
		Using command       : ../sparse -Wconstexpr-not-const constexpr-labelref.c
		Expecting exit value: 0
	     TEST    __builtin_offsetof() constness verification. (constexpr-offse=
tof.c)
		Using command       : ../sparse constexpr-offsetof.c
		Expecting exit value: 0
	     TEST    pointer arithmetic constness verification. (constexpr-pointer=
-arith.c)
		Using command       : ../sparse -Wconstexpr-not-const constexpr-pointer-a=
rith.c
		Expecting exit value: 0
	     TEST    integer literal cast to pointer type constness verification. =
(constexpr-pointer-cast.c)
		Using command       : ../sparse -Wconstexpr-not-const constexpr-pointer-c=
ast.c
		Expecting exit value: 0
	     TEST    Expression constness propagation in preops (constexpr-preop.c)
		Using command       : ../sparse constexpr-preop.c
		Expecting exit value: 0
	     TEST    constness of pure/const builtins (constexpr-pure-builtin.c)
		Using command       : ../sparse constexpr-pure-builtin.c
		Expecting exit value: 0
	     TEST    string literal constness verification. (constexpr-string.c)
		Using command       : ../sparse -Wconstexpr-not-const constexpr-string.c
		Expecting exit value: 0
	     TEST    __builtin_types_compatible_p() constness verification. (const=
expr-types-compatible-p.c)
		Using command       : ../sparse constexpr-types-compatible-p.c
		Expecting exit value: 0
	     TEST    Check -Wcontext (context.c)
		Using command       : ../sparse context.c
		Expecting exit value: 0
	     TEST    crash add-doms (crash-add-doms.c)
		Using command       : ../test-linearize crash-add-doms.c
		Expecting exit value: 0
	     TEST    crash bb_target (crash-bb_target.c)
		Using command       : ../test-linearize crash-bb_target.c
		Expecting exit value: 0
	     TEST    crash ep->active (crash-ep-active.c)
		Using command       : ../test-linearize crash-ep-active.c
		Expecting exit value: 0
	     TEST    crash ptrlist (crash-ptrlist.c)
		Using command       : ../test-linearize crash-ptrlist.c
		Expecting exit value: 0
	     TEST    crash rewrite_branch (crash-rewrite-branch.c)
		Using command       : ../test-linearize crash-rewrite-branch.c
		Expecting exit value: 0
	     TEST    crazy02-not-so.c (crazy02-not-so.c)
		Using command       : ../sparse -Wno-decl crazy02-not-so.c
		Expecting exit value: 0
	     TEST    crazy03.c (crazy03.c)
		Using command       : ../sparse crazy03.c
		Expecting exit value: 0
	     TEST    declaration after statement (ANSI) (declaration-after-stateme=
nt-ansi.c)
		Using command       : ../sparse -ansi declaration-after-statement-ansi.c
		Expecting exit value: 0
	     TEST    declaration after statement (C89) (declaration-after-statemen=
t-c89.c)
		Using command       : ../sparse -std=3Dc89 declaration-after-statement-c8=
9.c
		Expecting exit value: 0
	     TEST    declaration after statement (C99) (declaration-after-statemen=
t-c99.c)
		Using command       : ../sparse -std=3Dc99 declaration-after-statement-c9=
9.c
		Expecting exit value: 0
	     TEST    declaration after statement (default) (declaration-after-stat=
ement-default.c)
		Using command       : ../sparse declaration-after-statement-default.c
		Expecting exit value: 0
	     TEST    finding definitions (definitions.c)
		Using command       : ../sparse definitions.c
		Expecting exit value: 0
	     TEST    designated_init attribute (designated-init.c)
		Using command       : ../sparse designated-init.c
		Expecting exit value: 0
	     TEST    discarded-label-statement (discarded-label-statement.c)
		Using command       : ../test-linearize discarded-label-statement.c
		Expecting exit value: 0
	     TEST    division constants (div.c)
		Using command       : ../sparse div.c
		Expecting exit value: 0
	     TEST    Double semicolon in struct (double-semicolon.c)
		Using command       : ../sparse double-semicolon.c
		Expecting exit value: 0
	     TEST    Dubious bitwise operation on !x (dubious-bitwise-with-not.c)
		Using command       : ../sparse dubious-bitwise-with-not.c
		Expecting exit value: 0
	     TEST    endian-big.c (endian-big.c)
		Using command       : ../sparse -mbig-endian endian-big.c
		Expecting exit value: 0
	     TEST    endian-little.c (endian-little.c)
		Using command       : ../sparse -mlittle-endian endian-little.c
		Expecting exit value: 0
	     TEST    enum-mismatch (enum-mismatch.c)
		Using command       : ../sparse -Wenum-mismatch enum-mismatch.c
		Expecting exit value: 0
	     TEST    enumeration constants' scope [6.2.1p7] (enum_scope.c)
		Using command       : ../sparse enum_scope.c
		Expecting exit value: 0
	     TEST    Character escape sequences (escapes.c)
		Using command       : ../sparse escapes.c
		Expecting exit value: 0
	     TEST    duplicate extern array (extern-array.c)
		Using command       : ../sparse extern-array.c
		Expecting exit value: 0
	     TEST    extern inline function (extern-inline.c)
		Using command       : ../sparse extern-inline.c extern-inline.c
		Expecting exit value: 0
	     TEST    field overlap (field-overlap.c)
		Using command       : ../sparse field-overlap.c
		Expecting exit value: 0
	     TEST    field-override (field-override.c)
		Using command       : ../sparse -Woverride-init -Woverride-init-all field=
-override.c
		Expecting exit value: 0
	     TEST    Forced function argument type. (fored_arg.c)
		Using command       : ../sparse fored_arg.c
		Expecting exit value: 0
	     TEST    foul bitwise (foul-bitwise.c)
		Using command       : ../sparse foul-bitwise.c
		Expecting exit value: 0
	     TEST    fp-vs-ptrcast (fp-vs-ptrcast.c)
		Using command       : ../test-linearize -Wno-decl fp-vs-ptrcast.c
		Expecting exit value: 0
	     TEST    Function pointer inheritance (function-pointer-inheritance.c)
		Using command       : ../sparse function-pointer-inheritance.c
		Expecting exit value: 0
	     TEST    function-redecl (function-redecl.c)
		Using command       : ../sparse function-redecl.c
		Expecting exit value: 0
	     TEST    goto labels (goto-label.c)
		Using command       : ../sparse goto-label.c
		Expecting exit value: 0
	     TEST    identifier-list parsing (identifier_list.c)
		Using command       : ../sparse identifier_list.c
		Expecting exit value: 0
	     TEST    implicit-ret-type.c (implicit-ret-type.c)
		Using command       : ../sparse -Wno-decl implicit-ret-type.c
		Expecting exit value: 0
	     TEST    implicit-type.c (implicit-type.c)
		Using command       : ../sparse -Wno-decl implicit-type.c
		Expecting exit value: 0
	     TEST    internal infinite loop (0) (infinite-loop0.c)
		Using command       : ../sparse -Wno-decl infinite-loop0.c
		Expecting exit value: 0
	     TEST    infinite loop 02 (infinite-loop02.c)
		Using command       : ../sparse -Wno-decl infinite-loop02.c
		Expecting exit value: 0
	     TEST    infinite loop 03 (infinite-loop03.c)
		Using command       : ../sparse -Wno-decl infinite-loop03.c
		Expecting exit value: 0
	     TEST    char array initializers (init-char-array.c)
		Using command       : ../sparse init-char-array.c
		Expecting exit value: 0
	     TEST    parenthesized string initializer (init-char-array1.c)
		Using command       : ../sparse -Wparen-string init-char-array1.c
		Expecting exit value: 0
	     TEST    -Winit-cstring option (init_cstring.c)
		Using command       : ../sparse -Winit-cstring init_cstring.c
		Expecting exit value: 0
	     TEST    Initializer entry defined twice (initializer-entry-defined-tw=
ice.c)
		Using command       : ../sparse initializer-entry-defined-twice.c
		Expecting exit value: 0
	     TEST    inline compound literals (inline_compound_literals.c)
		Using command       : ../sparse inline_compound_literals.c
		Expecting exit value: 0
	     TEST    int128 (int128.c)
		Using command       : ../test-linearize int128.c
		Expecting exit value: 0
	     TEST    Integer promotions (integer-promotions.c)
		Using command       : ../sparse integer-promotions.c
		Expecting exit value: 0
	     TEST    integer constant & conditional expression (ioc-typecheck.c)
		Using command       : ../sparse ioc-typecheck.c
		Expecting exit value: 0
	error: actual error text does not match expected error text.
	error: see ioc-typecheck.c.error.* for further investigation.
	--- ioc-typecheck.c.error.expected	2017-08-30 16:02:07.552130702 +0000
	+++ ioc-typecheck.c.error.got	2017-08-30 16:02:07.548130646 +0000
	@@ -0,0 +1 @@
	+ioc-typecheck.c:3:16: error: bad integer constant expression
	info: test 'ioc-typecheck.c' is known to fail
	     TEST    kill-casts (kill-casts.c)
		Using command       : ../test-linearize kill-casts.c
		Expecting exit value: 0
	     TEST    kill-computedgoto (kill-computedgoto.c)
		Using command       : ../test-linearize kill-computedgoto.c
		Expecting exit value: 0
	     TEST    kill-cse (kill-cse.c)
		Using command       : ../test-linearize -Wno-decl kill-cse.c
		Expecting exit value: 0
	     TEST    kill insert-branch (kill-insert-branch.c)
		Using command       : ../test-linearize -Wno-decl kill-insert-branch.c
		Expecting exit value: 0
	     TEST    kill-load (kill-load.c)
		Using command       : ../test-linearize -Wno-decl kill-load.c
		Expecting exit value: 0
	     TEST    kill-phi-node (kill-phi-node.c)
		Using command       : ../test-linearize kill-phi-node.c
		Expecting exit value: 0
	     TEST    kill-phi-ttsbb (kill-phi-ttsbb.c)
		Using command       : ../test-linearize kill-phi-ttsbb.c
		Expecting exit value: 0
	     TEST    kill-phi-ttsbb2 (kill-phi-ttsbb2.c)
		Using command       : ../test-linearize kill-phi-ttsbb2.c
		Expecting exit value: 0
	     TEST    kill-phisrc (kill-phisrc.c)
		Using command       : ../test-linearize -Wno-decl kill-phisrc.c
		Expecting exit value: 0
	     TEST    kill-pure-call (kill-pure-call.c)
		Using command       : ../test-linearize -Wno-decl kill-pure-call.c
		Expecting exit value: 0
	     TEST    kill-replaced-insn (kill-replaced-insn.c)
		Using command       : ../test-linearize kill-replaced-insn.c
		Expecting exit value: 0
	     TEST    kill-rewritten-load (kill-rewritten-load.c)
		Using command       : ../test-linearize -Wno-decl kill-rewritten-load.c
		Expecting exit value: 0
	     TEST    kill-select (kill-select.c)
		Using command       : ../test-linearize kill-select.c
		Expecting exit value: 0
	     TEST    kill-slice (kill-slice.c)
		Using command       : ../test-linearize -Wno-decl kill-slice.c
		Expecting exit value: 0
	     TEST    kill-store (kill-store.c)
		Using command       : ../test-linearize -Wno-decl kill-store.c
		Expecting exit value: 0
	     TEST    kill-unreachable-phi (kill-unreachable-phi.c)
		Using command       : ../sparse kill-unreachable-phi.c
		Expecting exit value: 0
	     TEST    Label followed by __asm__ (label-asm.c)
		Using command       : ../sparse label-asm.c
		Expecting exit value: 0
	     TEST    Label attribute (label-attr.c)
		Using command       : ../sparse label-attr.c
		Expecting exit value: 0
	     TEST    label-expr (label-expr.c)
		Using command       : ../test-linearize label-expr.c
		Expecting exit value: 0
	     TEST    __label__ scope (label-scope.c)
		Using command       : ../sparse label-scope.c
		Expecting exit value: 0
	     TEST    bitfield initializer mask (linear/bitfield-init-mask.c)
		Using command       : ../test-linearize -fdump-linearize=3Donly -Wno-decl=
 linear/bitfield-init-mask.c
		Expecting exit value: 0
	     TEST    bitfield implicit init zero (linear/bitfield-init-zero.c)
		Using command       : ../test-linearize -Wno-decl linear/bitfield-init-ze=
ro.c
		Expecting exit value: 0
	     TEST    missing instruction's size (linear/missing-insn-size.c)
		Using command       : ../test-linearize linear/missing-insn-size.c
		Expecting exit value: 0
	     TEST    struct implicit init zero not needed (linear/struct-init-full=
=2Ec)
		Using command       : ../test-linearize -Wno-decl linear/struct-init-full=
=2Ec
		Expecting exit value: 0
	error: actual output text does not match expected output text.
	error: see linear/struct-init-full.c.output.* for further investigation.
	--- linear/struct-init-full.c.output.expected	2017-08-30 16:02:07.88813540=
4 +0000
	+++ linear/struct-init-full.c.output.got	2017-08-30 16:02:07.884135348 +00=
00
	@@ -1,10 +1,11 @@
	 s_init_all:
	-.L4:
	+.L0:
		<entry-point>
	+	store.96    $0 -> 0[s]
		store.32    %arg1 -> 0[s]
		store.32    $42 -> 4[s]
		store.32    $123 -> 8[s]
	-	load.96     %r8 <- 0[s]
	-	ret.96      %r8
	+	load.96     %r2 <- 0[s]
	+	ret.96      %r2
	=20
	=20
	info: test 'linear/struct-init-full.c' is known to fail
	     TEST    struct implicit init zero needed (linear/struct-init-partial.=
c)
		Using command       : ../test-linearize -Wno-decl linear/struct-init-part=
ial.c
		Expecting exit value: 0
	     TEST    Local label (local-label.c)
		Using command       : ../sparse local-label.c
		Expecting exit value: 0
	     TEST    Logical and/or (logical.c)
		Using command       : ../sparse logical.c
		Expecting exit value: 0
	     TEST    loop-linearization (loop-linearization.c)
		Using command       : ../test-linearize loop-linearization.c
		Expecting exit value: 0
	     TEST    Expansion of typeof when dealing with member of struct (membe=
r_of_typeof.c)
		Using command       : ../sparse member_of_typeof.c
		Expecting exit value: 0
	     TEST    memops-volatile (memops-volatile.c)
		Using command       : ../test-linearize memops-volatile.c
		Expecting exit value: 0
	     TEST    handling of identifier-less declarations (missing-ident.c)
		Using command       : ../sparse missing-ident.c
		Expecting exit value: 0
	     TEST    typedefs with many declarators (multi_typedef.c)
		Using command       : ../sparse multi_typedef.c
		Expecting exit value: 0
	     TEST    nested declarator vs. parameters (nested-declarator.c)
		Using command       : ../sparse nested-declarator.c
		Expecting exit value: 0
	     TEST    more on handling of ( in direct-declarator (nested-declarator=
2.c)
		Using command       : ../sparse nested-declarator2.c
		Expecting exit value: 0
	     TEST    nocast.c (nocast.c)
		Using command       : ../sparse nocast.c
		Expecting exit value: 0
	     TEST    noderef attribute (noderef.c)
		Using command       : ../sparse noderef.c
		Expecting exit value: 0
	     TEST    Using plain integer as NULL pointer (non-pointer-null.c)
		Using command       : ../sparse non-pointer-null.c
		Expecting exit value: 0
	     TEST    Old initializer with -Wno-old-initializer (old-initializer-no=
warn.c)
		Using command       : ../sparse -Wno-old-initializer
		Expecting exit value: 0
	     TEST    Old initializer (old-initializer.c)
		Using command       : ../sparse old-initializer.c
		Expecting exit value: 0
	     TEST    double-unop (optim/binops-same-args.c)
		Using command       : ../test-linearize -Wno-decl optim/binops-same-args.c
		Expecting exit value: 0
	     TEST    bool-context (optim/bool-context.c)
		Using command       : ../test-linearize -Wno-decl optim/bool-context.c
		Expecting exit value: 0
	     TEST    bool-same-args (optim/bool-same-args.c)
		Using command       : ../test-linearize optim/bool-same-args.c
		Expecting exit value: 0
	     TEST    bool-simplify (optim/bool-simplify.c)
		Using command       : ../test-linearize -Wno-decl optim/bool-simplify.c
		Expecting exit value: 0
	     TEST    cse-commutativity (optim/cse-commutativity.c)
		Using command       : ../test-linearize optim/cse-commutativity.c
		Expecting exit value: 0
	     TEST    cse-dual-compare (optim/cse-dual-compare.c)
		Using command       : ../test-linearize optim/cse-dual-compare.c
		Expecting exit value: 0
	error: Actual output contains some patterns which are not expected.
	info: test 'optim/cse-dual-compare.c' is known to fail
	     TEST    double-unop (optim/double-unop.c)
		Using command       : ../test-linearize -Wno-decl optim/double-unop.c
		Expecting exit value: 0
	     TEST    fpcast-nop (optim/fpcast-nop.c)
		Using command       : ../test-linearize optim/fpcast-nop.c
		Expecting exit value: 0
	     TEST    muldiv-by-one (optim/muldiv-by-one.c)
		Using command       : ../test-linearize -Wno-decl optim/muldiv-by-one.c
		Expecting exit value: 0
	     TEST    muldiv-by-zero (optim/muldiv-by-zero.c)
		Using command       : ../test-linearize -Wno-decl optim/muldiv-by-zero.c
		Expecting exit value: 0
	     TEST    muldiv-minus-one (optim/muldiv-minus-one.c)
		Using command       : ../test-linearize -Wno-decl optim/muldiv-minus-one.c
		Expecting exit value: 0
	     TEST    optim/setcc-setcc (optim/setcc-setcc.c)
		Using command       : ../test-linearize optim/setcc-setcc.c
		Expecting exit value: 0
	     TEST    optim/setcc-seteq (optim/setcc-seteq.c)
		Using command       : ../test-linearize optim/setcc-seteq.c
		Expecting exit value: 0
	     TEST    optim/setcc-setne (optim/setcc-setne.c)
		Using command       : ../test-linearize optim/setcc-setne.c
		Expecting exit value: 0
	     TEST    Ignore VOID in if-convert (optim/void-if-convert.c)
		Using command       : ../test-linearize -Wno-decl optim/void-if-convert.c
		Expecting exit value: 0
	     TEST    There is no scope boundary between global and file scope (out=
er-scope.c)
		Using command       : ../sparse -include outer-scope.c outer-scope.c
		Expecting exit value: 0
	     TEST    #pragma once (pragma-once.c)
		Using command       : ../sparse pragma-once.c
		Expecting exit value: 0
	     TEST    __COUNTER__ #1 (preprocessor/counter1.c)
		Using command       : ../sparse -E preprocessor/counter1.c
		Expecting exit value: 0
	     TEST    __COUNTER__ #2 (preprocessor/counter2.c)
		Using command       : ../sparse -Ipreprocessor -E preprocessor/counter2.c
		Expecting exit value: 0
	     TEST    __COUNTER__ #3 (preprocessor/counter3.c)
		Using command       : ../sparse -Ipreprocessor -E preprocessor/counter1.c=
 preprocessor/counter3.c
		Expecting exit value: 0
	     TEST    dump-macros with empty file (preprocessor/dump-macros-empty.c)
		Using command       : ../sparse -E -dD empty-file
		Expecting exit value: 0
	     TEST    dump-macros with multiple files (preprocessor/dump-macros-mul=
ti.c)
		Using command       : ../sparse -E -dD empty-file preprocessor/dump-macro=
s-multi.c
		Expecting exit value: 0
	     TEST    dump-macros (preprocessor/dump-macros.c)
		Using command       : ../sparse -E -dD -DIJK=3Dijk -UNDEF -UNYDEF preproc=
essor/dump-macros.c
		Expecting exit value: 0
	     TEST    early-escape (preprocessor/early-escape.c)
		Using command       : ../sparse -E preprocessor/early-escape.c
		Expecting exit value: 0
	     TEST    predefined __<type>_BIT__ (preprocessor/predef-char-bit.c)
		Using command       : ../test-linearize -Wno-decl preprocessor/predef-cha=
r-bit.c
		Expecting exit value: 0
	     TEST    predefined __<type>_MAX__ (preprocessor/predef-max.c)
		Using command       : ../test-linearize -Wno-decl preprocessor/predef-max=
=2Ec
		Expecting exit value: 0
	     TEST    predefined __SIZEOF_<type>__ (preprocessor/predef-sizeof.c)
		Using command       : ../test-linearize -Wno-decl preprocessor/predef-siz=
eof.c
		Expecting exit value: 0
	     TEST    Preprocessor #1 (preprocessor/preprocessor1.c)
		Using command       : ../sparse -E preprocessor/preprocessor1.c
		Expecting exit value: 0
	     TEST    Preprocessor #10 (preprocessor/preprocessor10.c)
		Using command       : ../sparse -E preprocessor/preprocessor10.c
		Expecting exit value: 0
	     TEST    Preprocessor #11 (preprocessor/preprocessor11.c)
		Using command       : ../sparse -E preprocessor/preprocessor11.c
		Expecting exit value: 0
	     TEST    Preprocessor #12 (preprocessor/preprocessor12.c)
		Using command       : ../sparse -E preprocessor/preprocessor12.c
		Expecting exit value: 0
	     TEST    Preprocessor #13 (preprocessor/preprocessor13.c)
		Using command       : ../sparse -E preprocessor/preprocessor13.c
		Expecting exit value: 0
	     TEST    Preprocessor #14 (preprocessor/preprocessor14.c)
		Using command       : ../sparse -E preprocessor/preprocessor14.c
		Expecting exit value: 0
	     TEST    Preprocessor #15 (preprocessor/preprocessor15.c)
		Using command       : ../sparse -E preprocessor/preprocessor15.c
		Expecting exit value: 0
	     TEST    Preprocessor #16 (preprocessor/preprocessor16.c)
		Using command       : ../sparse -E preprocessor/preprocessor16.c
		Expecting exit value: 0
	     TEST    Preprocessor #17 (preprocessor/preprocessor17.c)
		Using command       : ../sparse -E preprocessor/preprocessor17.c
		Expecting exit value: 0
	     TEST    Preprocessor #18 (preprocessor/preprocessor18.c)
		Using command       : ../sparse -E preprocessor/preprocessor18.c
		Expecting exit value: 0
	     TEST    Preprocessor #19 (preprocessor/preprocessor19.c)
		Using command       : ../sparse -E preprocessor/preprocessor19.c
		Expecting exit value: 0
	     TEST    Preprocessor #2 (preprocessor/preprocessor2.c)
		Using command       : ../sparse -E preprocessor/preprocessor2.c
		Expecting exit value: 0
	     TEST    Preprocessor #20 (preprocessor/preprocessor20.c)
		Using command       : ../sparse -E preprocessor/preprocessor20.c
		Expecting exit value: 0
	     TEST    Preprocessor #21 (preprocessor/preprocessor21.c)
		Using command       : ../sparse -E preprocessor/preprocessor21.c
		Expecting exit value: 0
	     TEST    Preprocessor #22 (preprocessor/preprocessor22.c)
		Using command       : ../sparse -E preprocessor/preprocessor22.c
		Expecting exit value: 0
	     TEST    Preprocessor #23 (preprocessor/preprocessor23.c)
		Using command       : ../sparse -E preprocessor/preprocessor23.c
		Expecting exit value: 0
	     TEST    Preprocessor #3 (preprocessor/preprocessor3.c)
		Using command       : ../sparse -E preprocessor/preprocessor3.c
		Expecting exit value: 0
	     TEST    Preprocessor #4 (preprocessor/preprocessor4.c)
		Using command       : ../sparse -E preprocessor/preprocessor4.c
		Expecting exit value: 0
	     TEST    Preprocessor #5 (preprocessor/preprocessor5.c)
		Using command       : ../sparse -E preprocessor/preprocessor5.c
		Expecting exit value: 0
	     TEST    Preprocessor #6 (preprocessor/preprocessor6.c)
		Using command       : ../sparse -E preprocessor/preprocessor6.c
		Expecting exit value: 0
	     TEST    Preprocessor #7 (preprocessor/preprocessor7.c)
		Using command       : ../sparse -E preprocessor/preprocessor7.c
		Expecting exit value: 0
	     TEST    Preprocessor #8 (preprocessor/preprocessor8.c)
		Using command       : ../sparse -E preprocessor/preprocessor8.c
		Expecting exit value: 0
	     TEST    Preprocessor #9 (preprocessor/preprocessor9.c)
		Using command       : ../sparse -E preprocessor/preprocessor9.c
		Expecting exit value: 0
	     TEST    Preprocessor #14 (preprocessor/stringify.c)
		Using command       : ../sparse -E preprocessor/stringify.c
		Expecting exit value: 0
	     TEST    wide char token-pasting (preprocessor/wide.c)
		Using command       : ../sparse -E preprocessor/wide.c
		Expecting exit value: 0
	     TEST    Compile skip function prototype (prototype.c)
		Using command       : ../sparsec -c prototype.c -o tmp.o
		Expecting exit value: 0
	     TEST    ptr-inherit.c (ptr-inherit.c)
		Using command       : ../sparse ptr-inherit.c
		Expecting exit value: 0
	     TEST    Pure function attribute (pure-function.c)
		Using command       : ../sparse pure-function.c
		Expecting exit value: 0
	     TEST    const et.al. are reserved identifiers (reserved.c)
		Using command       : ../sparse reserved.c
		Expecting exit value: 0
	     TEST    restrict array attribute (restrict-array.c)
		Using command       : ../sparse restrict-array.c
		Expecting exit value: 0
	     TEST    typeof with bitwise types (restricted-typeof.c)
		Using command       : ../sparse -Wbitwise restricted-typeof.c
		Expecting exit value: 0
	     TEST    sizeof(_Bool) is valid (sizeof-bool.c)
		Using command       : ../sparse -Wsizeof-bool sizeof-bool.c
		Expecting exit value: 0
	     TEST    Handling of sizeof compound-literal . member (sizeof-compound=
-postfix.c)
		Using command       : ../sparse sizeof-compound-postfix.c
		Expecting exit value: 0
	     TEST    valid specifier combinations (specifiers1.c)
		Using command       : ../sparse specifiers1.c
		Expecting exit value: 0
	     TEST    invalid specifier combinations (specifiers2.c)
		Using command       : ../sparse specifiers2.c
		Expecting exit value: 0
	     TEST    static forward declaration (static-forward-decl.c)
		Using command       : ../sparse static-forward-decl.c
		Expecting exit value: 0
	     TEST    static assertion (static_assert.c)
		Using command       : ../sparse static_assert.c
		Expecting exit value: 0
	     TEST    Address space of a struct member (struct-as.c)
		Using command       : ../sparse struct-as.c
		Expecting exit value: 0
	     TEST    struct attribute placement (struct-attribute-placement.c)
		Using command       : ../sparse struct-attribute-placement.c
		Expecting exit value: 0
	     TEST    struct namespaces #1 (struct-ns1.c)
		Using command       : ../sparse struct-ns1.c
		Expecting exit value: 0
	     TEST    struct not in scope (struct-ns2.c)
		Using command       : ../sparse struct-ns2.c
		Expecting exit value: 0
	error: actual error text does not match expected error text.
	error: see struct-ns2.c.error.* for further investigation.
	--- struct-ns2.c.error.expected	2017-08-30 16:02:09.076152032 +0000
	+++ struct-ns2.c.error.got	2017-08-30 16:02:09.068151920 +0000
	@@ -1,3 +0,0 @@
	-struct-ns2.c:2:11: warning: bad scope for 'struct Bar'
	-struct-ns2.c:12:14: error: incomplete type/unknown size for 'y'
	-struct-ns2.c:13:5: error: using member 'i' in incomplete 'struct Bar'
	info: test 'struct-ns2.c' is known to fail
	     TEST    struct size (struct-size1.c)
		Using command       : ../sparse struct-size1.c
		Expecting exit value: 0
	     TEST    tautological-compare (tautological-compare.c)
		Using command       : ../sparse -Wno-decl -Wtautological-compare tautolog=
ical-compare.c
		Expecting exit value: 0
	     TEST    binary operations (test-be.c)
		Using command       : ../sparse test-be.c
		Expecting exit value: 0
	     TEST    selfcheck1 (testsuite-selfcheck1.c)
		Using command       : ../sparse -E testsuite-selfcheck1.c
		Expecting exit value: 0
	     TEST    selfcheck2 (testsuite-selfcheck2.c)
		Using command       : ../sparse -E testsuite-selfcheck2.c
		Expecting exit value: 0
	error: Actual output doesn't contain some of the expected patterns.
	info: test 'testsuite-selfcheck2.c' is known to fail
	     TEST    selfcheck3 (testsuite-selfcheck3.c)
		Using command       : ../sparse -E testsuite-selfcheck3.c
		Expecting exit value: 0
	error: Actual output contains some patterns which are not expected.
	info: test 'testsuite-selfcheck3.c' is known to fail
	     TEST    Transparent union attribute. (transparent-union.c)
		Using command       : ../sparse transparent-union.c
		Expecting exit value: 0
	     TEST    "char []" to "char *" demotion (type1.c)
		Using command       : ../sparse type1.c
		Expecting exit value: 0
	     TEST    typedef shadowing (typedef_shadow.c)
		Using command       : ../sparse typedef_shadow.c
		Expecting exit value: 0
	     TEST    typeof-addresspace.c (typeof-addresspace.c)
		Using command       : ../sparse typeof-addresspace.c
		Expecting exit value: 0
	error: actual error text does not match expected error text.
	error: see typeof-addresspace.c.error.* for further investigation.
	--- typeof-addresspace.c.error.expected	2017-08-30 16:02:09.204153823 +0000
	+++ typeof-addresspace.c.error.got	2017-08-30 16:02:09.200153767 +0000
	@@ -0,0 +1,6 @@
	+typeof-addresspace.c:9:30: warning: incorrect type in initializer (differ=
ent address spaces)
	+typeof-addresspace.c:9:30:    expected int *ptr3
	+typeof-addresspace.c:9:30:    got int <asn:1>*ptr
	+typeof-addresspace.c:10:29: warning: incorrect type in initializer (diffe=
rent address spaces)
	+typeof-addresspace.c:10:29:    expected int *ptr4
	+typeof-addresspace.c:10:29:    got int <asn:1>*ptr
	info: test 'typeof-addresspace.c' is known to fail
	     TEST    Rusty Russell's typeof attribute casting. (typeof-attribute.c)
		Using command       : ../sparse typeof-attribute.c
		Expecting exit value: 0
	     TEST    typeof-mods (typeof-mods.c)
		Using command       : ../sparse typeof-mods.c
		Expecting exit value: 0
	     TEST    typeof-noderef (typeof-noderef.c)
		Using command       : ../sparse typeof-noderef.c
		Expecting exit value: 0
	error: actual error text does not match expected error text.
	error: see typeof-noderef.c.error.* for further investigation.
	--- typeof-noderef.c.error.expected	2017-08-30 16:02:09.240154327 +0000
	+++ typeof-noderef.c.error.got	2017-08-30 16:02:09.236154271 +0000
	@@ -0,0 +1,6 @@
	+typeof-noderef.c:7:30: warning: incorrect type in initializer (different =
modifiers)
	+typeof-noderef.c:7:30:    expected int *ptr3
	+typeof-noderef.c:7:30:    got int [noderef] *ptr
	+typeof-noderef.c:8:29: warning: incorrect type in initializer (different =
modifiers)
	+typeof-noderef.c:8:29:    expected int *ptr4
	+typeof-noderef.c:8:29:    got int [noderef] *ptr
	info: test 'typeof-noderef.c' is known to fail
	     TEST    typeof-safe (typeof-safe.c)
		Using command       : ../sparse typeof-safe.c
		Expecting exit value: 0
	error: actual error text does not match expected error text.
	error: see typeof-safe.c.error.* for further investigation.
	--- typeof-safe.c.error.expected	2017-08-30 16:02:09.252154495 +0000
	+++ typeof-safe.c.error.got	2017-08-30 16:02:09.248154439 +0000
	@@ -0,0 +1,9 @@
	+typeof-safe.c:9:30: warning: incorrect type in initializer (different mod=
ifiers)
	+typeof-safe.c:9:30:    expected int *ptr3
	+typeof-safe.c:9:30:    got int [safe] *ptr
	+typeof-safe.c:10:29: warning: incorrect type in initializer (different mo=
difiers)
	+typeof-safe.c:10:29:    expected int *ptr4
	+typeof-safe.c:10:29:    got int [safe] *ptr
	+typeof-safe.c:13:13: warning: incorrect type in assignment (different mod=
ifiers)
	+typeof-safe.c:13:13:    expected int [safe] *[assigned] ptr
	+typeof-safe.c:13:13:    got int *<noident>
	info: test 'typeof-safe.c' is known to fail
	     TEST    -Wtypesign (typesign.c)
		Using command       : ../sparse -Wtypesign typesign.c
		Expecting exit value: 0
	     TEST    Varargs bogus warning regression test #1 (varargs1.c)
		Using command       : ../sparse varargs1.c
		Expecting exit value: 0
	     TEST    wide character constants (wide.c)
		Using command       : ../sparse wide.c
		Expecting exit value: 0
	Out of 287 tests, 272 passed, 15 failed (10 of them are known to fail)
	Makefile:232: recipe for target 'check' failed
	make: *** [check] Error 1
	ukleinek@plummer:~/sparse$=20


The problem is that some cpp symbols are not defined in sparse that are
expected to exist. So I can "fix" backend/sum.c with the following
patch:

diff --git a/validation/backend/sum.c b/validation/backend/sum.c
index 0604299..d0be8dd 100644
--- a/validation/backend/sum.c
+++ b/validation/backend/sum.c
@@ -1,3 +1,5 @@
+#define __powerpc64__
+#define _CALL_ELF 2
 #include <stdio.h>
 #include <stdlib.h>
=20

I'm a bit clueless how sparse works here. I see __powerpc64__ and _CALL_ELF
already defined in cgcc, but sparse-llvm doesn't pick it up from there.

I didn't check deeply, but I guess for say amd64 the situation should be
similar because there __x86_64__ is required to be defined.

Can you give me a hint how to fix this? Is this a problem in sparse
itself or maybe llvm?

Best regards
Uwe

[1] https://bugs.debian.org/873508

--b2wgqps352tkjbkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAlmm5GgACgkQwfwUeK3K
7AnRKggAls3Rx4LkNhO34Ml+4Rx7OlQn1i54fzIxpMYwxa9yBj0FEq9kNASgOnBz
9D+8WFj/wrcGEIowlwxubCE7L6t6yyo9HGsg8pMsbdpEVNo4eahyvCmaBFccW7bt
83o2yUuNGrGxKyh1TaPuDDKktBLqg3zwQi5eQhk8KgwJ+PVJwRJCk2/0Svdtivk6
HVT6hfrtkc6W46oSQINUIXavIQfORzCDSjhuboNZUgc0t6iu/BNwzxA8RkFQeTn2
6zmX/rE1O6iWbYwo83YhF78jWyg5JRmwCwEyBzXcmlGSe2poVSEJXIeYPCCLGc77
jXkVBQD+B8osBfLBFM4yAL+dW6UeLg==
=mvPk
-----END PGP SIGNATURE-----

--b2wgqps352tkjbkb--
