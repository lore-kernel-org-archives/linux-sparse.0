Return-Path: <SRS0=1LG9=AT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1580C433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 10:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8ED2078A
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jul 2020 10:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SakSNiCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgGHKnz (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgGHKny (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Jul 2020 06:43:54 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D05C08C5DC;
        Wed,  8 Jul 2020 03:43:54 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l12so49805409ejn.10;
        Wed, 08 Jul 2020 03:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x3eyn7eZ0FIqH1Tq9PodhavXKLrdDvdkjZF73yDBrx4=;
        b=SakSNiCEsrxZlY3T62jSxVpnQnl2st34LRnb3TdjtoTsI6BniJFJ25N3Uhm4W25jny
         T2YLYO3DkdglV9Tx+VAx/xr9bpUO1geP1TmmOJ5TaqlAfQI8PfSgQ/ICCdJmeo3xX3DS
         VJp+oiwj8Gg8/h/mNFXsWQ8xUlCLj+zN65CpPzw8gYQaQsumh7jG8iRoACp7Z77k46gO
         hrZuCgRv06Ll+rQPAyka+R4dxvhNsDlJeB91xVVEfAAyuWoQqOtlMWcP2BwnWKe5N007
         34Mlj/nZs5BbdwVJKMVLAp6WXixy5vJ7EfIlTlq6RZXNfuxIJk0miRNAUf5u8dBEr0WR
         mUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x3eyn7eZ0FIqH1Tq9PodhavXKLrdDvdkjZF73yDBrx4=;
        b=FikTP+Xtb2VZnSJu2Bw0Aj+A0H0Z8aSk7gxbelUOlXDR6WEGl1O3P7fpmoLc8wlXOT
         YUW6Ea4Hjh4pSnz+MkJy49koXcXhIoQaLbNhdCzRdIKAzFRuRtvge5IvZJe5P//J0EKf
         mGhFLRD/4CqJYfI/WPUzvksUjPnDjcDpxCZYnhdB8jNGtjA9H/Zd5VJ8At7b1Ie/ZUEp
         yH00qN8hJdJVS4Yh9Ida+DrZet6mP8j+j8vxLUtCUdiv4ke1yeA9OTffU/IHYVusvQ24
         8ZMvhvFIcVls65D4x5+mJodwYrsHkff4aituFC3LIgm6gJdnwmT5TkpgNqKs1xEbFOai
         dN1A==
X-Gm-Message-State: AOAM532a2nYpmM7vM/5yP/aKMzOTqzegkxuDCbfvUY04g8zGLbTRh7MU
        TCii4xP3LVCFGpycVVWN36A=
X-Google-Smtp-Source: ABdhPJyn9zqj/mpaPntsAh8gHOHkpfCS9Xt3EErZ0oFuWqbCp63T4BHIjukC7JAF8PAntbeQKvOaMA==
X-Received: by 2002:a17:906:b15:: with SMTP id u21mr51686908ejg.520.1594205032710;
        Wed, 08 Jul 2020 03:43:52 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:d05c:92b3:9c89:b3fc])
        by smtp.gmail.com with ESMTPSA id l22sm1710396ejr.98.2020.07.08.03.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 03:43:51 -0700 (PDT)
Date:   Wed, 8 Jul 2020 12:43:50 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Sparse improvements & regressions for Linux v5.7-rc1 -> v5.8-rc1
Message-ID: <20200708104350.j2d3tz2udin2mqlw@ltop.local>
References: <20200708000651.f5bykhd3mhgsbvk7@ltop.local>
 <20200708095904.GI2549@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708095904.GI2549@kadam>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Jul 08, 2020 at 12:59:04PM +0300, Dan Carpenter wrote:
> On Wed, Jul 08, 2020 at 02:06:51AM +0200, Luc Van Oostenryck wrote:
> > I've finally written a silly script to easily compare my tests
> > of Sparse on the kernel. So, it's now easy to share those results.
> > 
> > It's a comparison of Sparse's unique warnings between v5.7-rc1 &
> > v5.8-rc1 on x86-64 (defconfig + allyesconfig). The results are
> > quite similar on other architectures.
> > 
> > Note that the differences can be caused by changes in the kernel
> > code or in Sparse code.
> > 
> > Have fun.
> > 
> 
> This is quite fun!  Could you post the raw errors from the v5.8-rc1
> kernel as well?  Probably it's too big for LKML, so it would have to
> be posted to pastebin or something.

Yes, even compressed it's too big.
I've added them in my dev tree on github:
	https://github.com/lucvoo/sparse-dev/commits/logs
It's just the last commit in the subdirectory 'Logs'.
I've added the raw and the cooked form.

Have fun,
-- Luc
