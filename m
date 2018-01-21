From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] sparse: option to print compound global data symbol info
Date: Sun, 21 Jan 2018 05:27:03 +0100
Message-ID: <20180121042702.sinboahtsdngkojv@ltop.local>
References: <80f9f805-fb35-65d6-4a86-ebe0b740fe58@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38252 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbeAUE1H (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 20 Jan 2018 23:27:07 -0500
Received: by mail-wm0-f43.google.com with SMTP id 141so10559639wme.3
        for <linux-sparse@vger.kernel.org>; Sat, 20 Jan 2018 20:27:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <80f9f805-fb35-65d6-4a86-ebe0b740fe58@infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Sat, Jan 20, 2018 at 07:36:24PM -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> with help from Linus. (many moons ago)
> 
> sparse addition to print all compound/composite global data symbols
> with their sizes and alignment.
> 
> usage: -list-symbols
> Example: (in kernel tree)
>   make C=2 CF="-list-symbols" arch/x86_64/kernel/smpboot.o
>   arch/x86/kernel/smpboot.c:99:1: struct cpuinfo_x86 [addressable] [noderef] [toplevel] <asn:3>cpu_info: compound size 240, alignment 8

If this only lists compound symbols, it seems a bit strange to me
to use '-list-symbols' as the option name. Maybe you could go one
step further an have '-list-symbols=compound' and if needed it can
be extended to '-list-symbols=all'.

> --- orig/sparse.c
> +++ next/sparse.c
> @@ -36,6 +36,7 @@
>  #include "allocate.h"
>  #include "token.h"
>  #include "parse.h"
> +#include "ptrlist.h"

Not really needed as it's already included indirectly but it
won't hurt, of course.

> +extern int list_symbols;

Not needed since already declared in lib.h.

> +static void list_all_symbols(struct symbol_list *list)
> +{
> +	struct symbol *sym;
> +
> +	FOR_EACH_PTR(list, sym) {
> +		/* Only show arrays, structures, unions, enums, & typedefs */
> +		if (!(sym->namespace & (NS_STRUCT | NS_TYPEDEF | NS_SYMBOL)))
> +			continue;
> +		/* Only show types we actually examined (ie used) */
> +		if (!sym->bit_size)
> +			continue;

Even after being examined, 'bit_size' can stay zero if there is
some errors. You can directly use 'if (!sym->examined)' if you
want but I think it's better to adjust the comment.

> +		if (sym->type == SYM_FN || sym->type == SYM_ENUM)
> +			continue;
> +		if (!sym->ctype.base_type)
> +			continue;
> +		if (sym->ctype.base_type->type == SYM_FN)
> +			continue;
> +		if (sym->ctype.base_type->type == SYM_ENUM)
> +			continue;
> +		if (sym->ctype.base_type->type == SYM_BASETYPE)
> +			continue;

It's a bit dangereous here. You should check for SYM_NODE.
I also think it would be better and simpler to use the helpers
is_func_type(), is_int_type(), ... or add is_compound_type().

> +		/* Don't show unnamed types */
> +		if (!sym->ident)
> +			continue;
> +		info(sym->pos, "%s: compound size %u, alignment %lu",
> +			show_typename(sym),
> +			sym->bit_size >> 3,

bits_to_bytes() should be used here.


Regards,
Luc Van Oostenryck
