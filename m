From: Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 3/3] irq: Privatize irq_common_data::state_use_accessors
Date: Tue, 29 Dec 2015 12:18:48 +0800
Message-ID: <1451362728-18961-4-git-send-email-boqun.feng@gmail.com>
References: <1451362728-18961-1-git-send-email-boqun.feng@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:34316 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbbL2ETy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 28 Dec 2015 23:19:54 -0500
In-Reply-To: <1451362728-18961-1-git-send-email-boqun.feng@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>

irq_common_data::state_use_accessors is not designed for public use.
Therefore make it private so that people who write code accessing it
directly will get blamed by sparse. Also #undef the macro
__irqd_to_state after used in header files, so that the macro can't be
misused.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/irq.h    | 6 ++++--
 kernel/irq/internals.h | 4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3c1c967..cd14cd4 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -137,7 +137,7 @@ struct irq_domain;
  * @msi_desc:		MSI descriptor
  */
 struct irq_common_data {
-	unsigned int		state_use_accessors;
+	unsigned int		__private state_use_accessors;
 #ifdef CONFIG_NUMA
 	unsigned int		node;
 #endif
@@ -208,7 +208,7 @@ enum {
 	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
 };
 
-#define __irqd_to_state(d)		((d)->common->state_use_accessors)
+#define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
 
 static inline bool irqd_is_setaffinity_pending(struct irq_data *d)
 {
@@ -299,6 +299,8 @@ static inline void irqd_clr_forwarded_to_vcpu(struct irq_data *d)
 	__irqd_to_state(d) &= ~IRQD_FORWARDED_TO_VCPU;
 }
 
+#undef __irqd_to_state
+
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
 {
 	return d->hwirq;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index fcab63c..3d18293 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -160,6 +160,8 @@ irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags)
 	__irq_put_desc_unlock(desc, flags, false);
 }
 
+#define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
+
 /*
  * Manipulation functions for irq_data.state
  */
@@ -188,6 +190,8 @@ static inline bool irqd_has_set(struct irq_data *d, unsigned int mask)
 	return __irqd_to_state(d) & mask;
 }
 
+#undef __irqd_to_state
+
 static inline void kstat_incr_irqs_this_cpu(struct irq_desc *desc)
 {
 	__this_cpu_inc(*desc->kstat_irqs);
-- 
2.6.4

