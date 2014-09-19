From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 7/7] sched: Silence nested-externs warnings
Date: Sat, 20 Sep 2014 00:54:53 +0200
Message-ID: <20140919225453.GJ2832@worktop.localdomain>
References: <1411140580-20909-1-git-send-email-jeffrey.t.kirsher@intel.com>
 <1411140580-20909-8-git-send-email-jeffrey.t.kirsher@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:43823 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758057AbaISWzA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 19 Sep 2014 18:55:00 -0400
Content-Disposition: inline
In-Reply-To: <1411140580-20909-8-git-send-email-jeffrey.t.kirsher@intel.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: sparse@chrisli.org, Mark Rustad <mark.d.rustad@intel.com>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Brian Norris <computersforpeace@gmail.com>

On Fri, Sep 19, 2014 at 08:29:40AM -0700, Jeff Kirsher wrote:
> From: Mark Rustad <mark.d.rustad@intel.com>
> 
> Use diagnostic control macros to ignore nested-externs warnings
> in this case.
> 
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Brian Norris <computersforpeace@gmail.com>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  include/linux/sched.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5c2c885..ed52c76 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -832,7 +832,9 @@ static inline int sched_info_on(void)
>  #ifdef CONFIG_SCHEDSTATS
>  	return 1;
>  #elif defined(CONFIG_TASK_DELAY_ACCT)
> +	DIAG_PUSH DIAG_IGNORE(nested-externs)
>  	extern int delayacct_on;
> +	DIAG_POP
>  	return delayacct_on;

Who has this nested extern warn on in anycase? I've never seen it
generate a warning. Also WTF is DIAG_PUSH/POP, its not a GCC thing
afaict.
