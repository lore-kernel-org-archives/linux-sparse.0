Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9FDC433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62EBA64FFD
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhCFQn2 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 11:43:28 -0500
Received: from avasout01.plus.net ([84.93.230.227]:41599 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhCFQnZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 11:43:25 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id Ia1SlZX9zg7CTIa1TlzKni; Sat, 06 Mar 2021 16:43:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1615049003; bh=YC3KakqjtUHwYpd3L8TQ1bdrfOqBRvVD5L1gfFWzFW0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=qM3QTyyGhuDy/0Md+GiLC92RBwZzMan3VymBaIApJvYVXvKz9/MwxFcJ5TI4oOTZe
         M/bTELYYkVjYS+Tr1fdzwCuP5pPx0nJ3Qz3iKsr/C0hPf8QUDFmd0opk93Zrtwyf7S
         rsMyDEzggGvOwrFV6t/8uewqfxS4zXnybInD50wafOZO5zn7IOjIRDORCQTVOk7ktY
         vMytbVcgu4geAq/VtOvoSHKxh/h+IblmshYVk4kfErejs+EdtD1YDbLAeSlAocq1BG
         ekC4rkg2HEONFUsb7/1wMa47NSuynEGx2WJzCAPswGYw+G9c8eYXcvxvrGzZLdHC0N
         9dM8Z5/Fb52qA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cYFJUkLM c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=B1Rj5xMdshEJKRxQVj0A:9
 a=AZrEKOhJ7TPWCF0j:21 a=gZbytGJhm3U958oI:21 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 6/6] ptrlist: change return value of
 linearize_ptr_list()/ptr_list_to_array()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
 <20210306100552.33784-7-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b9f7ecdf-ee6d-0c77-560e-e05b26bcec02@ramsayjones.plus.com>
Date:   Sat, 6 Mar 2021 16:43:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210306100552.33784-7-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNnY1w6elRRg3roRQYk3ORa+56kAZveaAKKu3edEiizlrkeVnxudQ3xD9yMqCsjhIlQzeQgxYJTAkoY2tnspOc7DRjwlzI7YDmYHDk06iKKESvgOjoyY
 FjMfcqXfK60tfTafXpHCYjgYtPsRgS8Jv0QyrNG/j1ETeZmg4wz8kEcOqeqdzPDZjmuz4UQpkQ7bmQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/03/2021 10:05, Luc Van Oostenryck wrote:
> The function linearize_ptr_list() is annoying to use because it
> returns the number of elements put in the array. So, if you need
> to know if the list contained the expected number of entries,
> you need to allocate to array with one more entries and check

s/allocate to array/allocate an array/

> that the return value is one less than the maximum size.
> 
> Change this, so that this function returns the total number of
> entries in the list, much like it's done for snprintf().

But this requires setting max == 0, right? This isn't documented.

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  ptrlist.c  | 10 +++++-----
>  simplify.c |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/ptrlist.c b/ptrlist.c
> index 0f0b3f6d818f..ecfbc07b2b6d 100644
> --- a/ptrlist.c
> +++ b/ptrlist.c
> @@ -154,10 +154,10 @@ void *ptr_list_nth_entry(struct ptr_list *list, unsigned int idx)
>  // @head: the list to be linearized
>  // @arr: a ``void*`` array to fill with @head's entries
>  // @max: the maximum number of entries to store into @arr
> -// @return: the number of entries linearized.
> +// @return: the number of entries in the list.
>  //
>  // Linearize the entries of a list up to a total of @max,
> -// and return the nr of entries linearized.
> +// and return the nunmber of entries in the list.

s/nunmber/number/

Somewhere here, the behaviour with max == 0 on input needs to
be documented.

ATB,
Ramsay Jones

>  //
>  // The array to linearize into (@arr) should really
>  // be ``void *x[]``, but we want to let people fill in any kind
> @@ -170,14 +170,14 @@ int linearize_ptr_list(struct ptr_list *head, void **arr, int max)
>  
>  		do {
>  			int i = list->nr;
> +			nr += i;
> +			if (max == 0)
> +				continue;
>  			if (i > max) 
>  				i = max;
>  			memcpy(arr, list->list, i*sizeof(void *));
>  			arr += i;
> -			nr += i;
>  			max -= i;
> -			if (!max)
> -				break;
>  		} while ((list = list->next) != head);
>  	}
>  	return nr;
> diff --git a/simplify.c b/simplify.c
> index cf5b3d748808..207af8edf28f 100644
> --- a/simplify.c
> +++ b/simplify.c
> @@ -108,7 +108,7 @@ static int get_phisources(struct instruction *sources[], int nbr, struct instruc
>  static int if_convert_phi(struct instruction *insn)
>  {
>  	struct instruction *array[2];
> -	struct basic_block *parents[3];
> +	struct basic_block *parents[2];
>  	struct basic_block *bb, *bb1, *bb2, *source;
>  	struct instruction *br;
>  	pseudo_t p1, p2;
> @@ -116,7 +116,7 @@ static int if_convert_phi(struct instruction *insn)
>  	bb = insn->bb;
>  	if (get_phisources(array, 2, insn))
>  		return 0;
> -	if (ptr_list_to_array(bb->parents, parents, 3) != 2)
> +	if (ptr_list_to_array(bb->parents, parents, 2) != 2)
>  		return 0;
>  	p1 = array[0]->phi_src;
>  	bb1 = array[0]->bb;
> 
