Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 550B2C433F5
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 22:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2914B61052
	for <linux-sparse@archiver.kernel.org>; Sat, 18 Sep 2021 22:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238346AbhIRWRp (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 18 Sep 2021 18:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236828AbhIRWRp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Sep 2021 18:17:45 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B534FC061574
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 15:16:20 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id bq5so49219726lfb.9
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 15:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhzplMeBODusyr1H2stA0puUgPSaTtOBgK77tHO282k=;
        b=JTYIBPqLj92nNTxPKVgSXgrpmcBI0kIM1GLPs6qJei5SauEXmL4YjUER2rr88W6PSq
         1DyThW7PUpCkaPaRUzGHd63izjL4GOav/VKQujZg/VmlgUEkUA00v11NnnZZ74r1NHxh
         4wDTaM/CdGI1g53lKb6vt1ECENxdljnyVleYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhzplMeBODusyr1H2stA0puUgPSaTtOBgK77tHO282k=;
        b=UMnzZZYgsNIeXAEAo228AW4hQo9XJUXruTOPy3fUatsBqb9m/hmh1eASUpY5nXOVtf
         H4c4SWZbI3ODSgRdliEd3l1pz59Ay7XQAIkxvsoCpVEHKeM3xPuCjfTfQ46bcndObxdL
         kFLgN0PGgiuiUajDOB5GY6mqipS8ml8acBGi7jVsPpQ1aJ4LAyMex/SnQjgZlgUnrZjR
         Tz2P+J+58YgTcxWW9M8sCBag92s4lUF1RMkCI8uCXP00VtQIyydFvWlcBZZ8xqDDk8uF
         OOLVFFthG3vn0Ng0TJBYMTiP5ljxCst/JhmnMDEXpm/H2WGZwPldK5YSpY9JVM/I7ZG6
         w8DA==
X-Gm-Message-State: AOAM530f3hCgRPcvhJZPS5L1snzZC9tLG1Z+JI+5Tn+iRDOUJsBST5AO
        ILA+5Mq/ZXEzDrC4yvyqKo2l0+pjaArLKqvRTs0=
X-Google-Smtp-Source: ABdhPJyxR37CiVYM++lTMFdwxoFERXq3f7xlGbrdg9XQxtGQj6X2oPZ/ITrDH4CkINAIDAnm16l76g==
X-Received: by 2002:a05:651c:2120:: with SMTP id a32mr15218479ljq.252.1632003377941;
        Sat, 18 Sep 2021 15:16:17 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id s2sm1160601lji.1.2021.09.18.15.16.17
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 15:16:17 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id c8so48892184lfi.3
        for <linux-sparse@vger.kernel.org>; Sat, 18 Sep 2021 15:16:17 -0700 (PDT)
X-Received: by 2002:a05:6512:3d29:: with SMTP id d41mr2659681lfv.474.1632002968346;
 Sat, 18 Sep 2021 15:09:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com>
 <202109182026.18IKQLng003683@valdese.nms.ulrich-teichert.org>
In-Reply-To: <202109182026.18IKQLng003683@valdese.nms.ulrich-teichert.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Sep 2021 15:09:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-=tMO9iCA4v+WgPSd+Gbowe5kptwo+okahihnO2fAOA@mail.gmail.com>
Message-ID: <CAHk-=wh-=tMO9iCA4v+WgPSd+Gbowe5kptwo+okahihnO2fAOA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Ulrich Teichert <krypton@ulrich-teichert.org>
Cc:     Michael Cree <mcree@orcon.net.nz>,
        Guenter Roeck <linux@roeck-us.net>,
        Richard Henderson <rth@twiddle.net>,
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

On Sat, Sep 18, 2021 at 1:26 PM Ulrich Teichert
<krypton@ulrich-teichert.org> wrote:
>
> I was just tinkering with it to get it compiled without warning,
> I certainly didn't get the big picture :-/

Ok, you shamed me into some tinkering too, and I fixed a couple of
issues with the alpha build.

The whole "pci_iounmap()" mess is not something I solved (you were
cc'd on the email I sent out about that), but I did test a few
different Jensen configurations and fixed a couple of uglies.

So at least _some_ Jensen configurations build cleanly once more, and
I re-enabled JENSEN as a valid machine target.

But if it doesn't boot, it's all fairly moot. And those things are a
pain to debug, and if the last booting kernel was years and years ago,
I don't think it realistically will necessarily ever be fixed.

Oh well. I have an odd love-hate relationship with alpha.

I think it's one of the worst architectures ever designed (memory
ordering is completely broken, and the lack of byte operations in the
original specs were a big reason for the initial problems and eventual
failure).

But at the same time, I really did enjoy it back in the day, and it
_was_ the first port I did, and the first truly integrated kernel
architecture (the original Linux m68k port that preceded it was a
"hack up and replace" job rather than "integrate")

           Linus
