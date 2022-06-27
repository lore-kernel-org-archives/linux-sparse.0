Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8F1C433EF
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 23:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiF0Xem (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 19:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236667AbiF0Xek (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 19:34:40 -0400
X-Greylist: delayed 147 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 16:34:39 PDT
Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050B0DF8B
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 16:34:38 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 5yFWotoT2AcBn5yFXodWlZ; Tue, 28 Jun 2022 00:34:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1656372877; bh=BCldnoRvvfCg67hTdFmX/xhV/rvN3Bl1OjYeLZXPHWk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=TplWUzKaXbVU/C8M6323StdEaSf8nNs4Shjx+jqO4vA1CLh+85l2cw+sRP6IPCgef
         5xMRDV4wxxEiKIOL8+I19+nn3WTvOhwAhXnz3rqn+q8gvmV4OV0iAAFC4cnQByVWOY
         w27Ex6IbEDNDS9YOkcATCUtWSG96aE5Bo9+STP2Ee6yLvkAPUp0ov09bLJJWaWSfqw
         6kCfDS9dewrbQeDXDNOQisUvbJnfpPnQtxdCVoMHao5jfRGuGtjLo4XJ1g2ytWM12+
         bXe+cc1be8X5mY2juo084yCvOtKLj75Wmd5sHOHOp9ufh/jYPLQ5evb0/0WGamDM4N
         KLcdsfE6CzfIg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JPUoDuGb c=1 sm=1 tr=0 ts=62ba3e8d
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=E-OkJ-TVZ97Nki-p6boA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <17a98e32-cda9-71e0-be04-4287dc1498c5@ramsayjones.plus.com>
Date:   Tue, 28 Jun 2022 00:34:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/5] bitwise: allow compares for bitwise types
Content-Language: en-GB
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>
References: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
 <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
 <20220627190540.13358-4-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20220627190540.13358-4-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOgfoja+OdAD+ytVEE/iMZFLjGPCahzkjSojVTlzvEBnlAt0pRZM4YGjzUkQXqrXDMCSDjANsCUgJLuMKQ6CwNz2NaH8IFy34ezDZTMMQLSIS6IL+BbQ
 OkLu8k3gWgNmx704T5v0KZTnqhEZWYBs6yiNAFU0RWmZQs05nEObD7Wxa0YM5V3OPfexu9zbi9sJBZFncYaZZHnVXrmZ+SjLA/Q=
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 27/06/2022 20:05, Luc Van Oostenryck wrote:
> Currently, bitwise types are restricted to bitwise operations
> (&, |, ^ and ~) as well as equality comparisons.
> 
> This patch makes the others comparisons valid for bitwise types
> too.
> 
> Warning: This change make sense in the context of [1] but

The [1] reference seems to be missing :)

ATB,
Ramsay Jones

>          doesn't make sense for the 'main' bitwise types:
>          __be32 and friends.
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  evaluate.c                       | 4 ++++
>  validation/bitwise-cmp.c         | 1 -
>  validation/linear/bitwise-cmps.c | 1 -
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index bcbcdf1ef0cc..bb8c0caa905a 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -435,6 +435,10 @@ static int restricted_binop(int op, struct symbol *type)
>  		case '^':
>  		case '?':
>  			return 2;	/* keep fouled */
> +		case '<':
> +		case '>':
> +		case SPECIAL_LTE:
> +		case SPECIAL_GTE:
>  		case SPECIAL_EQUAL:
>  		case SPECIAL_NOTEQUAL:
>  			return 3;	/* warn if fouled */
> diff --git a/validation/bitwise-cmp.c b/validation/bitwise-cmp.c
> index ca12b5e51e8e..8c3e6894072d 100644
> --- a/validation/bitwise-cmp.c
> +++ b/validation/bitwise-cmp.c
> @@ -28,5 +28,4 @@ static int gtx(b32 x, b32 y)  { return (x >  y); }
>  
>  /*
>   * check-name: bitwise-cmp
> - * check-known-to-fail
>   */
> diff --git a/validation/linear/bitwise-cmps.c b/validation/linear/bitwise-cmps.c
> index 6122944a42c6..f83ab7fe47db 100644
> --- a/validation/linear/bitwise-cmps.c
> +++ b/validation/linear/bitwise-cmps.c
> @@ -8,7 +8,6 @@ static int gtu(bs32 x, bs32 y)  { return (x >  y); }
>  /*
>   * check-name: bitwise-cmps
>   * check-command: test-linearize -Wno-decl $file
> - * check-known-to-fail
>   *
>   * check-output-ignore
>   * check-output-excludes: setb\\.
