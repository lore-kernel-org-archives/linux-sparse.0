Return-Path: <SRS0=PqT7=AC=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FFC433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Jun 2020 20:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6D42527C
	for <linux-sparse@archiver.kernel.org>; Sun, 21 Jun 2020 20:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEDCCDfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgFUUSv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 21 Jun 2020 16:18:51 -0400
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xcxNKWEdrZMD/P8dO5ztXQWb8NwHPdE8F8+iI+ek7t4=;
        b=QEDCCDfQsJC1L2NaR2WQLPPKOn3LOVoM/mUp0CrZf2AMqeqeglT7ZgjnuKOkmIJnJy
         kUDldnR8FNtCYga6CLyjPOZqyYjKs7j2saPUv72OEb6xFM34HFK3x4yGkqm2AWxXHUU+
         S1en4XA6KiC6z5nKDv4IKSTYUnOaX4hLl3t0Ma4KKotoPsiC+wx9WuTCogdluEpkOd0B
         NPDoxtCXxU3zMW+z6evNzTivZoOMwRiGFMBlsu2M1o8E29/4oihezCCw9u9eNp8JUJaz
         i1hHqJhcRgvuSIZJrMFVNfcuiRZ5xR0TImx4ncTZKIOmG96FBdtC4MGuPrxXjEU2KnfY
         hH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xcxNKWEdrZMD/P8dO5ztXQWb8NwHPdE8F8+iI+ek7t4=;
        b=n525OvYabovHtUZlq8L8dHMYebmd3wQ0MkJaDWxBMEVLzRdtBChz5NeYwmUwdtbU2g
         5DC/DdIzVydG08xz+W/CaRnN3uO/P9kMm9zCJnEutS6myCnlXuHoXhdVjySqte+qF4mV
         FJkvUI7Rixs55d9Xzr57MwFCMnGzMVF5fbYcvcz84C6lmtYnn2N+v+diLxFo5xdxPhXC
         W0MdrSsHn5pspgPGkzKfs9mLusSyrYsYygg6RlkWmfygBgeab8C1vOP873jq131LxsTL
         sdt2UmDbgtufYspEGIE0xwS2xdKMxudVJVaYfaY12m8fhyGukXE3yOOnjHk2nP2T4pKK
         lBYQ==
X-Gm-Message-State: AOAM531CzV0FiQh39/Naj4gj0PZHeKsfMWLHF2qVLnaO+lMZIT+pP/TF
        zAG4+Ie7tg0gQp7ENjLHzaQ2YyLM
X-Google-Smtp-Source: ABdhPJx16nUf0uIDXm4KYo6QEDqEcMqPAJzgALGv1xy/Ecydb0kg5kmv6QzWXXqgKe4e/+SKMx23ig==
X-Received: by 2002:a17:906:4a17:: with SMTP id w23mr6729950eju.360.1592770729767;
        Sun, 21 Jun 2020 13:18:49 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:45d4:9765:feb4:e780])
        by smtp.gmail.com with ESMTPSA id o90sm10731299edb.60.2020.06.21.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 13:18:49 -0700 (PDT)
Date:   Sun, 21 Jun 2020 22:18:04 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] evaluate.c: fix a gcc 'may be used uninitialized' warning
Message-ID: <20200621201804.iww6chjwknkldo7n@ltop.local>
References: <b3ff0d78-ceea-768e-339c-22466b84b81d@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3ff0d78-ceea-768e-339c-22466b84b81d@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org
Message-ID: <20200621201804.acjzRRdbXMrTSYtCGTewjDnqLzq7oUTB8pMfUWKgRbM@z>

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
-
+               base = stype->ctype.base_type;

Thanks for the bug report and for giving a try to the release.
-- Luc
