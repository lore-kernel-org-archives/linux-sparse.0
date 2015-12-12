From: Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 0/3] sparse: Introduce __private to privatize members of structs
Date: Sat, 12 Dec 2015 10:55:59 +0800
Message-ID: <1449888962-29348-1-git-send-email-boqun.feng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>
List-Id: linux-sparse@vger.kernel.org

Hi all,

As I proposed:

http://marc.info/?l=linux-arm-kernel&m=144944469805753

, we can define a __private modifier for sparse to detect misuses of private
members of structs. This could make maintenace a little easier and prevent some
potential bugs.

This patchset serves as a POC and consists of three patches:

1.	Introduce __private and related macro, also improve compiler.h a litte
	bit

2.	Privatize rcu_node::lock

3.	Privatize irq_common_data::state_use_accessors

This patchset is against

	-rcu/rcu/next	5f343fc7f0ce7edfe344e7cc5afdfe145a18f802

because this depends on commits:
	
	"rcu: Create transitive rnp->lock acquisition functions"

and

	"rcu: Add transitivity to remaining rcu_node ->lock acquisitions


I tried to use 0day to test this, but seems the email transfer from 0day to my
mail box is very slow recently, so I haven't received a recent result yet. But
as one can see, this patchset doesn't have any functional modification, the 0day
may not find anything interesting ;-)


Looking forward to any suggestion, question and comment ;-)

Regards,
Boqun
