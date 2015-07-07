From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH] include/linux/compiler.h: unconditionally define __pmem
 sparse attribute
Date: Tue, 07 Jul 2015 09:45:29 -0600
Message-ID: <1436283929.790.2.camel@theros.lm.intel.com>
References: <87fv50c6vn.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1380 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756984AbbGGPpb (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 7 Jul 2015 11:45:31 -0400
In-Reply-To: <87fv50c6vn.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2015-07-07 at 17:41 +0200, Nicolai Stange wrote:
> Commit 61031952f4c8 ("arch, x86: pmem api for ensuring durability of
>                       persistent memory updates")
> defined __pmem in include/linux/compiler.h only for the case
> CONFIG_RCU_SPARSE_POINTER=n, probably by accident.
> 
> With CONFIG_RCU_SPARSE_POINTER=y a sparse compile gives the error:
>   CHECK   init/main.c
>   arch/x86/include/asm/io.h:251:27: error: void declaration
>   arch/x86/include/asm/io.h:251:27: error: Expected ; at end of declaration
>   arch/x86/include/asm/io.h:251:27: error: got *
>   arch/x86/include/asm/io.h:255:1: error: Expected ; at the end of
>     type declaration
>   arch/x86/include/asm/io.h:255:1: error: got }
> 
> This happens because the __pmem in
> arch/x86/include/asm/io.h:251:
>   static inline void __pmem *arch_memremap_pmem([...])
> is undefined.
> 
> Define __pmem unconditionally in include/linux/compiler.h.
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>
> ---
>  include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 7f8ad95..4f85b58 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -21,8 +21,8 @@
>  # define __rcu		__attribute__((noderef, address_space(4)))
>  #else
>  # define __rcu
> -# define __pmem		__attribute__((noderef, address_space(5)))
>  #endif
> +# define __pmem		__attribute__((noderef, address_space(5)))
>  extern void __chk_user_ptr(const volatile void __user *);
>  extern void __chk_io_ptr(const volatile void __iomem *);
>  #else

Yep, thank you for the fix.  I think Dan already has a version of this queued
up in his tree for his next pull request:

https://git.kernel.org/cgit/linux/kernel/git/djbw/nvdimm.git/commit/?h=libnvdimm-pending&id=31f02455455d405320e2f749696bef4e02903b35


