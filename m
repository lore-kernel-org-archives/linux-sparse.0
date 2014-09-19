From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH 7/7] sched: Silence nested-externs warnings
Date: Fri, 19 Sep 2014 08:29:40 -0700
Message-ID: <1411140580-20909-8-git-send-email-jeffrey.t.kirsher@intel.com>
References: <1411140580-20909-1-git-send-email-jeffrey.t.kirsher@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1411140580-20909-1-git-send-email-jeffrey.t.kirsher@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sparse@chrisli.org
Cc: Mark Rustad <mark.d.rustad@intel.com>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>
List-Id: linux-sparse@vger.kernel.org

From: Mark Rustad <mark.d.rustad@intel.com>

Use diagnostic control macros to ignore nested-externs warnings
in this case.

CC: Ingo Molnar <mingo@redhat.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
---
 include/linux/sched.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5c2c885..ed52c76 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -832,7 +832,9 @@ static inline int sched_info_on(void)
 #ifdef CONFIG_SCHEDSTATS
 	return 1;
 #elif defined(CONFIG_TASK_DELAY_ACCT)
+	DIAG_PUSH DIAG_IGNORE(nested-externs)
 	extern int delayacct_on;
+	DIAG_POP
 	return delayacct_on;
 #else
 	return 0;
-- 
1.9.3
