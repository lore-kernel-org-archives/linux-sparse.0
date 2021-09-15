Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879F6C433FE
	for <linux-sparse@archiver.kernel.org>; Wed, 15 Sep 2021 19:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A58A61165
	for <linux-sparse@archiver.kernel.org>; Wed, 15 Sep 2021 19:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhIOTUh (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 15 Sep 2021 15:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhIOTUg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Sep 2021 15:20:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD644C061574
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 12:19:16 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i7so8381680lfr.13
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 12:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRAe5/tE1Mx+glbEumA/10LHbf2sLTrpOcfg2d46p4U=;
        b=VWatl0Tg6Rs2+8cyQ1nNI7llz+Jwjnz45GyA7Ialu8h0m7yH1LKoqAuI6k/Ywlygil
         KDQQX525bUWsnQP59sCymg2Xi7UR5AijXzfqK2/Z2O+QbzWUet5is4fYAxM3ieQOdqUi
         Q6n8XepF4xgcAuR6YdqHkkzo9csOkkBGuEk5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRAe5/tE1Mx+glbEumA/10LHbf2sLTrpOcfg2d46p4U=;
        b=dTpGRY1sCTLkCz8Gkm1tWs615TDFQn8ZNys4CRnofRPCJqSbFLFeZm1q4mZRGLbuDF
         Pnps/7ZbyL0kuz2KNuZW/kzM5nMkd2EBKS3YyCxtGIA8kh2V4YpXSiZdiQPa8jYSEIoT
         bAv+UkfN+12+8lP0t9I5jQufdf3YNL/pHUguUgMmC6Wuwb4mU+L0JHfbOgaJgin6lwpb
         HMEJRfiiPepcQIzPio2HBYhc/jroebLXBiSMNmTIzRqYVyz+A3E13alHbhU/D4nZ3C7i
         B1Y7qomaoRxhSZSg9a723TXjG7OMMxh6UpuXM5BvZOWQ0T7cERAubAwQ8ZqTIDzas8VO
         cIgg==
X-Gm-Message-State: AOAM53345MaEq4kPWKUjKErA1nDYLp5nkk0z05SzJm2/GmX8RyQaqi3j
        NhOmZt1rnzkZlI8hBUto6ckNXlyJMg8y+7TQw2k=
X-Google-Smtp-Source: ABdhPJz382k3KzqJkgEB9rVZFxluAxDRaaCjHX2/zrSKdf1w5wv2djxFoPTYu102UBezYSvWokaOPg==
X-Received: by 2002:a05:6512:c15:: with SMTP id z21mr1121382lfu.193.1631733554952;
        Wed, 15 Sep 2021 12:19:14 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id k27sm95957ljn.72.2021.09.15.12.19.14
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 12:19:14 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id i4so8553188lfv.4
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 12:19:14 -0700 (PDT)
X-Received: by 2002:a05:6512:94e:: with SMTP id u14mr1121103lft.173.1631733554128;
 Wed, 15 Sep 2021 12:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210915035227.630204-1-linux@roeck-us.net>
In-Reply-To: <20210915035227.630204-1-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 12:18:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
Message-ID: <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Sep 14, 2021 at 8:52 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> This patch series introduces absolute_pointer() to fix the problem.
> absolute_pointer() disassociates a pointer from its originating symbol
> type and context, and thus prevents gcc from making assumptions about
> pointers passed to memory operations.

Ok, I've applied this to my tree.

I note that the physical BOOT_PCB addresses in the alpha setup.h file
might be useful for things like MILO in user space, but since I
couldn't even find MILO sources any more, I couldn't really check.

I suspect alpha is basically on life support and presumably nobody
would ever compile a bootloader anyway, so it's unlikely to matter.

If somebody does find any issues, we'll know better and we can ask
where the user space sources are that might use that alpha setup.h
file.

                Linus
