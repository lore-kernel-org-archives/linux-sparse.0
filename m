From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [BUG report]sparse warnings on DEFINE_PER_CPU() symbols non-static
Date: Thu, 05 Dec 2013 08:18:56 +0800
Message-ID: <529FC670.2080308@cn.fujitsu.com>
References: <5294175F.2080407@cn.fujitsu.com> <20131203222543.GQ8277@htj.dyndns.org> <529EA0F4.5070205@cn.fujitsu.com> <20131204151240.GO3158@htj.dyndns.org>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:61003 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752978Ab3LEAUY (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 4 Dec 2013 19:20:24 -0500
In-Reply-To: <20131204151240.GO3158@htj.dyndns.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: josh@kernel.org, linux-sparse@vger.kernel.org, Wu Fengguang <fengguang.wu@intel.com>, kbuild-all@01.org, Rusty Russell <rusty@rustcorp.com.au>, Christoph Lameter <cl@linux-foundation.org>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

On 12/04/2013 11:12 PM, Tejun Heo wrote:
> On Wed, Dec 04, 2013 at 11:26:44AM +0800, Wanlong Gao wrote:
>> Goes away but comes new error:
>>
>> /git/linux/fs/inode.c:74:8: error: symbol 'nr_inodes' redeclared with different type (originally declared at /git/linux/fs/inode.c:74) - different address spaces
>> /git/linux/fs/inode.c:75:8: error: symbol 'nr_unused' redeclared with different type (originally declared at /git/linux/fs/inode.c:75) - different address spaces
>> /git/linux/fs/inode.c:835:8: error: symbol 'last_ino' redeclared with different type (originally declared at /git/linux/fs/inode.c:835) - different address spaces
> 
> Oops, my bad.  How about the following?

It works, thank you.

Tested-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

> 
> diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
> index 57e890a..a5fc7d0 100644
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -69,6 +69,7 @@
>  	__PCPU_DUMMY_ATTRS char __pcpu_scope_##name;			\
>  	extern __PCPU_DUMMY_ATTRS char __pcpu_unique_##name;		\
>  	__PCPU_DUMMY_ATTRS char __pcpu_unique_##name;			\
> +	extern __PCPU_ATTRS(sec) __typeof__(type) name;			\
>  	__PCPU_ATTRS(sec) PER_CPU_DEF_ATTRIBUTES __weak			\
>  	__typeof__(type) name
>  #else
> 

