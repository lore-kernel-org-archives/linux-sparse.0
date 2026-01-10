Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4A9227B95
	for <linux-sparse@vger.kernel.org>; Sat, 10 Jan 2026 03:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768015410; cv=none; b=sHMq+ESiOP4qk7b6RX5K2qZJohqWAk0qopVhidRogLxjDOHfVjjZYxXq8ux5RZ+UX/+OPE64guiudUHzpSTuG0MtoBqwwCITVDK8mxfE9rXx5GK8L1jr4DhpHUTjtG+b0ZMLCcaM9Rl4onMMqxZKGkx6DcTYOaKA/UkWAScFu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768015410; c=relaxed/simple;
	bh=pIOWvWaMtOeKk2tGzz6+GGUr1ULM/ynwPFesUocVqWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mV4bNSte3LS0qJlarnd++IUbMo4vomfeIGiOWuj1RwUDaqcTKE2pSRm4n6HQUU6N99kUTQ/wZ2/BEqvmolC0xdAKXIwe0QFiH45GNcqTJc62ENiyO32AEIvSoEZASCyZUCfQtBUWiAEvxGO/wi3rap2IbRWPthGm3BXKYUTYjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oWcbw1A4; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oWcbw1A4"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-43284ed32a0so2445314f8f.3
        for <linux-sparse@vger.kernel.org>; Fri, 09 Jan 2026 19:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768015406; x=1768620206; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mq1TLJDe/+4ZL2ybMlQeyJEwr2YWMjzl9f+SS6lqEM=;
        b=oWcbw1A4uPwGs4vppG6VLWQEWjK4cV8m8zusZrJAkg45Vf9r3Gkot3WJE14LScCPFz
         AJnkY3wgatsZDMlnujMrkF6rlCFeCt2CeGakIOP8W9ggfZK4MV+KIY/b9WjABHZTDRNx
         TcMmHNubUt8TIoHoQTj9Rxitgv8yCSXzZU9sP6KF8a20mm1kjjKqLVaqbb+Obn36+HmX
         M1I2lwHEGK4HXLvJd4juxSrqoAu7jljxHMqUpHLTEoxBg9y8bNSm6T9b05XA9sFP/xXm
         Q2fYhJGdbhddaINXCxW0QW3BwKW4pnojpZGQrrBddlS75g1C1A/NGJve7sfinvqMVz63
         4xJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768015406; x=1768620206;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8mq1TLJDe/+4ZL2ybMlQeyJEwr2YWMjzl9f+SS6lqEM=;
        b=QRgLS/yvSe4s0DXNu//0nmT1KS8Qhcx2MjShf5Xe/fDR+etDujr7uBhbOWWZJSqb9C
         Xvk9zUnI/G0Lq2GxWO1eEfMrkH3Dhdm8YAH/Ef6vSQ+2xph4UtReOpZkhpfqP++Yuh/6
         jxqOMhSn6HBwsxBaPeoOCG/GaQJJrans8tSJ9E2v3zudASRGPwM3XorWd7v9l3JSsjhS
         UeZaE4nSH0y1l2DSXGCcC7ygXL3t7Kmrr8rG9XkAZ7drCVo8BIu15eSi65stTLCRvIne
         7Y9aB3NWZNTYhHtGBeL0+R8Wi/pcAciWX/SIC7JkFGEmW/SbK5jxUPiGzhc2b5kPZ8To
         TeXw==
X-Forwarded-Encrypted: i=1; AJvYcCV7hn6h6D8mgtmJrOcfSmlBLEps+cV70sNeTZf8TTz8LX9X8mBQVxWZUjMkPTptsDGzvnciEf16spO+6yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLsG92FIvMsTfqhd8Z2QpsqnfnjJbtxsY73rPZag3p7Yuy5R5
	Oky0N2aXfydJIi3B8drihcsX47JS8WkVHF2c13I5TNftMuN+ZZMYubsnYv7f6n77NQ==
X-Gm-Gg: AY/fxX7FdmguH6M/RV69vA5yPpG8tdkT/d7JaOr7RPrMJP13/QshNXAzkk/JODTVoEf
	8jfk4KY4lPsOlJaRpqJrBxYCFhG70PPAKruzPnrIquxI06SQukJDStANb5y1MR2HHsqK2m8b3Vt
	tCZ4w1JVs2cIDB3jsrc3Z6uup7ItmKwKWItjPkKw+nVqvXwQmacVbtyWqjC6W4wfVlZ5kTD51Qq
	VTEBbUI5bi6BQDCl6G+D4MkROF+RCZ+JX1qYU57toTElsBbdT0FRDCikbPMFozzrA1/QpLpLG0i
	ES26C4W3WZMQhdq7F5wLnUU0iI7hCJ3XMS6fIQ5TFJwcj1HfOTCerJwV1P0boST3eGrYzmji1XF
	S1F2QOeO413q+SiFnMRHdSXuHPEdlxhBkPiRLu1mRU0IZYwSEU7M8MVHkob2usmzZaN3WZ7E6TU
	lnPO7d3naanvT5STIbWr6YkBuGwOz7JocPqNAla+IwxIEyDPtV
X-Google-Smtp-Source: AGHT+IG9MVcoXYErsfPeUV+H1nwvNcE/auehFYm8oxMSVuIuHSa0XoHmpfdrWmRqI4nV3F3yqmQGrg==
X-Received: by 2002:a05:6000:2909:b0:42f:bad9:20c9 with SMTP id ffacd0b85a97d-432c36329f9mr14528086f8f.19.1768015405505;
        Fri, 09 Jan 2026 19:23:25 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:2965:801e:e18a:cba1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee24esm25605099f8f.33.2026.01.09.19.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 19:23:24 -0800 (PST)
Date: Sat, 10 Jan 2026 04:23:16 +0100
From: Marco Elver <elver@google.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, kasan-dev@googlegroups.com,
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org
Subject: Re: [PATCH v5 10/36] locking/mutex: Support Clang's context analysis
Message-ID: <aWHGJA8imMgELQrA@elver.google.com>
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-11-elver@google.com>
 <57062131-e79e-42c2-aa0b-8f931cb8cac2@acm.org>
 <aWA9P3_oI7JFTdkC@elver.google.com>
 <20260109060249.GA5259@lst.de>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109060249.GA5259@lst.de>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Fri, Jan 09, 2026 at 07:02AM +0100, Christoph Hellwig wrote:
> On Fri, Jan 09, 2026 at 12:26:55AM +0100, Marco Elver wrote:
> > Probably the most idiomatic option is to just factor out construction.
> > Clearly separating complex object construction from use also helps
> > readability regardless, esp. where concurrency is involved. We could
> > document such advice somewhere.
> 
> Initializing and locking a mutex (or spinlock, or other primitive) is a
> not too unusual pattern, often used when inserting an object into a
> hash table or other lookup data structure.  So supporting it without
> creating pointless wrapper functions would be really useful.  One thing
> that would be nice to have and probably help here is to have lock
> initializers that create the lock in a held state.

Fair point. Without new APIs, we can fix it with the below patch;
essentially "promoting" the context lock to "reentrant" during
initialization scope. It's not exactly well documented on the Clang
side, but is a side-effect of how reentrancy works in the analysis:
https://github.com/llvm/llvm-project/pull/175267

------ >8 ------

From 9c9b521b286f241f849dcc4f9efbd9582dabd3cc Mon Sep 17 00:00:00 2001
From: Marco Elver <elver@google.com>
Date: Sat, 10 Jan 2026 00:47:35 +0100
Subject: [PATCH] compiler-context-analysis: Support immediate acquisition
 after initialization

When a lock is initialized (e.g. mutex_init()), we assume/assert that
the context lock is held to allow initialization of guarded members
within the same scope.

However, this previously prevented actually acquiring the lock within
that same scope, as the analyzer would report a double-lock warning:

  mutex_init(&mtx);
  ...
  mutex_lock(&mtx); // acquiring mutex 'mtx' that is already held

To fix (without new init+lock APIs), we can tell the analysis to treat
the "held" context lock resulting from initialization as reentrant,
allowing subsequent acquisitions to succeed.

To do so *only* within the initialization scope, we can cast the lock
pointer to any reentrant type for the init assume/assert. Introduce a
generic reentrant context lock type `struct __ctx_lock_init` and add
`__inits_ctx_lock()` that casts the lock pointer to this type before
assuming/asserting it.

This ensures that the initial "held" state is reentrant, allowing
patterns like:

  mutex_init(&lock);
  ...
  mutex_lock(&lock);

to compile without false positives, and avoids having to make all
context lock types reentrant outside an initialization scope.

The caveat here is missing real double-lock bugs right after init scope.
However, this is a classic trade-off of avoiding false positives against
(unlikely) false negatives.

Link: https://lore.kernel.org/all/57062131-e79e-42c2-aa0b-8f931cb8cac2@acm.org/
Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler-context-analysis.h | 12 ++++++++++++
 include/linux/local_lock_internal.h       |  6 +++---
 include/linux/mutex.h                     |  2 +-
 include/linux/rwlock.h                    |  4 ++--
 include/linux/rwlock_rt.h                 |  2 +-
 include/linux/rwsem.h                     |  4 ++--
 include/linux/seqlock.h                   |  2 +-
 include/linux/spinlock.h                  |  8 ++++----
 include/linux/spinlock_rt.h               |  2 +-
 include/linux/ww_mutex.h                  |  2 +-
 lib/test_context-analysis.c               |  3 +++
 11 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
index db7e0d48d8f2..e056cd6e8aaa 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -43,6 +43,14 @@
 # define __assumes_ctx_lock(...)		__attribute__((assert_capability(__VA_ARGS__)))
 # define __assumes_shared_ctx_lock(...)	__attribute__((assert_shared_capability(__VA_ARGS__)))
 
+/*
+ * Generic reentrant context lock type that we cast to when initializing context
+ * locks with __assumes_ctx_lock(), so that we can support guarded member
+ * initialization, but also immediate use after initialization.
+ */
+struct __ctx_lock_type(init_generic) __reentrant_ctx_lock __ctx_lock_init;
+# define __inits_ctx_lock(var) __assumes_ctx_lock((const struct __ctx_lock_init *)(var))
+
 /**
  * __guarded_by - struct member and globals attribute, declares variable
  *                only accessible within active context
@@ -120,6 +128,8 @@
 		__attribute__((overloadable)) __assumes_ctx_lock(var) { }				\
 	static __always_inline void __assume_shared_ctx_lock(const struct name *var)			\
 		__attribute__((overloadable)) __assumes_shared_ctx_lock(var) { }			\
+	static __always_inline void __init_ctx_lock(const struct name *var)				\
+		__attribute__((overloadable)) __inits_ctx_lock(var) { }					\
 	struct name
 
 /**
@@ -162,6 +172,7 @@
 # define __releases_shared_ctx_lock(...)
 # define __assumes_ctx_lock(...)
 # define __assumes_shared_ctx_lock(...)
+# define __inits_ctx_lock(var)
 # define __returns_ctx_lock(var)
 # define __guarded_by(...)
 # define __pt_guarded_by(...)
@@ -176,6 +187,7 @@
 # define __release_shared_ctx_lock(var)		do { } while (0)
 # define __assume_ctx_lock(var)			do { (void)(var); } while (0)
 # define __assume_shared_ctx_lock(var)			do { (void)(var); } while (0)
+# define __init_ctx_lock(var)			do { (void)(var); } while (0)
 # define context_lock_struct(name, ...)		struct __VA_ARGS__ name
 # define disable_context_analysis()
 # define enable_context_analysis()
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
index e8c4803d8db4..36b8628d09fd 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -86,13 +86,13 @@ do {								\
 			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
 			      LD_LOCK_PERCPU);			\
 	local_lock_debug_init(lock);				\
-	__assume_ctx_lock(lock);				\
+	__init_ctx_lock(lock);					\
 } while (0)
 
 #define __local_trylock_init(lock)				\
 do {								\
 	__local_lock_init((local_lock_t *)lock);		\
-	__assume_ctx_lock(lock);				\
+	__init_ctx_lock(lock);					\
 } while (0)
 
 #define __spinlock_nested_bh_init(lock)				\
@@ -104,7 +104,7 @@ do {								\
 			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
 			      LD_LOCK_NORMAL);			\
 	local_lock_debug_init(lock);				\
-	__assume_ctx_lock(lock);				\
+	__init_ctx_lock(lock);					\
 } while (0)
 
 #define __local_lock_acquire(lock)					\
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 89977c215cbd..5d2ef75c4fdb 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -62,7 +62,7 @@ do {									\
 	static struct lock_class_key __key;				\
 									\
 	__mutex_init((mutex), #mutex, &__key);				\
-	__assume_ctx_lock(mutex);					\
+	__init_ctx_lock(mutex);						\
 } while (0)
 
 /**
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 65a5b55e1bcd..7e171634d2c4 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -22,11 +22,11 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__rwlock_init((lock), #lock, &__key);			\
-	__assume_ctx_lock(lock);				\
+	__init_ctx_lock(lock);					\
 } while (0)
 #else
 # define rwlock_init(lock)					\
-	do { *(lock) = __RW_LOCK_UNLOCKED(lock); __assume_ctx_lock(lock); } while (0)
+	do { *(lock) = __RW_LOCK_UNLOCKED(lock); __init_ctx_lock(lock); } while (0)
 #endif
 
 #ifdef CONFIG_DEBUG_SPINLOCK
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 37b387dcab21..1e087a6ce2cf 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -22,7 +22,7 @@ do {							\
 							\
 	init_rwbase_rt(&(rwl)->rwbase);			\
 	__rt_rwlock_init(rwl, #rwl, &__key);		\
-	__assume_ctx_lock(rwl);				\
+	__init_ctx_lock(rwl);				\
 } while (0)
 
 extern void rt_read_lock(rwlock_t *rwlock)	__acquires_shared(rwlock);
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 8da14a08a4e1..6ea7d2a23580 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -121,7 +121,7 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__init_rwsem((sem), #sem, &__key);			\
-	__assume_ctx_lock(sem);					\
+	__init_ctx_lock(sem);					\
 } while (0)
 
 /*
@@ -175,7 +175,7 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__init_rwsem((sem), #sem, &__key);			\
-	__assume_ctx_lock(sem);					\
+	__init_ctx_lock(sem);					\
 } while (0)
 
 static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 113320911a09..a0670adb4b6e 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -816,7 +816,7 @@ static __always_inline void write_seqcount_latch_end(seqcount_latch_t *s)
 	do {								\
 		spin_lock_init(&(sl)->lock);				\
 		seqcount_spinlock_init(&(sl)->seqcount, &(sl)->lock);	\
-		__assume_ctx_lock(sl);					\
+		__init_ctx_lock(sl);					\
 	} while (0)
 
 /**
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 396b8c5d6c1b..e50372a5f7d1 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -106,12 +106,12 @@ do {									\
 	static struct lock_class_key __key;				\
 									\
 	__raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN);	\
-	__assume_ctx_lock(lock);					\
+	__init_ctx_lock(lock);						\
 } while (0)
 
 #else
 # define raw_spin_lock_init(lock)				\
-	do { *(lock) = __RAW_SPIN_LOCK_UNLOCKED(lock); __assume_ctx_lock(lock); } while (0)
+	do { *(lock) = __RAW_SPIN_LOCK_UNLOCKED(lock); __init_ctx_lock(lock); } while (0)
 #endif
 
 #define raw_spin_is_locked(lock)	arch_spin_is_locked(&(lock)->raw_lock)
@@ -324,7 +324,7 @@ do {								\
 								\
 	__raw_spin_lock_init(spinlock_check(lock),		\
 			     #lock, &__key, LD_WAIT_CONFIG);	\
-	__assume_ctx_lock(lock);				\
+	__init_ctx_lock(lock);					\
 } while (0)
 
 #else
@@ -333,7 +333,7 @@ do {								\
 do {						\
 	spinlock_check(_lock);			\
 	*(_lock) = __SPIN_LOCK_UNLOCKED(_lock);	\
-	__assume_ctx_lock(_lock);		\
+	__init_ctx_lock(_lock);			\
 } while (0)
 
 #endif
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 0a585768358f..154d7290bd99 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -20,7 +20,7 @@ static inline void __rt_spin_lock_init(spinlock_t *lock, const char *name,
 do {								\
 	rt_mutex_base_init(&(slock)->lock);			\
 	__rt_spin_lock_init(slock, name, key, percpu);		\
-	__assume_ctx_lock(slock);				\
+	__init_ctx_lock(slock);					\
 } while (0)
 
 #define _spin_lock_init(slock, percpu)				\
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 58e959ee10e9..ecb5564ee70d 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -107,7 +107,7 @@ context_lock_struct(ww_acquire_ctx) {
  */
 static inline void ww_mutex_init(struct ww_mutex *lock,
 				 struct ww_class *ww_class)
-	__assumes_ctx_lock(lock)
+	__inits_ctx_lock(lock)
 {
 	ww_mutex_base_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
 	lock->ctx = NULL;
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 1c5a381461fc..2f733b5cc650 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -165,6 +165,9 @@ static void __used test_mutex_init(struct test_mutex_data *d)
 {
 	mutex_init(&d->mtx);
 	d->counter = 0;
+
+	mutex_lock(&d->mtx);
+	mutex_unlock(&d->mtx);
 }
 
 static void __used test_mutex_lock(struct test_mutex_data *d)
-- 
2.52.0.457.g6b5491de43-goog
