Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D2C433EF
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 14:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiFZOme (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiFZOme (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 10:42:34 -0400
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7522EBC10
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 07:42:33 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 5TT4oIJlFuTE05TT5oJchk; Sun, 26 Jun 2022 15:42:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1656254552; bh=5ArBpaO1NYKzlx0Dm7sEAYkPTDowb3X839/XwHGelZo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=M6ZAVvIy6iHxW8jUMe2lf3dFwUN/kcuff9g56AuB5FerRw8DyaS1tpAuyGzVWf1vW
         fX6rOpIM45UsUKz5U3ubdp3qYH4skv5ukEWFE5bpEkkl+jU0hN+erL42j+WARJsJ3f
         Ehq8uB2TQlZOC0RGS1BBv2Y81FPNKuxCjpVsOABxGp1fm1uZlP3REAfmRkUB/Dtp6U
         EbELBlb0NhaDuWCcWgTFu9v9svJSByHFjbWBlUA4auZi0RhqJVUrTUUBU+1POoLwFG
         KUjf6upyUavmGOJz9ES+B0f+TKG7XOpwxeWd10eZMKjyMcRQm9YIov8z9LO0un/aiV
         4ywwWptmVc0NA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=DfIEF9hW c=1 sm=1 tr=0 ts=62b87058
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=jzKyNKKzJk1atDPJpZYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <ff0997f3-aefa-08cf-24b9-c5931e21958b@ramsayjones.plus.com>
Date:   Sun, 26 Jun 2022 15:42:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/6] inline: comment about creating node of node on
 variadics
Content-Language: en-GB
To:     Luc Van Oostenryck <lucvoo@kernel.org>,
        linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20220626130748.74163-1-lucvoo@kernel.org>
 <20220626130748.74163-3-lucvoo@kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20220626130748.74163-3-lucvoo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfI8dnLVj1awDbsrwOkoFtderJWcJBxAN/MhJHLEu8uZDfrQepbc8ZJKnuiHWGf328TMdW/IFtEMCc0s0FVlcZ5d4CfFIU/JqNTuSVyQqbzGS0e+atSWX
 ekwl41agjnAunIWfmj5GZFlb6gOiuHgTIJarEjhQyy9syi60yxecvh+r59bmdxpDOn5mEE+f1Jcp8e/jorHl5V2zr4DnEdQQ74E=
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org



On 26/06/2022 14:07, Luc Van Oostenryck wrote:
> From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> When inlining a variadic function (unsupported in general by
> sparse but OK when the arguments are unused and occurs as such
> in the kernel), the extra arguments are added in the declaration
> list as SYM_NODE.
> 
> But these arguments can already be SYM_NODEs. Sparse doesn't
> support everywhere such nested nodes (they must be merged) but
> in this case it's fine as the node will be merged when evaluated.
> 
> Add a comment telling the situation is fine.
> Also, move the code to where the variadic arguments are handled
> since the fixed one will be anyway directly overwritten.
> 
> Note: Sparse doesn't really support inlining of variadic functions
>       but is fine when the arguments are not used (and such cases
>       occur in the kernel).

This note prompted a feeling of deja-vu :) It is simply repeating
(in slightly different words) the content of the first paragraph.

ATB,
Ramsay Jones

> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  inline.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/inline.c b/inline.c
> index 0097e4bf620a..d031c9b19128 100644
> --- a/inline.c
> +++ b/inline.c
> @@ -542,11 +542,15 @@ int inline_function(struct expression *expr, struct symbol *sym)
>  	FOR_EACH_PTR(arg_list, arg) {
>  		struct symbol *a = alloc_symbol(arg->pos, SYM_NODE);
>  
> -		a->ctype.base_type = arg->ctype;
>  		if (name) {
>  			*a = *name;
>  			set_replace(name, a);
>  			add_symbol(&fn_symbol_list, a);
> +		} else {
> +			// This may create a node of a node but it will
> +			// be resolved later when the corresponding
> +			// STMT_DECLARATION will be evaluated.
> +			a->ctype.base_type = arg->ctype;
>  		}
>  		a->initializer = arg;
>  		add_symbol(&arg_decl, a);
