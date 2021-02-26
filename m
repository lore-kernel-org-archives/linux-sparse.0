Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EACC433E0
	for <linux-sparse@archiver.kernel.org>; Fri, 26 Feb 2021 23:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE0964F03
	for <linux-sparse@archiver.kernel.org>; Fri, 26 Feb 2021 23:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBZX5s (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 26 Feb 2021 18:57:48 -0500
Received: from avasout03.plus.net ([84.93.230.244]:49185 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBZX5r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 26 Feb 2021 18:57:47 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id Fmygl8bKeEfgXFmyhlx0AW; Fri, 26 Feb 2021 23:57:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1614383820; bh=vLZOt0J4Ip6//D92b8pqwG4x3kNe60jQA08BAkQ1UcQ=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Sbb9sxRkvOU5pGDbuvXSswcF2WpF0NNLBHLZzhR8SbZzgMCw+vcpYXqRfheT5045D
         TkpgqIotZ8V1QGWri7Qozm4YoTsm2V3OEhug8Z+FND8Duvb4eCFkWWY/In6st2ykTO
         156tetvMW4gI0DI6YkjjV2bELKRXmkBnz8N6m+0X89LdKOXm0EpUr9u034Rd3rbFgV
         jSBR/ij01twF6gd+s2wH2T/fHaZG4GDjfcjC1Tya0ixgw1M9n/hS2CsvRo5b7eBQx0
         q7phZbFdKz8vntgFNJ8728e0I/2vqFrIieqYeEJClkKiB15St9zlsAlAQoTy/tTowP
         eeVAnjkC2iaqQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=WomwzeXv c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=WRUKtI-64B4KGYDc1AYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/4] slice: OP_SLICE needs the source's type: make it a
 kind of unop
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
 <20210225233908.97275-4-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <bff5dc80-92cc-8bc0-2bd8-0e6f8f9f46a7@ramsayjones.plus.com>
Date:   Fri, 26 Feb 2021 23:56:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210225233908.97275-4-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOIbO2zHl8H4t73UtP1thKLvy4NR/5vn7JtMdaHO76DLebshwLOusQU1nr7MYjI02V42LiVnNkWqL9O64k/JU8B/Dg9Caq6jl+JZfDcxL9hUjboohVfX
 /NOB62ObG7R6bnvUTZcEP81/v/m1dZ3nIDTNwV94rRiuotbfQnouw9XA97cgE/V3G/szOA375c5xrw==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 25/02/2021 23:39, Luc Van Oostenryck wrote:
> OP_SLICE's source's type is needed for some simplifications.
> For example, in some cases it can be simplified into OP_TRUNC.
> 
> So, merge its representation with the one for unops which also
> need the source's type.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  linearize.c | 5 +++--
>  linearize.h | 5 +----
>  liveness.c  | 5 +----
>  3 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/linearize.c b/linearize.c
> index 96a717bc2909..7ab69d3ac968 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -470,7 +470,7 @@ const char *show_instruction(struct instruction *insn)
>  		break;
>  
>  	case OP_SLICE:
> -		buf += sprintf(buf, "%s <- %s, %d", show_pseudo(insn->target), show_pseudo(insn->base), insn->from);
> +		buf += sprintf(buf, "%s <- %s, %d", show_pseudo(insn->target), show_pseudo(insn->src), insn->from);
>  		break;
>  
>  	case OP_NOT: case OP_NEG:
> @@ -1239,7 +1239,8 @@ static pseudo_t linearize_slice(struct entrypoint *ep, struct expression *expr)
>  
>  	insn->target = new;
>  	insn->from = expr->r_bitpos;
> -	use_pseudo(insn, pre, &insn->base);
> +	insn->orig_type = expr->base->ctype;
> +	use_pseudo(insn, pre, &insn->src);
>  	add_one_insn(ep, insn);
>  	return new;
>  }
> diff --git a/linearize.h b/linearize.h
> index 4d83675caaf1..429f4797e359 100644
> --- a/linearize.h
> +++ b/linearize.h
> @@ -113,6 +113,7 @@ struct instruction {
>  		};
>  		struct /* unops */ {
>  			pseudo_t src;
> +			unsigned from;			/* slice */
>  			struct symbol *orig_type;	/* casts */
>  		};
>  		struct /* memops */ {
> @@ -127,10 +128,6 @@ struct instruction {
>  			pseudo_t _src1, _src2;		// alias .src[12]
>  			struct symbol *itype;		// input operands' type
>  		};
> -		struct /* slice */ {
> -			pseudo_t base;
> -			unsigned from;
> -		};
>  		struct /* setval */ {
>  			struct expression *val;
>  		};
> diff --git a/liveness.c b/liveness.c
> index 30a9a5b6b169..755509e59b52 100644
> --- a/liveness.c
> +++ b/liveness.c
> @@ -76,6 +76,7 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
>  	/* Uni */
>  	case OP_UNOP ... OP_UNOP_END:
>  	case OP_SYMADDR:
> +	case OP_SLICE:
>  		USES(src1); DEFINES(target);

wouldn't USES(src) be more appropriate? They are not binops.

ATB,
Ramsay Jones

>  		break;
>  
> @@ -121,10 +122,6 @@ static void track_instruction_usage(struct basic_block *bb, struct instruction *
>  		} END_FOR_EACH_PTR(pseudo);
>  		break;
>  
> -	case OP_SLICE:
> -		USES(base); DEFINES(target);
> -		break;
> -
>  	case OP_ASM:
>  		asm_liveness(bb, insn, def, use);
>  		break;
> 
