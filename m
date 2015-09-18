From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [kbuild-all] [kvm:queue 27/38] arch/x86/kvm/hyperv.c:186:41:
 sparse: incorrect type in argument 2 (different modifiers)
Date: Fri, 18 Sep 2015 23:06:44 +0800
Message-ID: <20150918150644.GB20668@wfg-t540p.sh.intel.com>
References: <201509182109.6ccgXDVp%fengguang.wu@intel.com>
 <55FC16F4.7060407@openvz.org>
 <55FC17B4.9060702@redhat.com>
 <20150918144026.GJ3317@rkaganb.sw.ru>
 <55FC22B4.9010301@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12711 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932108AbbIRPGz (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 18 Sep 2015 11:06:55 -0400
Content-Disposition: inline
In-Reply-To: <55FC22B4.9010301@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Andrey Smetanin <asmetanin@virtuozzo.com>, kbuild-all@01.org, kvm@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

[CC sparse people]

On Fri, Sep 18, 2015 at 04:41:56PM +0200, Paolo Bonzini wrote:
> 
> 
> On 18/09/2015 16:40, Roman Kagan wrote:
> > typedef unsigned long __nocast cputime_t;
> > 
> > extern void task_cputime_adjusted(cputime_t *);
> > extern void current_task_runtime_100ns(void);
> > 
> > void current_task_runtime_100ns(void)
> > {
> >         cputime_t utime;
> > 
> >         task_cputime_adjusted(&utime);
> > }
> > %%% gcc -c x.c -Wall -Werror -O2; echo $?
> > 0
> > %%% sparse x.c
> > x.c:16:32: warning: incorrect type in argument 1 (different modifiers)
> > x.c:16:32:    expected unsigned long [nocast] [usertype] *<noident>
> > x.c:16:32:    got unsigned long *<noident>
> > x.c:16:32: warning: implicit cast to nocast type
> > 
> > Looks like a sparse bug to me.
> 
> Indeed...
> 
> Paolo
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
