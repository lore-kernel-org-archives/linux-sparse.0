Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27355C433FE
	for <linux-sparse@archiver.kernel.org>; Fri,  1 Apr 2022 00:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiDAAYJ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Mar 2022 20:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbiDAAYG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Mar 2022 20:24:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BC923F9E0
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 17:22:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id p26-20020a05600c1d9a00b0038ccbff1951so2616775wms.1
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 17:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKqz1Mdn+a76YTOAN4pkLcsDdxqMIb341GyJ1mMbn4g=;
        b=r7/0P+gLeJObOX79hjnX/5UuEQeJl4zuAbrJGyhV08YNdiRMj8TzrvJbe5YkmUAGWY
         mZhA9emHoEHCn4lEv4EvNc8fqo4nqUyfDQFq4BEwCQx/DTtnpWDwjd3/IaEZsI8pSqyS
         WjpMp3DpVBxwsEJ95nCBJ+/pczjqk7ilCSfpnVILZ7SWNsYZmbp3MDKNhETQzOYksHYF
         qhGFQxDs8lUwKxvSdlJn+vSLlyHqbuXTRb1N11WJyph0kUPERw3FVbCryrZTBj2Tweo9
         RJpGE7f0J9S2buBc0BEs6Q2CQdJ5UwjnCB//QwYVmRQoKId9dxhttnNc/CCDe/PtT7UL
         PY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKqz1Mdn+a76YTOAN4pkLcsDdxqMIb341GyJ1mMbn4g=;
        b=y3WgmAX/1RyTH2BAA26x51bi/tcuzYZh6fmpz+rFHQNnrcaGv8yc2h89WGVVjGxiUD
         8+kHy5RBPHscqFb5xs1mw+lJXxjDjruVWCDszf33W2xxV2d5+IllWxGLxhYTRpEuMzS8
         GIrnRgHenQIqzQsbl9Sgcl+SOHXZwznZsfV8AWzFBqhFSgtLmSTctcuFn9icIKVxAU9m
         k64Y41pnMl5akC0Ud8mHPfCIJyDn5X5WNt1yQ4hg7aJS9m69AOm7hJ8bDl6KjY4n3+Eq
         1V4HfNpO4msRycRhRKk81Wv/x3998/EmZl0JDNG7SCaqr6ueQbs2uMH+iOIkpf78ORWT
         hSrg==
X-Gm-Message-State: AOAM53295Nubrr5gDf4ykq+BmhcSpgUQrA+b1lABgyTit4pSMV1s4JSZ
        TjCmyqdL0/T5IAGu5nzyTlNCLpvTO+nAjRVdTkX27A==
X-Google-Smtp-Source: ABdhPJyXs2kiijhvj7ZEIkf4LgFEBAL3bNGbwnp9Hp9Ce+KJcEqlpKTa5nUQk4PlzawW8Gaz7vFgZm/0MW22sAEhJh4=
X-Received: by 2002:a05:600c:4f48:b0:38c:a460:cb6 with SMTP id
 m8-20020a05600c4f4800b0038ca4600cb6mr6654078wmq.96.1648772536629; Thu, 31 Mar
 2022 17:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1648674305.git.marcelo.schmitt1@gmail.com> <62f461a20600b95e694016c4e5348ef2e260fa87.1648674305.git.marcelo.schmitt1@gmail.com>
In-Reply-To: <62f461a20600b95e694016c4e5348ef2e260fa87.1648674305.git.marcelo.schmitt1@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 1 Apr 2022 08:22:05 +0800
Message-ID: <CABVgOSktSP6GwU+zfJLC7A-UZUKT0QHSmACG-ScFDhb34Jf-aw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] Documentation: dev-tools: Enhance static analysis
 section with discussion
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Daniel Latypov <dlatypov@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-sparse@vger.kernel.org, cocci@inria.fr,
        smatch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, julia.lawall@inria.fr
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Mar 31, 2022 at 5:50 AM Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
>
> Enhance the static analysis tools section with a discussion on when to
> use each of them.
>
> This was mainly taken from Dan Carpenter and Julia Lawall's comments on
> a previous documentation patch for static analysis tools.
>
> Lore: https://lore.kernel.org/linux-doc/20220329090911.GX3293@kadam/T/#mb97770c8e938095aadc3ee08f4ac7fe32ae386e6
>
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Acked-by: David Gow <davidgow@google.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Julia Lawall <julia.lawall@inria.fr>
> ---
> Change log v2 -> v3:
> - Changed the paragraph about Sparse to make it sound better (hopefully)
> - Minor adjusts to make the considerations about Coccinelle sound better
>   and be precise

These (plus the cut down note on Sparse/Smatch overlaps) are
definitely an improvement.

Assuming no-one with more knowledge of these that me objects, I think
this is good-to-go!

Thanks,
-- David
