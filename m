Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD87AC433B4
	for <linux-sparse@archiver.kernel.org>; Tue, 13 Apr 2021 00:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDCE610CB
	for <linux-sparse@archiver.kernel.org>; Tue, 13 Apr 2021 00:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbhDMAXX (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 12 Apr 2021 20:23:23 -0400
Received: from avasout03.plus.net ([84.93.230.244]:35387 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhDMAXX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 12 Apr 2021 20:23:23 -0400
Received: from [10.0.2.15] ([195.213.6.1])
        by smtp with ESMTPA
        id W6pYlzwkcutR5W6pZlEkXm; Tue, 13 Apr 2021 01:23:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1618273383; bh=zUL5//E6UgjG+R8yrdValurqDceamoZRH9SgXKnXLhA=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=fd1dfqrFzL2qYZ97IlozhIKfT7IELRj3i2FZ463iPoFJ21U6f/j6hGXh+24TR0rS6
         GX6Se9YzTKpeKdehspCXKKYu3IGb9XI2iAQu2fEEGwJW9OUX9Qy02aJ38u571c8M45
         xDQBapsSUZ/EnRFaVRavPJmKv+WzRJDDThtPLUuHQDjK9ZN9Ppbs/uYKBu+SQYeO2W
         wFVoxzzZ/I5xo/YwXnnp/QAmexdDMvOlF/VbhGKFq7eet6I8y8/Jpe0WgKz9aWvDuH
         zeN7YWQ+e3TNXNodbla5NqWnL9XESJe3LGv5QToIgV7OudvJJX127SXez95NvxOqcG
         D5ZzahctKY1gA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=KZJJTTQD c=1 sm=1 tr=0
 a=v1fZ9eGmBRQ2oAddCs0ezw==:117 a=v1fZ9eGmBRQ2oAddCs0ezw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=tGS6WzexE9tHEDMjTbgA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 2/8] builtin: define a symbol_op for a generic op
 acting on integer
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20210412212111.29186-1-luc.vanoostenryck@gmail.com>
 <20210412212111.29186-3-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6d23e861-782e-de66-7ce7-76ff149d4a60@ramsayjones.plus.com>
Date:   Tue, 13 Apr 2021 01:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210412212111.29186-3-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJ6AEjIDp3hNCjDbmi9NG62CWDX9sdDtWu6MMlRxj4f8XYpdA4sGQ8o/IW6IuK74+CudKOcA3mJEeYwO3NqZBZJF+0XIrLXtAIrdzl0WYxBxLQAHVDHZ
 SFJgZ+/IbDGL52PY+FJu7uuYyfp2ViELcRp/MrXxwkajtnlbKwVFOpm1ZptT7VWFgeTYNDT90Dd+jQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 12/04/2021 22:21, Luc Van Oostenryck wrote:
> This can be used to define some generic (polymorphic) builtin
> with a signature like:
> 	<name>(int)
> 	<name>(T, T)
> 	<name>(int, T)
> 	<name>(int, T, long, T, ... T)
> where T is some integer type which will be instantiated at each call.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  builtin.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  builtin.h |  2 ++
>  2 files changed, 63 insertions(+)
> 
> diff --git a/builtin.c b/builtin.c
> index ff03dbab9a06..928e03050375 100644
> --- a/builtin.c
> +++ b/builtin.c
> @@ -390,6 +390,67 @@ static struct symbol_op overflow_p_op = {
>  };
>  
>  
> +///
> +// Evaluate the arguments of 'generic' integer operators.
> +//
> +// Parameters with a complete type are used like in a normal prototype.
> +// The first parameter with a 'dynamic' type will be consider
> +// as polymorphic and for each calls will be instancied with the type
> +// of its effective argument.
> +// The next dynamic parameters will the use this polymorphic type.
> +// This allows to declare functions with some parameters having
> +// a type variably defined at call time:
> +//	int foo(int, T, T);
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
> +	FOR_EACH_PTR(expr->args, arg) {

Hmm, now n is always 0 in the error message, so:
		n++;
here?

> +		if (!is_dynamic_type(t)) {
> +			;
> +		} else if (!ctype) {
> +			// fist 'dynamic' type, chat that it is an integer

s/chat/check/

> +			t = arg->ctype;
> +			if (!t)
> +				return 0;
> +			if (t->type == SYM_NODE)
> +				t = t->ctype.base_type;
> +			if (!t)
> +				return 0;
> +			if (t->ctype.base_type != &int_type)
> +				goto err;
> +
> +			// next 'dynamic' arguments will use this type
> +			ctype = t;
> +		} else {
> +			// use the previous 'dynamic' type
> +			t = ctype;
> +		}
> +		add_ptr_list(&types, t);
> +		NEXT_PTR_LIST(t);
> +	} END_FOR_EACH_PTR(arg);
> +	FINISH_PTR_LIST(t);
> +	return evaluate_arguments(types, expr->args);

Hmm, does this do the usual argument promotions, so e.g. an 'generic'
'short' gets promoted to 'int' in the prototype? I guess not, that
would have to be done above, while adding to the types list, right?
Hmm, I would have to study evaluate_arguments(), but it may be worth
a comment here?

> +
> +err:
> +	sparse_error(arg->pos, "non-integer type for argument %d:", n);
> +	info(arg->pos, "        %s", show_typename(arg->ctype));
> +	expr->ctype = &bad_ctype;
> +	return 0;
> +}

So, this certainly looks better. Thanks! ;-)

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
