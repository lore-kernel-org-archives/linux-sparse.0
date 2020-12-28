Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39B1C433E6
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29E4223E8
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 16:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgL1QzT (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 11:55:19 -0500
Received: from avasout06.plus.net ([212.159.14.18]:60445 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbgL1QzS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 11:55:18 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id tvmwkPfv0hO4HtvmxkCurs; Mon, 28 Dec 2020 16:54:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609174471; bh=HvVgluMByYysE6StWE1biSvSOKJ6CLJ/PHtx981axi8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=kwdXKHNhm50iUGtjRs1HAhplJayEfOC8tYadJjF05SsiMTq6TEt/7P1WinZxrWThd
         XfveGHS2xWAKIHFj04k9WssKCchUe0Zv6KGsRXeZtxYOD8yWfOV9A8cStxvYN7hDwN
         BtZKtRbq0tEpmWdfIbNPL0xNRbQ0OiKSNR/KCtfn9e+GNUU6M5Y0TZGkqxLIdmKc6u
         Y9iccfCXFQxouJf4QDIJLJKp2ANUaIKUOzI6MRUCowS4dRSOy9W7R7JoblXVEuB6zS
         bXTg8hz2kHgTULCVbJ5/vSA4z9MGBjjDGJsViQLO7eKkIm/b3OJxVp219qZQ7//Z9M
         6z7a6eFQrNZWw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=8vK1M8yhuMJp1CfKBPMA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 10/16] struct-attr: prepare to handle attributes at the
 end of struct definitions (1)
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Jacob Keller <jacob.e.keller@intel.com>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-11-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <d15f0dbe-4645-6050-f995-7c815e86f8c0@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 16:54:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201226175129.9621-11-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLXGGn2Ar7X5FdK0fg+K91kxmCnExDnAj/CNYNbr/DyZcR7KM3zv9YypT61xBtegb2Vz/M0yDeruGqrcXabRhTkAS4VirQ+o31jbmYfvxdqO4JuuFckL
 hkYvuvpULWQRKBWA/WZbb2dTyiHI15zGnlgINuAu5NyQ/nWKJzwhm10iewSMhzMMGbmT9FIJcFek1A==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> Type attributes for struct can be placed either just after the
> keyword 'struct' or after the '}' ending its definition but this
> later case is currently ignored.
> 
> Prepare the handling of this by factoring the code common to both
> cases in a single place.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  parse.c                        | 11 +++++------
>  validation/parsing/enum-attr.c |  4 ++--
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/parse.c b/parse.c
> index d6343f0e48bf..99d810910dab 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -745,12 +745,7 @@ static struct token *struct_union_enum_specifier(enum type type,
>  			if (sym->symbol_list)
>  				error_die(token->pos, "redefinition of %s", show_typename (sym));
>  			sym->pos = *repos;
> -			token = parse(token->next, sym);
> -			token = expect(token, '}', "at end of struct-union-enum-specifier");
> -
> -			// Mark the structure as needing re-examination
> -			sym->examined = 0;
> -			sym->endpos = token->pos;
> +			goto end;
>  		}
>  		return token;
>  	}
> @@ -763,10 +758,14 @@ static struct token *struct_union_enum_specifier(enum type type,
>  	}
>  
>  	sym = alloc_symbol(token->pos, type);
> +end:
>  	set_current_scope(sym);		// used by dissect
>  	token = parse(token->next, sym);
>  	ctx->ctype.base_type = sym;
>  	token =  expect(token, '}', "at end of specifier");
> +
> +	// Mark the structure as needing re-examination
> +	sym->examined = 0;
>  	sym->endpos = token->pos;

Hmm, this is not a simple 1:1 code movement.
Is the 'set_current_scope(sym);' or 'ctx->ctype.base_type = sym;'
relevant to this change? It is not mentioned in the commit
message (and I can't tell just looking at the patch text).

ATB,
Ramsay Jones

>  
>  	return token;
> diff --git a/validation/parsing/enum-attr.c b/validation/parsing/enum-attr.c
> index a962d8b417af..8d851a162135 100644
> --- a/validation/parsing/enum-attr.c
> +++ b/validation/parsing/enum-attr.c
> @@ -21,9 +21,9 @@ enum bad {
>  parsing/enum-attr.c:10:15: error: typename in expression
>  parsing/enum-attr.c:10:15: error: undefined identifier '__attribute__'
>  parsing/enum-attr.c:10:15: error: bad constant expression type
> -parsing/enum-attr.c:10:22: error: Expected } at end of struct-union-enum-specifier
> +parsing/enum-attr.c:10:22: error: Expected } at end of specifier
>  parsing/enum-attr.c:10:22: error: got 33
> -parsing/enum-attr.c:14:18: error: Expected } at end of struct-union-enum-specifier
> +parsing/enum-attr.c:14:18: error: Expected } at end of specifier
>  parsing/enum-attr.c:14:18: error: got __attribute__
>   * check-error-end
>   */
> 
