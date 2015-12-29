From: Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 2/3] RCU: Privatize rcu_node::lock
Date: Tue, 29 Dec 2015 12:18:47 +0800
Message-ID: <1451362728-18961-3-git-send-email-boqun.feng@gmail.com>
References: <1451362728-18961-1-git-send-email-boqun.feng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451362728-18961-1-git-send-email-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>
List-Id: linux-sparse@vger.kernel.org

In patch:

"rcu: Add transitivity to remaining rcu_node ->lock acquisitions"

All locking operations on rcu_node::lock are replaced with the wrappers
because of the need of transitivity, which indicates we should never
write code using LOCK primitives alone(i.e. without a proper barrier
following) on rcu_node::lock outside those wrappers. We could detect
this kind of misuses on rcu_node::lock in the future by adding __private
modifier on rcu_node::lock.

To privatize rcu_node::lock, unlock wrappers are also needed. Replacing
spinlock unlocks with these wrappers not only privatizes rcu_node::lock
but also makes it easier to figure out critical sections of rcu_node.

This patch adds __private modifier to rcu_node::lock and makes every
access to it wrapped by ACCESS_PRIVATE(). Besides, unlock wrappers are
added and raw_spin_unlock(&rnp->lock) and its friends are replaced with
those wrappers.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/rcu/tree.c        | 103 ++++++++++++++++++++++++-----------------------
 kernel/rcu/tree.h        |  42 ++++++++++++++-----
 kernel/rcu/tree_plugin.h |  26 ++++++------
 3 files changed, 96 insertions(+), 75 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3a8856f..1cc569d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1246,7 +1246,7 @@ static void rcu_dump_cpu_stacks(struct rcu_state *rsp)
 				if (rnp->qsmask & (1UL << cpu))
 					dump_cpu_task(rnp->grplo + cpu);
 		}
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 }
 
@@ -1266,12 +1266,12 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	delta = jiffies - READ_ONCE(rsp->jiffies_stall);
 	if (delta < RCU_STALL_RAT_DELAY || !rcu_gp_in_progress(rsp)) {
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
 	WRITE_ONCE(rsp->jiffies_stall,
 		   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
-	raw_spin_unlock_irqrestore(&rnp->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	/*
 	 * OK, time to rat on our buddy...
@@ -1292,7 +1292,7 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gpnum)
 					ndetected++;
 				}
 		}
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 
 	print_cpu_stall_info_end();
@@ -1357,7 +1357,7 @@ static void print_cpu_stall(struct rcu_state *rsp)
 	if (ULONG_CMP_GE(jiffies, READ_ONCE(rsp->jiffies_stall)))
 		WRITE_ONCE(rsp->jiffies_stall,
 			   jiffies + 3 * rcu_jiffies_till_stall_check() + 3);
-	raw_spin_unlock_irqrestore(&rnp->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	/*
 	 * Attempt to revive the RCU machinery by forcing a context switch.
@@ -1595,7 +1595,7 @@ rcu_start_future_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	}
 unlock_out:
 	if (rnp != rnp_root)
-		raw_spin_unlock(&rnp_root->lock);
+		raw_spin_unlock_rcu_node(rnp_root);
 out:
 	if (c_out != NULL)
 		*c_out = c;
@@ -1815,7 +1815,7 @@ static void note_gp_changes(struct rcu_state *rsp, struct rcu_data *rdp)
 		return;
 	}
 	needwake = __note_gp_changes(rsp, rnp, rdp);
-	raw_spin_unlock_irqrestore(&rnp->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (needwake)
 		rcu_gp_kthread_wake(rsp);
 }
@@ -1840,7 +1840,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	raw_spin_lock_irq_rcu_node(rnp);
 	if (!READ_ONCE(rsp->gp_flags)) {
 		/* Spurious wakeup, tell caller to go back to sleep.  */
-		raw_spin_unlock_irq(&rnp->lock);
+		raw_spin_unlock_irq_rcu_node(rnp);
 		return false;
 	}
 	WRITE_ONCE(rsp->gp_flags, 0); /* Clear all flags: New grace period. */
@@ -1850,7 +1850,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		 * Grace period already in progress, don't start another.
 		 * Not supposed to be able to happen.
 		 */
-		raw_spin_unlock_irq(&rnp->lock);
+		raw_spin_unlock_irq_rcu_node(rnp);
 		return false;
 	}
 
@@ -1859,7 +1859,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	/* Record GP times before starting GP, hence smp_store_release(). */
 	smp_store_release(&rsp->gpnum, rsp->gpnum + 1);
 	trace_rcu_grace_period(rsp->name, rsp->gpnum, TPS("start"));
-	raw_spin_unlock_irq(&rnp->lock);
+	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
 	 * Apply per-leaf buffered online and offline operations to the
@@ -1873,7 +1873,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
 		    !rnp->wait_blkd_tasks) {
 			/* Nothing to do on this leaf rcu_node structure. */
-			raw_spin_unlock_irq(&rnp->lock);
+			raw_spin_unlock_irq_rcu_node(rnp);
 			continue;
 		}
 
@@ -1907,7 +1907,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 			rcu_cleanup_dead_rnp(rnp);
 		}
 
-		raw_spin_unlock_irq(&rnp->lock);
+		raw_spin_unlock_irq_rcu_node(rnp);
 	}
 
 	/*
@@ -1938,7 +1938,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		trace_rcu_grace_period_init(rsp->name, rnp->gpnum,
 					    rnp->level, rnp->grplo,
 					    rnp->grphi, rnp->qsmask);
-		raw_spin_unlock_irq(&rnp->lock);
+		raw_spin_unlock_irq_rcu_node(rnp);
 		cond_resched_rcu_qs();
 		WRITE_ONCE(rsp->gp_activity, jiffies);
 	}
@@ -1996,7 +1996,7 @@ static void rcu_gp_fqs(struct rcu_state *rsp, bool first_time)
 		raw_spin_lock_irq_rcu_node(rnp);
 		WRITE_ONCE(rsp->gp_flags,
 			   READ_ONCE(rsp->gp_flags) & ~RCU_GP_FLAG_FQS);
-		raw_spin_unlock_irq(&rnp->lock);
+		raw_spin_unlock_irq_rcu_node(rnp);
 	}
 }
 
@@ -2025,7 +2025,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	 * safe for us to drop the lock in order to mark the grace
 	 * period as completed in all of the rcu_node structures.
 	 */
-	raw_spin_unlock_irq(&rnp->lock);
+	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
 	 * Propagate new ->completed value to rcu_node structures so
@@ -2046,7 +2046,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 			needgp = __note_gp_changes(rsp, rnp, rdp) || needgp;
 		/* smp_mb() provided by prior unlock-lock pair. */
 		nocb += rcu_future_gp_cleanup(rsp, rnp);
-		raw_spin_unlock_irq(&rnp->lock);
+		raw_spin_unlock_irq_rcu_node(rnp);
 		cond_resched_rcu_qs();
 		WRITE_ONCE(rsp->gp_activity, jiffies);
 		rcu_gp_slow(rsp, gp_cleanup_delay);
@@ -2068,7 +2068,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 				       READ_ONCE(rsp->gpnum),
 				       TPS("newreq"));
 	}
-	raw_spin_unlock_irq(&rnp->lock);
+	raw_spin_unlock_irq_rcu_node(rnp);
 }
 
 /*
@@ -2247,7 +2247,7 @@ static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
 {
 	WARN_ON_ONCE(!rcu_gp_in_progress(rsp));
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
-	raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
 	rcu_gp_kthread_wake(rsp);
 }
 
@@ -2277,7 +2277,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
 			 * Our bit has already been cleared, or the
 			 * relevant grace period is already over, so done.
 			 */
-			raw_spin_unlock_irqrestore(&rnp->lock, flags);
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			return;
 		}
 		WARN_ON_ONCE(oldmask); /* Any child must be all zeroed! */
@@ -2289,7 +2289,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
 		if (rnp->qsmask != 0 || rcu_preempt_blocked_readers_cgp(rnp)) {
 
 			/* Other bits still set at this level, so done. */
-			raw_spin_unlock_irqrestore(&rnp->lock, flags);
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			return;
 		}
 		mask = rnp->grpmask;
@@ -2299,7 +2299,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
 
 			break;
 		}
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		rnp_c = rnp;
 		rnp = rnp->parent;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -2331,7 +2331,7 @@ static void rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
 
 	if (rcu_state_p == &rcu_sched_state || rsp != rcu_state_p ||
 	    rnp->qsmask != 0 || rcu_preempt_blocked_readers_cgp(rnp)) {
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;  /* Still need more quiescent states! */
 	}
 
@@ -2348,7 +2348,7 @@ static void rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
 	/* Report up the rest of the hierarchy, tracking current ->gpnum. */
 	gps = rnp->gpnum;
 	mask = rnp->grpmask;
-	raw_spin_unlock(&rnp->lock);	/* irqs remain disabled. */
+	raw_spin_unlock_rcu_node(rnp);	/* irqs remain disabled. */
 	raw_spin_lock_rcu_node(rnp_p);	/* irqs already disabled. */
 	rcu_report_qs_rnp(mask, rsp, rnp_p, gps, flags);
 }
@@ -2385,12 +2385,12 @@ rcu_report_qs_rdp(int cpu, struct rcu_state *rsp, struct rcu_data *rdp)
 		 */
 		rdp->cpu_no_qs.b.norm = true;	/* need qs for new gp. */
 		rdp->rcu_qs_ctr_snap = __this_cpu_read(rcu_qs_ctr);
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
 	mask = rdp->grpmask;
 	if ((rnp->qsmask & mask) == 0) {
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
 		rdp->core_needs_qs = false;
 
@@ -2601,10 +2601,11 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
 		rnp->qsmaskinit &= ~mask;
 		rnp->qsmask &= ~mask;
 		if (rnp->qsmaskinit) {
-			raw_spin_unlock(&rnp->lock); /* irqs remain disabled. */
+			raw_spin_unlock_rcu_node(rnp);
+			/* irqs remain disabled. */
 			return;
 		}
-		raw_spin_unlock(&rnp->lock); /* irqs remain disabled. */
+		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 	}
 }
 
@@ -2627,7 +2628,7 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
 	mask = rdp->grpmask;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rnp->qsmaskinitnext &= ~mask;
-	raw_spin_unlock_irqrestore(&rnp->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
 /*
@@ -2865,7 +2866,7 @@ static void force_qs_rnp(struct rcu_state *rsp,
 			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gpnum, flags);
 		} else {
 			/* Nothing to do here, so just drop the lock. */
-			raw_spin_unlock_irqrestore(&rnp->lock, flags);
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
 	}
 }
@@ -2901,11 +2902,11 @@ static void force_quiescent_state(struct rcu_state *rsp)
 	raw_spin_unlock(&rnp_old->fqslock);
 	if (READ_ONCE(rsp->gp_flags) & RCU_GP_FLAG_FQS) {
 		rsp->n_force_qs_lh++;
-		raw_spin_unlock_irqrestore(&rnp_old->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
 		return;  /* Someone beat us to it. */
 	}
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
-	raw_spin_unlock_irqrestore(&rnp_old->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
 	rcu_gp_kthread_wake(rsp);
 }
 
@@ -2931,7 +2932,7 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 	if (cpu_needs_another_gp(rsp, rdp)) {
 		raw_spin_lock_rcu_node(rcu_get_root(rsp)); /* irqs disabled. */
 		needwake = rcu_start_gp(rsp);
-		raw_spin_unlock_irqrestore(&rcu_get_root(rsp)->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
 		if (needwake)
 			rcu_gp_kthread_wake(rsp);
 	} else {
@@ -3022,7 +3023,7 @@ static void __call_rcu_core(struct rcu_state *rsp, struct rcu_data *rdp,
 
 			raw_spin_lock_rcu_node(rnp_root);
 			needwake = rcu_start_gp(rsp);
-			raw_spin_unlock(&rnp_root->lock);
+			raw_spin_unlock_rcu_node(rnp_root);
 			if (needwake)
 				rcu_gp_kthread_wake(rsp);
 		} else {
@@ -3442,14 +3443,14 @@ static void sync_exp_reset_tree_hotplug(struct rcu_state *rsp)
 	rcu_for_each_leaf_node(rsp, rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmaskinit == rnp->expmaskinitnext) {
-			raw_spin_unlock_irqrestore(&rnp->lock, flags);
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			continue;  /* No new CPUs, nothing to do. */
 		}
 
 		/* Update this node's mask, track old value for propagation. */
 		oldmask = rnp->expmaskinit;
 		rnp->expmaskinit = rnp->expmaskinitnext;
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 		/* If was already nonzero, nothing to propagate. */
 		if (oldmask)
@@ -3464,7 +3465,7 @@ static void sync_exp_reset_tree_hotplug(struct rcu_state *rsp)
 			if (rnp_up->expmaskinit)
 				done = true;
 			rnp_up->expmaskinit |= mask;
-			raw_spin_unlock_irqrestore(&rnp_up->lock, flags);
+			raw_spin_unlock_irqrestore_rcu_node(rnp_up, flags);
 			if (done)
 				break;
 			mask = rnp_up->grpmask;
@@ -3487,7 +3488,7 @@ static void __maybe_unused sync_exp_reset_tree(struct rcu_state *rsp)
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		WARN_ON_ONCE(rnp->expmask);
 		rnp->expmask = rnp->expmaskinit;
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 }
 
@@ -3528,11 +3529,11 @@ static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 			if (!rnp->expmask)
 				rcu_initiate_boost(rnp, flags);
 			else
-				raw_spin_unlock_irqrestore(&rnp->lock, flags);
+				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			break;
 		}
 		if (rnp->parent == NULL) {
-			raw_spin_unlock_irqrestore(&rnp->lock, flags);
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			if (wake) {
 				smp_mb(); /* EGP done before wake_up(). */
 				wake_up(&rsp->expedited_wq);
@@ -3540,7 +3541,7 @@ static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 			break;
 		}
 		mask = rnp->grpmask;
-		raw_spin_unlock(&rnp->lock); /* irqs remain disabled */
+		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled */
 		rnp = rnp->parent;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled */
 		WARN_ON_ONCE(!(rnp->expmask & mask));
@@ -3575,7 +3576,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_state *rsp, struct rcu_node *rnp,
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	if (!(rnp->expmask & mask)) {
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
 	rnp->expmask &= ~mask;
@@ -3736,7 +3737,7 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 		 */
 		if (rcu_preempt_has_tasks(rnp))
 			rnp->exp_tasks = rnp->blkd_tasks.next;
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 		/* IPI the remaining CPUs for expedited quiescent state. */
 		mask = 1;
@@ -3753,7 +3754,7 @@ retry_ipi:
 			raw_spin_lock_irqsave_rcu_node(rnp, flags);
 			if (cpu_online(cpu) &&
 			    (rnp->expmask & mask)) {
-				raw_spin_unlock_irqrestore(&rnp->lock, flags);
+				raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 				schedule_timeout_uninterruptible(1);
 				if (cpu_online(cpu) &&
 				    (rnp->expmask & mask))
@@ -3762,7 +3763,7 @@ retry_ipi:
 			}
 			if (!(rnp->expmask & mask))
 				mask_ofl_ipi &= ~mask;
-			raw_spin_unlock_irqrestore(&rnp->lock, flags);
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
 		/* Report quiescent states for those that went offline. */
 		mask_ofl_test |= mask_ofl_ipi;
@@ -4169,7 +4170,7 @@ static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
 			return;
 		raw_spin_lock_rcu_node(rnp); /* Interrupts already disabled. */
 		rnp->qsmaskinit |= mask;
-		raw_spin_unlock(&rnp->lock); /* Interrupts remain disabled. */
+		raw_spin_unlock_rcu_node(rnp); /* Interrupts remain disabled. */
 	}
 }
 
@@ -4193,7 +4194,7 @@ rcu_boot_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rdp->rsp = rsp;
 	mutex_init(&rdp->exp_funnel_mutex);
 	rcu_boot_init_nocb_percpu_data(rdp);
-	raw_spin_unlock_irqrestore(&rnp->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
 /*
@@ -4221,7 +4222,7 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rcu_sysidle_init_percpu_data(rdp->dynticks);
 	atomic_set(&rdp->dynticks->dynticks,
 		   (atomic_read(&rdp->dynticks->dynticks) & ~0x1) + 1);
-	raw_spin_unlock(&rnp->lock);		/* irqs remain disabled. */
+	raw_spin_unlock_rcu_node(rnp);		/* irqs remain disabled. */
 
 	/*
 	 * Add CPU to leaf rcu_node pending-online bitmask.  Any needed
@@ -4242,7 +4243,7 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rdp->rcu_qs_ctr_snap = per_cpu(rcu_qs_ctr, cpu);
 	rdp->core_needs_qs = false;
 	trace_rcu_grace_period(rsp->name, rdp->gpnum, TPS("cpuonl"));
-	raw_spin_unlock_irqrestore(&rnp->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
 static void rcu_prepare_cpu(int cpu)
@@ -4364,7 +4365,7 @@ static int __init rcu_spawn_gp_kthread(void)
 			sp.sched_priority = kthread_prio;
 			sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 		}
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		wake_up_process(t);
 	}
 	rcu_spawn_nocb_kthreads();
@@ -4455,8 +4456,8 @@ static void __init rcu_init_one(struct rcu_state *rsp)
 		cpustride *= levelspread[i];
 		rnp = rsp->level[i];
 		for (j = 0; j < levelcnt[i]; j++, rnp++) {
-			raw_spin_lock_init(&rnp->lock);
-			lockdep_set_class_and_name(&rnp->lock,
+			raw_spin_lock_init(&ACCESS_PRIVATE(rnp, lock));
+			lockdep_set_class_and_name(&ACCESS_PRIVATE(rnp, lock),
 						   &rcu_node_class[i], buf[i]);
 			raw_spin_lock_init(&rnp->fqslock);
 			lockdep_set_class_and_name(&rnp->fqslock,
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 83360b4..4886d6a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -149,8 +149,9 @@ struct rcu_dynticks {
  * Definition for node within the RCU grace-period-detection hierarchy.
  */
 struct rcu_node {
-	raw_spinlock_t lock;	/* Root rcu_node's lock protects some */
-				/*  rcu_state fields as well as following. */
+	raw_spinlock_t __private lock;	/* Root rcu_node's lock protects */
+					/*  some rcu_state fields as well as */
+					/*  following. */
 	unsigned long gpnum;	/* Current grace period for this node. */
 				/*  This will either be equal to or one */
 				/*  behind the root rcu_node's gpnum. */
@@ -680,7 +681,7 @@ static inline void rcu_nocb_q_lengths(struct rcu_data *rdp, long *ql, long *qll)
 #endif /* #else #ifdef CONFIG_PPC */
 
 /*
- * Wrappers for the rcu_node::lock acquire.
+ * Wrappers for the rcu_node::lock acquire and release.
  *
  * Because the rcu_nodes form a tree, the tree traversal locking will observe
  * different lock values, this in turn means that an UNLOCK of one level
@@ -689,29 +690,48 @@ static inline void rcu_nocb_q_lengths(struct rcu_data *rdp, long *ql, long *qll)
  *
  * In order to restore full ordering between tree levels, augment the regular
  * lock acquire functions with smp_mb__after_unlock_lock().
+ *
+ * As ->lock of struct rcu_node is a __private field, therefore one should use
+ * these wrappers rather than directly call raw_spin_{lock,unlock}* on ->lock.
  */
 static inline void raw_spin_lock_rcu_node(struct rcu_node *rnp)
 {
-	raw_spin_lock(&rnp->lock);
+	raw_spin_lock(&ACCESS_PRIVATE(rnp, lock));
 	smp_mb__after_unlock_lock();
 }
 
+static inline void raw_spin_unlock_rcu_node(struct rcu_node *rnp)
+{
+	raw_spin_unlock(&ACCESS_PRIVATE(rnp, lock));
+}
+
 static inline void raw_spin_lock_irq_rcu_node(struct rcu_node *rnp)
 {
-	raw_spin_lock_irq(&rnp->lock);
+	raw_spin_lock_irq(&ACCESS_PRIVATE(rnp, lock));
 	smp_mb__after_unlock_lock();
 }
 
-#define raw_spin_lock_irqsave_rcu_node(rnp, flags)	\
-do {							\
-	typecheck(unsigned long, flags);		\
-	raw_spin_lock_irqsave(&(rnp)->lock, flags);	\
-	smp_mb__after_unlock_lock();			\
+static inline void raw_spin_unlock_irq_rcu_node(struct rcu_node *rnp)
+{
+	raw_spin_unlock_irq(&ACCESS_PRIVATE(rnp, lock));
+}
+
+#define raw_spin_lock_irqsave_rcu_node(rnp, flags)			\
+do {									\
+	typecheck(unsigned long, flags);				\
+	raw_spin_lock_irqsave(&ACCESS_PRIVATE(rnp, lock), flags);	\
+	smp_mb__after_unlock_lock();					\
+} while (0)
+
+#define raw_spin_unlock_irqrestore_rcu_node(rnp, flags)			\
+do {									\
+	typecheck(unsigned long, flags);				\
+	raw_spin_unlock_irqrestore(&ACCESS_PRIVATE(rnp, lock), flags);	\
 } while (0)
 
 static inline bool raw_spin_trylock_rcu_node(struct rcu_node *rnp)
 {
-	bool locked = raw_spin_trylock(&rnp->lock);
+	bool locked = raw_spin_trylock(&ACCESS_PRIVATE(rnp, lock));
 
 	if (locked)
 		smp_mb__after_unlock_lock();
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 9467a8b..0d51a67 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -235,7 +235,7 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 		rnp->gp_tasks = &t->rcu_node_entry;
 	if (!rnp->exp_tasks && (blkd_state & RCU_EXP_BLKD))
 		rnp->exp_tasks = &t->rcu_node_entry;
-	raw_spin_unlock(&rnp->lock); /* rrupts remain disabled. */
+	raw_spin_unlock_rcu_node(rnp); /* interrupts remain disabled. */
 
 	/*
 	 * Report the quiescent state for the expedited GP.  This expedited
@@ -489,7 +489,7 @@ void rcu_read_unlock_special(struct task_struct *t)
 							 !!rnp->gp_tasks);
 			rcu_report_unblock_qs_rnp(rcu_state_p, rnp, flags);
 		} else {
-			raw_spin_unlock_irqrestore(&rnp->lock, flags);
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
 
 		/* Unboost if we were boosted. */
@@ -518,14 +518,14 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	if (!rcu_preempt_blocked_readers_cgp(rnp)) {
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
 	t = list_entry(rnp->gp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry)
 		sched_show_task(t);
-	raw_spin_unlock_irqrestore(&rnp->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
 /*
@@ -991,7 +991,7 @@ static int rcu_boost(struct rcu_node *rnp)
 	 * might exit their RCU read-side critical sections on their own.
 	 */
 	if (rnp->exp_tasks == NULL && rnp->boost_tasks == NULL) {
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return 0;
 	}
 
@@ -1028,7 +1028,7 @@ static int rcu_boost(struct rcu_node *rnp)
 	 */
 	t = container_of(tb, struct task_struct, rcu_node_entry);
 	rt_mutex_init_proxy_locked(&rnp->boost_mtx, t);
-	raw_spin_unlock_irqrestore(&rnp->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	/* Lock only for side effect: boosts task t's priority. */
 	rt_mutex_lock(&rnp->boost_mtx);
 	rt_mutex_unlock(&rnp->boost_mtx);  /* Then keep lockdep happy. */
@@ -1088,7 +1088,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 
 	if (!rcu_preempt_blocked_readers_cgp(rnp) && rnp->exp_tasks == NULL) {
 		rnp->n_balk_exp_gp_tasks++;
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
 	if (rnp->exp_tasks != NULL ||
@@ -1098,13 +1098,13 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	     ULONG_CMP_GE(jiffies, rnp->boost_time))) {
 		if (rnp->exp_tasks == NULL)
 			rnp->boost_tasks = rnp->gp_tasks;
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		t = rnp->boost_kthread_task;
 		if (t)
 			rcu_wake_cond(t, rnp->boost_kthread_status);
 	} else {
 		rcu_initiate_boost_trace(rnp);
-		raw_spin_unlock_irqrestore(&rnp->lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 }
 
@@ -1172,7 +1172,7 @@ static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
 		return PTR_ERR(t);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rnp->boost_kthread_task = t;
-	raw_spin_unlock_irqrestore(&rnp->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	sp.sched_priority = kthread_prio;
 	sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	wake_up_process(t); /* get to TASK_INTERRUPTIBLE quickly. */
@@ -1308,7 +1308,7 @@ static void rcu_prepare_kthreads(int cpu)
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	__releases(rnp->lock)
 {
-	raw_spin_unlock_irqrestore(&rnp->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
 static void invoke_rcu_callbacks_kthread(void)
@@ -1559,7 +1559,7 @@ static void rcu_prepare_for_idle(void)
 		rnp = rdp->mynode;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
 		needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
-		raw_spin_unlock(&rnp->lock); /* irqs remain disabled. */
+		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 		if (needwake)
 			rcu_gp_kthread_wake(rsp);
 	}
@@ -2059,7 +2059,7 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	needwake = rcu_start_future_gp(rnp, rdp, &c);
-	raw_spin_unlock_irqrestore(&rnp->lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (needwake)
 		rcu_gp_kthread_wake(rdp->rsp);
 
-- 
2.6.4
