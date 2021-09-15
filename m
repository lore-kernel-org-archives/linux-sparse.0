Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C55C433EF
	for <linux-sparse@archiver.kernel.org>; Wed, 15 Sep 2021 19:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F7E6105A
	for <linux-sparse@archiver.kernel.org>; Wed, 15 Sep 2021 19:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhIOTtY (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 15 Sep 2021 15:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOTtY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 15 Sep 2021 15:49:24 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92C3C061766
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 12:48:04 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so8853808lfu.5
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y64G4Nr6eLupd8AyUDQV+QjpzOrG0jVGWqFOvbj7NhQ=;
        b=Y4csyohCZU+8YoKj/T3AMNnwgk3FRg+INHHD4fuGyDsUm1wq1h6AKxBYulDw3FoQ7G
         0NziSuibsMyNi5yefbYsucBch28Uj+K3jgCIw+xC9NJQXLVMnDOuhKqiW0u/dIQHiVqz
         N3nrrQCoMhlCRtjeNcE5DeBxWUyUUAZ/n68kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y64G4Nr6eLupd8AyUDQV+QjpzOrG0jVGWqFOvbj7NhQ=;
        b=RB8erG4bYrQDXPkBdAzX0KzMRzUYQ37odldnxxnQJcnMSEL8xCrct9atOrJJm0MRl3
         uU0FaeXFHnj1NwYgEouQN559/dR5TVAe2f46OoUuo3rWck/jr11SPDkACy+56fk0F+/V
         1Zk8LlbTRgUCQ8GpDxZBdDeP0y+MFHs9MY6hSzLWIuO/9TqHISIyVXlKBzbuZ/TN+43p
         viTKzlr85lMpdY/p3zjflJW3kq9Wo6uEvAObTueLTzMsb7TJEBEoEYgziGz4ZF3hl1KZ
         SbenInF2diFCPj/n6+NLDt8YY/3RZYZUiQOsXZ3ml7M7lbsA+g+wtRsgL8FJPLzr7bc+
         Tg4Q==
X-Gm-Message-State: AOAM532mFSpKq9RRJLvlQ4qdg2KXD5TxbTgEOWRPaLQqNgCZXhJyrAcc
        99KUY12yHPsKSfQBZYwUrvNMBmX7Yfvm9sE4wYI=
X-Google-Smtp-Source: ABdhPJx5HX9EIEUy7wS0XrghTPRkGI7DJ7rSRNzLmNBsdnLzEvUSbguBjgFUyFph2QmJs6L6oHK0+Q==
X-Received: by 2002:a05:6512:3c9b:: with SMTP id h27mr1226349lfv.171.1631735282451;
        Wed, 15 Sep 2021 12:48:02 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id j12sm92109ljc.121.2021.09.15.12.48.00
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 12:48:01 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id m3so6993786lfu.2
        for <linux-sparse@vger.kernel.org>; Wed, 15 Sep 2021 12:48:00 -0700 (PDT)
X-Received: by 2002:a05:6512:3991:: with SMTP id j17mr1261083lfu.280.1631735280541;
 Wed, 15 Sep 2021 12:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210915035227.630204-1-linux@roeck-us.net> <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
 <47fcc9cc-7d2e-bc79-122b-8eccfe00d8f3@roeck-us.net>
In-Reply-To: <47fcc9cc-7d2e-bc79-122b-8eccfe00d8f3@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 12:47:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdEHPm6vGcJ_Zr-Q_p=Muv1Oby5H2+6QyPGxiZ7_Wv+w@mail.gmail.com>
Message-ID: <CAHk-=wgdEHPm6vGcJ_Zr-Q_p=Muv1Oby5H2+6QyPGxiZ7_Wv+w@mail.gmail.com>
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

On Wed, Sep 15, 2021 at 12:35 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On a side note, we may revive the parisc patch. Helge isn't entirely
> happy with the other solution for parisc; it is quite invasive and
> touches a total of 19 files if I counted correctly.

Ok, my suggestion to use the linker was not a "do it this way", it
really was just a "maybe alternate approach". So no objections if
absolute_pointer() ends up being the simpler solution.

What other notable issues end up being still live? I sent out that one
patch for sparc, but didn't get any response to it. I'm inclined to
just apply it (the 'struct mdesc_hdr' pointer misuse one).

         Linus
