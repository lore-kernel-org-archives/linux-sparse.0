Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCCCC433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 21 May 2022 09:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiEUJq1 (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 May 2022 05:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbiEUJq0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 May 2022 05:46:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BD52CDD8
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 02:46:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id jx22so6114719ejb.12
        for <linux-sparse@vger.kernel.org>; Sat, 21 May 2022 02:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JV7spCalXEKoXLdLh7Z/t0i3QcibKd4Vm4M2Rr+//fU=;
        b=VHSsWCUIrJK4f/9280+x9+Gj6kESox7t39eTZqhivQ2Lx27A7wYK7mxpi56vKJ1Wiy
         BoT91Muk87GKFS3f20gi4r35aryZnBe4WVJ0pqnOrtAWce2OEOXmM5vrsnvyqZQvNtAz
         lHUK5Kp9nam+1pvQpbHewISahmfZakm/WoCoXejQnzm3wUy0cj8wYXrQE0THGIgAYQau
         18gK6lZAZu1Rpd+sx1VpowFI3T832VRSh96kEWe7nGCqgnbDLHLI+tnM0D6E6ehEGqkX
         55qVUvPUQUh5tpBOTE1iWt4SKmDmW+A9tp7qH6YHL4WxBIfAV/hFvKy7dXIj2Fxc8jIy
         5g6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JV7spCalXEKoXLdLh7Z/t0i3QcibKd4Vm4M2Rr+//fU=;
        b=HqU+Tgzkc9H7J+5HGpoREI2RIy+5IXANX2b6gUxv6d1ytHyCADrLuLXAcjt3JEPP9T
         dxA5CKVtXaYEDTg7wKQF+Fd3wUiO4e+P53snI7HW0iz4UqVo0s2edbPgPrVqYpDPRolI
         GQxOsQ3sKavr20RguD4o+x+c7i1tmGBhKmgEusl4RXxHKNevRd08gxrD8DswYdiEAEwa
         fYEmE8cdXZyrmDAGuV1kLIoB+Bdn4NPryLFYH5OE2kd+AbwUr968bF6Q2iXo6RQx/4zv
         k/AwXKRbL3ZRlZ8t8yYZuktT3GX5z5RrUojWxtVVh9DtfXwDQwDWFPNkBYgf2NLC3J8j
         4EvQ==
X-Gm-Message-State: AOAM533qdrvNHG/E9Toax7hLWCVNOPIQ0nTmfIsZ52oCSn7DD6fS/ukj
        8tLnXB9IyThxkaOir/TONCQ=
X-Google-Smtp-Source: ABdhPJwQuY/z8ESXtk0NcE3m8MYiSHJ3IM1MMOC5AJ0gpd9xH/nj37SmT8fdkRUeVzONK3/YMNiM2w==
X-Received: by 2002:a17:906:fc20:b0:6fe:a5f6:379d with SMTP id ov32-20020a170906fc2000b006fea5f6379dmr6915648ejb.503.1653126383942;
        Sat, 21 May 2022 02:46:23 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id er22-20020a170907739600b006fe9f9d0938sm2326068ejc.175.2022.05.21.02.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 02:46:23 -0700 (PDT)
Date:   Sat, 21 May 2022 11:46:22 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/3] semind: Index more symbols
Message-ID: <20220521094622.ygnkse26visliklk@mail>
References: <20211102140645.83081-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102140645.83081-1-gladkov.alexey@gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Nov 02, 2021 at 03:06:42PM +0100, Alexey Gladkov wrote:
> Greetings!
> 
> For indexing purposes, macros definitions and typedefs are added to the
> semind database. Functions that are not used in the code are also indexed.

Thank you very much, pushed now, an ... apologies for this huge delay.

-- Luc
