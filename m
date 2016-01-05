From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [kbuild-all] [kvm:queue 27/38] arch/x86/kvm/hyperv.c:186:41:
 sparse: incorrect type in argument 2 (different modifiers)
Date: Tue, 5 Jan 2016 14:51:57 +0100
Message-ID: <20160105135156.GB1044@macpro.local>
References: <201509182109.6ccgXDVp%fengguang.wu@intel.com>
 <55FC16F4.7060407@openvz.org>
 <55FC17B4.9060702@redhat.com>
 <20150918144026.GJ3317@rkaganb.sw.ru>
 <55FC22B4.9010301@redhat.com>
 <20150918150644.GB20668@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150918150644.GB20668@wfg-t540p.sh.intel.com>
Sender: kvm-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Andrey Smetanin <asmetanin@virtuozzo.com>, kbuild-all@01.org, kvm@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Fri, Sep 18, 2015 at 11:06:44PM +0800, Fengguang Wu wrote:
> [CC sparse people]
> 
> On Fri, Sep 18, 2015 at 04:41:56PM +0200, Paolo Bonzini wrote:
> > 
> > 
> > On 18/09/2015 16:40, Roman Kagan wrote:
> > > typedef unsigned long __nocast cputime_t;
> > > 
> > > extern void task_cputime_adjusted(cputime_t *);
> > > extern void current_task_runtime_100ns(void);
> > > 
> > > void current_task_runtime_100ns(void)
> > > {
> > >         cputime_t utime;
> > > 
> > >         task_cputime_adjusted(&utime);
> > > }
> > > %%% gcc -c x.c -Wall -Werror -O2; echo $?
> > > 0
> > > %%% sparse x.c
> > > x.c:16:32: warning: incorrect type in argument 1 (different modifiers)
> > > x.c:16:32:    expected unsigned long [nocast] [usertype] *<noident>
> > > x.c:16:32:    got unsigned long *<noident>
> > > x.c:16:32: warning: implicit cast to nocast type
> > > 
> > > Looks like a sparse bug to me.
> > 
> > Indeed...
> > 
> > Paolo

The problem is that the intent and semantic of 'nocast' is not clear at all.
There is an explanation about 'nocast' vs. 'bitwise' here:
	https://git.kernel.org/cgit/devel/sparse/sparse.git/tree/Documentation/sparse.txt
but it doesn't give much info about the exact wanted behaviour.

Since for the kernel 'nocast' is only used for cputime_t & cputime64_t,
I think it should be clarified and fixed if needed.
A patch proposal is following.

Regards,
Luc
