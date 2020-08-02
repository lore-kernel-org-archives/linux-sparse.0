Return-Path: <SRS0=4hY4=BM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B07C433E0
	for <linux-sparse@archiver.kernel.org>; Sun,  2 Aug 2020 21:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A1E2072A
	for <linux-sparse@archiver.kernel.org>; Sun,  2 Aug 2020 21:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+ysHNNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgHBVJY (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 2 Aug 2020 17:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgHBVJY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 2 Aug 2020 17:09:24 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527BDC06174A
        for <linux-sparse@vger.kernel.org>; Sun,  2 Aug 2020 14:09:23 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bo3so13961473ejb.11
        for <linux-sparse@vger.kernel.org>; Sun, 02 Aug 2020 14:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=U04ApghxsphbZ7jm1ro3v434pjgwhT3B8hCTRtWqo74=;
        b=i+ysHNNCPsMWnZe/O2KCqR36ybBh4cvllcsEBwW7o7FPm0O6NxofpXoInN05F3SwsK
         4uyK8JPsiQ9Q8jzpsEaOwHRHh3zuzkxWQtN9WhJTB6iv4CTKjmNd30MT9As3pqEEKVsc
         tZRJ05iFe84imq4VNURPirwNGXN6CioJrvNeosqvuIJOGUcf7o6mBOg4Wxt662JHUEBq
         yp/QwxaLENX85YiHH74BAzizmnv4w01TN6kO2DCaUnPqGDinwctytROKveiXcYmfgqF4
         GVqCRP2/koLzGGLOQb7fUpKnZ6qCyQzkoKNoXFIG3QU1YG9am317fJ/muMA5YEA9SSVA
         W9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U04ApghxsphbZ7jm1ro3v434pjgwhT3B8hCTRtWqo74=;
        b=HxiJ6zrLSBCS/sKp5VmdT8kzkEVQOl6btIw/lBJFM9TLDvKM02MTP6W1zKHxMOxZwL
         qEyG3mkrZWl0qpQ/LocJJ7jWAE72M++xJIgc8TZuJhhw65EEqvLsDUFixJ6mfKIrSZ6v
         q+hB7XSfbFpNFLEdCpxGjBoyBPtmd9dt3O+R23mQPIe0XwcIdfBMTbkFA0UfvOlSCfBg
         DGraDRUE5l4xmw2Z7W6PIjvQ8mZWle8rVgGy7aoVD0oh6K5+zHBhcfiOKAAMYGNZhnE3
         xW5CywqwKLxePX2zoHvqNAgm5Ef7noEed8MdkRa2oXZ5Nss4s9t6mhM3zFnCqih35kGg
         YveA==
X-Gm-Message-State: AOAM530lDT9x1yAwsQ72lHol2NqBYr00LDaXlYsSQulFrpQG2Tmz+lPi
        PVT+4eALhKg/c0YnmzyFLiqSfg7R
X-Google-Smtp-Source: ABdhPJwzOHw78hI/CbzJJjgcReqThDcZT9xFX4jaIjDTHcZSj6ogZ9/fjEtYnrVEwx0K69ymJzcJZQ==
X-Received: by 2002:a17:906:c056:: with SMTP id bm22mr14342385ejb.444.1596402562080;
        Sun, 02 Aug 2020 14:09:22 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:4c03:fcaa:281b:6f77])
        by smtp.gmail.com with ESMTPSA id s4sm14300492ejx.94.2020.08.02.14.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 14:09:21 -0700 (PDT)
Date:   Sun, 2 Aug 2020 23:09:20 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= / sparse 
        <gitlab+5b23fc039aeb26067a246ee32520567d@salsa.debian.org>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200802210920.2cimehb3rvnhvp3b@ltop.local>
References: <reply-5b23fc039aeb26067a246ee32520567d@salsa.debian.org>
 <merge_request_28506@salsa.debian.org>
 <note_185118@salsa.debian.org>
 <note_185156@salsa.debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <note_185156@salsa.debian.org>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Aug 02, 2020 at 08:19:46PM +0000, Uwe Kleine-König wrote:
> Uwe Kleine-König commented on a discussion: https://salsa.debian.org/ukleinek/sparse/-/merge_requests/2#note_185156
> 
> It only fails for memops.c because it is only called for that one. See
> https://salsa.debian.org/ukleinek/sparse/-/blob/debian-unstable/debian/rules

Ah yes, OK :)
I thought 'make selfcheck' was called.

-- Luc
