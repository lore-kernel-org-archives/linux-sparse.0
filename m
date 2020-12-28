Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC11CC433DB
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 17:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6201D22472
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 17:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgL1RXY (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 12:23:24 -0500
Received: from avasout06.plus.net ([212.159.14.18]:33957 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbgL1RXX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 12:23:23 -0500
Received: from [10.0.2.15] ([80.189.83.3])
        by smtp with ESMTPA
        id twE8kPhlMhO4HtwE9kCvha; Mon, 28 Dec 2020 17:22:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1609176157; bh=9HphBOCOsL+h9B8ZuWYSAhoCeto8l4wI42spIcb7Bu4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=VnTHaSHiy15rSBf0FIrgHKKzn9bTjCWrEolMgUW0TXR3WbQTnlKQ7dOlcfnrvRIud
         MojcwbUXMV71N1ipjXziamj6t+A30YTMWGNWjG2eUz0Ws6juyAAWq7jxH53baIM3Xo
         8z5jNY7JAJ5iB9Ym7R5LwDoX+D+ceCysZoKi42ydf1NV3ueWRAqZBv9iDQsTtL/FHb
         9TW1G+doVYC4kJ0A6gEjdYwGvZdyRCHH0yzOpupdX3AlY/AMX+pI1Ac21qA0X1RxMd
         3fAJpgZ35AsByRq5BoWJNP6XI+CehtmTIkKSdb3wYdmNd34a7/v4SIx1qa4cEMDW+O
         viUlWllZfu/DQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=HN+d/rRCB1WM0IHjUF19mA==:117 a=HN+d/rRCB1WM0IHjUF19mA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=U7EVDT20MNuem_F1dFEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/2] fix rem_usage()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20201227092759.30999-1-luc.vanoostenryck@gmail.com>
 <20201227092759.30999-3-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <52a111f5-aea4-d705-f0c3-d71ecb2226dc@ramsayjones.plus.com>
Date:   Mon, 28 Dec 2020 17:22:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201227092759.30999-3-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfP26TOaLa09HAfko8vUy2MjhZ0anGU+HysSUD8mbvecFJiTV4jJQJHjM5Bp62ZxRGvoW9pmVwLMWb3AWO2YDPk4oKuwvGcb/ezUZNyztKgvS7KXicddM
 GTgQ1DPRjBWzPSdFQ2JnZnWMBC5kIT73Fmmt2QF4CqKAOUkDemztJhI5ApE1UcLbOUBTs0DntIuEZQ==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 27/12/2020 09:27, Luc Van Oostenryck wrote:
> rem_usage() is used to remove an element from a def-use chain. Optionally,

Hmm, rename this to 'remove_usage()' at the same time?

ATB,
Ramsay Jones

> if the chain become empty, the defining instruction can also be killed.
> 
> This optional part is currently be done on all pseudos but only those
> having a definition should be concerned.
> 
> Fix this by adding a check so that only PSEUDO_REGs and PSEUDO_PHIs are killed.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  simplify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/simplify.c b/simplify.c
> index a877b693b610..12482d787189 100644
> --- a/simplify.c
> +++ b/simplify.c
> @@ -271,7 +271,7 @@ static inline void rem_usage(pseudo_t p, pseudo_t *usep, int kill)
>  {
>  	if (has_use_list(p)) {
>  		delete_pseudo_user_list_entry(&p->users, usep, 1);
> -		if (kill && !p->users)
> +		if (kill && !p->users && has_definition(p))
>  			kill_instruction(p->def);
>  	}
>  }
> 
