From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [RFC v2 0/3] sparse: Introduce __private to privatize members of
 structs
Date: Mon, 4 Jan 2016 14:21:53 -0800
Message-ID: <20160104222153.GH32217@linux.vnet.ibm.com>
References: <1451362728-18961-1-git-send-email-boqun.feng@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:44461 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbcADWWK (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 4 Jan 2016 17:22:10 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-sparse@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Mon, 4 Jan 2016 15:22:10 -0700
Content-Disposition: inline
In-Reply-To: <1451362728-18961-1-git-send-email-boqun.feng@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>, Peter Zijlstra <peterz@infradead.org>

On Tue, Dec 29, 2015 at 12:18:45PM +0800, Boqun Feng wrote:
> Hi all,
> 
> This is v2 of __private.
> 
> Link for v1: http://marc.info/?l=linux-sparse&m=144988906932520&w=2
> 
> Change since v1:
> 
> *	#undef __irqd_to_state after used (Peter Zijlstra)
> 
> 
> This patchset introduces a __private modifier for sparse to detect misuses of
> private members of structs. This could make maintenace a little easier and
> prevent some potential bugs.
> 
> 
> This patchset consists of three patches:
> 
> 1.	Introduce __private and related macro, also improve compiler.h a litte
> 	bit
> 
> 2.	Privatize rcu_node::lock
> 
> 3.	Privatize irq_common_data::state_use_accessors
> 
> This patchset is against
> 
> 	-rcu/rcu/next	c95a158356397844a5a6deb0bd58758084f891df
> 
> because it depends on commits:
> 	
> 	"rcu: Create transitive rnp->lock acquisition functions"
> and
> 	"rcu: Add transitivity to remaining rcu_node ->lock acquisitions
> 
> 
> Tested by 0day.
> 
> Looking forward to any suggestion, question and comment ;-)

Queued for review and testing, along with Thomas's Reviewed-by.  If all
goes well, I expect to send them upstream in the 4.6 merge window.

							Thanx, Paul

