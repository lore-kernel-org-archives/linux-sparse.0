From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Date: Wed, 2 Jan 2019 15:57:58 -0500
Message-ID: <20190102205715.14054-4-mst@redhat.com>
References: <20190102205715.14054-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190102205715.14054-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jonathan Corbet <corbet@lwn.net>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Arnd
List-Id: linux-sparse@vger.kernel.org

It's not uncommon to have two access two unrelated memory locations in a
specific order.  At the moment one has to use a memory barrier for this.

However, if the first access was a read and the second used an address
depending on the first one we would have a data dependency and no
barrier would be necessary.

This adds a new interface: dependent_ptr_mb which does exactly this: it
returns a pointer with a data dependency on the supplied value.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 Documentation/memory-barriers.txt | 20 ++++++++++++++++++++
 arch/alpha/include/asm/barrier.h  |  1 +
 include/asm-generic/barrier.h     | 18 ++++++++++++++++++
 include/linux/compiler.h          |  4 ++++
 4 files changed, 43 insertions(+)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index c1d913944ad8..9dbaa2e1dbf6 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -691,6 +691,18 @@ case what's actually required is:
 		p = READ_ONCE(b);
 	}
 
+Alternatively, a control dependency can be converted to a data dependency,
+e.g.:
+
+	q = READ_ONCE(a);
+	if (q) {
+		b = dependent_ptr_mb(b, q);
+		p = READ_ONCE(b);
+	}
+
+Note how the result of dependent_ptr_mb must be used with the following
+accesses in order to have an effect.
+
 However, stores are not speculated.  This means that ordering -is- provided
 for load-store control dependencies, as in the following example:
 
@@ -836,6 +848,12 @@ out-guess your code.  More generally, although READ_ONCE() does force
 the compiler to actually emit code for a given load, it does not force
 the compiler to use the results.
 
+Converting to a data dependency helps with this too:
+
+	q = READ_ONCE(a);
+	b = dependent_ptr_mb(b, q);
+	WRITE_ONCE(b, 1);
+
 In addition, control dependencies apply only to the then-clause and
 else-clause of the if-statement in question.  In particular, it does
 not necessarily apply to code following the if-statement:
@@ -875,6 +893,8 @@ to the CPU containing it.  See the section on "Multicopy atomicity"
 for more information.
 
 
+
+
 In summary:
 
   (*) Control dependencies can order prior loads against later stores.
diff --git a/arch/alpha/include/asm/barrier.h b/arch/alpha/include/asm/barrier.h
index 92ec486a4f9e..b4934e8c551b 100644
--- a/arch/alpha/include/asm/barrier.h
+++ b/arch/alpha/include/asm/barrier.h
@@ -59,6 +59,7 @@
  * as Alpha, "y" could be set to 3 and "x" to 0.  Use rmb()
  * in cases like this where there are no data dependencies.
  */
+#define ARCH_NEEDS_READ_BARRIER_DEPENDS 1
 #define read_barrier_depends() __asm__ __volatile__("mb": : :"memory")
 
 #ifdef CONFIG_SMP
diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 2cafdbb9ae4c..fa2e2ef72b68 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -70,6 +70,24 @@
 #define __smp_read_barrier_depends()	read_barrier_depends()
 #endif
 
+#if defined(COMPILER_HAS_OPTIMIZER_HIDE_VAR) && \
+	!defined(ARCH_NEEDS_READ_BARRIER_DEPENDS)
+
+#define dependent_ptr_mb(ptr, val) ({					\
+	long dependent_ptr_mb_val = (long)(val);			\
+	long dependent_ptr_mb_ptr = (long)(ptr) - dependent_ptr_mb_val;	\
+									\
+	BUILD_BUG_ON(sizeof(val) > sizeof(long));			\
+	OPTIMIZER_HIDE_VAR(dependent_ptr_mb_val);			\
+	(typeof(ptr))(dependent_ptr_mb_ptr + dependent_ptr_mb_val);	\
+})
+
+#else
+
+#define dependent_ptr_mb(ptr, val) ({ mb(); (ptr); })
+
+#endif
+
 #ifdef CONFIG_SMP
 
 #ifndef smp_mb
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 6601d39e8c48..f599c30f1b28 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -152,9 +152,13 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #endif
 
 #ifndef OPTIMIZER_HIDE_VAR
+
 /* Make the optimizer believe the variable can be manipulated arbitrarily. */
 #define OPTIMIZER_HIDE_VAR(var)						\
 	__asm__ ("" : "=rm" (var) : "0" (var))
+
+#define COMPILER_HAS_OPTIMIZER_HIDE_VAR 1
+
 #endif
 
 /* Not-quite-unique ID. */
-- 
MST
