From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [BUG report]sparse warnings on DEFINE_PER_CPU() symbols non-static
Date: Wed, 04 Dec 2013 11:26:44 +0800
Message-ID: <529EA0F4.5070205@cn.fujitsu.com>
References: <5294175F.2080407@cn.fujitsu.com> <20131203222543.GQ8277@htj.dyndns.org>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:37781 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752417Ab3LDD2N (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Dec 2013 22:28:13 -0500
In-Reply-To: <20131203222543.GQ8277@htj.dyndns.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: josh@kernel.org, linux-sparse@vger.kernel.org, Wu Fengguang <fengguang.wu@intel.com>, kbuild-all@01.org, Rusty Russell <rusty@rustcorp.com.au>, Christoph Lameter <cl@linux-foundation.org>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

On 12/04/2013 06:25 AM, Tejun Heo wrote:
> Hello,
> 
> On Tue, Nov 26, 2013 at 11:37:03AM +0800, Wanlong Gao wrote:
>> If kernel config CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y, then the sparse will report non-static
>> warnings like following:
>>
>>> /git/linux/fs/inode.c:74:8: warning: symbol 'nr_inodes' was not declared. Should it be static?
>>> /git/linux/fs/inode.c:75:8: warning: symbol 'nr_unused' was not declared. Should it be static?
>>>
>>> $ vi +74 fs/inode.c
>>>   73 
>>>   74 static DEFINE_PER_CPU(unsigned long, nr_inodes);
>>>   75 static DEFINE_PER_CPU(unsigned long, nr_unused);
>>>   76 
> 
> Hmmm, so, if FORCE_WEAK_PER_CPU is set or the arch needs WEAK_PER_CPU,
> DEFINE_PER_CPU() explodes into mind-bending series of definitions to
> ensure that the symbol is globally unique to avoid breaking weak decl
> requirements on a few archs.  In the process static is dropped from
> the actual declaration and it's apparently missing extern decl in
> front of it.
> 
> Does the following patch make it go away?

Goes away but comes new error:

/git/linux/fs/inode.c:74:8: error: symbol 'nr_inodes' redeclared with different type (originally declared at /git/linux/fs/inode.c:74) - different address spaces
/git/linux/fs/inode.c:75:8: error: symbol 'nr_unused' redeclared with different type (originally declared at /git/linux/fs/inode.c:75) - different address spaces
/git/linux/fs/inode.c:835:8: error: symbol 'last_ino' redeclared with different type (originally declared at /git/linux/fs/inode.c:835) - different address spaces


Thanks,
Wanlong Gao

> 
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
> 

