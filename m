From: Josh Triplett <josh@kernel.org>
Subject: Re: [BUG report]sparse warnings on DEFINE_PER_CPU() symbols
 non-static
Date: Tue, 3 Dec 2013 15:43:20 -0800
Message-ID: <20131203234320.GA15141@jtriplet-mobl1>
References: <5294175F.2080407@cn.fujitsu.com>
 <20131203222543.GQ8277@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54151 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab3LCXnc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Dec 2013 18:43:32 -0500
Content-Disposition: inline
In-Reply-To: <20131203222543.GQ8277@htj.dyndns.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, linux-sparse@vger.kernel.org, Wu Fengguang <fengguang.wu@intel.com>, kbuild-all@01.org, Rusty Russell <rusty@rustcorp.com.au>, Christoph Lameter <cl@linux-foundation.org>

On Tue, Dec 03, 2013 at 05:25:43PM -0500, Tejun Heo wrote:
> Hello,
> 
> On Tue, Nov 26, 2013 at 11:37:03AM +0800, Wanlong Gao wrote:
> > If kernel config CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y, then the sparse will report non-static
> > warnings like following:
> > 
> > > /git/linux/fs/inode.c:74:8: warning: symbol 'nr_inodes' was not declared. Should it be static?
> > > /git/linux/fs/inode.c:75:8: warning: symbol 'nr_unused' was not declared. Should it be static?
> > >
> > > $ vi +74 fs/inode.c
> > >   73 
> > >   74 static DEFINE_PER_CPU(unsigned long, nr_inodes);
> > >   75 static DEFINE_PER_CPU(unsigned long, nr_unused);
> > >   76 
> 
> Hmmm, so, if FORCE_WEAK_PER_CPU is set or the arch needs WEAK_PER_CPU,
> DEFINE_PER_CPU() explodes into mind-bending series of definitions to
> ensure that the symbol is globally unique to avoid breaking weak decl
> requirements on a few archs.  In the process static is dropped from
> the actual declaration and it's apparently missing extern decl in
> front of it.
> 
> Does the following patch make it go away?

It should, but is there some reason why you couldn't make the definition
on the line immediately below that static?

> Thanks.
> 
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index 57e890a..8c490cc 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -69,6 +69,7 @@
>  	__PCPU_DUMMY_ATTRS char __pcpu_scope_##name;			\
>  	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
>  	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
> +	extern __typeof__(type) name;					\
>  	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak			\
>  	__typeof__(type) name
>  #else
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
