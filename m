Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7275C433DB
	for <linux-sparse@archiver.kernel.org>; Sat, 27 Feb 2021 00:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB3864F0D
	for <linux-sparse@archiver.kernel.org>; Sat, 27 Feb 2021 00:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhB0AE6 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 26 Feb 2021 19:04:58 -0500
Received: from avasout03.plus.net ([84.93.230.244]:49548 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhB0AE5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 26 Feb 2021 19:04:57 -0500
Received: from [10.0.2.15] ([147.147.167.73])
        by smtp with ESMTPA
        id Fn5dl8bcaEfgXFn5elx0Fp; Sat, 27 Feb 2021 00:04:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1614384250; bh=0Xhs4SZvkGKNS5SXOBNndZUZnAhOriF/5IL+z/rbEns=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=bQGka4isGc+oXAQ8PePc3xa2I7H3itSYGLAVbvq3TqTMhWIYs0uiu2XURHVzuCIZ1
         uW6xrrz5KwK6jAbGoaaBaIy25Htnkl7DEkL8vPQaZDBcjSCqWATN1Ir3vO0FOjdhfZ
         6tL2iGKZ2QrBxf74gJFhU8qtH6LnhXdIK7wXXkLelDwNWwwjZPC8VAquH6iPAWaRS7
         PfiWClo1r0ZRLTATGF1aIXACeIiWDRyceBQv9ErXNsWnbHbGuOvQ6lNWRxw6dC9B5O
         fisouAk4fA/Iv+L60g5ed8DwHo4Kra+aO9FLCmnDn7wPgRuRCqMXOKg+bJghPZ7b6/
         xi1ZszvGmXIpQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=WomwzeXv c=1 sm=1 tr=0
 a=nK5asC+3lBOC3EoKtwbYYg==:117 a=nK5asC+3lBOC3EoKtwbYYg==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=y22DNZP3KGIcbmTiLZ4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 4/4] slice: display the source's size, like for unops
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
References: <20210225233908.97275-1-luc.vanoostenryck@gmail.com>
 <20210225233908.97275-5-luc.vanoostenryck@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <90a7c962-ef8a-fe29-167e-76ae99183413@ramsayjones.plus.com>
Date:   Sat, 27 Feb 2021 00:04:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210225233908.97275-5-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGzn8YxIuQaUSFF86KljY5gEJ0N+VYNIOTV3M4zhHpc8vGHC6o5ulQyET/h2p0tEblzwJJC9I3ynY7i0y15WZ51ybLEpHkyavspxnsHjpMKxiq2sCLgp
 S/rOpWlZ6lYkUB+nHRtZBmj1k9KRLH1KfERx9NCxKW9y1dzgec8izHKp806BnQ/ZW7BnqZwMC7pfJw==
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 25/02/2021 23:39, Luc Van Oostenryck wrote:
> When displaying an OP_SLICE, the width is shown but the size
> of the source pseudo is useful to. So display the it, like
> done for unops.

Hmm, s/useful to./useful too./, s/the it,/it/,
s/like.*unops./in a similar manner to the unops./

... if that makes sense! ;-)

ie:
	When displaying an OP_SLICE, the width is shown but the size
	of the source pseudo is useful too. So, display it in a similar
	manner to the unops.


ATB,
Ramsay Jones

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  linearize.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linearize.c b/linearize.c
> index 7ab69d3ac968..b06c062599ee 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -470,7 +470,7 @@ const char *show_instruction(struct instruction *insn)
>  		break;
>  
>  	case OP_SLICE:
> -		buf += sprintf(buf, "%s <- %s, %d", show_pseudo(insn->target), show_pseudo(insn->src), insn->from);
> +		buf += sprintf(buf, "%s <- (%d) %s, %d", show_pseudo(insn->target), type_size(insn->orig_type), show_pseudo(insn->src), insn->from);
>  		break;
>  
>  	case OP_NOT: case OP_NEG:
> 
