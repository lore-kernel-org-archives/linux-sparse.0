From: Mark D Rustad <mark.d.rustad@intel.com>
Subject: [PATCH] sched: Remove nested extern
Date: Mon, 22 Sep 2014 10:55:11 -0700
Message-ID: <20140922175511.62229.98784.stgit@mdrustad-wks.jf.intel.com>
References: <CAFLxGvwfuE-458duC9ARMLLMBCvZaBQnwDjPW6uJC4FAViBXjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFLxGvwfuE-458duC9ARMLLMBCvZaBQnwDjPW6uJC4FAViBXjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sparse@chrisli.org
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, richard.weinberger@gmail.com, linux-sparse@vger.kernel.org, mingo@redhat.com, jeffrey.t.kirsher@intel.com, mark.d.rustad@intel.com, computersforpeace@gmail.com
List-Id: linux-sparse@vger.kernel.org

Avoid W=2 nested-externs warning by moving the nested extern to
a normal extern. This eliminates that warning which is generated
for every inclusion of sched.h in a kernel build when W=2 is used.
This also removes a point of maintenance if the definition of
delayacct_on were ever to change.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 include/linux/delayacct.h |    1 -
 include/linux/sched.h     |    3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 6cee17c22313..51229790af00 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -30,7 +30,6 @@
 
 #ifdef CONFIG_TASK_DELAY_ACCT
 
-extern int delayacct_on;	/* Delay accounting turned on/off */
 extern struct kmem_cache *delayacct_cache;
 extern void delayacct_init(void);
 extern void __delayacct_tsk_init(struct task_struct *);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5c2c885ee52b..1f1dcfdcd92c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -825,6 +825,8 @@ struct task_delay_info {
 	u64 freepages_delay;	/* wait for memory reclaim */
 	u32 freepages_count;	/* total count of memory reclaim */
 };
+
+extern int delayacct_on;	/* Delay accounting turned on/off */
 #endif	/* CONFIG_TASK_DELAY_ACCT */
 
 static inline int sched_info_on(void)
@@ -832,7 +834,6 @@ static inline int sched_info_on(void)
 #ifdef CONFIG_SCHEDSTATS
 	return 1;
 #elif defined(CONFIG_TASK_DELAY_ACCT)
-	extern int delayacct_on;
 	return delayacct_on;
 #else
 	return 0;
