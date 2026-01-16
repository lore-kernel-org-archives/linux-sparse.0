Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481C26A0D5;
	Fri, 16 Jan 2026 11:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768562757; cv=none; b=ao9RG90xZ6bZqLt5uTDoizvGMefN50Z/xpL4GgFyaQ+XwtF4GqCg3WBtbZCsBJhCS7NYM8WzEpqDxj67IQl3dp/E2D3/wx6h+ybdGgDKDRjpw8KUEc3kYY2q7nBB4nDgaUEindiMCW5a2B+gd28iZgBMKFKqaz01lvoatGutG6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768562757; c=relaxed/simple;
	bh=LEi9ETXfF/PjYEQ8yvNe+FYSEK3mzAJ6q3r7vMqgp2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fh0u03i2zMr7FshPA/MDV9w80nr+6wIPg7HRxOj1WIqVFrAvEH40pobtMzXGdM3ZhhXbvkbEDhEgktG5BH9LOO4ae99zO1hRz6G9+S4tBkHVzV8ujkmBsCEhMMYFVv190WN9PXj0MR2Zoro0D5fGCGkOsEH939v54m593n6VoCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIwMRUYX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIwMRUYX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89736C116C6;
	Fri, 16 Jan 2026 11:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768562757;
	bh=LEi9ETXfF/PjYEQ8yvNe+FYSEK3mzAJ6q3r7vMqgp2Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iIwMRUYX5TQeqT4HOODtSJE7vj+hlzu+A/Wu4ia5w5A9vQcUBAeDqukPRxVWKiK1i
	 EiMyLs0eg9vQTASK3Sf1cBPePFeGt07sSe+qYTyezmPAdRTMWv1/6D8A+AS4v+UmuW
	 Emc6EjNmHcjNMCXR62jticwzBPprU2GSVTvcHT5eegRaUvdh7UC1g4Q7zQQb2fffHr
	 aQap/6WZzZ9bu50EThCLCKg/p5fYnlGUINpur9cgeergFCLQCEpT2JnUDl2DW/7iuf
	 35Vevz6/u1geYG17c/4cI7MOXf+mLe9ty8my9MJoocLYt7zoPr7irDSBeUAFWIPiBT
	 Akywx6UNMS6zg==
From: Thomas Gleixner <tglx@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kernel test robot <lkp@intel.com>, Ian Rogers <irogers@google.com>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org, sparse@chrisli.org, linux-sparse@vger.kernel.org, Marco
 Elver <elver@google.com>
Subject: Re: [tip:timers/vdso 12/14] net/rds/ib_cm.c:96:35: sparse: sparse:
 incorrect type in argument 1 (different modifiers)
In-Reply-To: <87ms2e32gw.ffs@tglx>
References: <202601150001.sKSN644a-lkp@intel.com> <87v7h23cb0.ffs@tglx>
 <20260115211120.GD831050@noisy.programming.kicks-ass.net>
 <87ms2e32gw.ffs@tglx>
Date: Fri, 16 Jan 2026 12:25:53 +0100
Message-ID: <87jyxh3ike.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Jan 16 2026 at 00:01, Thomas Gleixner wrote:
> This time I looked deeper and it seems that USE_TYPEOF_UNQUAL is not
> set.
>
> If I force it to be set and use a proper compiler and top of tree
> sparse, everything seems to be happy.
>
> Figuring that out is something for tomorrow...

USE_TYPEOF_UNQUAL is set _after_ the __unqual_scalar muck is
processed...

Updated fix below.

Thanks,

        tglx
---
 include/linux/compiler.h       |   10 ----------
 include/linux/compiler_types.h |   11 +++++++++++
 2 files changed, 11 insertions(+), 10 deletions(-)

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
