From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/3] memcpy()'s byte count is unsigned
Date: Fri, 2 Jun 2017 01:16:12 +0100
Message-ID: <18cc66e6-a4d8-2756-a356-a507b8a4bd14@ramsayjones.plus.com>
References: <84e547c2-8a5b-225c-1363-361e091821f4@ramsayjones.plus.com>
 <20170601202724.77597-1-luc.vanoostenryck@gmail.com>
 <20170601202724.77597-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout08.plus.net ([212.159.14.20]:52702 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdFBAQU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 20:16:20 -0400
In-Reply-To: <20170601202724.77597-2-luc.vanoostenryck@gmail.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
Cc: Chris Li <sparse@chrisli.org>, Junio C Hamano <gitster@pobox.com>



On 01/06/17 21:27, Luc Van Oostenryck wrote:
> The checker part of sparse does some checking on memcpy(),
> memset(), copy_{from,to}_user() byte count and warn if the
> value is known to be too large. The comparison is done with
> signed numbers and it also warns if the value is negative.
> 
> However these functions take an unsigned byte count (size_t)
> and so the value can't really be negative.

My patch wasn't as careful as this. (and I was too lazy to check
that the kernel functions took a size_t parameter).

Assuming all functions take a size_t parameter, looks good.

ATB,
Ramsay Jones

> 
> Additionaly, the number of bits used by sparse internally may not
> be the same as the one used for the target's size_t. So sparse's
> check against negative value may not be the same as checking if
> the target's value would be so-large-than-the-upper-bit-is-set.
> 
> Change this by removing the test for negative values and simply
> do an unsigned compare.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  sparse.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sparse.c b/sparse.c
> index 02ab97743..1cb90e20d 100644
> --- a/sparse.c
> +++ b/sparse.c
> @@ -152,9 +152,9 @@ static void check_byte_count(struct instruction *insn, pseudo_t count)
>  	if (!count)
>  		return;
>  	if (count->type == PSEUDO_VAL) {
> -		long long val = count->value;
> -		if (val <= 0 || val > 100000)
> -			warning(insn->pos, "%s with byte count of %lld",
> +		unsigned long long val = count->value;
> +		if (val > 100000ULL)
> +			warning(insn->pos, "%s with byte count of %llu",
>  				show_ident(insn->func->sym->ident), val);
>  		return;
>  	}
> 
