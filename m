Return-Path: <SRS0=O0OO=BT=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34729C433E0
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 19:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2783206C0
	for <linux-sparse@archiver.kernel.org>; Sun,  9 Aug 2020 19:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3cDFtdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgHITVL (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgHITVL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Aug 2020 15:21:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E235C061756
        for <linux-sparse@vger.kernel.org>; Sun,  9 Aug 2020 12:21:11 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id f24so7287800ejx.6
        for <linux-sparse@vger.kernel.org>; Sun, 09 Aug 2020 12:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8hqtZesgm9V2FVf3D3vHVvRBSYGIt8uCvxS9gdZa9MI=;
        b=N3cDFtdLgnol2nETseLUNjeH5OZPz3cCH58v5kv0R5X+nyQKVBfMcxr85oBmmCioXK
         jd5IrI4ZFNYU1a5RcR3IW9zHcSwJogzucAIaRUJnCFLTC+aStOeYloqiE1KoAwA8U8MK
         CvUjsoKhklubFuMBgHWkBMrF1URV8Dz2OCC985LaPSlQrBgyUwQ1dWMcXAgtqNeqvEjy
         IKnwlcMHTNuIprMfDDEUq1QDuxTBa5UyphL46a8zFaSxfnOCqHE65ICnABkAleEBdaJQ
         TajDSsrd4FbUfxsmnw+BuEY9/zNFQk494n35nKbkC4BXA4jQLYCm7ZQKdxkiy9v+/O08
         Wgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8hqtZesgm9V2FVf3D3vHVvRBSYGIt8uCvxS9gdZa9MI=;
        b=OBDDnfYboydjx44RtFBP5mHbHBucNllntd/HYaNe+/UXVAU/DbZ71DxsON13eYcH2g
         h474X2dZTAd68u5G+dAqxmzljAsRiVLT8OJWDzP/+jh5emFEJsppAU8tpaCOrEi/VeFj
         g3wDUZjhl/pxfqzmGqwtMaXEDZ1nea94YryapJWuVdHvSmlRH9yUpNwlk1HXi4VDvVBg
         6T/f1h1dVcimGIn8Cd0VQ+8/6raW35xJ77VtKinSDC3QQgWRog+PKLYL+wBJhWbh7wWF
         s588Zk124mKyQLCNh3Jpdlw56AySMdUud+tR3LUyj/QvAwPe0HhsUSPLCiWQ37RSL0wE
         BB/A==
X-Gm-Message-State: AOAM532e+uCWFgQ52zu6ZJ7zeQMjbktSi2J4MOiiCgshwZKjWEGoxvsh
        biWyKZZBoWJ9BMu6ag3g61zO2gpO
X-Google-Smtp-Source: ABdhPJxYU+H9eWf2Fg0fwwygrdpwkfU96I2cqovDHuFoWWyEz/8m4QHSIagMXERGKnKHFtfcLJrWGQ==
X-Received: by 2002:a17:906:ce59:: with SMTP id se25mr19935160ejb.359.1597000868959;
        Sun, 09 Aug 2020 12:21:08 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:b5f4:fb07:8fe3:ee8e])
        by smtp.gmail.com with ESMTPSA id lj26sm11144957ejb.26.2020.08.09.12.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 12:21:07 -0700 (PDT)
Date:   Sun, 9 Aug 2020 21:21:06 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= / sparse 
        <gitlab+f2c7a505ea576c194910ce335a7779a8@salsa.debian.org>
Cc:     linux-sparse@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200809192106.ddombg3xdmjiiciw@ltop.local>
References: <reply-f2c7a505ea576c194910ce335a7779a8@salsa.debian.org>
 <merge_request_28506@salsa.debian.org>
 <note_184882@salsa.debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <note_184882@salsa.debian.org>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

I see that sparse v0.6.2 have made it to Debian testing.

Thanks a lot for having made this possible.

-- Luc
