Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE5DC433ED
	for <linux-sparse@archiver.kernel.org>; Sun, 11 Apr 2021 20:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505746105A
	for <linux-sparse@archiver.kernel.org>; Sun, 11 Apr 2021 20:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbhDKUsL (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 11 Apr 2021 16:48:11 -0400
Received: from avasout03.plus.net ([84.93.230.244]:45112 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236537AbhDKUsK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 11 Apr 2021 16:48:10 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Apr 2021 16:48:10 EDT
Received: from [10.0.2.15] ([195.213.6.1])
        by smtp with ESMTPA
        id VgsVlxw8CutR5VgsWlEF3p; Sun, 11 Apr 2021 21:40:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1618173621; bh=eGYY2wicCp98zmyvOorvXzH4HDdwbvAmjILJT2AV9+o=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=PbJMn07kdLpqgmwZWq3kAq+UfwXRHfyGnOlfi0EjcMpPgsge9kd74SMpdWyKVIQVx
         SGuZRzulkSIB2AwdzNzHGagvheg3W8gO7ChXyJYcCrxfF4Cp7OlgQiunLH8tg/mAP8
         43/q7lgI3SxJzqqFuti+vxbf2/Xu4s7WsDVXNhFF1vTpUgmLG1GWgB41cllMfb0gAL
         FO6GQidVr7FaLJipm8JdRrnYPjK76+1+jnyOR69UjyKHts4AfDNQR+l8YxvjG7Anuo
         5W3V+FWM+awn/yTBuA12N10NyCWX5rpxZMXAvc2uULMw2H6yCVf2w0v9JBaA/g0jWw
         0BiaWo/NGy8Iw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=KZJJTTQD c=1 sm=1 tr=0
 a=v1fZ9eGmBRQ2oAddCs0ezw==:117 a=v1fZ9eGmBRQ2oAddCs0ezw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=Q4RKnxTo-t2DafZ9oyEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/8] builtin: define a symbol_op for a generic op acting
 on integer
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20210410133045.53189-1-luc.vanoostenryck@gmail.com>
 <20210410133045.53189-3-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <9bca36d1-b84a-7b6f-37cb-fd5285a86f0f@ramsayjones.plus.com>
Date:   Sun, 11 Apr 2021 21:40:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210410133045.53189-3-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfH9ZORlBtjFUVw3D7Y4B+9dBeZOmCcXkuP4XbC/zCybng/3Un65JZid2SwmchcouLX0s+SjoyOdpOZ/raYXeZsB1aX0lBZFD8ubjRz7TGkZR3TiyreMN
 YDXe4YRU+NJuQCIt1Qs9yY0GT0wIko8Uwfyx4XiCRdNUT3gUbYIPhZS9NsTQU0HzCVAJU9I/2N5+lg==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 10/04/2021 14:30, Luc Van Oostenryck wrote:
> This can be used to define some generic (polymorphic) builtin
> with a signature like:
> 	op(T)
> 	op(T, T)
> 	op(T,T, ... T)
> where T is some integer type.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  builtin.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  builtin.h |  2 ++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/builtin.c b/builtin.c
> index ff03dbab9a06..f03bf109c818 100644
> --- a/builtin.c
> +++ b/builtin.c
> @@ -390,6 +390,56 @@ static struct symbol_op overflow_p_op = {
>  };
>  

I must apologize in advance, I've got a head cold, I'm tired and
should probably not be commenting (especially since I am only
skimming these patches), but ...

>  
> +///
> +// Evaluate the arguments of 'generic' integer operators.
> +//
> +// All arguments must be the same basic integer type and
> +// their number comes from the prototype and is already checked.
> +static int evaluate_generic_int_op(struct expression *expr)
> +{
> +	struct symbol *fntype = expr->fn->ctype->ctype.base_type;
> +	struct symbol_list *types = NULL;
> +	struct symbol *ctype = NULL;
> +	struct expression *arg;
> +	struct symbol *t;
> +	int n = 0;
> +
> +	PREPARE_PTR_LIST(fntype->arguments, t);

So, t is used to iterate over the 'fntype->arguments' (which is to say
the generic type T), ...

> +	FOR_EACH_PTR(expr->args, arg) {
> +		struct symbol *type;
> +
> +		if (++n == 1) {
> +			t = arg->ctype;

which is then set to the first argument type, here ...

> +			if (!arg || !(type = arg->ctype))
> +				return 0;
> +			if (type->type == SYM_NODE)
> +				type = type->ctype.base_type;
> +			if (!type)
> +				return 0;
> +			if (type->ctype.base_type != &int_type || type == &bool_ctype)
> +				goto err;
> +		} else {
> +			t = ctype;

... and thereafter (for 2, 3, ...) to NULL. (ctype is not set to anything
and it is initialized to NULL above).

> +		}
> +		add_ptr_list(&types, t);

... so this 'types' list is just {arg->ctype, NULL, NULL, ...}

> +		NEXT_PTR_LIST(t);
> +	} END_FOR_EACH_PTR(arg);
> +	FINISH_PTR_LIST(t);
> +	return evaluate_arguments(types, expr->args);
> +
> +err:
> +	sparse_error(arg->pos, "non-integer type for argument %d:", n);

here, n will only ever be 1, right? (only way to get here, via goto, from
the n == 1 conditional, above).

> +	info(arg->pos, "        %s", show_typename(arg->ctype));
> +	expr->ctype = &bad_ctype;
> +	return 0;
> +}

I stopped reading here. (I probably should have stopped sooner! ;).

ATB,
Ramsay Jones

> +
> +struct symbol_op generic_int_op = {
> +	.args = args_prototype,
> +	.evaluate = evaluate_generic_int_op,
> +};
> +
> +
>  static int eval_atomic_common(struct expression *expr)
>  {
>  	struct symbol *fntype = expr->fn->ctype->ctype.base_type;
> diff --git a/builtin.h b/builtin.h
> index 9cb6728444fe..5fe77c926244 100644
> --- a/builtin.h
> +++ b/builtin.h
> @@ -14,4 +14,6 @@ struct builtin_fn {
>  
>  void declare_builtins(int stream, const struct builtin_fn tbl[]);
>  
> +extern struct symbol_op generic_int_op;
> +
>  #endif
> 
