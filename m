Return-Path: <SRS0=AbyH=DC=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C0C4363D
	for <linux-sparse@archiver.kernel.org>; Fri, 25 Sep 2020 08:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39C1208B6
	for <linux-sparse@archiver.kernel.org>; Fri, 25 Sep 2020 08:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6J6Yr7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgIYIqu (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 25 Sep 2020 04:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgIYIqu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 25 Sep 2020 04:46:50 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F13C0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 25 Sep 2020 01:46:49 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o8so2523017ejb.10
        for <linux-sparse@vger.kernel.org>; Fri, 25 Sep 2020 01:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JStmwhzQF8wQZ7DB/SAMfvBkRinHzJbCp2xKaEl4/O4=;
        b=L6J6Yr7amSLknni/hmc3UZmUVrBHMm19bK+K5CsHtqTCKCM2D8bfPvGBGaHad8nmux
         KXZTfUqD4I3t+c2QQc3IMuogIK1Y8ZLZ86tK337wi/PlDwlTq/if815KkJ/80avEvF2a
         SZcO9WHD/p8xcm/E2n7sLM3I9Pj+rIxZTZLVHpv3gzdTR1Tdih5DcUBxdlWR5bjT6v5/
         yjP25PQS6itysR8hMB4y1DEWvVKUYHtK31bQl+ZeJ1NQ3KLWvDqdG3G0snZ7dcZgQm7i
         0DavsfM1nu3S0ApkqZqyTWb8cshEFxZ1V9hz85gxAgvaikelS5zCgZLucGl0Ivy7to25
         mO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JStmwhzQF8wQZ7DB/SAMfvBkRinHzJbCp2xKaEl4/O4=;
        b=fSaSUpOszH1pLuaNujkeFukS2O9+bOjzUOEs6V+n4AauOJHylb9vDIZqaCYr56ffCT
         PTP3MX3r9snAoC4Am/EVkZaMtDxk8uARwM3QDHjifMEMZ6UARjnaoPKjOegYeYfRAzey
         n/i+LGxHrm1ea8G2KpuXiEX2F7tC2qHT8wVgCPQLKogDISIjGvYWkpQfwudTiG1dB0RC
         ZvSdwpVlp1IAtlJOgjLzhj0SdnUon8mkGnttIfacaUm0KiE7LTjpcUOUnmD7dOljYngJ
         1XiIN03XZU2R7Zm6Dd5gpfQV6v9F0eucPtDcV/qUWDsGRySd/NZ68HI0+BkEorP4yc6u
         KyvQ==
X-Gm-Message-State: AOAM5302syEz4K9UpBrcGQkWm/P2QeonAh2ysnDNte+SZFcQF6XldpvU
        oP6ZB+N1Dh//7vMc6X9V7n0=
X-Google-Smtp-Source: ABdhPJyNrKozgFr5Iu+h5lV62nQVPMERG3Yt6TZf3jQR+I3gXXjBvKqZBMahc54RTBclS9q6p1he3Q==
X-Received: by 2002:a17:906:3759:: with SMTP id e25mr1599966ejc.281.1601023608482;
        Fri, 25 Sep 2020 01:46:48 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:4056:ade:a865:c9e1])
        by smtp.gmail.com with ESMTPSA id g16sm1327006edf.20.2020.09.25.01.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 01:46:47 -0700 (PDT)
Date:   Fri, 25 Sep 2020 10:46:46 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jiri Slaby <jirislaby@gmail.com>
Cc:     Christian Eggers <ceggers@arri.de>, linux-sparse@vger.kernel.org,
        Dirk Mueller <dmueller@suse.com>
Subject: Re: Segmentation fault when running sparse with current linux master
Message-ID: <20200925084646.56wyiphyl65qidwd@ltop.local>
References: <1832426.vqaiCtIcaR@n95hx1g2>
 <20200917142017.5fhdjdfrwjyjqlpu@ltop.local>
 <4184357.m9dUj1Odhv@n95hx1g2>
 <20200924193817.5ilitvaqneach5pg@ltop.local>
 <141c85b6-f607-7594-ed3f-49684fe4bb3a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <141c85b6-f607-7594-ed3f-49684fe4bb3a@gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Sep 25, 2020 at 07:37:57AM +0200, Jiri Slaby wrote:
> On 24. 09. 20, 21:38, Luc Van Oostenryck wrote:
> > 
> > In the official tree, there is a branch 'maint-v0.6.2' which just contain
> > 4 patches fixing some problems with the release v0.6.2, the second patch
> > 	77f35b796cc8 ("generic: fix missing inlining of generic expression")
> > being the one fixing this problem.
> 
> Being fixed in Tumbleweed:
> https://build.opensuse.org/request/show/837254

Awesome! Thank you.
 
> If you want the fix on older distros, we can do that, but you have to
> create a bug against the product first… 20180324 is pretty old version
> and is both in 15.1 and even 15.2.

Mmmm, 20180324, that's sparse v0.5.2. It's very old indeed and
unusable for current kernel development anyway.

Best regards,
-- Luc
