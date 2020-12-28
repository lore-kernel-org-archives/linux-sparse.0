Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24B5C4332B
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CA8C20659
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441735AbgL1Qru (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 11:47:50 -0500
Received: from avasout06.plus.net ([212.159.14.18]:59994 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730001AbgL1Qrt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 11:47:49 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id tvfhkPfKahO4HtvfikCua6; Mon, 28 Dec 2020 16:47:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609174022; bh=34Fa3l6Nm/JvH5Uqm7025u+jg6ieOV7BWY7+nAri8MI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=n6EVijsqrV2D6iK6JyKAGUnG93fFB+AyEM1+qTB5ufv/CphMSWEzeRIRd/P1LdLA1
         GqtV4kGbYUZkjfaWjsDnudqF4oQKs5zZoQBYmBavpv6/u5Scw8iTX11DlAQADa8eRk
         A4hILtFEKCPxnV4T6Mof9GUidaOXuZsYBgI81XEES7DE7CBcuW5j+SrRi9n/LW8NXs
         G08KoTiqY5McKHTxH/N96BcwmKYeSxqHxv4KSw4azq6jja4nsWSQXHTc3l+0+SS9KK
         /AOl/byUAmRqktHSk15qWFci5bXu9kfcL+b67jZvXlXmZfcUP1F0H3aXKuUyH3QejG
         /ClDZ+oVqYGbg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=CDs8lwEEnlRZMw7_yhgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 08/16] apply_ctype: reverse the order of arguments
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-9-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3be177c7-b744-2d79-7f9b-935bc22b3db9@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 16:47:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201226175129.9621-9-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOWE2u1Gv4JVA8IM66BhB8kYZ0DloEgp114o8ktdSj7Vnvy+zSkxCFnZ4etOdOp8LB7e2+GbZi2Hvm48IzKoCxjal8AI3HLq/hZur2KQyaFG+as8oSvH
 ztUMbOeKZO9BLLjtRkHUNTNdiGgoClSNZvMQtXC5k80espqmeCcTPtyhGrA+oqtMhTc8epunO3RH6A==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> apply_ctype()'s argument order is: src, dst (so the reading
> direction) but the assignment/memcpy() order is much more used:
> 	dst = src;
> 	memcpy(dst, src, n);
> than the order here is confusing.
> 
> So, change its argument order to comply with the memcpy()/
> assignement order and stop the confusion.

Hmm, how about:

"""
apply_ctype()'s argument order is 'src' then 'dst', which reads as
copying 'src' to 'dst'. However, assignment, and many library functions
(eg. memcpy()), use the opposite order for the source and destination
of a copy operation.

So, change the argument order of apply_ctype() to mimic the order of
memcpy()/assignment, to hopefully reduce any potential confusion.
"""

Heh, well that is probably not much better! ;-)

However, what about the (er...) position of the 'pos' argument?
Should it move to the end?

ATB,
Ramsay Jones

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  parse.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/parse.c b/parse.c
> index 402214212d77..f106444f75d8 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -1043,7 +1043,7 @@ static struct token *enum_specifier(struct token *token, struct symbol *sym, str
>  	return ret;
>  }
>  
> -static void apply_ctype(struct position pos, struct ctype *src, struct ctype *dst);
> +static void apply_ctype(struct position pos, struct ctype *dst, struct ctype *src);
>  
>  static struct token *typeof_specifier(struct token *token, struct symbol *sym, struct decl_state *ctx)
>  {
> @@ -1056,7 +1056,7 @@ static struct token *typeof_specifier(struct token *token, struct symbol *sym, s
>  		struct symbol *sym;
>  		token = typename(token->next, &sym, NULL);
>  		ctx->ctype.base_type = sym->ctype.base_type;
> -		apply_ctype(token->pos, &sym->ctype, &ctx->ctype);
> +		apply_ctype(token->pos, &ctx->ctype, &sym->ctype);
>  	} else {
>  		struct symbol *typeof_sym = alloc_symbol(token->pos, SYM_TYPEOF);
>  		token = parse_expression(token->next, &typeof_sym->initializer);
> @@ -1427,7 +1427,7 @@ static struct token *generic_qualifier(struct token *next, struct symbol *sym, s
>  	return next;
>  }
>  
> -static void apply_ctype(struct position pos, struct ctype *src, struct ctype *dst)
> +static void apply_ctype(struct position pos, struct ctype *dst, struct ctype *src)
>  {
>  	unsigned long mod = src->modifiers;
>  
> @@ -1529,7 +1529,7 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
>  				break;
>  			seen |= Set_S | Set_T;
>  			ctx->ctype.base_type = s->ctype.base_type;
> -			apply_ctype(token->pos, &s->ctype, &ctx->ctype);
> +			apply_ctype(token->pos, &ctx->ctype, &s->ctype);
>  			token = token->next;
>  			continue;
>  		}
> 
