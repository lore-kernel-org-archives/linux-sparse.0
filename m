Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9A4C433DB
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3EE64FA8
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhCFQg0 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 11:36:26 -0500
Received: from avasout01.plus.net ([84.93.230.227]:41202 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhCFQfy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 11:35:54 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id IZuClZWkdg7CTIZuDlzKh8; Sat, 06 Mar 2021 16:35:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1615048553; bh=JaCSAe54dv6Xn19NOQARpAGI74BvdwM3NO9XFhE1A1k=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=K9YP5Br2qY0vCUgTmMxMyhd11LSNosqgIzeW09lqmaLzVgRmK59VlDCKQfXVQbNB0
         mbGoYVKAHOy14HJvEkn6ZKrD4zbPrpgL++fLChhElARsVDYLdfth7s5dXkuk+Fi+Vs
         evpzbHurtmELUku7S9RaKqk5OUOAqJejOv6+TfcWgrXFshGgxTkKJrSnSYOhazK8I3
         Sde2TbI7G5efFD3tMyvKIq1e2bJU90sPWo8fuass/XQmdMC7eWAiygsMKWAEXN1gsx
         H+120kg5NBc+yr0BKlxLdTZY7IJlOcoWVFcR/E4vFpc8kch4GWhYa+lKDru9VVe15n
         K3kv5zDl2peAw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cYFJUkLM c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=RVLQS0buqwImiduSq0cA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 5/6] ptrlist: make linearize_ptr_list() generic
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
 <20210306100552.33784-6-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b896e87f-8850-f0ae-875b-15251f93ffb3@ramsayjones.plus.com>
Date:   Sat, 6 Mar 2021 16:35:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210306100552.33784-6-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGGAFysHMdnAms8wfPV6GLCaN30K6OeBxv4DF5W0WnQtPUURB3xcKrdKcyHu3eH0k8mAhZhu0dp8ZUL4GAwcB9GPxnWy4R9Zchtfs9RiUOK6L8G8glgw
 n1iyg9UpGa+aeDtzdRaWdQN0IsSRvp5kvh75PTOMJWdFreaMRu4+v1bgi7moo9E3n3HaH5rwC4EhuQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/03/2021 10:05, Luc Van Oostenryck wrote:
> The ptrlist API has a function to copy the elements of a ptrlist
> into an array but it's not typed and thus needs a wrapper (or casts)
> for each type it's used for. Also, 'linearize' is confusing since
> this is unrelated to Sparse's linearization.
> 
> Simplify this by adding a generic (but type-safe) macro for this
> (and changing the name): ptr_list_to_array()

Hmm, you have removed/renamed all current callers of linearize_ptr_list(),
but you haven't 'changed the name'; you can't, otherwise the new wrapper
macro wouldn't work! ;-)

Maybe, s/and changing the name/with a more descriptive name/

ATB,
Ramsay Jones

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  ptrlist.h  | 6 ++++++
>  simplify.c | 4 ++--
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/ptrlist.h b/ptrlist.h
> index 0b06142252f5..5a3dcbeb97ae 100644
> --- a/ptrlist.h
> +++ b/ptrlist.h
> @@ -84,6 +84,12 @@ extern void __free_ptr_list(struct ptr_list **);
>  		(PTRLIST_TYPE(lst)) ptr_list_nth_entry(head, nth);\
>  	})
>  
> +#define ptr_list_to_array(list, array, size) ({				\
> +		struct ptr_list* head = (struct ptr_list*)(list);	\
> +		CHECK_TYPE(list, *array);				\
> +		linearize_ptr_list(head, (void**)array, size);		\
> +	})
> +
>  ////////////////////////////////////////////////////////////////////////
>  // API
>  #define PREPARE_PTR_LIST(head, ptr) \
> diff --git a/simplify.c b/simplify.c
> index 584078ddca89..cf5b3d748808 100644
> --- a/simplify.c
> +++ b/simplify.c
> @@ -83,7 +83,7 @@ static struct basic_block *phi_parent(struct basic_block *source, pseudo_t pseud
>  //	number of element, a positive number if there was
>  //	more than expected and a negative one if less.
>  //
> -// :note: we can't reuse a function like linearize_ptr_list()
> +// :note: we can't reuse ptr_list_to_array() for the phi-sources
>  //	because any VOIDs in the phi-list must be ignored here
>  //	as in this context they mean 'entry has been removed'.
>  static int get_phisources(struct instruction *sources[], int nbr, struct instruction *insn)
> @@ -116,7 +116,7 @@ static int if_convert_phi(struct instruction *insn)
>  	bb = insn->bb;
>  	if (get_phisources(array, 2, insn))
>  		return 0;
> -	if (linearize_ptr_list((struct ptr_list *)bb->parents, (void **)parents, 3) != 2)
> +	if (ptr_list_to_array(bb->parents, parents, 3) != 2)
>  		return 0;
>  	p1 = array[0]->phi_src;
>  	bb1 = array[0]->bb;
> 
