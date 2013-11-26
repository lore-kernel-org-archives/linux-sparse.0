From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: [BUG report]sparse warnings on DEFINE_PER_CPU() symbols non-static
Date: Tue, 26 Nov 2013 11:37:03 +0800
Message-ID: <5294175F.2080407@cn.fujitsu.com>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:20498 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751081Ab3KZDiP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Nov 2013 22:38:15 -0500
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: josh@kernel.org, linux-sparse@vger.kernel.org
Cc: Wu Fengguang <fengguang.wu@intel.com>, kbuild-all@01.org, Rusty Russell <rusty@rustcorp.com.au>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux-foundation.org>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

Hi Folks,


If kernel config CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y, then the sparse will report non-static
warnings like following:

> /git/linux/fs/inode.c:74:8: warning: symbol 'nr_inodes' was not declared. Should it be static?
> /git/linux/fs/inode.c:75:8: warning: symbol 'nr_unused' was not declared. Should it be static?
>
> $ vi +74 fs/inode.c
>   73 
>   74 static DEFINE_PER_CPU(unsigned long, nr_inodes);
>   75 static DEFINE_PER_CPU(unsigned long, nr_unused);
>   76 


Any thoughts?


Thanks,
Wanlong Gao
