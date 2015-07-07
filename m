From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH] compiler.h: Fix sparse check errors
Date: Tue, 07 Jul 2015 08:56:14 -0600
Message-ID: <1436280974.790.1.camel@theros.lm.intel.com>
References: <607087dd3321926ddf4f67762be67656501bfa25.1436276428.git.mchehab@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <607087dd3321926ddf4f67762be67656501bfa25.1436276428.git.mchehab@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-sparse@vger.kernel.org

On Tue, 2015-07-07 at 10:43 -0300, Mauro Carvalho Chehab wrote:
> The #define __pmem was put at the wrong place, inside a
> __rcu check. The way it is, if CONFIG_SPARSE_RCU_POINTER is
> not defined, it will produce thousands of errors like:
> 
> ./arch/x86/include/asm/io.h:251:27: error: void declaration
> ./arch/x86/include/asm/io.h:251:27: error: Expected ; at end of declaration
> ./arch/x86/include/asm/io.h:251:27: error: got *
> 
> making sparse pretty much useless, due to the excess of noise.
> 
> So, move the define out of the sparse RCU pointer check.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 7f8ad9593da7..4f85b58b7285 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -21,8 +21,8 @@
>  # define __rcu		__attribute__((noderef, address_space(4)))
>  #else
>  # define __rcu
> +#endif
>  # define __pmem		__attribute__((noderef, address_space(5)))
> -#endif
>  extern void __chk_user_ptr(const volatile void __user *);
>  extern void __chk_io_ptr(const volatile void __iomem *);
>  #else

Yep, thank you for the fix.  I think Dan already has a version of this queued
up in his tree for his next pull request:

https://git.kernel.org/cgit/linux/kernel/git/djbw/nvdimm.git/commit/?h=libnvdimm-pending&id=31f02455455d405320e2f749696bef4e02903b35
