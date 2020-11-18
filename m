Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A2C5519F
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 19:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF1A20853
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 19:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YoFYkiN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKRTvV (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgKRTvV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Nov 2020 14:51:21 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD4BC0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 11:51:21 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id p12so3673407ljc.9
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 11:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+fy1tOPTmqzx4gfGwkELIONuTYJE6ENxOat+i7y9Ns=;
        b=YoFYkiN7rdjZKve3lAcRffGleO/vXnJ6++CP2LxCTy/RxKrK3oYZrdexPiPAkm9ShR
         /SuKwygoB6gEEouXpfwjTNvVxH7DgFCvoOnAel/6oYB/lHQT/schV9uAmILLLCRIlcdD
         t3AIYTZxjJfNXU2SjY9Me8sQV6yGr7yGD8Jwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+fy1tOPTmqzx4gfGwkELIONuTYJE6ENxOat+i7y9Ns=;
        b=dBqOhgrbEtsmskoYdkzeikW7GG8kiCOEK1ZmTkpj+m1oWdAio167FHqXswAqfezQg5
         CxOWJSy6fWp1U9Ai2HcNjP00nE5ArsOhcPmEfZ78hS5l3pmsvzFupk1Sxg6KEPOQYJS4
         QezvzBPQw0IqKbsnPD0nykyfjrGGWm8PQ48sY3e/qb/dIwYhMzbabxADSt528D3H00yA
         L5pjf9qnyj3repqR3h5tgmPiDNhIrB3f0Esszxi4jSLB1seKDK5AIs+pjBIpeIWY526u
         WVUHTMvL2IqMmO7zrvTmt/iAzw9UC9ckcfgf6fu9WrL6TDXJwvkm2MoDIy+1iLdAJuj5
         GNnw==
X-Gm-Message-State: AOAM530HkN+CQcJb2dAoSo5bnKtEEwjaNTp1rwPxZu/PKMtic7wXhZrh
        DU4VXodF9RsCfA+ZrHXrto66s27pBde9jQ==
X-Google-Smtp-Source: ABdhPJx5yMZHIQ95juWtCuMZCFlFsPOjWfYkht6Or5gSyyB33nhw970doZRx9u/FKd3Mbu8IGIqZYQ==
X-Received: by 2002:a2e:920a:: with SMTP id k10mr4200790ljg.260.1605729078708;
        Wed, 18 Nov 2020 11:51:18 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 8sm3686406lfk.246.2020.11.18.11.51.17
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 11:51:17 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id y16so3715906ljh.0
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 11:51:17 -0800 (PST)
X-Received: by 2002:a2e:8701:: with SMTP id m1mr4270960lji.314.1605729076652;
 Wed, 18 Nov 2020 11:51:16 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
 <20201117212829.99552-1-luc.vanoostenryck@gmail.com> <CAHk-=wgtL1LPYev5cwhZqd=7RyaGrzx3mS-ydVZAQuYrf0XNuQ@mail.gmail.com>
 <CAHk-=wi-XUPMduO16mvNeou58O-LrxnSk33WBg+vbbqCpzHgOw@mail.gmail.com> <20201118191737.oq2e2t5h2wo3us3c@ltop.local>
In-Reply-To: <20201118191737.oq2e2t5h2wo3us3c@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Nov 2020 11:51:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjB+c+1ykVzRz5yKX486hHNMMNVAhrwwvbRuuo9eO5gfg@mail.gmail.com>
Message-ID: <CAHk-=wjB+c+1ykVzRz5yKX486hHNMMNVAhrwwvbRuuo9eO5gfg@mail.gmail.com>
Subject: Re: [PATCH] casts should drop qualifiers
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Nov 18, 2020 at 11:17 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> I don't think it's a good idea. The focus now is all about dropping
> the qualifiers but in code like:
>         const int x;
>         typeof(c) y;
> don't we want 'y' to also have the type 'const int'?

I assume you meant "typeof(x)". But yes, absolutely.

Which is why my suggested example patch had that explicit test for
"is_lvalue()".  So only for non-lvalues would it strip the qualifiers.

So "typeof(((void)0,x)) y;" would be "int", because that expression
inside the typeof isn't an lvalue.

But if you have something that is already doing the generic case, then
that's obviously better. My suggestion was more of a "we can zero in
on just that typeof case" thing.

            Linus
