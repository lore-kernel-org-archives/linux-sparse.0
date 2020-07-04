From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 2/3] add memory asm constraint for PPC
Date: Sat, 4 Jul 2020 18:44:53 +0100
Message-ID: <693a3fa0-5202-3695-54cf-aa1cc1f514fd@ramsayjones.plus.com>
References: <20200704135747.87752-1-luc.vanoostenryck@gmail.com>
 <20200704135747.87752-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout04.plus.net ([212.159.14.19]:45145 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDRo4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 4 Jul 2020 13:44:56 -0400
In-Reply-To: <20200704135747.87752-3-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org


Hi Luc,

All of the patches in this series look good to me! ;-)

(I have been following all patches on the list, I just
haven't had anything to say about them - which is a good thing!)

On 04/07/2020 14:57, Luc Van Oostenryck wrote:
> The 'Z' asm constraint is used for doing IO accessors on PPC but
> isn't part of the 'common constraints'. It's responsible for
> more than half of all warnings (with defconfig + allyesconfig).

Not a problem, but this made me think 'half of which warnings'. :-D
I assume, but it's just a guess, this means 'half of all asm-constraints
warnings on the kernel PPC build'.

How many warnings is that? What percentage is that of _all_ sparse
warnings on a typical kernel build?

Thanks!

[BTW, I also noticed the (long running) 'luc/options' branch, which
looks like it could prove to be a nice cleanup - I've only read the
commit messages, not the actual commits.]

ATB,
Ramsay Jones

> 
> Fix this by handling this constraint in a specific method for PPC.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  target-ppc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/target-ppc.c b/target-ppc.c
> index b138635b9103..c0d6068f436a 100644
> --- a/target-ppc.c
> +++ b/target-ppc.c
> @@ -1,6 +1,7 @@
>  #include "symbol.h"
>  #include "target.h"
>  #include "machine.h"
> +#include "expression.h"
>  
>  
>  static void predefine_ppc(const struct target *self)
> @@ -15,6 +16,16 @@ static void predefine_ppc(const struct target *self)
>  		predefine("_BIG_ENDIAN", 1, "1");
>  }
>  
> +static const char *asm_constraint_ppc(struct asm_operand *op, int c, const char *str)
> +{
> +	switch (c) {
> +	case 'Z':
> +		op->is_memory = true;
> +		break;
> +	}
> +	return str;
> +}
> +
>  
>  static void predefine_ppc32(const struct target *self)
>  {
> @@ -32,6 +43,7 @@ const struct target target_ppc32 = {
>  	.target_64bit = &target_ppc64,
>  
>  	.predefine = predefine_ppc32,
> +	.asm_constraint = asm_constraint_ppc,
>  };
>  
>  
> @@ -55,4 +67,5 @@ const struct target target_ppc64 = {
>  	.target_32bit = &target_ppc32,
>  
>  	.predefine = predefine_ppc64,
> +	.asm_constraint = asm_constraint_ppc,
>  };
> 
