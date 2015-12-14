From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 3/3] irq: Privatize irq_common_data::state_use_accessors
Date: Mon, 14 Dec 2015 16:59:45 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1512141657430.4336@nanos>
References: <1449888962-29348-1-git-send-email-boqun.feng@gmail.com> <1449888962-29348-4-git-send-email-boqun.feng@gmail.com> <20151214095021.GM6357@twins.programming.kicks-ass.net> <alpine.DEB.2.11.1512141102470.4336@nanos>
 <20151214120021.GJ1072@fixme-laptop.cn.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151214120021.GJ1072@fixme-laptop.cn.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, 14 Dec 2015, Boqun Feng wrote:
> Probably something like this(untested, only run "make kernel/irq/")?
> 
> Subject: [RFC v2 3/3] irq: Privatize irq_common_data::state_use_accessors
> 
> According to Peter Zijlstra, irq_common_data::state_use_accessors is not
> designed for public use. Therefore make it private so that people who
> write code accessing it directly will get blamed by sparse.
> 
> Also macro __irqd_to_state() is for _designed_ accesses to irq_data's
> state only, it's better to limit its scope, therefore put all its
> callers together and #undef it after use.

That exposes the set/clr functions to the global header file, while
today those are restricted to the core internals header. There is a
reason why I did not make them public ....

Thanks,

	tglx
