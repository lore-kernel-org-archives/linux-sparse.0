From: Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 3/3] irq: Privatize irq_common_data::state_use_accessors
Date: Sat, 12 Dec 2015 10:56:02 +0800
Message-ID: <1449888962-29348-4-git-send-email-boqun.feng@gmail.com>
References: <1449888962-29348-1-git-send-email-boqun.feng@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449888962-29348-1-git-send-email-boqun.feng@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, Marc Zyngier <marc.zyngier@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Brian Norris <computersforpeace@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>
List-Id: linux-sparse@vger.kernel.org

According to Peter Zijlstra, irq_common_data::state_use_accessors is not
designed for public use. Therefore make it private so that people who
write code accessing it directly will get blamed by sparse.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---
 include/linux/irq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 3c1c967..0b8f273 100644
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
-- 
2.6.4
