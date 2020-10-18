Return-Path: <SRS0=Dp15=DZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CC2C433E7
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Oct 2020 23:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B285A22266
	for <linux-sparse@archiver.kernel.org>; Sun, 18 Oct 2020 23:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="bESG7I24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgJRX7F (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 18 Oct 2020 19:59:05 -0400
Received: from avasout02.plus.net ([212.159.14.17]:33297 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgJRX7F (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Oct 2020 19:59:05 -0400
Received: from [10.0.2.15] ([195.213.6.121])
        by smtp with ESMTPA
        id UIZpkur0Y0K1OUIZrkTq5L; Mon, 19 Oct 2020 00:59:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1603065543; bh=EplD3FPlgGtkWTWZqEEZ3boq4TaquH4A9lDtLzo33OM=;
        h=From:Subject:To:References:Date:In-Reply-To;
        b=bESG7I2498133QQFhhFS1l8mO6321+ReiIYKUaqBnV5JpefxPXbd1yvdQFi/OiBpE
         kiMo2jXF85Qvo6Y78mMjQFbQsCWQKqHwjnTNEsM/1LSYzscmNsa00vshu17JKHp4cN
         wPVddKpE1x3qVEaD5t1OHG4UBSc3vep5DTdlbhcLnZdDRNnOB3jMRc4F/quiohUdhJ
         2HU5uajD8nbrzXbjRraQcAy064uvNNYt/72MsqA7kIR3DPDKvQS2cAGvh2ydBNe6H1
         NbgjGrQgBLos5UBPPHY22/RI7vqr2S1zX8K8k/acd4ULTHXJOMpdl3gRhxzBRRTRD5
         kUho860wDrTaA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=rEkw2CHrnBWBxokklcO+KQ==:117 a=rEkw2CHrnBWBxokklcO+KQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=-uFeE1ZUPqctKCJuqIcA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 04/12] builtin: evaluate __sync_*_fetch*()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20201017225633.53274-1-luc.vanoostenryck@gmail.com>
 <20201017225633.53274-5-luc.vanoostenryck@gmail.com>
Message-ID: <c19eba37-af33-a852-a286-a6ecf23d77ea@ramsayjones.plus.com>
Date:   Mon, 19 Oct 2020 00:59:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201017225633.53274-5-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLDnBkQ/PkZarSlerHnAhC8RWedpx9/0PBfH+VxTtcRUofxZQTmTK7HP5U7PEa0WrkXo0lw3dRYSGAr/wT3f1ufEfCWKTqGRjyQum9qxs7m/15t0yCFm
 YnKQ6SaxNNdy7LOkQIRq6ctyTk0cqhd4VoThEVSEaWh65ktr84+XhuFde3c+Hm+MjgCLO85fHX3v0g==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 17/10/2020 23:56, Luc Van Oostenryck wrote:
> Reuse the generic method for all these builtins.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  builtin.c                       | 26 +++++++++++++-------------
>  validation/builtin-sync-fetch.c | 24 ++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 13 deletions(-)
>  create mode 100644 validation/builtin-sync-fetch.c
> 
> diff --git a/builtin.c b/builtin.c
> index 880dd54f647e..5e490830e147 100644
> --- a/builtin.c
> +++ b/builtin.c
> @@ -627,23 +627,23 @@ static const struct builtin_fn builtins_common[] = {
>  	{ "__builtin___vsnprintf_chk", &int_ctype, 0, { &string_ctype, size_t_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype }},
>  	{ "__builtin___vsprintf_chk", &int_ctype, 0, { &string_ctype, &int_ctype, size_t_ctype, &const_string_ctype, va_list_ctype }},
>  
> -	{ "__sync_add_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> -	{ "__sync_and_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_add_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
> +	{ "__sync_and_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },

Hmm, I get that the return type is derived from the type of the first
argument, but I don't see where that return type is checked/assigned
to the function return type. :( So, why are these set to NULL, but ...

>  	{ "__sync_bool_compare_and_swap", &bool_ctype, 1, { vol_ptr, &dyntype, &dyntype }, .op = &atomic_op},

... this one isn't?

ATB,
Ramsay Jones


> -	{ "__sync_fetch_and_add", &int_ctype, 1, { &ptr_ctype }},
> -	{ "__sync_fetch_and_and", &int_ctype, 1, { &ptr_ctype }},
> -	{ "__sync_fetch_and_nand", &int_ctype, 1, { &ptr_ctype }},
> -	{ "__sync_fetch_and_or", &int_ctype, 1, { &ptr_ctype }},
> -	{ "__sync_fetch_and_sub", &int_ctype, 1, { &ptr_ctype }},
> -	{ "__sync_fetch_and_xor", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_fetch_and_add", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
> +	{ "__sync_fetch_and_and", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
> +	{ "__sync_fetch_and_nand", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
> +	{ "__sync_fetch_and_or", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
> +	{ "__sync_fetch_and_sub", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
> +	{ "__sync_fetch_and_xor", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
>  	{ "__sync_lock_release", &void_ctype, 1, { &ptr_ctype }},
> -	{ "__sync_lock_test_and_set", &int_ctype, 1, { &ptr_ctype }},
> -	{ "__sync_nand_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> -	{ "__sync_or_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> -	{ "__sync_sub_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_lock_test_and_set", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
> +	{ "__sync_nand_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
> +	{ "__sync_or_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
> +	{ "__sync_sub_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
>  	{ "__sync_synchronize", &void_ctype, 0 },
>  	{ "__sync_val_compare_and_swap", NULL, 1, { vol_ptr, &dyntype, &dyntype }, .op = &atomic_op },
> -	{ "__sync_xor_and_fetch", &int_ctype, 1, { &ptr_ctype }},
> +	{ "__sync_xor_and_fetch", NULL, 1, { vol_ptr, &dyntype }, .op = &atomic_op },
>  
>  	{ }
>  };
> diff --git a/validation/builtin-sync-fetch.c b/validation/builtin-sync-fetch.c
> new file mode 100644
> index 000000000000..45139a3c8c3e
> --- /dev/null
> +++ b/validation/builtin-sync-fetch.c
> @@ -0,0 +1,24 @@
> +static int ok_int(int *ptr, int val)
> +{
> +	return __sync_add_and_fetch(ptr, val);
> +}
> +
> +static long* ok_ptr(long **ptr, long *val)
> +{
> +	return __sync_add_and_fetch(ptr, val);
> +}
> +
> +static void chk_ret_ok(long *ptr, long val)
> +{
> +	_Static_assert([typeof(__sync_add_and_fetch(ptr, val))] == [long], "");
> +}
> +
> +static int chk_val(int *ptr, long val)
> +{
> +	// OK: val is converted to an int
> +	return __sync_add_and_fetch(ptr, val);
> +}
> +
> +/*
> + * check-name: builtin-sync-fetch
> + */
> 
