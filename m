Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB6E3590D4;
	Fri, 16 Jan 2026 18:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587500; cv=none; b=gQG8g5JKHWoQsc6Cqtuox2djGEdBgDXMFWwzcTz8vu5YJz9+WUysI5jW77J3FL551Trst5uhAbjSLwpOmilsbom0SWCikpe904PumTZa6FFPlwF81Q77h3IbX94foVOHzL4K6lRYAgtgzbgRNLH1M6LvXLvyopvZUeL3GbtBFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587500; c=relaxed/simple;
	bh=psHWMZZzmK8Ax9HtUbsQ7uTkEcJpDCl6APeRvZm0sWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dN04xx1AcrWmUlZ48d0JaI43saO21P1mB69dVgvhceLynR2a2qdxiySJ1Ffz6kCP6ZOZmtvd78ecEu4u0tmcu7aT2hB1xuJmYhYu3Cbf5AoceCIPJVRUqIx43+ydRFjDNYhBJ3ont8DepWff1NTiVVkCclnyWQP+31rSrNvL4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkUPm6RY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkUPm6RY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DD9C116C6;
	Fri, 16 Jan 2026 18:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768587499;
	bh=psHWMZZzmK8Ax9HtUbsQ7uTkEcJpDCl6APeRvZm0sWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MkUPm6RYfa+GpU95PT6aF/8IO2qAxcS3uItS/9zfQUzv8fpK+6v2wuVouQdlplTXj
	 67Ewu3u7Nilv5HwexzJC0wfAs67455PjQhVzKlGeOZRWcrj0LSxouesygSH0JpvMdb
	 zwMkhJglH6+ZQJyLzFvtk2JPwwwiFw/cv3eHJmq3DcPCrJ346HIf5YkdDd/6qhCyKr
	 PE4TIoQHkRCmrSiWBUpdQy/5wCotuDjOLpKqrQnWNUHr7OYReitDuCn+PGCa8VQhHz
	 Bax48PsJ/Z96pLzwGd/4QS88TsKdTMAYtu3hNI24GTqob3Aju093TqUsGDe/sIzcP0
	 yi3MX8BbayPww==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>, Ian Rogers <irogers@google.com>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org, sparse@chrisli.org, linux-sparse@vger.kernel.org, Marco
 Elver <elver@google.com>
Subject: [PATCH] compiler: Use __typeof_unqual__() for __unqual_scalar_typeof()
In-Reply-To: <87jyxh3ike.ffs@tglx>
References: <202601150001.sKSN644a-lkp@intel.com> <87v7h23cb0.ffs@tglx>
 <20260115211120.GD831050@noisy.programming.kicks-ass.net>
 <87ms2e32gw.ffs@tglx> <87jyxh3ike.ffs@tglx>
Date: Fri, 16 Jan 2026 19:18:16 +0100
Message-ID: <87ecnp2zh3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Peter Zijlstra <peterz@infradead.org>

The recent changes to get_unaligned() resulted in a new sparse warning:

   net/rds/ib_cm.c:96:35: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
   net/rds/ib_cm.c:96:35: sparse:     expected void *
   net/rds/ib_cm.c:96:35: sparse:     got restricted __be64 const *
 
The updated get_unaligned_t() uses __unqual_scalar_typeof() to get an
unqualified type. This works correctly for the compilers, but fails for
sparse when the data type is __be64 (or any other __beNN variant).

On sparse runs (C=[12]) __beNN types are annotated with
__attribute__((bitwise)).

That annotation allows sparse to detect incompatible operations on __beNN
variables, but it also prevents sparse from evaluating the _Generic() in
__unqual_scalar_typeof() and map __beNN to a unqualified scalar type, so it
ends up with the default, i.e. the original qualified type of a 'const
__beNN' pointer. That then ends up as the first pointer argument to
builtin_memcpy(), which obviously causes the above sparse warnings.

The sparse git tree supports typeof_unqual() now, which allows to use it
instead of the _Generic() based __unqual_scalar_typeof(). With that sparse
correctly evaluates the unqualified type and keeps the __beNN logic intact.

The downside is that this requires a top of tree sparse build and an old
sparse version will emit a metric ton of incomprehensible error messages
before it dies with a segfault.

Therefore implement a sanity check which validates that the checker is
available and capable of handling typeof_unqual(). Emit a warning if not so
the user can take informed action.

[ tglx: Move the evaluation of USE_TYPEOF_UNQUAL to compiler_types.h so it is
  	set before use and implement the sanity checker ]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Closes: https://lore.kernel.org/oe-kbuild-all/202601150001.sKSN644a-lkp@intel.com/
---
 Makefile                       |    8 ++++++++
 include/linux/compiler.h       |   10 ----------
 include/linux/compiler_types.h |   11 +++++++++++
 scripts/checker-valid.sh       |   19 +++++++++++++++++++
 4 files changed, 38 insertions(+), 10 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -1178,6 +1178,14 @@ ifdef CONFIG_CC_IS_CLANG
 KBUILD_USERLDFLAGS += --ld-path=$(LD)
 endif
 
+# Validate the checker is available and functional
+ifneq ($(KBUILD_CHECKSRC), 0)
+  ifneq ($(shell $(srctree)/scripts/checker-valid.sh $(CHECK)), 1)
+    $(warning C=$(KBUILD_CHECKSRC) specified, but $(CHECK) is not available or not up to date)
+    KBUILD_CHECKSRC = 0
+  endif
+endif
+
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)
 
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -231,16 +231,6 @@ void ftrace_likely_update(struct ftrace_
 				"must be non-C-string (not NUL-terminated)")
 
 /*
- * Use __typeof_unqual__() when available.
- *
- * XXX: Remove test for __CHECKER__ once
- * sparse learns about __typeof_unqual__().
- */
-#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
-# define USE_TYPEOF_UNQUAL 1
-#endif
-
-/*
  * Define TYPEOF_UNQUAL() to use __typeof_unqual__() as typeof
  * operator when available, to return an unqualified type of the exp.
  */
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -562,6 +562,13 @@ struct ftrace_likely_data {
 #define asm_inline asm
 #endif
 
+/*
+ * Use __typeof_unqual__() when available.
+ */
+#if CC_HAS_TYPEOF_UNQUAL || defined(__CHECKER__)
+# define USE_TYPEOF_UNQUAL 1
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
@@ -569,6 +576,7 @@ struct ftrace_likely_data {
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
  */
+#ifndef USE_TYPEOF_UNQUAL
 /*
  * Prefer C11 _Generic for better compile-times and simpler code. Note: 'char'
  * is not type-compatible with 'signed char', and we define a separate case.
@@ -586,6 +594,9 @@ struct ftrace_likely_data {
 			 __scalar_type_to_expr_cases(long),		\
 			 __scalar_type_to_expr_cases(long long),	\
 			 default: (x)))
+#else
+#define __unqual_scalar_typeof(x) __typeof_unqual__(x)
+#endif
 
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
--- /dev/null
+++ b/scripts/checker-valid.sh
@@ -0,0 +1,19 @@
+#!/bin/sh -eu
+# SPDX-License-Identifier: GPL-2.0
+
+[ ! -x "$(command -v "$1")" ] && exit 1
+
+tmp_file=$(mktemp)
+trap "rm -f $tmp_file" EXIT
+
+cat << EOF >$tmp_file
+static inline int u(const int *q)
+{
+	__typeof_unqual__(*q) v = *q;
+	return v;
+}
+EOF
+
+# sparse happily exits with 0 on error so validate
+# there is none on stderr. Use awk as grep is a pain with sh -e
+$1 $tmp_file 2>&1 | awk -v c=1 '/error/{c=0}END{print c}'
