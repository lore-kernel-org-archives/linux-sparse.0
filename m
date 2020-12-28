Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C11AC433E0
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 17:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A611229C4
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 17:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgL1RUw (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 12:20:52 -0500
Received: from avasout06.plus.net ([212.159.14.18]:33757 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgL1RUv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 12:20:51 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id twC6kPhb0hO4HtwC7kCvc8; Mon, 28 Dec 2020 17:20:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609176031; bh=uw3xqnUVDUESnjBltIpdHZqKNJFRNbnoMOWlf/wi6ZI=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Ifvy/zfESoFseBDo7/t4260z2wp3BIXRF8oLCRnMoTHs+ivg1ttPCoa7OuYVY+RIT
         yCMHBdkI4cuLtB5OYPwBS7twhux6xWmBlFHYBTj40CfUc5HNyCkxRB7ZybGPS2iRF1
         oesrfVQS/tzZBPHiQ+WHaPv995zNutBeDRXWOep1kHGo5yw6tpRA5XwASlVnkAFV72
         rfbf2OkHu+sapyBcGnZdCZnHQpSSUJe7m1CR/VMIkFeL5+W4J/44RjdT1Vi6NSHLNw
         P/x9UKiGKGwcm9LdDbkhg6XcbcdR31W5brjrsQEckepsVzaPGTkW43P/fcO/p1J0Ls
         tnZGh47XitJsQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=9YWXKKpNliN_FHuYpl0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/2] add helper has_definition()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20201227092759.30999-1-luc.vanoostenryck@gmail.com>
 <20201227092759.30999-2-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <0b310b49-2357-cc38-7e40-b215c6fe0773@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 17:20:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201227092759.30999-2-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLLPNc9l/GuTK69lX2O/pHS7qfHyQf/sZbM92mWEJ5uCP4xovGAwqm1ZGhrIaZBbOQ7zd+iWGd8Vlc7aemSO84ifTsLIGAhcMwNQuGhxa1XF5rhwEJen
 /X5C9/J0cWvM+e820QGoT1mU6KnjnuW9WBPu9xMjLbLuB5VO2uMwvxo/MwKv6x7l2+AzINcW0o1e3w==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 27/12/2020 09:27, Luc Van Oostenryck wrote:
> Add he helper has_definition() to check if the pseudo belong to one

s/Add he/Add the/

ATB,
Ramsay Jones

> of the pseudo types having a definition: PSEUDO_REG & PSEUDO_PHI.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  linearize.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/linearize.h b/linearize.h
> index 2c548d43526f..c5bdd04257a1 100644
> --- a/linearize.h
> +++ b/linearize.h
> @@ -249,6 +249,11 @@ static inline int has_use_list(pseudo_t p)
>  	return (p && p->type != PSEUDO_VOID && p->type != PSEUDO_UNDEF && p->type != PSEUDO_VAL);
>  }
>  
> +static inline bool has_definition(pseudo_t p)
> +{
> +	return p->type == PSEUDO_REG || p->type == PSEUDO_PHI;
> +}
> +
>  static inline int pseudo_user_list_size(struct pseudo_user_list *list)
>  {
>  	return ptr_list_size((struct ptr_list *)list);
> 
