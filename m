From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC v2 3/3] irq: Privatize
 irq_common_data::state_use_accessors
Date: Tue, 29 Dec 2015 10:46:39 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1512291046250.28591@nanos>
References: <1451362728-18961-1-git-send-email-boqun.feng@gmail.com> <1451362728-18961-4-git-send-email-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:42041 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbL2Jri (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 29 Dec 2015 04:47:38 -0500
In-Reply-To: <1451362728-18961-4-git-send-email-boqun.feng@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Christopher Li <sparse@chrisli.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>, Peter Zijlstra <peterz@infradead.org>

On Tue, 29 Dec 2015, Boqun Feng wrote:

> irq_common_data::state_use_accessors is not designed for public use.
> Therefore make it private so that people who write code accessing it
> directly will get blamed by sparse. Also #undef the macro
> __irqd_to_state after used in header files, so that the macro can't be
> misused.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

