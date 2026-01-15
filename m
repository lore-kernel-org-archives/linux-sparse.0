Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21532573C;
	Thu, 15 Jan 2026 21:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511497; cv=none; b=QA7OC+FbPPkD91fUi9Yel+RzLHN2AsZDSFH+hKY4nqD0GvrRsxB/uKYcyNF2qrkUq2ZfV4hbcMo4T4ecDwGeZVe3z9goOHt/4SFQE4ZMOUYBDSP/0fVlGNGrqMsUhLrjp3joGDDWvjC3uhBoua0BiAoGpAXcvjqecWxyPCxmTpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511497; c=relaxed/simple;
	bh=WR9unCzc0TB01qcd9ZOTxjfmUxp33j4cJgHXk+CTsHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAn1TSUDE2F/KRfu/VzvaXdtIguwzK1UbvfINkNaWieRaykrDrPV2bgdKQfroVtELjA9DHHit1Moi04A1mwycTao8nUYAzJkM2rwkI4QuQmpwe7g16nWjo2NE/+ys8IvZZw0zTeK4neAz4yS6PC+JLWXSHeIkIEw/pSxgrG9Seg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Sf8vz5gs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Sf8vz5gs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kayCw8jfD5k3qb9Lh5Ilv68xIPi5jIFXkpxrm1bVPS8=; b=Sf8vz5gsO9Fb2TquzK6r7orykR
	PBDsHWbDgnKEV8GXuRMBh2nDvKmE+Si4sLLVXUqvlWU78s1ijC/pTuJKyTHnaQpsKw4EmD9hD7bsi
	IkYy7ItuLtEJ+/sCYUOXZmC4eDSuYjYSq2/GxT8kGNvyI3o/SOh8xrdbvxiKTw9XGkxJPog+iqwlY
	25CMRq4k/Mhv2W/SST1so+r3YpGZcnTN8TGKNSzPRZgIYd5WDHY/Pg0vXhJ0KIShKWmMZQ5OqHQY+
	tEGHvcP//xD80SFmaN9UB7CbDt3LoPA7pYCygkgr2d8jikvuCDBrtc1L5oZBZ62FWBfh0zWBPgncc
	H+eZL34A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgUcj-00000007eNU-1pyJ;
	Thu, 15 Jan 2026 21:11:28 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 21CB23003C4; Thu, 15 Jan 2026 22:11:20 +0100 (CET)
Date: Thu, 15 Jan 2026 22:11:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Ian Rogers <irogers@google.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, sparse@chrisli.org, linux-sparse@vger.kernel.org,
	Marco Elver <elver@google.com>
Subject: Re: [tip:timers/vdso 12/14] net/rds/ib_cm.c:96:35: sparse: sparse:
 incorrect type in argument 1 (different modifiers)
Message-ID: <20260115211120.GD831050@noisy.programming.kicks-ass.net>
References: <202601150001.sKSN644a-lkp@intel.com>
 <87v7h23cb0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7h23cb0.ffs@tglx>

On Thu, Jan 15, 2026 at 08:28:51PM +0100, Thomas Gleixner wrote:
> On Thu, Jan 15 2026 at 00:36, kernel test robot wrote:
> 
> Cc+ sparse folks.
> 
> > sparse warnings: (new ones prefixed by >>)
> >>> net/rds/ib_cm.c:96:35: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
> >    net/rds/ib_cm.c:96:35: sparse:     expected void *
> >    net/rds/ib_cm.c:96:35: sparse:     got restricted __be64 const *
> >    net/rds/ib_cm.c:103:27: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void * @@     got restricted __be64 const * @@
> >    net/rds/ib_cm.c:103:27: sparse:     expected void *
> >    net/rds/ib_cm.c:103:27: sparse:     got restricted __be64 const *
> 
> After staring a while at it, it turns out that get_unaligned_t(), which
> uses __unqual_scalar_typeof() to get an unqualified type makes sparse
> unhappy when the data type is __be64 (or any other __beNN variant).
> 
> __beNN is annotated with __attribute__((bitwise)) when sparse is invoked
> (#ifdef CHECKER). That allows sparse to detect incompatible math
> operations with __beNN variables.
> 

Per:

  https://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git/commit/?id=dc9efe442b8949234a6599fdc94dc7221dd040e1

it seems Sparse now knows about __typeof_unqual__; and it looks like the
implementation does what you want here (although I've not tested it).

Something like so perhaps, which then mandates the very latest Sparse.

---
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 04487c9bd751..7e0583ceb49f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -232,11 +232,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 /*
  * Use __typeof_unqual__() when available.
- *
- * XXX: Remove test for __CHECKER__ once
- * sparse learns about __typeof_unqual__().
  */
-#if CC_HAS_TYPEOF_UNQUAL && !defined(__CHECKER__)
+#if CC_HAS_TYPEOF_UNQUAL || defined(__CHECKER__)
 # define USE_TYPEOF_UNQUAL 1
 #endif
 
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d3318a3c2577..a37d832d99a8 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -569,6 +569,7 @@ struct ftrace_likely_data {
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
  */
+#ifndef USE_TYPEOF_UNQUAL
 /*
  * Prefer C11 _Generic for better compile-times and simpler code. Note: 'char'
  * is not type-compatible with 'signed char', and we define a separate case.
@@ -586,6 +587,9 @@ struct ftrace_likely_data {
 			 __scalar_type_to_expr_cases(long),		\
 			 __scalar_type_to_expr_cases(long long),	\
 			 default: (x)))
+#else
+#define __unqual_scalar_typeof(x) __typeof_unqual__(x)
+#endif
 
 /* Is this type a native word size -- useful for atomic operations */
 #define __native_word(t) \
