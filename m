From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 3/3] irq: Privatize irq_common_data::state_use_accessors
Date: Mon, 14 Dec 2015 11:03:03 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1512141102470.4336@nanos>
References: <1449888962-29348-1-git-send-email-boqun.feng@gmail.com> <1449888962-29348-4-git-send-email-boqun.feng@gmail.com> <20151214095021.GM6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151214095021.GM6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, 14 Dec 2015, Peter Zijlstra wrote:
> On Sat, Dec 12, 2015 at 10:56:02AM +0800, Boqun Feng wrote:
> > According to Peter Zijlstra, irq_common_data::state_use_accessors is not
> > designed for public use. Therefore make it private so that people who
> > write code accessing it directly will get blamed by sparse.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > ---
> >  include/linux/irq.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/irq.h b/include/linux/irq.h
> > index 3c1c967..0b8f273 100644
> > --- a/include/linux/irq.h
> > +++ b/include/linux/irq.h
> > @@ -137,7 +137,7 @@ struct irq_domain;
> >   * @msi_desc:		MSI descriptor
> >   */
> >  struct irq_common_data {
> > -	unsigned int		state_use_accessors;
> > +	unsigned int		__private state_use_accessors;
> >  #ifdef CONFIG_NUMA
> >  	unsigned int		node;
> >  #endif
> > @@ -208,7 +208,7 @@ enum {
> >  	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
> >  };
> >  
> > -#define __irqd_to_state(d)		((d)->common->state_use_accessors)
> > +#define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
> >  
> >  static inline bool irqd_is_setaffinity_pending(struct irq_data *d)
> >  {
> 
> We should probably #undef that one once we're done with it.. Thomas?

Probably.
 
