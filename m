Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D297C433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DFFB64DD1
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 16:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCFQVO (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 11:21:14 -0500
Received: from avasout01.plus.net ([84.93.230.227]:40372 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhCFQUw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 11:20:52 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id IZfdlZVu0g7CTIZfelzKTW; Sat, 06 Mar 2021 16:20:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1615047650; bh=YJS3Vqj8PF4H09ksacEAHNHLbU6UoM7h+YWoDEdG7r8=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=cA4TlLT+VJghmjUrNK5viHmBXfriYftNULkM7iqAVNo7kToKxIGRsKWg6croaiInL
         u5HTLXoXrHvkBe6QSQzaPp9y7A3uUqTrXbjViYW8MWrq6uRW9anVR1/V8ooDGD7KtB
         aSmHZ2DC95PjpXa0JSc3Jl1bPMb0xP4NxTy9vjomIOR3bzAzBOmGDHgFy1AAeJ6PoN
         j3S2OVnq/Br7BbCvZw8jHliY7tB0EUmCPv61jFSKNBMFv5eXxGKMo1p9oCGAlOj5DM
         KOg9wSsf0+GMmToIYgglJ/Tkm3BFpEDPFvzqOQRQMXstwjUElNcAby8a1Qr5TXNLTU
         hhAAKwq4jNURg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=cYFJUkLM c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=WhgRyd8PCGhpRw1qKj4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/6] ptrlist: change TYPEOF() into PTRLIST_TYPE()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
 <20210306100552.33784-3-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <b76f78f8-6525-43d1-0d30-290e3587ca1f@ramsayjones.plus.com>
Date:   Sat, 6 Mar 2021 16:20:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210306100552.33784-3-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLSkNdFmtinUJxvmSzrEoIAViH19+QpqA7SR0G4KhDjSIg/kdOJycp0EEJQXQtd8EepswjmnGNRSFE4ww1CzZkKmMh6o+B5zsD8jVBuckgThlapK82L6
 VCk5fFl74pmiHiZ25MmBmo5KEcjukzUsYGHooQXPQOWX5s2X6XvwV4S9xMLxMcw6Y9cGLYPinEasmw==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 06/03/2021 10:05, Luc Van Oostenryck wrote:
> The name of the macro TYPEOF() is too generic and doesn't explain
> that it only returns the type of the pointers stored in ptrlists.
> 
> So, change he name to something more explicit: PTRLIST_TYPE().

s/change he/change the/

ATB,
Ramsay Jones

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  ptrlist.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/ptrlist.h b/ptrlist.h
> index 41d9011c8716..3b952097545f 100644
> --- a/ptrlist.h
> +++ b/ptrlist.h
> @@ -12,7 +12,7 @@
>  
>  /* Silly type-safety check ;) */
>  #define CHECK_TYPE(head,ptr)		(void)(&(ptr) == &(head)->list[0])
> -#define TYPEOF(head)			__typeof__((head)->list[0])
> +#define PTRLIST_TYPE(head)		__typeof__((head)->list[0])
>  #define VRFY_PTR_LIST(head)		(void)(sizeof((head)->list[0]))
>  
>  #define LIST_NODE_NR (13)
> @@ -75,7 +75,7 @@ extern void __free_ptr_list(struct ptr_list **);
>  
>  #define ptr_list_nth(lst, nth) ({					\
>  		struct ptr_list* head = (struct ptr_list*)(lst);	\
> -		(__typeof__((lst)->list[0])) ptr_list_nth_entry(head, nth);\
> +		(PTRLIST_TYPE(lst)) ptr_list_nth_entry(head, nth);\
>  	})
>  
>  ////////////////////////////////////////////////////////////////////////
> @@ -251,7 +251,7 @@ extern void __free_ptr_list(struct ptr_list **);
>  extern void split_ptr_list_head(struct ptr_list *);
>  
>  #define DO_INSERT_CURRENT(new, __head, __list, __nr) do {		\
> -	TYPEOF(__head) *__this, *__last;				\
> +	PTRLIST_TYPE(__head) *__this, *__last;				\
>  	if (__list->nr == LIST_NODE_NR) {				\
>  		split_ptr_list_head((struct ptr_list*)__list);		\
>  		if (__nr >= __list->nr) {				\
> @@ -270,8 +270,8 @@ extern void split_ptr_list_head(struct ptr_list *);
>  } while (0)
>  
>  #define DO_DELETE_CURRENT(__head, __list, __nr) do {			\
> -	TYPEOF(__head) *__this = __list->list + __nr;			\
> -	TYPEOF(__head) *__last = __list->list + __list->nr - 1;		\
> +	PTRLIST_TYPE(__head) *__this = __list->list + __nr;		\
> +	PTRLIST_TYPE(__head) *__last = __list->list + __list->nr - 1;	\
>  	while (__this < __last) {					\
>  		__this[0] = __this[1];					\
>  		__this++;						\
> 
