Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E76C433DB
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D9264DD1
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCFQUL (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 11:20:11 -0500
Received: from avasout01.plus.net ([84.93.230.227]:40308 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbhCFQTk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 11:19:40 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id IZeTlZVq0g7CTIZeUlzKSU; Sat, 06 Mar 2021 16:19:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1615047579; bh=mUXj3acM4AM3kT4tlmR1c7F5Y0V6yfZ9oVjf9tIwrlY=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=MwT69Nsrw6Vmj5fNpl1emdUcmHq79e0Fr6Y7p/wMTlPf2M9xxXFQszJTu4Ve4GZoV
         Zjb+dGloOv71CGHGilVmYI4mFJlqGDHfTqH737J4faxAegdTI+df5+Gwp1t1yEKXDr
         criEYTxrbiaYD8Du57+92dxjgtmvJlw1RZ1ibLUSSUtzg0g2UDS+xAoluZbpX7/2ai
         RWKAx0q6PTMZhdKzcuTGEXVZS1tSSS+X35VbKSbPo0CFUT6EsqZaKGCZnjWmOzNAvn
         Xv8lgUuvvPAzTo9m0wIt2yE9Ji1O4uCaHSCbhrfP+Xx7s4zWwpZEQkzRYKY/Ms9Pas
         pnxpy37J7VJ4g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cYFJUkLM c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=UFRetlQBAy3LkWI9vmQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/6] ptrlist: ~fix TYPEOF()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
 <20210306100552.33784-2-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <907c570d-4e1e-81a7-3932-8934787611e3@ramsayjones.plus.com>
Date:   Sat, 6 Mar 2021 16:19:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210306100552.33784-2-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAEwo5iT6eS6yq5J5E72oez8D4xb5zmcnxKFJF/E0UMBf1xtmGEzf2d5DTaV+qv8JHAsJzI5ScHPIo/zdYjZiLBPzuWgI4ZuR3+ve2N87gL2M64PMfG/
 eDFBJho18iJ5FPa1X7fjZwZQQL1nrjzVw6zT2EXfv2UiWCvjB191bSI+11ldexFGnWuR5Xt2ohkVBg==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/03/2021 10:05, Luc Van Oostenryck wrote:
> The macro TYPEOF() return the type of the addresses of the pointers
> stored in the list. That's one level too much in general.
> 
> Change it to simply return the type of the stored pointers.

s/~fix/fix/ in the subject. I read ~ as NOT, so NOT fix, or don't fix. ;-)

ATB,
Ramsay Jones

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  ptrlist.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/ptrlist.h b/ptrlist.h
> index c5fa4cdd94cb..41d9011c8716 100644
> --- a/ptrlist.h
> +++ b/ptrlist.h
> @@ -12,7 +12,7 @@
>  
>  /* Silly type-safety check ;) */
>  #define CHECK_TYPE(head,ptr)		(void)(&(ptr) == &(head)->list[0])
> -#define TYPEOF(head)			__typeof__(&(head)->list[0])
> +#define TYPEOF(head)			__typeof__((head)->list[0])
>  #define VRFY_PTR_LIST(head)		(void)(sizeof((head)->list[0]))
>  
>  #define LIST_NODE_NR (13)
> @@ -251,7 +251,7 @@ extern void __free_ptr_list(struct ptr_list **);
>  extern void split_ptr_list_head(struct ptr_list *);
>  
>  #define DO_INSERT_CURRENT(new, __head, __list, __nr) do {		\
> -	TYPEOF(__head) __this, __last;					\
> +	TYPEOF(__head) *__this, *__last;				\
>  	if (__list->nr == LIST_NODE_NR) {				\
>  		split_ptr_list_head((struct ptr_list*)__list);		\
>  		if (__nr >= __list->nr) {				\
> @@ -270,8 +270,8 @@ extern void split_ptr_list_head(struct ptr_list *);
>  } while (0)
>  
>  #define DO_DELETE_CURRENT(__head, __list, __nr) do {			\
> -	TYPEOF(__head) __this = __list->list + __nr;			\
> -	TYPEOF(__head) __last = __list->list + __list->nr - 1;		\
> +	TYPEOF(__head) *__this = __list->list + __nr;			\
> +	TYPEOF(__head) *__last = __list->list + __list->nr - 1;		\
>  	while (__this < __last) {					\
>  		__this[0] = __this[1];					\
>  		__this++;						\
> 
