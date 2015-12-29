From: Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC v2 0/3] sparse: Introduce __private to privatize members of structs
Date: Tue, 29 Dec 2015 12:18:45 +0800
Message-ID: <1451362728-18961-1-git-send-email-boqun.feng@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34033 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbbL2ET3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 28 Dec 2015 23:19:29 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>

Hi all,

This is v2 of __private.

Link for v1: http://marc.info/?l=linux-sparse&m=144988906932520&w=2

Change since v1:

*	#undef __irqd_to_state after used (Peter Zijlstra)


This patchset introduces a __private modifier for sparse to detect misuses of
private members of structs. This could make maintenace a little easier and
prevent some potential bugs.


This patchset consists of three patches:

1.	Introduce __private and related macro, also improve compiler.h a litte
	bit

2.	Privatize rcu_node::lock

3.	Privatize irq_common_data::state_use_accessors

This patchset is against

	-rcu/rcu/next	c95a158356397844a5a6deb0bd58758084f891df

because it depends on commits:
	
	"rcu: Create transitive rnp->lock acquisition functions"
and
	"rcu: Add transitivity to remaining rcu_node ->lock acquisitions


Tested by 0day.

Looking forward to any suggestion, question and comment ;-)

Regards,
Boqun
