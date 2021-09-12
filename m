Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72925C433FE
	for <linux-sparse@archiver.kernel.org>; Sun, 12 Sep 2021 19:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5516560FDA
	for <linux-sparse@archiver.kernel.org>; Sun, 12 Sep 2021 19:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhILTNR (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 12 Sep 2021 15:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhILTNN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Sep 2021 15:13:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE6FC061574
        for <linux-sparse@vger.kernel.org>; Sun, 12 Sep 2021 12:11:59 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i7so91617lfr.13
        for <linux-sparse@vger.kernel.org>; Sun, 12 Sep 2021 12:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1PHZ6ydkqEkrZPVcY11k8G+o6nXM73c5JaOIi36jdM=;
        b=Mmh3TCnuXic/hCA6XvkP2osD5zmauEUtEa852ODITJl9q7DRJZnlYFaFYG+mxH6vf6
         Z+ggUrlsmP9EQRyIHakVw8bJD81GHQopdHiqd4QBP+UGydXePHYv5SH2cpjAaKjOE5af
         i5L6vjez7vZKGjXnjuCG5wVITdXtC1IYH3rOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1PHZ6ydkqEkrZPVcY11k8G+o6nXM73c5JaOIi36jdM=;
        b=p9xnyXi9cjDACAXlyh81ykZqQ4caN5UYsqWZY+Rk53Ia5PTDrX/BZg/TKe5rzeqOEg
         YLtkjGolcXIbH5Nk+z/nhVv5Vp8husxu2nC1CaAk/Svwd5UJYNbt6nQzmnMHvih0PeUv
         1zUUHoQ+/MWhDh0D6C8alM5+iB+ylEzXzRzU7EpxXdLOHTH+qQSo5elwl4hxZr0kKF5H
         YjAZf0S3goADCxZ8J7XediH5juwY6Fk5eC4mnJoKAhsl0xXeVdBVYQcEqzNjL8RpOxPJ
         /dqooexmNuRfvYcNgjn37JFSTG05di6abBsNu+lPKAbWb4gCPuuoNrGy+EOetAFnIatI
         T7qg==
X-Gm-Message-State: AOAM531LCxQJglW+fkC+wOgiqe4dmrjSXkimoRsVpGPYBLbhzoqW04mI
        gxE891CHRJzBb73M/Cx+M5uQdyNuKcmR3wJ6150=
X-Google-Smtp-Source: ABdhPJw1FO7LF2N/g83rWKSeCrtz8+D4BIDWX5Exsy48pd/Mo9KhgvWujbgYzs3KCLJwpKvFAdC/OQ==
X-Received: by 2002:a05:6512:3501:: with SMTP id h1mr6135362lfs.446.1631473916861;
        Sun, 12 Sep 2021 12:11:56 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t2sm683243ljk.125.2021.09.12.12.11.54
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 12:11:54 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id bq5so16230383lfb.9
        for <linux-sparse@vger.kernel.org>; Sun, 12 Sep 2021 12:11:54 -0700 (PDT)
X-Received: by 2002:a05:6512:3d04:: with SMTP id d4mr6147162lfv.474.1631473913911;
 Sun, 12 Sep 2021 12:11:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210912160149.2227137-1-linux@roeck-us.net> <20210912160149.2227137-4-linux@roeck-us.net>
In-Reply-To: <20210912160149.2227137-4-linux@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Sep 2021 12:11:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1TBvyk7SWX+5LLYN8ZnTJMut1keQbOrKCG=nb08hdiQ@mail.gmail.com>
Message-ID: <CAHk-=wi1TBvyk7SWX+5LLYN8ZnTJMut1keQbOrKCG=nb08hdiQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] parisc: Use absolute_pointer for memcmp on fixed
 memory location
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

On Sun, Sep 12, 2021 at 9:02 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> -       running_on_qemu = (memcmp(&PAGE0->pad0, "SeaBIOS", 8) == 0);
> +       running_on_qemu = (memcmp(absolute_pointer(&PAGE0->pad0), "SeaBIOS", 8) == 0);

This seems entirely the wrong thing to do, and makes no sense. That
"&PAGE0->pad0" is a perfectly valid pointer, and that's not where the
problem is.

The problem is "PAGE0" itself:

    #define PAGE0   ((struct zeropage *)__PAGE_OFFSET)

which takes that absolute offset and creates a pointer out of it.

IOW, _that_ is what should have the "absolute_pointer()" thing, and in
that context the name of that macro and its use actually makes sense.

No?

An alternative - and possibly cleaner - approach that doesn't need
absolute_pointer() at all might be to just do

        extern struct zeropage PAGE0;

and then make that PAGE0 be defined to __PAGE_OFFSET in the parisc
vmlinux.lds.S file.

Then doing things like

        running_on_qemu = !memcmp(&PAGE0.pad0, "SeaBIOS", 8);

would JustWork(tm).

Hmm?

             Linus
