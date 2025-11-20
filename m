Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08EE35C1AA
	for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651657; cv=none; b=ZXJ46zKGDJgHDtctqJk4qofdC01UaTUIr0uYfKlA6lMMHKUZaeL03mKxfppwJbj1n+FKClpby+xKl3o7E9YdZ77S8Isi5QF9bpwW2/CBIpsiKacb6RcrGivaqigqjAaelQ64QK+m3hKmb9kGzcP6Tuztmj1+Ka06p5ESinBpPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651657; c=relaxed/simple;
	bh=VbJWJQZmBX4+csAoT1yUNldmDqG40I0IsN6jc/COgn4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hl6p/flwjAFUmOu4O2YCD/OrvXmVeuM75bLBhVlxZ7HcIWyogg9hIpFoXr03BNWk0RkVf3R3kEJEl3hK+IpjgrOo6oEwDGe/pTWhhaZPGA6UjBpeKX4SCzcvd1zQ45fvnpaQbqvsperkharOqrQlxn0frceuDWHoNaQibj9tVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrdudiZa; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrdudiZa"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4775fcf67d8so10455825e9.0
        for <linux-sparse@vger.kernel.org>; Thu, 20 Nov 2025 07:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651628; x=1764256428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJMOXRb0WgY3NkQlI/hPCIKlELlXVsKWBZcrKDKyFiM=;
        b=GrdudiZaHvxb1ceX1CbrJeUQy6v+6Dja9fYK1GVBTfp5tDyfaWLBbkziOkp+4OATq1
         vkzOMCn6UePQO6uF7yU5m6ZnAhoKEv2rMbK+rglsDKVfZbp41FKRInaOgg7L/m4X/X71
         Qf7xw3ntI0rHCD7XRphR/0WgM1uXvmlbL2VpvsT6Nrgu8ameafysrzxZG0JZfyyJNH1E
         WAMMz9z+y1jAt0MlLwb5NJjxq9Dz+Un6zFFOfHmd96Vee0Z964+CrgaG8kiDlaAyoUyT
         jAzyYckkjya33dwP+UsD4A7XOTYa0KkswBE5ypf+yGk9uFGH0UmoVdLerP9WXZx8D/m2
         UMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651628; x=1764256428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aJMOXRb0WgY3NkQlI/hPCIKlELlXVsKWBZcrKDKyFiM=;
        b=nSD4MiTAo9Ajmb7KGAg8gtNXyO5uTpt78bwXkDD8jyU/mdaj2qDQqqkaFo/SuN98md
         dluIy/u2aymgQj4bqHfYbVjqRNJZROrUbGNx4Vlk0iblSRYEm39pX4/ntjnaP76C2G+k
         YzL4j/ng9Hzi7efl4H7if1JobQF49Y3y2/ACELL3dB29R1E52qcBBSrQgY7TiH8aoqpD
         1siIdbo8UH7xN7mzG0BlNs1/wQS8pQuL44sNfKMAblkYwj57ulMNBQikK6ZQ1Yui9aQU
         BFTWA3XM3A+TDp4aKbgqMfsqJoDxvncZoBKDN38IIER1ydZ8VuQHLqeRDSxZN7E0Cf/o
         rYog==
X-Forwarded-Encrypted: i=1; AJvYcCXY0rW5F5EwnPbWf1PtqnM/tXW7t8UbYo1WiyVu6Trc29p/+mD3TSoa7LQsWYEYYPAU7YV8JMhWqjjBIs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTGHDjMjx7Toh6SSYAigv3i6iP8V27dx+5wy25ylajfSOtvrt9
	0zSeehsAKmy85CSSc7SkzbihldNXI9b1azXoQ9EG6pADd0/WXXzvxge7e2jpMkgvssws3cfGhVO
	/nw==
X-Google-Smtp-Source: AGHT+IFOmV1c9L2LvdRR9E5a5WseLoVuoNabSykiYJeUUPoV60hKtqkuL5rUoQ3b9gFsGSgiTWOm153hKQ==
X-Received: from wmpi31.prod.google.com ([2002:a05:600c:4b1f:b0:477:55c0:6392])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4f49:b0:477:7991:5d1e
 with SMTP id 5b1f17b1804b1-477b8a9fd96mr32224715e9.25.1763651627745; Thu, 20
 Nov 2025 07:13:47 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:55 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-31-elver@google.com>
Subject: [PATCH v4 30/35] stackdepot: Enable context analysis
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Enable context analysis for stackdepot.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.

v2:
* Remove disable/enable_context_analysis() around headers.
---
 lib/Makefile     |  1 +
 lib/stackdepot.c | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 59ed5f881bcb..2e983f37d173 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -248,6 +248,7 @@ obj-$(CONFIG_POLYNOMIAL) += polynomial.o
 # Prevent the compiler from calling builtins like memcmp() or bcmp() from this
 # file.
 CFLAGS_stackdepot.o += -fno-builtin
+CONTEXT_ANALYSIS_stackdepot.o := y
 obj-$(CONFIG_STACKDEPOT) += stackdepot.o
 KASAN_SANITIZE_stackdepot.o := n
 # In particular, instrumenting stackdepot.c with KMSAN will result in infinite
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index de0b0025af2b..166f50ad8391 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -61,18 +61,18 @@ static unsigned int stack_bucket_number_order;
 /* Hash mask for indexing the table. */
 static unsigned int stack_hash_mask;
 
+/* The lock must be held when performing pool or freelist modifications. */
+static DEFINE_RAW_SPINLOCK(pool_lock);
 /* Array of memory regions that store stack records. */
-static void **stack_pools;
+static void **stack_pools __pt_guarded_by(&pool_lock);
 /* Newly allocated pool that is not yet added to stack_pools. */
 static void *new_pool;
 /* Number of pools in stack_pools. */
 static int pools_num;
 /* Offset to the unused space in the currently used pool. */
-static size_t pool_offset = DEPOT_POOL_SIZE;
+static size_t pool_offset __guarded_by(&pool_lock) = DEPOT_POOL_SIZE;
 /* Freelist of stack records within stack_pools. */
-static LIST_HEAD(free_stacks);
-/* The lock must be held when performing pool or freelist modifications. */
-static DEFINE_RAW_SPINLOCK(pool_lock);
+static __guarded_by(&pool_lock) LIST_HEAD(free_stacks);
 
 /* Statistics counters for debugfs. */
 enum depot_counter_id {
@@ -291,6 +291,7 @@ EXPORT_SYMBOL_GPL(stack_depot_init);
  * Initializes new stack pool, and updates the list of pools.
  */
 static bool depot_init_pool(void **prealloc)
+	__must_hold(&pool_lock)
 {
 	lockdep_assert_held(&pool_lock);
 
@@ -338,6 +339,7 @@ static bool depot_init_pool(void **prealloc)
 
 /* Keeps the preallocated memory to be used for a new stack depot pool. */
 static void depot_keep_new_pool(void **prealloc)
+	__must_hold(&pool_lock)
 {
 	lockdep_assert_held(&pool_lock);
 
@@ -357,6 +359,7 @@ static void depot_keep_new_pool(void **prealloc)
  * the current pre-allocation.
  */
 static struct stack_record *depot_pop_free_pool(void **prealloc, size_t size)
+	__must_hold(&pool_lock)
 {
 	struct stack_record *stack;
 	void *current_pool;
@@ -391,6 +394,7 @@ static struct stack_record *depot_pop_free_pool(void **prealloc, size_t size)
 
 /* Try to find next free usable entry from the freelist. */
 static struct stack_record *depot_pop_free(void)
+	__must_hold(&pool_lock)
 {
 	struct stack_record *stack;
 
@@ -428,6 +432,7 @@ static inline size_t depot_stack_record_size(struct stack_record *s, unsigned in
 /* Allocates a new stack in a stack depot pool. */
 static struct stack_record *
 depot_alloc_stack(unsigned long *entries, unsigned int nr_entries, u32 hash, depot_flags_t flags, void **prealloc)
+	__must_hold(&pool_lock)
 {
 	struct stack_record *stack = NULL;
 	size_t record_size;
@@ -486,6 +491,7 @@ depot_alloc_stack(unsigned long *entries, unsigned int nr_entries, u32 hash, dep
 }
 
 static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
+	__must_not_hold(&pool_lock)
 {
 	const int pools_num_cached = READ_ONCE(pools_num);
 	union handle_parts parts = { .handle = handle };
@@ -502,7 +508,8 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 		return NULL;
 	}
 
-	pool = stack_pools[pool_index];
+	/* @pool_index either valid, or user passed in corrupted value. */
+	pool = context_unsafe(stack_pools[pool_index]);
 	if (WARN_ON(!pool))
 		return NULL;
 
@@ -515,6 +522,7 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 
 /* Links stack into the freelist. */
 static void depot_free_stack(struct stack_record *stack)
+	__must_not_hold(&pool_lock)
 {
 	unsigned long flags;
 
-- 
2.52.0.rc1.455.g30608eb744-goog

