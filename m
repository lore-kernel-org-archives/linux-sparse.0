From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC 3/3] irq: Privatize irq_common_data::state_use_accessors
Date: Mon, 14 Dec 2015 20:00:35 +0800
Message-ID: <20151214120021.GJ1072@fixme-laptop.cn.ibm.com>
References: <1449888962-29348-1-git-send-email-boqun.feng@gmail.com>
 <1449888962-29348-4-git-send-email-boqun.feng@gmail.com>
 <20151214095021.GM6357@twins.programming.kicks-ass.net>
 <alpine.DEB.2.11.1512141102470.4336@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f194.google.com ([209.85.214.194]:36508 "EHLO
	mail-ob0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbbLNMBO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 14 Dec 2015 07:01:14 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1512141102470.4336@nanos>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>

On Mon, Dec 14, 2015 at 11:03:03AM +0100, Thomas Gleixner wrote:
> On Mon, 14 Dec 2015, Peter Zijlstra wrote:
> > On Sat, Dec 12, 2015 at 10:56:02AM +0800, Boqun Feng wrote:
> > > According to Peter Zijlstra, irq_common_data::state_use_accessors is not
> > > designed for public use. Therefore make it private so that people who
> > > write code accessing it directly will get blamed by sparse.
> > > 
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  include/linux/irq.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/include/linux/irq.h b/include/linux/irq.h
> > > index 3c1c967..0b8f273 100644
> > > --- a/include/linux/irq.h
> > > +++ b/include/linux/irq.h
> > > @@ -137,7 +137,7 @@ struct irq_domain;
> > >   * @msi_desc:		MSI descriptor
> > >   */
> > >  struct irq_common_data {
> > > -	unsigned int		state_use_accessors;
> > > +	unsigned int		__private state_use_accessors;
> > >  #ifdef CONFIG_NUMA
> > >  	unsigned int		node;
> > >  #endif
> > > @@ -208,7 +208,7 @@ enum {
> > >  	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
> > >  };
> > >  
> > > -#define __irqd_to_state(d)		((d)->common->state_use_accessors)
> > > +#define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
> > >  
> > >  static inline bool irqd_is_setaffinity_pending(struct irq_data *d)
> > >  {
> > 
> > We should probably #undef that one once we're done with it.. Thomas?
> 
> Probably.
>  

Probably something like this(untested, only run "make kernel/irq/")?

Subject: [RFC v2 3/3] irq: Privatize irq_common_data::state_use_accessors

According to Peter Zijlstra, irq_common_data::state_use_accessors is not
designed for public use. Therefore make it private so that people who
write code accessing it directly will get blamed by sparse.

Also macro __irqd_to_state() is for _designed_ accesses to irq_data's
state only, it's better to limit its scope, therefore put all its
callers together and #undef it after use.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
v1-->v2:
	* move all callers of __irqd_to_state() together so that we can
	  #undef it after use.

 include/linux/irq.h    | 35 +++++++++++++++++++++++++++++++++--
 kernel/irq/internals.h | 28 ----------------------------
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3c1c967..9b20df6 100644
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
@@ -208,7 +208,11 @@ enum {
 	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
 };
 
-#define __irqd_to_state(d)		((d)->common->state_use_accessors)
+#define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
+
+/*
+ * Manipulation functions for irq_data's state
+ */
 
 static inline bool irqd_is_setaffinity_pending(struct irq_data *d)
 {
@@ -299,6 +303,33 @@ static inline void irqd_clr_forwarded_to_vcpu(struct irq_data *d)
 	__irqd_to_state(d) &= ~IRQD_FORWARDED_TO_VCPU;
 }
 
+static inline void irqd_set_move_pending(struct irq_data *d)
+{
+	__irqd_to_state(d) |= IRQD_SETAFFINITY_PENDING;
+}
+
+static inline void irqd_clr_move_pending(struct irq_data *d)
+{
+	__irqd_to_state(d) &= ~IRQD_SETAFFINITY_PENDING;
+}
+
+static inline void irqd_clear(struct irq_data *d, unsigned int mask)
+{
+	__irqd_to_state(d) &= ~mask;
+}
+
+static inline void irqd_set(struct irq_data *d, unsigned int mask)
+{
+	__irqd_to_state(d) |= mask;
+}
+
+static inline bool irqd_has_set(struct irq_data *d, unsigned int mask)
+{
+	return __irqd_to_state(d) & mask;
+}
+
+#undef __irqd_to_state
+
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
 {
 	return d->hwirq;
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index fcab63c..307fff8 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -160,34 +160,6 @@ irq_put_desc_unlock(struct irq_desc *desc, unsigned long flags)
 	__irq_put_desc_unlock(desc, flags, false);
 }
 
-/*
- * Manipulation functions for irq_data.state
- */
-static inline void irqd_set_move_pending(struct irq_data *d)
-{
-	__irqd_to_state(d) |= IRQD_SETAFFINITY_PENDING;
-}
-
-static inline void irqd_clr_move_pending(struct irq_data *d)
-{
-	__irqd_to_state(d) &= ~IRQD_SETAFFINITY_PENDING;
-}
-
-static inline void irqd_clear(struct irq_data *d, unsigned int mask)
-{
-	__irqd_to_state(d) &= ~mask;
-}
-
-static inline void irqd_set(struct irq_data *d, unsigned int mask)
-{
-	__irqd_to_state(d) |= mask;
-}
-
-static inline bool irqd_has_set(struct irq_data *d, unsigned int mask)
-{
-	return __irqd_to_state(d) & mask;
-}
