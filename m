From: Dave Jones <davej@redhat.com>
Subject: Re: annotating semaphores.
Date: Thu, 13 Dec 2007 17:05:42 -0500
Message-ID: <20071213220542.GA32252@redhat.com>
References: <20071212200053.GA19747@redhat.com> <70318cbf0712131400j607b8f55mbb64e9b8cb7f8682@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:34765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761483AbXLMWFp (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 13 Dec 2007 17:05:45 -0500
Content-Disposition: inline
In-Reply-To: <70318cbf0712131400j607b8f55mbb64e9b8cb7f8682@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

On Thu, Dec 13, 2007 at 02:00:09PM -0800, Christopher Li wrote:
 > On Dec 12, 2007 12:00 PM, Dave Jones <davej@redhat.com> wrote:
 > > Today I came across a bug in the kernel cpufreq code where
 > > we were missing a bunch of up_write() calls in error paths
 > > of a function.
 > >
 > > I've been trying to get sparse's context checking to pick up
 > > on the errors and failing.  The kernel patch below is what I have
 > > so far, but it seems to report no output whatsoever.
 > > What am I missing ?
 > 
 > Can you share the example buggy cpufreq code that miss the up_write() calls?

Sure. In drivers/cpufreq/cpufreq.c cpufreq_add_dev() is missing several
calls to unlock_policy_rwsem_write() in the error paths.

The patch below should make it more obvious..

	Dave

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 5e626b1..79581fa 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -841,19 +841,25 @@ static int cpufreq_add_dev (struct sys_device * sys_dev)
 	drv_attr = cpufreq_driver->attr;
 	while ((drv_attr) && (*drv_attr)) {
 		ret = sysfs_create_file(&policy->kobj, &((*drv_attr)->attr));
-		if (ret)
+		if (ret) {
+			unlock_policy_rwsem_write(cpu);
 			goto err_out_driver_exit;
+		}
 		drv_attr++;
 	}
 	if (cpufreq_driver->get){
 		ret = sysfs_create_file(&policy->kobj, &cpuinfo_cur_freq.attr);
-		if (ret)
+		if (ret) {
+			unlock_policy_rwsem_write(cpu);
 			goto err_out_driver_exit;
+		}
 	}
 	if (cpufreq_driver->target){
 		ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
-		if (ret)
+		if (ret) {
+			unlock_policy_rwsem_write(cpu);
 			goto err_out_driver_exit;
+		}
 	}
 
 	spin_lock_irqsave(&cpufreq_driver_lock, flags);
-- 
http://www.codemonkey.org.uk
