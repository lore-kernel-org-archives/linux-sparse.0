Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA0C433EF
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 14:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiFZOi2 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 10:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFZOi2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 10:38:28 -0400
Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC953BC03
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 07:38:25 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id 5TP4oII6UuTE05TP5oJccu; Sun, 26 Jun 2022 15:38:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1656254303; bh=DDv1kDt8hhDq0DKyx2F7TE//ej1A2Il9bR817WJWsx8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=E0d2OImfTQ71mAfMccCV4MihkcCtQUfiMHQjR6LxL9VaXErZ6GOSxRdFJPjqMlax9
         LXETJXnqydl8rQaox/wZZKCVAj1ZDY/uSHBNdRzMDWkaH/u3pB3VNcvfwRDr0ZBS/a
         UXNLygeF/DQ5M0lhfupzkG4AKfO/xmwQC3SnQrURUpjTWO1C27c3rkCl3XpvrSOjMq
         EAnqpEUafzMT978CwtyULX5pL+2wyuib2Q1EqcjwX03MIHHzJGRyOUyOIqUe1/4hgF
         MnVU6BnqmeGxD6b//PAjYMI4boku5cgvGh7ZL+jte8KLxeHFYff/qqPTAW4mawGGZL
         Bfcs33RSZMwRQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=DfIEF9hW c=1 sm=1 tr=0 ts=62b86f5f
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=W1RdySg6JHUqfKvxTWwA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <2491612b-afa2-5e81-05d7-73bfd6aaa26c@ramsayjones.plus.com>
Date:   Sun, 26 Jun 2022 15:38:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] inline: avoid node of node on variadics
Content-Language: en-GB
To:     Luc Van Oostenryck <lucvoo@kernel.org>,
        linux-sparse@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <20220625221454.63271-1-lucvoo@kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20220625221454.63271-1-lucvoo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMF0Um2FcdjHBLbmWFsqcZPQCLq100OFclIMTlEeknvr9ui0iLCtwKyxIZCQ1GNX6CEuatbBbJQfVi8NSQf5pbBWnydUFwel+k7LQyd9ijkNUmMKJb3D
 7OnXvdnOH5jIpD0AjXuIbVSRKbNwWroglSSf6nrrhlyCsME/dBJGy6DM1U6Hct5kp87TvxwCFhZZpI62IRR4gmJX2xAVF3kB/hM=
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi Luc,

I was just about to comment on this patch when I noticed [PATCH 2/6] of
a new series, which, if I'm reading it correctly replaces this patch; yes?

[I have been a little tardy recently, but I do try to read all patches! ;) ]

ATB,
Ramsay Jones

On 25/06/2022 23:14, Luc Van Oostenryck wrote:
> From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> When inlining a variadic function (unsupported in general by
> sparse but OK when the arguments are unused and occurs as such
> in the kernel), the extra arguments are added in the declaration
> list as SYM_NODE.
> 
> But the base type of these nodes are the effective arguments and
> are, as such, already SYM_NODEs. So, nodes of nodes are created
> and Sparse doesn't support those (these nodes must be merged).
> 
> Fix this, by simply copying the effective argument, like done
> for the non-variadic ones.
> 
> Note: Sparse doesn't really support inlining of variadic functions
>       but is fine when the arguments are not used (and such cases
>       occur in the kernel).
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  inline.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/inline.c b/inline.c
> index 0097e4bf620a..4ee44eedec7a 100644
> --- a/inline.c
> +++ b/inline.c
> @@ -542,11 +542,12 @@ int inline_function(struct expression *expr, struct symbol *sym)
>  	FOR_EACH_PTR(arg_list, arg) {
>  		struct symbol *a = alloc_symbol(arg->pos, SYM_NODE);
>  
> -		a->ctype.base_type = arg->ctype;
>  		if (name) {
>  			*a = *name;
>  			set_replace(name, a);
>  			add_symbol(&fn_symbol_list, a);
> +		} else {
> +			*a = *arg->ctype;
>  		}
>  		a->initializer = arg;
>  		add_symbol(&arg_decl, a);
