Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A684302146;
	Thu, 15 Jan 2026 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768505336; cv=none; b=ccZWJMQNHWG+u145lnVH6VBqB1SSonyT7oETPCyGzOo8y9kheKDB14IEgpfO8a69CUnk31D0GG6HqaECs/hOlinO8+4JYChGdYgdPMgUanxFxwBEfOpsDLT49Y5jhl3K8B+pKBFxMpIFPtcFuOOEzPEknJbkRCHBpVhB2WMmi3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768505336; c=relaxed/simple;
	bh=Wo/txeARv50mVYgrFFM1IA1Srg8UmVSu6pDOZ1mNGGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ahy2K5hhFxfUEuEef9DWASVT91x6SteLXPrnNlSQm3oEjfrJet6enpUsLyTUmwzfqJmVXkIy45A2n9crOg95IjfFou9hVrTlWgpDEw8YK7WTpAykMf0vpD1qJ44JgM4TJLidk2G8+kj/C3T2JrUeMacYJDM1RQ88gDQONmZNhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnAQBrQV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnAQBrQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47340C116D0;
	Thu, 15 Jan 2026 19:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768505335;
	bh=Wo/txeARv50mVYgrFFM1IA1Srg8UmVSu6pDOZ1mNGGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hnAQBrQV3RCWyticWFFCRjJCx4SkZxvJC44X/BY8k7HHHmabP+hnUk4V4gVUzFAFy
	 gWhszffeXfUtKpvmd6CqH6WAOxkQYMtSrWyaRkZbYClvgVwuEvELuuSmAyE0dlWFP1
	 2kvI91NfI1mntWHfGgfD5UGwrDECx5X/L8hbqUIkV9hX2EblFV0+gSy0Nj2ncQ5eZV
	 t+MsWmiaL+GDEljZ1eqAjPAB3zVcE1S00RkjHRFF7KFI7UYYfLZCJNILD6pXTBCM2L
	 YL8FOv0ZotmjBQeIpUaLvcXF2/WbNgUM0BJyWcOP4CLfDOM5eUlDTJaft/A0s+IB17
	 pMumJ71fsD1qw==
From: Thomas Gleixner <tglx@kernel.org>
To: kernel test robot <lkp@intel.com>, Ian Rogers <irogers@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 x86@kernel.org, sparse@chrisli.org, linux-sparse@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>, Marco Elver <elver@google.com>
Subject: Re: [tip:timers/vdso 12/14] net/rds/ib_cm.c:96:35: sparse: sparse:
 incorrect type in argument 1 (different modifiers)
In-Reply-To: <202601150001.sKSN644a-lkp@intel.com>
References: <202601150001.sKSN644a-lkp@intel.com>
Date: Thu, 15 Jan 2026 20:28:51 +0100
Message-ID: <87v7h23cb0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 15 2026 at 00:36, kernel test robot wrote:

Cc+ sparse folks.

> sparse warnings: (new ones prefixed by >>)
>>> net/rds/ib_cm.c:96:35: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
>    net/rds/ib_cm.c:96:35: sparse:     expected void *
>    net/rds/ib_cm.c:96:35: sparse:     got restricted __be64 const *
>    net/rds/ib_cm.c:103:27: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
>    net/rds/ib_cm.c:103:27: sparse:     expected void *
>    net/rds/ib_cm.c:103:27: sparse:     got restricted __be64 const *

After staring a while at it, it turns out that get_unaligned_t(), which
uses __unqual_scalar_typeof() to get an unqualified type makes sparse
unhappy when the data type is __be64 (or any other __beNN variant).

__beNN is annotated with __attribute__((bitwise)) when sparse is invoked
(#ifdef CHECKER). That allows sparse to detect incompatible math
operations with __beNN variables.

That annotation also causes the type comparison in the sparse _Generic()
evaluation to fail so that it ends up with the default, i.e. the
original qualified type of a 'const __beNN' pointer. That then ends up as
the first pointer argument to builtin_memcpy(), which obviously causes
the above sparse warnings.

The easiest solution would be to force cast the pointer to void * when
CHECKER is defined, but that reduces coverage.

I've come up with the below, but it's clearly a hack... __CAST_SPARSE()
is required as sparse otherwise complains about storing __u64 in __be64.

Thanks,

        tglx
---
 include/linux/compiler_types.h |   10 ++++++++++
 include/vdso/unaligned.h       |   16 +++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)

--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -577,6 +577,15 @@ struct ftrace_likely_data {
 		unsigned type:	(unsigned type)0,			\
 		signed type:	(signed type)0
 
+#ifdef __CHECKER__
+#define __be_types_expr_cases()						\
+	__be16: (__u16)0,						\
+	__be32: (__u32)0,						\
+	__be64: (__u64)0,
+#else
+#define __be_types_expr_cases()
+#endif
+
 #define __unqual_scalar_typeof(x) typeof(				\
 		_Generic((x),						\
 			 char:	(char)0,				\
@@ -585,6 +594,7 @@ struct ftrace_likely_data {
 			 __scalar_type_to_expr_cases(int),		\
 			 __scalar_type_to_expr_cases(long),		\
 			 __scalar_type_to_expr_cases(long long),	\
+			 __be_types_expr_cases()			\
 			 default: (x)))
 
 /* Is this type a native word size -- useful for atomic operations */
--- a/include/vdso/unaligned.h
+++ b/include/vdso/unaligned.h
@@ -4,6 +4,12 @@
 
 #include <linux/compiler_types.h>
 
+#ifdef __CHECKER__
+#define __CAST_SPARSE(type) (type __force)
+#else
+#define __CAST_SPARSE(type)
+#endif
+
 /**
  * __get_unaligned_t - read an unaligned value from memory.
  * @type:	the type to load from the pointer.
@@ -17,12 +23,12 @@
  * expression rather than type, a pointer is used to avoid warnings about mixing
  * the use of 0 and NULL. The void* cast silences ubsan warnings.
  */
-#define __get_unaligned_t(type, ptr) ({					\
-	type *__get_unaligned_ctrl_type __always_unused = NULL;		\
+#define __get_unaligned_t(type, ptr) ({						\
+	type *__get_unaligned_ctrl_type __always_unused = NULL;			\
 	__unqual_scalar_typeof(*__get_unaligned_ctrl_type) __get_unaligned_val; \
-	__builtin_memcpy(&__get_unaligned_val, (void *)(ptr),		\
-			 sizeof(__get_unaligned_val));			\
-	__get_unaligned_val;						\
+	__builtin_memcpy(&__get_unaligned_val, (void *)(ptr),			\
+			 sizeof(__get_unaligned_val));				\
+	__CAST_SPARSE(type) __get_unaligned_val;				\
 })
 
 /**




    

      
