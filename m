Return-Path: <SRS0=17k7=BP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C863C433DF
	for <linux-sparse@archiver.kernel.org>; Wed,  5 Aug 2020 19:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1354C22CA0
	for <linux-sparse@archiver.kernel.org>; Wed,  5 Aug 2020 19:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn3mOjzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgHET6f (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbgHET6b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 5 Aug 2020 15:58:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB10AC061575
        for <linux-sparse@vger.kernel.org>; Wed,  5 Aug 2020 12:58:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qc22so32938749ejb.4
        for <linux-sparse@vger.kernel.org>; Wed, 05 Aug 2020 12:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cpe7PWUIXDxcwwXs6oe9FZfyyAUB0Go8L3Ngj344DuY=;
        b=kn3mOjzGKernompHjiNB6kp3Wt37YgFZ0R6IcaMfln/sCdFgya5S3bUz21czicPUfH
         wsHp58Ck2zWYKi8x6dOIptmqhz09p8x1VAJYmH+ta5RowivzvM5pt51l5rsu++ByiEds
         sXFrUuQ1YBuIFwo3pwBSlYKR4HzMeJ7ZR5gheX3zU3lQvAtNzB3AKawRmaN7jQwQzz7g
         XGsLYDnvOjJ9U8/Ha8L26SsiRhroWXQaF3dwcH2KUzOg7zaISdZTizAlU6R1cKyewQ4p
         3NogSj0Vy5pRGdMa3eCkST1rGHzau2kpfnm5KU4JZIClvKLVmUkxAJpbM3HoyAZkAW7j
         nFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cpe7PWUIXDxcwwXs6oe9FZfyyAUB0Go8L3Ngj344DuY=;
        b=oHf/6HoiaU2MS2KhvMGxkcORs2beKHbOWE2rKNFYN3lQVEQnwKqJ6fzR11jcGRuFmd
         dvQHYWVvl0lTBC0sgXZKM4C9M/4Ph5QVE+I/7RWK4xof9R9ZlL4MBbMZeUitod2JQhcx
         hXEngnMZu6X5Gsrkm+K1d4Yd3xRXAZluQYMzJ8ji/0kOjVv+0wWtBAE3LBl4uwc8PHJg
         mbkCuYOsBMMc3r5TvUmIJwNYPhZ3VPudsVVEL3lenjwo3QIg6/b8u/mqKQxcOGbDrAQa
         rSJRVQEb3tRBv054YAI+/Xe0E6feDBoqOnx1ytGAEBtWZ4xVBJ5IW38ZRhjDN2VFuuux
         iGuA==
X-Gm-Message-State: AOAM533OkV0FqU7/evkGutSfa6P9O+z4jYLg/DGhFnYOVrXAM15/zmM+
        d24Xy3I3u/u4gc5+dmJ3Nam/V2HI
X-Google-Smtp-Source: ABdhPJzlzDsdeHCvIoGXrlwYQ8wc4Fvcbqzp042m7SWuJiJmZAezr5MLRYaZQc5MNmwr5XMRwf1wTQ==
X-Received: by 2002:a17:907:41dc:: with SMTP id og20mr971140ejb.183.1596657505673;
        Wed, 05 Aug 2020 12:58:25 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:917a:43b0:ff2a:9935])
        by smtp.gmail.com with ESMTPSA id m12sm2008028edv.94.2020.08.05.12.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 12:58:24 -0700 (PDT)
Date:   Wed, 5 Aug 2020 21:58:23 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     linux-sparse@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200805195823.uwidzoysnfvfinqm@ltop.local>
References: <note_185453@salsa.debian.org>
 <note_185458@salsa.debian.org>
 <note_185460@salsa.debian.org>
 <note_185461@salsa.debian.org>
 <note_185530@salsa.debian.org>
 <note_185532@salsa.debian.org>
 <20200805110418.iutr56vyewhbqr7v@ltop.local>
 <20200805112141.ier2xkhm5sqjtbck@comp-core-i7-2640m-0182e6>
 <20200805152026.djv66eopgsgrtqyk@ltop.local>
 <20200805154449.jya7d45vfoi4eea6@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805154449.jya7d45vfoi4eea6@comp-core-i7-2640m-0182e6>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Aug 05, 2020 at 05:44:49PM +0200, Alexey Gladkov wrote:
> On Wed, Aug 05, 2020 at 05:20:26PM +0200, Luc Van Oostenryck wrote:
> > 
> > Excellent.
> > Can I apply the attached patch with your signoff and you as author?
> 
> Sure.

Thanks. I just pushed it upstream.

-- Luc 
