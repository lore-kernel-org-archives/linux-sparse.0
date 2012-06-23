From: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH v4 12/13] fair.c: Use generic rbtree impl in fair scheduler
Date: Fri, 22 Jun 2012 23:00:47 -0500
Message-ID: <1340424048-7759-13-git-send-email-daniel.santos@pobox.com>
References: <1340424048-7759-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nm23-vm0.access.bullet.mail.mud.yahoo.com ([66.94.236.141]:20890
	"HELO nm23-vm0.access.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757080Ab2FWEH4 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 23 Jun 2012 00:07:56 -0400
In-Reply-To: <1340424048-7759-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Turner <pjt@google.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Richard Weinberger <richard@nod.at>, Rob Landley <rob@landley.net>, Steven Rostedt <rostedt@goodmis.org>, Suresh Siddha <suresh.b.siddha@intel.com>

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 kernel/sched/fair.c |   82 +++++++++++++++++----------------------------------
 1 files changed, 27 insertions(+), 55 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c099cc6..ac12e303 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -447,6 +447,20 @@ static inline int entity_before(struct sched_entity *a,
 	return (s64)(a->vruntime - b->vruntime) < 0;
 }
 
+static inline long compare_vruntime(u64 *a, u64 *b)
+{
+#if __BITS_PER_LONG >= 64
+	return (long)((s64)*a - (s64)*b);
+#else
+/* This is hacky, but is done to reduce instructions -- we wont use this for
+ * rbtree lookups, only inserts, and since our relationship is defined as
+ * non-unique, we only need to return positive if a > b and any other value
+ * means less than.
+ */
+	return (long)(*a > *b);
+#endif
+}
+
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
 	u64 vruntime = cfs_rq->min_vruntime;
@@ -472,56 +486,14 @@ static void update_min_vruntime(struct cfs_rq *cfs_rq)
 #endif
 }
 
-/*
- * Enqueue an entity into the rb-tree:
- */
-static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	struct rb_node **link = &cfs_rq->tasks_timeline.rb_node;
-	struct rb_node *parent = NULL;
-	struct sched_entity *entry;
-	int leftmost = 1;
-
-	/*
-	 * Find the right place in the rbtree:
-	 */
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct sched_entity, run_node);
-		/*
-		 * We dont care about collisions. Nodes with
-		 * the same key stay together.
-		 */
-		if (entity_before(se, entry)) {
-			link = &parent->rb_left;
-		} else {
-			link = &parent->rb_right;
-			leftmost = 0;
-		}
-	}
-
-	/*
-	 * Maintain a cache of leftmost tree entries (it is frequently
-	 * used):
-	 */
-	if (leftmost)
-		cfs_rq->rb_leftmost = &se->run_node;
-
-	rb_link_node(&se->run_node, parent, link);
-	rb_insert_color(&se->run_node, &cfs_rq->tasks_timeline);
-}
-
-static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	if (cfs_rq->rb_leftmost == &se->run_node) {
-		struct rb_node *next_node;
-
-		next_node = rb_next(&se->run_node);
-		cfs_rq->rb_leftmost = next_node;
-	}
-
-	rb_erase(&se->run_node, &cfs_rq->tasks_timeline);
-}
+RB_DEFINE_INTERFACE(
+	fair_tree,
+	struct cfs_rq, tasks_timeline, rb_leftmost, /* no right or count */, ,
+	struct sched_entity, run_node, vruntime,
+	0, compare_vruntime, /* no augment */,
+	/* find unused */ ,
+	static __flatten, /* let gcc decide rather or not to inline insert */
+	/* find_near unused */, /* insert_near unused */)
 
 struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 {
@@ -1108,7 +1080,7 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_stats_enqueue(cfs_rq, se);
 	check_spread(cfs_rq, se);
 	if (se != cfs_rq->curr)
-		__enqueue_entity(cfs_rq, se);
+		fair_tree_insert(cfs_rq, se);
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -1189,7 +1161,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	clear_buddies(cfs_rq, se);
 
 	if (se != cfs_rq->curr)
-		__dequeue_entity(cfs_rq, se);
+		fair_tree_remove(cfs_rq, se);
 	se->on_rq = 0;
 	update_cfs_load(cfs_rq, 0);
 	account_entity_dequeue(cfs_rq, se);
@@ -1260,7 +1232,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 * runqueue.
 		 */
 		update_stats_wait_end(cfs_rq, se);
-		__dequeue_entity(cfs_rq, se);
+		fair_tree_remove(cfs_rq, se);
 	}
 
 	update_stats_curr_start(cfs_rq, se);
@@ -1339,7 +1311,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	if (prev->on_rq) {
 		update_stats_wait_start(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
-		__enqueue_entity(cfs_rq, prev);
+		fair_tree_insert(cfs_rq, prev);
 	}
 	cfs_rq->curr = NULL;
 }
@@ -3593,7 +3565,7 @@ void update_group_power(struct sched_domain *sd, int cpu)
 		/*
 		 * !SD_OVERLAP domains can assume that child groups
 		 * span the current group.
-		 */ 
+		 */
 
 		group = child->groups;
 		do {
-- 
1.7.3.4

