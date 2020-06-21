From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] evaluate.c: fix a gcc 'may be used uninitialized' warning
Date: Sun, 21 Jun 2020 22:18:04 +0200
Message-ID: <20200621201804.iww6chjwknkldo7n@ltop.local>
References: <b3ff0d78-ceea-768e-339c-22466b84b81d@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbgFUUSv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 21 Jun 2020 16:18:51 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FEDC061794
        for <linux-sparse@vger.kernel.org>; Sun, 21 Jun 2020 13:18:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l12so15839367ejn.10
        for <linux-sparse@vger.kernel.org>; Sun, 21 Jun 2020 13:18:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b3ff0d78-ceea-768e-339c-22466b84b81d@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Jun 21, 2020 at 08:34:31PM +0100, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Luc,
> 
> Thanks for v0.6.2! :-D
> 
> However, I am seeing a gcc compiler warning:
> 
>     CC      evaluate.o
>   evaluate.c: In function ‘evaluate_generic_selection’:
>   evaluate.c:3310:38: warning: ‘base’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>      if (base->type == SYM_ARRAY && base->array_size) {
>                                     ~~~~^~~~~~~~~~~~
> 
> This patch is just an FYI/quick-fix for this warning. The patch
> I wanted to send, moved the declaration of the base symbol into
> a new block at the 'if (stype->type == SYM_NODE)' conditional,
> which would now include the (indented) SYM_ARRAY conditional
> block. This, of course, meant that the SYM_ARRAY conditional was
> indented too far to the right ... ;-)
> 
> [perhaps this argues for that code to be refactored into a function]

I just saw this warning too. Of course, *after* the release is made.
 
What I had in made while writing the code was:
		base = stype;
		if (stype->type == SYM_NODE)
			base = stype->ctype.base_type;

Your patch here below will work correctly but is not semantically
correct if stype->type != SYM_NODE. Fortunately, it's guaranteed
to always be a SYM_NODE (typename() is so). So, I'll probably
commit the following:

-               if (stype->type == SYM_NODE)
-                       base = stype->ctype.base_type;
