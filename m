From: Dave Jones <davej@redhat.com>
Subject: annotating semaphores.
Date: Wed, 12 Dec 2007 15:00:53 -0500
Message-ID: <20071212200053.GA19747@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:39616 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550AbXLLUAz (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 12 Dec 2007 15:00:55 -0500
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.1) with ESMTP id lBCK0s6p027080
	for <linux-sparse@vger.kernel.org>; Wed, 12 Dec 2007 15:00:54 -0500
Received: from gelk.kernelslacker.org (vpn-14-2.rdu.redhat.com [10.11.14.2])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id lBCK0sp4028717
	for <linux-sparse@vger.kernel.org>; Wed, 12 Dec 2007 15:00:54 -0500
Received: from gelk.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by gelk.kernelslacker.org (8.14.2/8.13.8) with ESMTP id lBCK0rJd022808
	for <linux-sparse@vger.kernel.org>; Wed, 12 Dec 2007 15:00:53 -0500
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.14.2/8.14.2/Submit) id lBCK0rfl022807
	for linux-sparse@vger.kernel.org; Wed, 12 Dec 2007 15:00:53 -0500
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Today I came across a bug in the kernel cpufreq code where
we were missing a bunch of up_write() calls in error paths
of a function.

I've been trying to get sparse's context checking to pick up
on the errors and failing.  The kernel patch below is what I have
so far, but it seems to report no output whatsoever.
What am I missing ?

	Dave

diff --git a/include/asm-x86/rwsem.h b/include/asm-x86/rwsem.h
index 041906f..3111853 100644
--- a/include/asm-x86/rwsem.h
+++ b/include/asm-x86/rwsem.h
@@ -106,6 +106,7 @@ LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value
 		: "+m" (sem->count)
 		: "a" (sem)
 		: "memory", "cc");
+	__acquire(sem);
 }
 
 /*
@@ -128,6 +129,7 @@ LOCK_PREFIX	"  cmpxchgl  %2,%0\n\t"
 		: "+m" (sem->count), "=&a" (result), "=&r" (tmp)
 		: "i" (RWSEM_ACTIVE_READ_BIAS)
 		: "memory", "cc");
+	__acquire(sem);
 	return result>=0 ? 1 : 0;
 }
 
@@ -167,6 +169,7 @@ static inline int __down_write_trylock(struct rw_semaphore *sem)
 				  RWSEM_ACTIVE_WRITE_BIAS);
 	if (ret == RWSEM_UNLOCKED_VALUE)
 		return 1;
+	__acquire(sem);
 	return 0;
 }
 
@@ -186,6 +189,7 @@ LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old valu
 		: "+m" (sem->count), "=d" (tmp)
 		: "a" (sem), "1" (tmp)
 		: "memory", "cc");
+	__release(sem);
 }
 
 /*
@@ -204,6 +208,7 @@ LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 ->
 		: "+m" (sem->count)
 		: "a" (sem), "i" (-RWSEM_ACTIVE_WRITE_BIAS)
 		: "memory", "cc", "edx");
+	__release(sem);
 }
 
 /*
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index c4e0016..cf110b0 100644
diff --git a/include/linux/rwsem-spinlock.h b/include/linux/rwsem-spinlock.h
index 813cee1..90a4b2b 100644
--- a/include/linux/rwsem-spinlock.h
+++ b/include/linux/rwsem-spinlock.h
@@ -60,13 +60,13 @@ do {								\
 	__init_rwsem((sem), #sem, &__key);			\
 } while (0)
 
-extern void FASTCALL(__down_read(struct rw_semaphore *sem));
-extern int FASTCALL(__down_read_trylock(struct rw_semaphore *sem));
-extern void FASTCALL(__down_write(struct rw_semaphore *sem));
+extern void FASTCALL(__down_read(struct rw_semaphore *sem)) __acquires(sem);
+extern int FASTCALL(__down_read_trylock(struct rw_semaphore *sem)) __acquires(sem);
+extern void FASTCALL(__down_write(struct rw_semaphore *sem)) __acquires(sem);
 extern void FASTCALL(__down_write_nested(struct rw_semaphore *sem, int subclass));
-extern int FASTCALL(__down_write_trylock(struct rw_semaphore *sem));
-extern void FASTCALL(__up_read(struct rw_semaphore *sem));
-extern void FASTCALL(__up_write(struct rw_semaphore *sem));
+extern int FASTCALL(__down_write_trylock(struct rw_semaphore *sem) __acquires(sem));
+extern void FASTCALL(__up_read(struct rw_semaphore *sem)) __releases(sem);
+extern void FASTCALL(__up_write(struct rw_semaphore *sem)) __releases(sem);
 extern void FASTCALL(__downgrade_write(struct rw_semaphore *sem));
 
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
diff --git a/lib/rwsem-spinlock.c b/lib/rwsem-spinlock.c
index c4cfd6c..c13d112 100644
--- a/lib/rwsem-spinlock.c
+++ b/lib/rwsem-spinlock.c
@@ -162,6 +162,7 @@ void fastcall __sched __down_read(struct rw_semaphore *sem)
 
 	tsk->state = TASK_RUNNING;
  out:
+	__acquire(sem);
 	;
 }
 
@@ -184,6 +185,7 @@ int fastcall __down_read_trylock(struct rw_semaphore *sem)
 
 	spin_unlock_irqrestore(&sem->wait_lock, flags);
 
+	__acquire(sem);
 	return ret;
 }
 
@@ -228,6 +230,7 @@ void fastcall __sched __down_write_nested(struct rw_semaphore *sem, int subclass
 
 	tsk->state = TASK_RUNNING;
  out:
+	__acquire(sem);
 	;
 }
 
@@ -253,6 +256,7 @@ int fastcall __down_write_trylock(struct rw_semaphore *sem)
 	}
 
 	spin_unlock_irqrestore(&sem->wait_lock, flags);
+	__acquire(sem);
 
 	return ret;
 }
@@ -270,6 +274,7 @@ void fastcall __up_read(struct rw_semaphore *sem)
 		sem = __rwsem_wake_one_writer(sem);
 
 	spin_unlock_irqrestore(&sem->wait_lock, flags);
+	__release(sem);
 }
 
 /*
@@ -286,6 +291,7 @@ void fastcall __up_write(struct rw_semaphore *sem)
 		sem = __rwsem_do_wake(sem, 1);
 
 	spin_unlock_irqrestore(&sem->wait_lock, flags);
+	__release(sem);
 }
 
 /*
-- 
http://www.codemonkey.org.uk
