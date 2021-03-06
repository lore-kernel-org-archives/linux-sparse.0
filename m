Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C5FC433DB
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1351864DD1
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCFQWy (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 11:22:54 -0500
Received: from avasout01.plus.net ([84.93.230.227]:40478 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhCFQWZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 11:22:25 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id IZh8lZVzkg7CTIZhAlzKUu; Sat, 06 Mar 2021 16:22:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1615047744; bh=dJsPffHs5OwlRPd5tOKD0Ibh2lIFdQlKEQnqelLLCAY=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=DecTgh3JHaEgOmX4HZnVhJptA/ylk5L1QwicMIZEEKbzGFavJFMM60ixvBsHsHfHA
         gW5xrFdO7yPK9QOGkEjf4dudTi8TdcvdCm8jBjAcpQEL2s7ckPYKUyherxttaTeI1a
         z8f0zr99GxM/vRJWYDI6mQVkWbhBlRJsvGAQYkwtwQfwY36mNgYd4JJFZXY/60AoFV
         VcEuAV80QTbH8CxS7Xd38Q2o2lZ+/Qy8yv0xth4JkNg4wk/pWNSyUiinHXB4J+9xVF
         Lw1F31VaSTpRtHNUptLnrVCA54jzjsDwACLRhjrriQ/CpHv0GRBzEG3U/ghtgFVEJh
         w1GCiI39ZKjlA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cYFJUkLM c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=nBwF1Uj4k2fSAbKUvaUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/6] ptrlist: add pop_ptr_list()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
 <20210306100552.33784-4-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <3f1387a7-5620-ec62-2ff6-200b0369ac0e@ramsayjones.plus.com>
Date:   Sat, 6 Mar 2021 16:22:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210306100552.33784-4-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEwlnqEpQiTZgfWChzRQDBXH0k3cgYmIHf/i/apFwny2bMPFPvRsD51a4pzMTHW0+IyhaZ2o/XYwrn29QiLvT/ZWtyB/QIF4XIkZDPWVxaffRcNn8fW2
 m+33ckizAXe3X9KQzIEshUmeHGUIIaWdM9Ml6mhUupNFRokOaqOSzyqcCFvqsp/+LwWAV5WFB1+YbQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/03/2021 10:05, Luc Van Oostenryck wrote:
> Some algorithms need with a stack or a working list from which the

s/with a stack/a stack/

ATB,
Ramsay Jones

> last element can be removed. The ptrlist API has a function to do
> this but it's not typed and thus needs a wrapper for each type
> it's used for.
> 
> Simplify this by adding a generic (but type-safe) macro for this
> while also giving it a nicer name: pop_ptr_list().
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  ptrlist.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/ptrlist.h b/ptrlist.h
> index 3b952097545f..0b06142252f5 100644
> --- a/ptrlist.h
> +++ b/ptrlist.h
> @@ -67,6 +67,12 @@ extern void **__add_ptr_list_tag(struct ptr_list **, void *, unsigned long);
>  		(__typeof__(&(ptr))) __add_ptr_list_tag(head, ptr, tag);\
>  	})
>  
> +#define pop_ptr_list(l) ({						\
> +		PTRLIST_TYPE(*(l)) ptr;					\
> +		ptr = delete_ptr_list_last((struct ptr_list**)(l));	\
> +		ptr;							\
> +	})
> +
>  extern void __free_ptr_list(struct ptr_list **);
>  #define free_ptr_list(list)	do {					\
>  		VRFY_PTR_LIST(*(list));					\
> 
