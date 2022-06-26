Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363B2C433EF
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 14:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiFZOpG (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 10:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFZOpG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 10:45:06 -0400
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139ADDFD4
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 07:45:04 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 5TVWoIKl0uTE05TVXoJcjM; Sun, 26 Jun 2022 15:45:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1656254703; bh=7v7igrLej4K+RuFhE2L7CurppLRTrsGNeKHJc62Rgfs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=aY0Sid37j9aW7u2LTy3Uz9od7iOXx9AhDfHT25vnuJ0hdSa1F4GbLW8qJy+zAV+gl
         nIfpaQRJ8AnAYf7Oqyez6sHkKMPO4EgoXrvi/wuv9KmvVB9svA+/EuE/KYMo5s/VfY
         fpIuLDAgXU3rozlnwbNxJNxTE9A2rXVIHMEcyt0LRk4ij6GBcGOenA4u4SOhACakUf
         4YPdqvkyFYnb7UQgsKrUcucaa/vAUwvCjyudwWol9TlPXxuZvWm7nAIw8ji1jD/AXD
         jY8LcyJ9QNSmO2aiGf7LS8ypKa1cje8B5vWsvD1s9Tvssc+zP33u5UZJ7+IpfcnN9m
         1wOcKuALjyNuQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=DfIEF9hW c=1 sm=1 tr=0 ts=62b870ef
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=7W-vtjp4sT3u5N9D4xEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <a401f72d-7ac4-76d0-3c19-f26f9cfb9e6e@ramsayjones.plus.com>
Date:   Sun, 26 Jun 2022 15:45:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/6] inline: avoid needless intermediate vars
Content-Language: en-GB
To:     Luc Van Oostenryck <lucvoo@kernel.org>,
        linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20220626130748.74163-1-lucvoo@kernel.org>
 <20220626130748.74163-5-lucvoo@kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20220626130748.74163-5-lucvoo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAQ7IjTfzcnIGBTveL8r9WCzre62LRemUs3rj/GXamxbDtJISfUJPcY8+L6+5ClMXJ0Z3TL4Vdz6IRX+R9JdfyQ8CQwWizXQI3SUrQRBnHHbnDMQwS3S
 GH0/ICIUjvgYvdhM5Z1LdP4XhGn1vHY6AIoYPyw0srfGUpQJMVTvBl394hIXm2M5hBDpxHFZoCUXcaOJT8XTvoV7QNFyF78j+UE=
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 26/06/2022 14:07, Luc Van Oostenryck wrote:
> From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> In inline_function(), the we need to iterate over the parameters

s/the we/we/


ATB,
Ramsay Jones

> and the (effective) arguments. An itermediate variable is used for
> each: "name_list" and "arg_list".
> 
> These confuse me a lot (especially "name_list", "param_list" would
> be much more OK) and are just used once.
> 
> So, avoid using an intermediate variable for these.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  inline.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/inline.c b/inline.c
> index 4696eb509f9a..a6f9252ab0ff 100644
> --- a/inline.c
> +++ b/inline.c
> @@ -516,9 +516,8 @@ int inline_function(struct expression *expr, struct symbol *sym)
>  {
>  	struct symbol_list * fn_symbol_list;
>  	struct symbol *fn = sym->ctype.base_type;
> -	struct expression_list *arg_list = expr->args;
>  	struct statement *stmt = alloc_statement(expr->pos, STMT_COMPOUND);
> -	struct symbol_list *name_list, *arg_decl;
> +	struct symbol_list *arg_decl;
>  	struct symbol *name;
>  	struct expression *arg;
>  
> @@ -529,8 +528,6 @@ int inline_function(struct expression *expr, struct symbol *sym)
>  	if (fn->expanding)
>  		return 0;
>  
> -	name_list = fn->arguments;
> -
>  	expr->type = EXPR_STATEMENT;
>  	expr->statement = stmt;
>  	expr->ctype = fn->ctype.base_type;
> @@ -538,8 +535,8 @@ int inline_function(struct expression *expr, struct symbol *sym)
>  	fn_symbol_list = create_symbol_list(sym->inline_symbol_list);
>  
>  	arg_decl = NULL;
> -	PREPARE_PTR_LIST(name_list, name);
> -	FOR_EACH_PTR(arg_list, arg) {
> +	PREPARE_PTR_LIST(fn->arguments, name);
> +	FOR_EACH_PTR(expr->args, arg) {
>  		struct symbol *a = alloc_symbol(arg->pos, SYM_NODE);
>  
>  		if (name) {
