Return-Path: <SRS0=Dp15=DZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25EEC433E7
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Oct 2020 21:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C69922269
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Oct 2020 21:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="b36kignN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbgJRVja (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Oct 2020 17:39:30 -0400
Received: from avasout06.plus.net ([212.159.14.18]:58413 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJRVj3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Oct 2020 17:39:29 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Oct 2020 17:39:28 EDT
Received: from [10.0.2.15] ([80.189.83.91])
        by smtp with ESMTPA
        id UGHUkW6sIhO4HUGHVkZPSj; Sun, 18 Oct 2020 22:31:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1603056717; bh=MFOoTdXvbbXh15e12W70juDR2G6gM6DJYKhyYHtZxX4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=b36kignN+CFN0lruNA3eWva1Yws8FPE9k5MQNNZn/AZIo+QpHQSjzDNJnSDYcCPRy
         Ml4hR0F/L+9ckXv4dH9ToAWkl3+U4bl4mJLj2PB/dMN6QiLhsiizLyiT8KR2JppbEI
         sJUGCQj80g9kJqbcEXOnL714tMtZEbFNy6PfvJkn6EgO+a+dWOF8E8HX2dCLSvB1Ie
         8OMiureO2b2UOA8o5AsheExZFO9SuD9bEnY5mQY2kcHWDI2MruvsQ7nkbRUgnuINeH
         DtIDS2kHIPVs3DzfPMENVKjYShmBJGri5D1PyIW09G2ADPzyi/NuZK/fhRQVVobZfj
         jb6iPMUhXNknA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=A65RX4RczHRR0ayl1rpLXg==:117 a=A65RX4RczHRR0ayl1rpLXg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=gKqOCVmO3iT8eqyFGsYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 03/12] builtin: make eval_sync_compare_and_swap() more
 generic
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
 <20201017225633.53274-4-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <728b9b1a-600a-ee81-a2cb-16c684124d0e@ramsayjones.plus.com>
Date:   Sun, 18 Oct 2020 22:31:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201017225633.53274-4-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfOcE8WJeB+q3bRenA2DEBtO7+MpjNqH2TLK9n5BytkI0SxdxmMjSIadiRNsru3cyiY/7xb3wMrPBJdw/yv9dkRyeHmbqw7Cz5BrE7ZmxJLHaDnYj1SFi
 2UaO7WZ3ON5bZUZIPofjv3OWEPYMs1l139ooIPUYC8mj10ouiUkZdjo66GmhIWp/0GfodCATDpdINA==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 17/10/2020 23:56, Luc Van Oostenryck wrote:
> Most __sync_* or __atomic_* builtin functions have one or
> more arguments having its real type determined by the first
> argument: either the same type (a pointer to an integral type)
> or the type of the object it points to.
> 
> Currently, only __sync_{bool,val}_compare_and_swap() are handled
> but lots of very similar variants would be needed for the others.
> So, make it a generic function, able to handle all these builtins.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  builtin.c | 47 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 31 insertions(+), 16 deletions(-)
> 
> diff --git a/builtin.c b/builtin.c
> index 0d4cb12cca22..880dd54f647e 100644
> --- a/builtin.c
> +++ b/builtin.c
> @@ -31,6 +31,14 @@
>  #include "compat/bswap.h"
>  #include <stdarg.h>
>  
> +#define dyntype incomplete_ctype
> +static bool is_dynamic_type(struct symbol *t)
> +{
> +	if (t->type == SYM_NODE)
> +		t = t->ctype.base_type;
> +	return t == &dyntype;
> +}
> +
>  static int evaluate_to_int_const_expr(struct expression *expr)
>  {
>  	expr->ctype = &int_ctype;
> @@ -362,29 +370,32 @@ static struct symbol_op overflow_p_op = {
>  };
>  
>  
> -static int eval_sync_compare_and_swap(struct expression *expr)
> +static int eval_atomic_common(struct expression *expr)
>  {
> +	struct symbol *fntype = expr->fn->ctype->ctype.base_type;
>  	struct symbol_list *types = NULL;
>  	struct symbol *ctype = NULL;
> +	struct symbol *t;
>  	struct expression *arg;
>  	int n = 0;
>  
> -	/* the first arg is a pointer type; we'd already verified that */
> +	// The number of arguments have already be verified.
> +	// The first arg must be a pointer type to an integral type.

s/pointer type to/pointer to/
(it just sounds odd, otherwise)
or maybe ... must be a 'pointer to an integral' type. ?

ATB,
Ramsay Jones

> +	PREPARE_PTR_LIST(fntype->arguments, t);
>  	FOR_EACH_PTR(expr->args, arg) {
> -		struct symbol *t = arg->ctype;
> +		struct symbol *ptrtype = NULL;
>  
> -		if (!t)
> -			return 0;
> -
> -		// 2nd & 3rd args must be a basic integer type or a pointer
> -		// 1st arg must be a pointer to such a type.
>  		if (++n == 1) {
> +			t = arg->ctype;
> +			if (!t)
> +				return 0;
>  			if (t->type == SYM_NODE)
>  				t = t->ctype.base_type;
>  			if (!t)
>  				return 0;
>  			if (t->type != SYM_PTR)
>  				goto err;
> +			ptrtype = t;
>  			t = t->ctype.base_type;
>  			if (!t)
>  				return 0;
> @@ -395,11 +406,14 @@ static int eval_sync_compare_and_swap(struct expression *expr)
>  			if (t->type != SYM_PTR && t->ctype.base_type != &int_type)
>  				goto err;
>  			ctype = t;
> -			add_ptr_list(&types, arg->ctype);
> -		} else {
> -			add_ptr_list(&types, ctype);
> +			t = ptrtype;
> +		} else if (is_dynamic_type(t)) {
> +			t = ctype;
>  		}
> +		add_ptr_list(&types, t);
> +		NEXT_PTR_LIST(t);
>  	} END_FOR_EACH_PTR(arg);
> +	FINISH_PTR_LIST(t);
>  
>  	if (!expr->ctype)	// __sync_val_compare_and_swap()
>  		expr->ctype = ctype;
> @@ -412,9 +426,9 @@ err:
>  	return 0;
>  }
>  
> -static struct symbol_op sync_compare_and_swap_op = {
> -	.args = args_triadic,
> -	.evaluate = eval_sync_compare_and_swap,
> +static struct symbol_op atomic_op = {
> +	.args = args_prototype,
> +	.evaluate = eval_atomic_common,
>  };
>  
>  
> @@ -464,6 +478,7 @@ static void declare_builtins(int stream, const struct builtin_fn tbl[])
>  static const struct builtin_fn builtins_common[] = {
>  #define size_t_ctype	&size_t_alias
>  #define va_list_ctype	&ptr_ctype
> +#define vol_ptr		&volatile_ptr_ctype
>  	{ "__builtin_choose_expr", NULL, 1, .op = &choose_op },
>  	{ "__builtin_constant_p", NULL, 1, .op = &constant_p_op },
>  	{ "__builtin_expect", &long_ctype, 0, { &long_ctype ,&long_ctype }, .op = &expect_op },
> @@ -614,7 +629,7 @@ static const struct builtin_fn builtins_common[] = {
>  
>  	{ "__sync_add_and_fetch", &int_ctype, 1, { &ptr_ctype }},
>  	{ "__sync_and_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> -	{ "__sync_bool_compare_and_swap", &bool_ctype, 1, { &ptr_ctype }, .op = &sync_compare_and_swap_op},
> +	{ "__sync_bool_compare_and_swap", &bool_ctype, 1, { vol_ptr, &dyntype, &dyntype }, .op = &atomic_op},
>  	{ "__sync_fetch_and_add", &int_ctype, 1, { &ptr_ctype }},
>  	{ "__sync_fetch_and_and", &int_ctype, 1, { &ptr_ctype }},
>  	{ "__sync_fetch_and_nand", &int_ctype, 1, { &ptr_ctype }},
> @@ -627,7 +642,7 @@ static const struct builtin_fn builtins_common[] = {
>  	{ "__sync_or_and_fetch", &int_ctype, 1, { &ptr_ctype }},
>  	{ "__sync_sub_and_fetch", &int_ctype, 1, { &ptr_ctype }},
>  	{ "__sync_synchronize", &void_ctype, 0 },
> -	{ "__sync_val_compare_and_swap", NULL, 1, { &ptr_ctype }, .op = &sync_compare_and_swap_op },
> +	{ "__sync_val_compare_and_swap", NULL, 1, { vol_ptr, &dyntype, &dyntype }, .op = &atomic_op },
>  	{ "__sync_xor_and_fetch", &int_ctype, 1, { &ptr_ctype }},
>  
>  	{ }
> 
