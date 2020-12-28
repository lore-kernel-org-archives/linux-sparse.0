Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D37C433E0
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 17:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E7482245C
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 17:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgL1RKt (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 12:10:49 -0500
Received: from avasout06.plus.net ([212.159.14.18]:33255 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgL1RKs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 12:10:48 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id tw1wkPguBhO4Htw1ykCvIh; Mon, 28 Dec 2020 17:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609175402; bh=qRz0l73efR0K/bauvJ6hClDKkSLIqT+mv9t9KIrsaOY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RqrW1DDu+I7Eyo4NkCsPc8iDBkeTd17pHwinl2tjJNzADuKswxzm5RRpFASJgRbY3
         H+lffe3Unye1Royptq4v5CKCIchLfVptQxxYNLFmxrGqyHryuFbpLaUEmx5IvQlX1x
         a7V94zu4M0gXLzDo0a/VKbCKsq6o+Of5BjpBAGR5oqdnIA6pTxr1ejpF7GYLviUbfn
         o1CDuf7B9VY+wF6VBIeBYryljk8SBPy3khZgB9fmG4ykBHXUxSnG3tO4XoaKXMGwT7
         pssInS7yTSR1+7/ATn1zZnfksW5mZi3OSXidIVd/8XM8HiKW/jtWCGG+C32LbYf0rY
         9VEEt+us42Wjw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=ZdErM9xfrX9WmjcBptkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 15/16] packed: no out-of-bound access of packed
 bitfields
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-16-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <09c3a7d2-7787-e7af-53ff-089312f3fd50@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 17:10:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201226175129.9621-16-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC84JfG4iFDDNgF14dRG3oyG0aMJyzgPI+s97IqwW5uNXc7F1MbYRifSgr6DavtTbW4693n+N1PsP0a71ujWQmtTfFpQlTKMMJtX2+EGTgpNQF5KJE8d
 7qiVZ8vrUn37Tj9UW06vZTkol+cqG6DIu2SA72URD17Wox/Fl7MO6angxJ7RcD3HNCmQ0Sl+tExt0Q==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> There is (at least) 2 ways by which packed bitfields doesn't
> follow normal layout/access rules and as consequence can't (always)
> be accessed the usual way (load the whole underlying word, then shift
> and mask to isolate the bitfield).
> 
> At least two different cases are a concern:
> 1) there is no padding at the end of a bitfield sequence. For example,
>    the following struct is only 3 bytes width:
> 	struct s {
> 		int f:24;
> 	} __packed;
>    So, trying to access the bitfield by first doing a 32-bit load
>    will create an out-of-bound access.
> 
> 2) a bitfield smaller than one word may need more than one word to be
>    accessed. For example, with the following struct
> 	struct {
> 		int a:5;
> 		int f:30;
> 		int z:5;
> 	} __packed;
>    the bitfield 'f', while smaller than one 32-bit word, can't be accessed
>    with a single 32-bit access.
> 
> At machine level, these bitfields should be accessed with several, possibly
> smaller, loads and their corresponding values reconstructed form these,

s/form/from/

> making things much more complicated than for non-packed bitfields.
> 
> But at IR level, things can be a little more flexible and things can stay
> simple by using sub-word or super-word accesses (until these need to
> be lowered to be usable at machine level). In other words, the example here
> can be safely accessed with respectively a 24-bit and a 40-bit load.
> This is what is done in this patch.

Hmm, I didn't know the IR could represent this! ;-)
Is the 'lowering' code already present? Maybe next patch.

ATB,
Ramsay Jones

> ---
>  linearize.c | 13 +++++++++++--
>  symbol.h    |  1 +
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/linearize.c b/linearize.c
> index 0250c6bb17ef..e80715ab2458 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -977,8 +977,17 @@ static struct symbol *bitfield_base_type(struct symbol *sym)
>  	if (sym) {
>  		if (sym->type == SYM_NODE)
>  			base = base->ctype.base_type;
> -		if (base->type == SYM_BITFIELD)
> -			return base->ctype.base_type;
> +		if (base->type == SYM_BITFIELD) {
> +			base = base->ctype.base_type;
> +			if (sym->packed) {
> +				int size = bits_to_bytes(sym->bit_offset + sym->bit_size);
> +				sym = __alloc_symbol(0);
> +				*sym = *base;
> +				sym->bit_size = bytes_to_bits(size);
> +				return sym;
> +			}
> +			return base;
> +		}
>  	}
>  	return sym;
>  }
> diff --git a/symbol.h b/symbol.h
> index 5c5a7f12affa..866d57522f49 100644
> --- a/symbol.h
> +++ b/symbol.h
> @@ -192,6 +192,7 @@ struct symbol {
>  					accessed:1,
>  					builtin:1,
>  					torename:1,
> +					packed:1,
>  					transparent_union:1;
>  			int		rank:3;	// arithmetic's rank
>  			struct expression *array_size;
> 
