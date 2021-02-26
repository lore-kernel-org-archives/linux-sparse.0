Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05799C433E0
	for <linux-sparse@archiver.kernel.org>; Fri, 26 Feb 2021 23:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B986364F0D
	for <linux-sparse@archiver.kernel.org>; Fri, 26 Feb 2021 23:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBZXri (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 26 Feb 2021 18:47:38 -0500
Received: from avasout03.plus.net ([84.93.230.244]:48745 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhBZXrh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 26 Feb 2021 18:47:37 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id Fmorl8axUEfgXFmotlx06s; Fri, 26 Feb 2021 23:46:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1614383211; bh=2OK+9goV+HGnOJIokVc4z6VccLjZE+Eta1Vs5p2r6zw=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=ZAjy4OFQK24zeaonGhWhxJSiPZ0JoCX1JX00DNNyt+NR6chSW5NdANcCNlWqvdLvP
         2V/L8uHxfyKUBCH7H2lre8+pDn975fS0AS4l+nuK7Uk4NQiRmWV9SwXmB9PDkSyZIq
         sLykg8NzUezq2IPIQ0uMpS92ZdT9tjLP5iDKxje/cg7Ib3aLSoGrgp56fm3MMJv3hE
         31OkfdZSmd4zBOM7fBdKwLd6IKnJ+0NZgHelbuOxIb5hN08ZAAQiWJemfH2dKw3ZGr
         zYZASqwka2VYS7/ZG9iHWtyyQwzt2sdYJpemERj0Bewoqdlf/NCZZoPhofyKtiN6GU
         LtgSax1c5c/Sg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=WomwzeXv c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=BvsfWK9VvvrgyxQ2MUkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/4] slice: remove unneeded len from OP_SLICE
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
 <20210225233908.97275-2-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <558d59c7-ca74-706e-e1a6-68a15f6fc43a@ramsayjones.plus.com>
Date:   Fri, 26 Feb 2021 23:46:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210225233908.97275-2-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGBb/wR32mVUX0OslR5FSRnQe6LYfgt/sPBNRcLwM0Xc8GH77hClOqC9xMhRryDOstj1dEHAj3R1Yd4AWIbPKiK8TbyREtcjy1XkFcvU23qCmZbh8YBH
 HEFFe0ZGtIJ+xw8FP6PCoJzC/bn+gJwo8gomcG1u4kZL4+ZP5Qs3QlhlSrx6OkxkwgXY6F5mHz8k+w==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 25/02/2021 23:39, Luc Van Oostenryck wrote:
> OP_SLICE::len is necessarily equal to the result size.
> So remove this redundancy.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Documentation/IR.rst | 2 +-
>  linearize.c          | 3 +--
>  linearize.h          | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/IR.rst b/Documentation/IR.rst
> index 38df84ff3954..c7db32073361 100644
> --- a/Documentation/IR.rst
> +++ b/Documentation/IR.rst
> @@ -408,7 +408,7 @@ Others
>  	Extract a "slice" from an aggregate.
>  
>  	* .base: (pseudo_t) aggregate (alias .src)
> -	* .from, .len: offet & size of the "slice" within the aggregate
> +	* .from: offet of the "slice" within the aggregate

s/offet/offset/

ATB,
Ramsay Jones

>  	* .target: result
>  	* .type: type of .target
>  
> diff --git a/linearize.c b/linearize.c
> index 0c9b0e59cc4b..96a717bc2909 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -470,7 +470,7 @@ const char *show_instruction(struct instruction *insn)
>  		break;
>  
>  	case OP_SLICE:
> -		buf += sprintf(buf, "%s <- %s, %d, %d", show_pseudo(insn->target), show_pseudo(insn->base), insn->from, insn->len);
> +		buf += sprintf(buf, "%s <- %s, %d", show_pseudo(insn->target), show_pseudo(insn->base), insn->from);
>  		break;
>  
>  	case OP_NOT: case OP_NEG:
> @@ -1239,7 +1239,6 @@ static pseudo_t linearize_slice(struct entrypoint *ep, struct expression *expr)
>  
>  	insn->target = new;
>  	insn->from = expr->r_bitpos;
> -	insn->len = expr->r_nrbits;
>  	use_pseudo(insn, pre, &insn->base);
>  	add_one_insn(ep, insn);
>  	return new;
> diff --git a/linearize.h b/linearize.h
> index cf0cf066a8e5..4d83675caaf1 100644
> --- a/linearize.h
> +++ b/linearize.h
> @@ -129,7 +129,7 @@ struct instruction {
>  		};
>  		struct /* slice */ {
>  			pseudo_t base;
> -			unsigned from, len;
> +			unsigned from;
>  		};
>  		struct /* setval */ {
>  			struct expression *val;
> 
