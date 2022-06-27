Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AB5C433EF
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 23:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbiF0XfM (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiF0XfM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 19:35:12 -0400
Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40297DF8B
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 16:35:11 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 5yD4otnqaAcBn5yD5odWkp; Tue, 28 Jun 2022 00:32:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1656372729; bh=gfskdcoxvdejMan26LENbPzg1N3zOADFqAP3O7LzFfQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ai/ubmONl1TJAO7lrlAVM/GuLR0vFbvBfvyvNrEg7uzLqtElgMThZZjJKEr7KBzLW
         N0utJdcxqfLr23oWIkPHGw3YSYgRMK2x9zQ+KIW3AVvQUpdySJ7vFYitbjlHMjFIQ4
         1PhINL3EYw9tQ5kMpPmaJKqKGixtpcFQI69nRQQm9syMJhNSmFOa6Z7M2pAJtw6UBR
         AZVFv0npj/7msz1EiyjDh0EYttwQXzbWwFBsrFCoK8Yig1h+Du1ThInH8YXVeumcth
         T2uRHpTKUP5zyd/i3D7zaiQfeKwnXjzCrDNiGyPv0BTo251DSBDuc4rPN6DUOo5rUw
         tooXkdz3mJL5w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JPUoDuGb c=1 sm=1 tr=0 ts=62ba3df9
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=9qV9x0tqV3PRz3u1FukA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <1be25b6f-5065-f448-b6f0-9e6eaf077264@ramsayjones.plus.com>
Date:   Tue, 28 Jun 2022 00:32:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/5] bitwise: accept all ones as non-restricted value
Content-Language: en-GB
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
 <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
 <20220627190540.13358-3-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20220627190540.13358-3-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMSvmP/0/BJ7lDZIYaJ89Et0aDiWbQyr8iqmSU6MolnRxNyi9eNCBQ1dMomwaFipdgfFzxdA53RiqbYV8rXG3M+f1yYipOdHUYN32FAcDoCk9iOQyTJ4
 +8Mxg7J3WV3FiHxgNIGv7CuVLqzXXDhDNIMDhk5SCZbsd0dF0in65goM2fPAmf6voHvc7cWnTwmRjEonCoT2cxDK46prADKEfu0=
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 27/06/2022 20:05, Luc Van Oostenryck wrote:
> Currently, the only value bitwise types can act on is 0
> because the this value is anyway invariant for all bitwise

s/the this/this/
s/anyway//

ATB,
Ramsay Jones

> operations and endianness conversions.
> 
> But, a bit-pattern of all ones has the same properties and
> is also very often used.
> 
> So, accept all ones as a valid value for bitwise operations.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  evaluate.c                |  2 +-
>  validation/bitwise-cast.c | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index 61f59ee3908e..bcbcdf1ef0cc 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -417,7 +417,7 @@ static int restricted_value(struct expression *v, struct symbol *type)
>  {
>  	if (v->type != EXPR_VALUE)
>  		return 1;
> -	if (v->value != 0)
> +	if (v->value != 0 && v->value != bits_mask(type->bit_size))
>  		return 1;
>  	return 0;
>  }
> diff --git a/validation/bitwise-cast.c b/validation/bitwise-cast.c
> index 0583461cb745..1075a3e9410c 100644
> --- a/validation/bitwise-cast.c
> +++ b/validation/bitwise-cast.c
> @@ -35,6 +35,19 @@ static __be32 quuy(void)
>  	return (__attribute__((force)) __be32) 1730;
>  }
>  
> +/* Implicit casts of all ones, legal */
> +static __be32 foo1(void)
> +{
> +	__be32 x = 0xffffffff;
> +	return x;
> +}
> +
> +/* Explicit cast of all ones, legal */
> +static __be32 bar1(void)
> +{
> +	return (__be32)0xffffffff;
> +}
> +
>  /*
>   * check-name: conversions to bitwise types
>   * check-command: sparse -Wbitwise $file
