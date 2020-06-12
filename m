From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 5/7] arch: add specificities for Nios2
Date: Fri, 12 Jun 2020 02:04:50 +0100
Message-ID: <3452bdc1-cc47-4f55-98ea-a84075e56c7e@ramsayjones.plus.com>
References: <20200610202735.84968-1-luc.vanoostenryck@gmail.com>
 <20200610202735.84968-6-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:33228 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgFLBEy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 11 Jun 2020 21:04:54 -0400
In-Reply-To: <20200610202735.84968-6-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org



On 10/06/2020 21:27, Luc Van Oostenryck wrote:
> The real goal here is in fact to move the nios2-specfic
> builtins out of the main builtins table.

I had to do a search for Nois II - do people actually run Linux
on these? :-P

This and all remaining patches look good.

Thanks.

ATB,
Ramsay Jones

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Makefile       |  1 +
>  builtin.c      |  5 -----
>  machine.h      |  1 +
>  target-nios2.c | 31 +++++++++++++++++++++++++++++++
>  target.c       |  2 ++
>  target.h       |  1 +
>  6 files changed, 36 insertions(+), 5 deletions(-)
>  create mode 100644 target-nios2.c
> 
> diff --git a/Makefile b/Makefile
> index e93cfd66d0c9..69fae4828e62 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -70,6 +70,7 @@ LIB_OBJS += target-arm64.o
>  LIB_OBJS += target-default.o
>  LIB_OBJS += target-m68k.o
>  LIB_OBJS += target-mips.o
> +LIB_OBJS += target-nios2.o
>  LIB_OBJS += target-ppc.o
>  LIB_OBJS += target-riscv.o
>  LIB_OBJS += target-s390.o
> diff --git a/builtin.c b/builtin.c
> index dcf8200ec002..9442fb5b89ef 100644
> --- a/builtin.c
> +++ b/builtin.c
> @@ -578,11 +578,6 @@ static const struct builtin_fn builtins_common[] = {
>  	{ "__builtin_bfin_ssync", &void_ctype, 0 },
>  	{ "__builtin_bfin_norm_fr1x32", &int_ctype, 0, { &int_ctype }},
>  
> -	// Nios-II-specific
> -	{ "__builtin_rdctl", &int_ctype, 0, { &int_ctype }},
> -	{ "__builtin_wrctl", &void_ctype, 0, { &int_ctype, &int_ctype }},
> -	{ "__builtin_custom_ini", &int_ctype, 0, { &int_ctype }},
> -
>  	{ }
>  };
>  
> diff --git a/machine.h b/machine.h
> index 9c17dd6aa620..a211345c80ce 100644
> --- a/machine.h
> +++ b/machine.h
> @@ -33,6 +33,7 @@ enum machine {
>  	MACH_SPARC32,	MACH_SPARC64,
>  	MACH_S390,	MACH_S390X,
>  	MACH_M68K,
> +	MACH_NIOS2,
>  	MACH_UNKNOWN
>  };
>  
> diff --git a/target-nios2.c b/target-nios2.c
> new file mode 100644
> index 000000000000..05f0926e2df9
> --- /dev/null
> +++ b/target-nios2.c
> @@ -0,0 +1,31 @@
> +#include "symbol.h"
> +#include "target.h"
> +#include "machine.h"
> +#include "builtin.h"
> +
> +
> +static void predefine_nios2(const struct target *self)
> +{
> +	predefine("__NIOS2__", 1, "1");
> +	predefine("__nios2__", 1, "1");
> +
> +	if (arch_big_endian)
> +		predefine("__nios2_big_endian__", 1, "1");
> +	else
> +		predefine("__nios2_little_endian__", 1, "1");
> +}
> +
> +static const struct builtin_fn builtins_nios2[] = {
> +	{ "__builtin_rdctl", &int_ctype, 0, { &int_ctype }},
> +	{ "__builtin_wrctl", &void_ctype, 0, { &int_ctype, &int_ctype }},
> +	{ "__builtin_custom_ini", &int_ctype, 0, { &int_ctype }},
> +	{ }
> +};
> +
> +const struct target target_nios2 = {
> +	.mach = MACH_NIOS2,
> +	.bitness = ARCH_LP32,
> +
> +	.predefine = predefine_nios2,
> +	.builtins = builtins_nios2,
> +};
> diff --git a/target.c b/target.c
> index abfa975672b1..0ef0eb5a14ae 100644
> --- a/target.c
> +++ b/target.c
> @@ -63,6 +63,7 @@ static const struct target *targets[] = {
>  	[MACH_X86_64] =		&target_x86_64,
>  	[MACH_MIPS32] =		&target_mips32,
>  	[MACH_MIPS64] =		&target_mips64,
> +	[MACH_NIOS2] =		&target_nios2,
>  	[MACH_PPC32] =		&target_ppc32,
>  	[MACH_PPC64] =		&target_ppc64,
>  	[MACH_RISCV32] =	&target_riscv32,
> @@ -89,6 +90,7 @@ enum machine target_parse(const char *name)
>  		{ "i386",	MACH_I386,	32, },
>  		{ "m68k",	MACH_M68K,	32, },
>  		{ "mips",	MACH_MIPS32,	0,  },
> +		{ "nios2",	MACH_NIOS2,	32, },
>  		{ "powerpc",	MACH_PPC32,	0,  },
>  		{ "ppc",	MACH_PPC32,	0,  },
>  		{ "riscv",	MACH_RISCV32,	0,  },
> diff --git a/target.h b/target.h
> index 1202c0be1ac9..4c184d8f2fbe 100644
> --- a/target.h
> +++ b/target.h
> @@ -85,6 +85,7 @@ extern const struct target target_arm64;
>  extern const struct target target_m68k;
>  extern const struct target target_mips32;
>  extern const struct target target_mips64;
> +extern const struct target target_nios2;
>  extern const struct target target_ppc32;
>  extern const struct target target_ppc64;
>  extern const struct target target_riscv32;
> 
