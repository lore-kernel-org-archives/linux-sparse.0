Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7AFC433F5
	for <linux-sparse@archiver.kernel.org>; Sun, 12 Sep 2021 22:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 898D8610A6
	for <linux-sparse@archiver.kernel.org>; Sun, 12 Sep 2021 22:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhILXAN (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 12 Sep 2021 19:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbhILXAM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Sep 2021 19:00:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68E9C061760
        for <linux-sparse@vger.kernel.org>; Sun, 12 Sep 2021 15:58:57 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bq5so16971278lfb.9
        for <linux-sparse@vger.kernel.org>; Sun, 12 Sep 2021 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X35Fq5OT81Nr4I6Qbip78STPxqD/PDV+RfIaRcMXDmA=;
        b=M7RyeS9xLb3mVaGM35ZObppxdx3xXQJgghifuu8UVsRcqA3tbQu/b3NBc4q9G58Skc
         TooyKBQ11SGfPWSLHHrBcpkzM1JhOK+0oM7hKbEmTR97BKf+c74T2tMKjBtHYbQLqmvW
         URtAxnOjLh0lc9MI1zr/I99Zl6xDfwYZhCri4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X35Fq5OT81Nr4I6Qbip78STPxqD/PDV+RfIaRcMXDmA=;
        b=pwCoLFLoZrWld8VXiXx05XsPqbluJBk0jsFqQRuMVQOIFRpFvDACVmviXhtAeqKYWN
         aYOE9sz5aQ+YZxC/V3smF63vNAaMWKFFkSfh7BstGLp1I5jTwtU9NneHvQCOf2/cZ9lQ
         q8QSZ0pYZLanBm3Rr+a0shr5IFfcq5ArYQPJVxSY8rjwls9MyyjQaCcxm577UKQBTjDi
         qBO58asF1QmybZVZI4mPuyUKnr7WgLv7c4pE4Ksai4xuk7QbnI+6HBclA/o4HCMMVIZk
         v4rD7cj8sSQGyRj87x7VejeGDzGiZFqmompT03GPDIU+i35bXDB9MpoklQeeNqHurIqt
         oZQw==
X-Gm-Message-State: AOAM530C+WJvRMJk9pRZkckTCw9+Jjd3aYDfNtmdFoRZoVA/Brb1JRan
        Z2xh7VgmjxtC17pDG9kYzjEfVUPbfWMRp/hczfE=
X-Google-Smtp-Source: ABdhPJxy8w0rfqGT1qiVUqTS0wI89I//GxQpntP4JmU938bpI0a4zAReUL6uuR07ne9dOLwkm4QP0Q==
X-Received: by 2002:a19:500e:: with SMTP id e14mr6646464lfb.673.1631487535747;
        Sun, 12 Sep 2021 15:58:55 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id b17sm741193ljj.35.2021.09.12.15.58.53
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Sep 2021 15:58:54 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id j12so13772567ljg.10
        for <linux-sparse@vger.kernel.org>; Sun, 12 Sep 2021 15:58:53 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr8107686ljg.68.1631487533580;
 Sun, 12 Sep 2021 15:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210912160149.2227137-1-linux@roeck-us.net> <20210912160149.2227137-5-linux@roeck-us.net>
 <CAHk-=wi1=8shingNuo1CtfJ7eDByDsmwsz750Nbxq=7q0Gs+zg@mail.gmail.com> <0f36c218-d79c-145f-3368-7456dd39a3f2@roeck-us.net>
In-Reply-To: <0f36c218-d79c-145f-3368-7456dd39a3f2@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Sep 2021 15:58:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi11WAHpJi8KDbbp7FGcqnfkB3r6TZqnZeOKvfYGCOsaQ@mail.gmail.com>
Message-ID: <CAHk-=wi11WAHpJi8KDbbp7FGcqnfkB3r6TZqnZeOKvfYGCOsaQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] alpha: Use absolute_pointer for strcmp on fixed
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

On Sun, Sep 12, 2021 at 1:37 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> COMMAND_LINE is, for whatever reason, defined in
> arch/alpha/include/uapi/asm/setup.h, ie in the uapi.
>
> Can I even touch that ?

I think that's entirely a historical accident.

Note how most of those #define's don't even work for user space
because they use PAGE_OFFSET, which is defined in <asm/page.h>. And
others depend on the kernel config system.

There's a couple that do seem to be potentially for user space (MILO
bootloader), and who knows just what hacks that code might have with
internal knowledge of this header file. But anything I can find on the
net seems to predate our move to 'uapi' headers, so I wouldn't really
worry about it.

So I'd suggest just moving that whole file back to <asm/setup.h>,
changing it as necessary, and then seeing if anybody notices.

Because I suspect the answer to that is just crickets chirping..

              Linus
