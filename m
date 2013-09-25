From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip:sched/core 16/27] fs/jbd/commit.c:105:12: sparse: context
 imbalance in 'inverted_lock' - wrong count at exit
Date: Wed, 25 Sep 2013 20:59:25 +0200
Message-ID: <20130925185925.GD3657@laptop.programming.kicks-ass.net>
References: <52432bed.WfPoNUw4qxmYeQy4%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56908 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab3IYS7c (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 25 Sep 2013 14:59:32 -0400
Content-Disposition: inline
In-Reply-To: <52432bed.WfPoNUw4qxmYeQy4%fengguang.wu@intel.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, kbuild-all@01.org, linux-sparse@vger.kernel.org, sparse@chrisli.org

On Thu, Sep 26, 2013 at 02:31:09AM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> head:   1a338ac32ca630f67df25b4a16436cccc314e997
> commit: 0c44c2d0f459cd7e275242b72f500137c4fa834d [16/27] x86: Use asm goto to implement better modify_and_test() functions
> reproduce: make C=1 CF=-D__CHECK_ENDIAN__
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> fs/jbd/commit.c:105:12: sparse: context imbalance in 'inverted_lock' - wrong count at exit
>    fs/jbd/commit.c:205:9: sparse: context imbalance in 'journal_submit_data_buffers' - different lock contexts for basic block
>    fs/jbd/commit.c:456:9: sparse: context imbalance in 'journal_commit_transaction' - different lock contexts for basic block
> --
>    include/linux/bit_spinlock.h:62:25: sparse: context imbalance in '__try_to_free_cp_buf' - unexpected unlock
>    fs/jbd/checkpoint.c:155:36: sparse: context imbalance in '__log_wait_for_space' - unexpected unlock
>    include/linux/bit_spinlock.h:62:25: sparse: context imbalance in '__wait_cp_io' - unexpected unlock
>    fs/jbd/checkpoint.c:294:23: sparse: context imbalance in '__process_buffer' - unexpected unlock
>    fs/jbd/checkpoint.c:390:9: sparse: context imbalance in 'log_do_checkpoint' - different lock contexts for basic block
> >> fs/jbd/checkpoint.c:557:12: sparse: context imbalance in 'journal_clean_one_cp_list' - wrong count at exit
> --
> >> drivers/infiniband/hw/qib/qib_verbs.h:1061:36: sparse: crazy programmer
> 
> vim +/inverted_lock +105 fs/jbd/commit.c
> 
>     89			WARN_ON_ONCE(buffer_dirty(bh));
>     90			clear_buffer_freed(bh);
>     91			clear_buffer_mapped(bh);
>     92			clear_buffer_new(bh);
>     93			clear_buffer_req(bh);
>     94			bh->b_bdev = NULL;
>     95			release_buffer_page(bh);
>     96		} else
>     97			put_bh(bh);
>     98	}
>     99	
>    100	/*
>    101	 * Try to acquire jbd_lock_bh_state() against the buffer, when j_list_lock is
>    102	 * held.  For ranking reasons we must trylock.  If we lose, schedule away and
>    103	 * return 0.  j_list_lock is dropped in this case.
>    104	 */
>  > 105	static int inverted_lock(journal_t *journal, struct buffer_head *bh)
>    106	{
>    107		if (!jbd_trylock_bh_state(bh)) {
>    108			spin_unlock(&journal->j_list_lock);
>    109			schedule();
>    110			return 0;
>    111		}
>    112		return 1;
>    113	}

I've really no idea how that patch can cause sparse warnings. Patch
included below for the sparse people. Does sparse presume to understand
inline asm?

---
Subject: x86: Use asm goto to implement better modify_and_test() functions
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Sep 11 15:19:24 CEST 2013

Linus suggested using asm goto to get rid of the typical SETcc + TEST
instruction pair -- which also clobbers an extra register -- for our
typical modify_and_test() functions.

Because asm goto doesn't allow output fields it has to include an
unconditinal memory clobber when it changes a memory variable to force
a reload.

Luckily all atomic ops already imply a compiler barrier to go along
with their memory barrier semantics.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic.h      |   29 ++++----------------------
 arch/x86/include/asm/atomic64_64.h |   28 +++----------------------
 arch/x86/include/asm/bitops.h      |   24 +++------------------
 arch/x86/include/asm/local.h       |   28 +++----------------------
 arch/x86/include/asm/rmwcc.h       |   41 +++++++++++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 92 deletions(-)

--- a/arch/x86/include/asm/atomic.h
+++ b/arch/x86/include/asm/atomic.h
@@ -6,6 +6,7 @@
 #include <asm/processor.h>
 #include <asm/alternative.h>
 #include <asm/cmpxchg.h>
+#include <asm/rmwcc.h>
 
 /*
  * Atomic operations that C can't guarantee us.  Useful for
@@ -76,12 +77,7 @@ static inline void atomic_sub(int i, ato
  */
 static inline int atomic_sub_and_test(int i, atomic_t *v)
 {
-	unsigned char c;
-
-	asm volatile(LOCK_PREFIX "subl %2,%0; sete %1"
-		     : "+m" (v->counter), "=qm" (c)
-		     : "ir" (i) : "memory");
-	return c;
+	GEN_BINARY_RMWcc(LOCK_PREFIX "subl", v->counter, i, "%0", "e");
 }
 
 /**
@@ -118,12 +114,7 @@ static inline void atomic_dec(atomic_t *
  */
 static inline int atomic_dec_and_test(atomic_t *v)
 {
-	unsigned char c;
-
-	asm volatile(LOCK_PREFIX "decl %0; sete %1"
-		     : "+m" (v->counter), "=qm" (c)
-		     : : "memory");
-	return c != 0;
+	GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, "%0", "e");
 }
 
 /**
@@ -136,12 +127,7 @@ static inline int atomic_dec_and_test(at
  */
 static inline int atomic_inc_and_test(atomic_t *v)
 {
-	unsigned char c;
-
-	asm volatile(LOCK_PREFIX "incl %0; sete %1"
-		     : "+m" (v->counter), "=qm" (c)
-		     : : "memory");
-	return c != 0;
+	GEN_UNARY_RMWcc(LOCK_PREFIX "incl", v->counter, "%0", "e");
 }
 
 /**
@@ -155,12 +141,7 @@ static inline int atomic_inc_and_test(at
  */
 static inline int atomic_add_negative(int i, atomic_t *v)
 {
-	unsigned char c;
-
-	asm volatile(LOCK_PREFIX "addl %2,%0; sets %1"
-		     : "+m" (v->counter), "=qm" (c)
-		     : "ir" (i) : "memory");
-	return c;
+	GEN_BINARY_RMWcc(LOCK_PREFIX "addl", v->counter, i, "%0", "s");
 }
 
 /**
--- a/arch/x86/include/asm/atomic64_64.h
+++ b/arch/x86/include/asm/atomic64_64.h
@@ -72,12 +72,7 @@ static inline void atomic64_sub(long i,
  */
 static inline int atomic64_sub_and_test(long i, atomic64_t *v)
 {
-	unsigned char c;
-
-	asm volatile(LOCK_PREFIX "subq %2,%0; sete %1"
-		     : "=m" (v->counter), "=qm" (c)
-		     : "er" (i), "m" (v->counter) : "memory");
-	return c;
+	GEN_BINARY_RMWcc(LOCK_PREFIX "subq", v->counter, i, "%0", "e");
 }
 
 /**
@@ -116,12 +111,7 @@ static inline void atomic64_dec(atomic64
  */
 static inline int atomic64_dec_and_test(atomic64_t *v)
 {
-	unsigned char c;
-
-	asm volatile(LOCK_PREFIX "decq %0; sete %1"
-		     : "=m" (v->counter), "=qm" (c)
-		     : "m" (v->counter) : "memory");
-	return c != 0;
+	GEN_UNARY_RMWcc(LOCK_PREFIX "decq", v->counter, "%0", "e");
 }
 
 /**
@@ -134,12 +124,7 @@ static inline int atomic64_dec_and_test(
  */
 static inline int atomic64_inc_and_test(atomic64_t *v)
 {
-	unsigned char c;
-
-	asm volatile(LOCK_PREFIX "incq %0; sete %1"
-		     : "=m" (v->counter), "=qm" (c)
-		     : "m" (v->counter) : "memory");
-	return c != 0;
+	GEN_UNARY_RMWcc(LOCK_PREFIX "incq", v->counter, "%0", "e");
 }
 
 /**
@@ -153,12 +138,7 @@ static inline int atomic64_inc_and_test(
  */
 static inline int atomic64_add_negative(long i, atomic64_t *v)
 {
-	unsigned char c;
-
-	asm volatile(LOCK_PREFIX "addq %2,%0; sets %1"
-		     : "=m" (v->counter), "=qm" (c)
-		     : "er" (i), "m" (v->counter) : "memory");
-	return c;
+	GEN_BINARY_RMWcc(LOCK_PREFIX "addq", v->counter, i, "%0", "s");
 }
 
 /**
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -14,6 +14,7 @@
 
 #include <linux/compiler.h>
 #include <asm/alternative.h>
+#include <asm/rmwcc.h>
 
 #if BITS_PER_LONG == 32
 # define _BITOPS_LONG_SHIFT 5
@@ -204,12 +205,7 @@ static inline void change_bit(long nr, v
  */
 static inline int test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	int oldbit;
-
-	asm volatile(LOCK_PREFIX "bts %2,%1\n\t"
-		     "sbb %0,%0" : "=r" (oldbit), ADDR : "Ir" (nr) : "memory");
-
-	return oldbit;
+	GEN_BINARY_RMWcc(LOCK_PREFIX "bts", *addr, nr, "%0", "c");
 }
 
 /**
@@ -255,13 +251,7 @@ static inline int __test_and_set_bit(lon
  */
 static inline int test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	int oldbit;
-
-	asm volatile(LOCK_PREFIX "btr %2,%1\n\t"
-		     "sbb %0,%0"
-		     : "=r" (oldbit), ADDR : "Ir" (nr) : "memory");
-
-	return oldbit;
+	GEN_BINARY_RMWcc(LOCK_PREFIX "btr", *addr, nr, "%0", "c");
 }
 
 /**
@@ -314,13 +304,7 @@ static inline int __test_and_change_bit(
  */
 static inline int test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	int oldbit;
-
-	asm volatile(LOCK_PREFIX "btc %2,%1\n\t"
-		     "sbb %0,%0"
-		     : "=r" (oldbit), ADDR : "Ir" (nr) : "memory");
-
-	return oldbit;
+	GEN_BINARY_RMWcc(LOCK_PREFIX "btc", *addr, nr, "%0", "c");
 }
 
 static __always_inline int constant_test_bit(long nr, const volatile unsigned long *addr)
--- a/arch/x86/include/asm/local.h
+++ b/arch/x86/include/asm/local.h
@@ -52,12 +52,7 @@ static inline void local_sub(long i, loc
  */
 static inline int local_sub_and_test(long i, local_t *l)
 {
-	unsigned char c;
-
-	asm volatile(_ASM_SUB "%2,%0; sete %1"
-		     : "+m" (l->a.counter), "=qm" (c)
-		     : "ir" (i) : "memory");
-	return c;
+	GEN_BINARY_RMWcc(_ASM_SUB, l->a.counter, i, "%0", "e");
 }
 
 /**
@@ -70,12 +65,7 @@ static inline int local_sub_and_test(lon
  */
 static inline int local_dec_and_test(local_t *l)
 {
-	unsigned char c;
-
-	asm volatile(_ASM_DEC "%0; sete %1"
-		     : "+m" (l->a.counter), "=qm" (c)
-		     : : "memory");
-	return c != 0;
+	GEN_UNARY_RMWcc(_ASM_DEC, l->a.counter, "%0", "e");
 }
 
 /**
@@ -88,12 +78,7 @@ static inline int local_dec_and_test(loc
  */
 static inline int local_inc_and_test(local_t *l)
 {
-	unsigned char c;
-
-	asm volatile(_ASM_INC "%0; sete %1"
-		     : "+m" (l->a.counter), "=qm" (c)
-		     : : "memory");
-	return c != 0;
+	GEN_UNARY_RMWcc(_ASM_INC, l->a.counter, "%0", "e");
 }
 
 /**
@@ -107,12 +92,7 @@ static inline int local_inc_and_test(loc
  */
 static inline int local_add_negative(long i, local_t *l)
 {
-	unsigned char c;
-
-	asm volatile(_ASM_ADD "%2,%0; sets %1"
-		     : "+m" (l->a.counter), "=qm" (c)
-		     : "ir" (i) : "memory");
-	return c;
+	GEN_BINARY_RMWcc(_ASM_ADD, l->a.counter, i, "%0", "s");
 }
 
 /**
--- /dev/null
+++ b/arch/x86/include/asm/rmwcc.h
@@ -0,0 +1,41 @@
+#ifndef _ASM_X86_RMWcc
+#define _ASM_X86_RMWcc
+
+#ifdef CC_HAVE_ASM_GOTO
+
+#define __GEN_RMWcc(fullop, var, cc, ...)				\
+do {									\
+	asm volatile goto (fullop "; j" cc " %l[cc_label]"		\
+			: : "m" (var), ## __VA_ARGS__ 			\
+			: "memory" : cc_label);				\
+	return 0;							\
+cc_label:								\
+	return 1;							\
+} while (0)
+
+#define GEN_UNARY_RMWcc(op, var, arg0, cc) 				\
+	__GEN_RMWcc(op " " arg0, var, cc)
+
+#define GEN_BINARY_RMWcc(op, var, val, arg0, cc)			\
+	__GEN_RMWcc(op " %1, " arg0, var, cc, "er" (val))
+
+#else /* !CC_HAVE_ASM_GOTO */
+
+#define __GEN_RMWcc(fullop, var, cc, ...)				\
+do {									\
+	char c;								\
+	asm volatile (fullop "; set" cc " %1"				\
+			: "+m" (var), "=qm" (c)				\
+			: __VA_ARGS__ : "memory");			\
+	return c != 0;							\
+} while (0)
+
+#define GEN_UNARY_RMWcc(op, var, arg0, cc)				\
+	__GEN_RMWcc(op " " arg0, var, cc)
+
+#define GEN_BINARY_RMWcc(op, var, val, arg0, cc)			\
+	__GEN_RMWcc(op " %2, " arg0, var, cc, "er" (val))
+
+#endif /* CC_HAVE_ASM_GOTO */
+
+#endif /* _ASM_X86_RMWcc */
