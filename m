From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [BUG report] sparse warnings about "__ksymtab_*" symbols
Date: Tue, 26 Nov 2013 09:51:34 +0800
Message-ID: <5293FEA6.2080101@cn.fujitsu.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:11641 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab3KZBwo (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Nov 2013 20:52:44 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@kernel.org, linux-sparse@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, ak@linux.intel.com, Wu Fengguang <fengguang.wu@intel.com>, kbuild-all@01.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>

Hi folks,

After following kernel commit[1](find through bisect), We can see many sparse warnings like:
"
/git/linux/kernel/time/timekeeping.c:229:1: warning: symbol '__ksymtab_pvclock_gtod_register_notifier' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:246:1: warning: symbol '__ksymtab_pvclock_gtod_unregister_notifier' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:323:1: warning: symbol '__ksymtab___getnstimeofday' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:335:1: warning: symbol '__ksymtab_getnstimeofday' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:357:1: warning: symbol '__ksymtab_ktime_get' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:388:1: warning: symbol '__ksymtab_ktime_get_ts' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:417:1: warning: symbol '__ksymtab_timekeeping_clocktai' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:432:1: warning: symbol '__ksymtab_ktime_get_clocktai' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:486:1: warning: symbol '__ksymtab_do_gettimeofday' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:526:1: warning: symbol '__ksymtab_do_settimeofday' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:570:1: warning: symbol '__ksymtab_timekeeping_inject_offset' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:689:1: warning: symbol '__ksymtab_ktime_get_real' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:712:1: warning: symbol '__ksymtab_getrawmonotonic' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:1467:1: warning: symbol '__ksymtab_getboottime' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:1500:1: warning: symbol '__ksymtab_get_monotonic_boottime' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:1517:1: warning: symbol '__ksymtab_ktime_get_boottime' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:1529:1: warning: symbol '__ksymtab_monotonic_to_bootbased' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:1537:1: warning: symbol '__ksymtab_get_seconds' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:1560:1: warning: symbol '__ksymtab_current_kernel_time' was not declared. Should it be static?
/git/linux/kernel/time/timekeeping.c:1662:1: warning: symbol '__ksymtab_ktime_get_monotonic_offset' was not declared. Should it be static?
"

Any thoughts?


Thanks,
Wanlong Gao



[1]
commit e0f244c63fc9d192dfd399cc2677bbdca61994b1
Author: Andi Kleen <ak@linux.intel.com>
Date:   Wed Oct 23 10:57:58 2013 +1030

    asmlinkage, module: Make ksymtab and kcrctab symbols and __this_module __visible
    
    Make the ksymtab symbols for EXPORT_SYMBOL visible.
    This prevents the LTO compiler from adding a .NUMBER prefix,
    which avoids various problems in later export processing.
    
    Cc: rusty@rustcorp.com.au
    Signed-off-by: Andi Kleen <ak@linux.intel.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
