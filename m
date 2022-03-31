Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6EAC433F5
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Mar 2022 19:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbiCaT7f (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbiCaT7f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Mar 2022 15:59:35 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028CE216FB1
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 12:57:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id by7so1283176ljb.0
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5Ku3AT958fXb2EqUNFvdSLG3w/dnh+RkSS2wtvNoCI=;
        b=dC5gAhcXyyQcdKAR2Thgi8KpyQzaGS7mKZNyRv3txikbNnS/fBHYh+ATEbo/c6TWF7
         Uwn+ddXN2MutH6zn2M+KkM8wivsEEOWeA5nY6qK1TEjk4qm3Edx0RWLap8fO+EcNJAs7
         1RjxkmKdt0zmGcSrhRfN1Tx2Xj7ovnhizz518=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5Ku3AT958fXb2EqUNFvdSLG3w/dnh+RkSS2wtvNoCI=;
        b=2R70yMYZDe1f4I4uScZlII2iJUCV0+YbZAyR/VSkFmK+oLs0Qj4Q1AMjBUuZx2scu3
         3e9SwmR4FuDKSiHLT8wQYFHNXGyvym2jAlMPbdQ8eiHv/szhEE4YB22zdbIjOjHiQGyC
         5BekETlJgf6Zof29Efyz/m05dbs+94SCkrikxstZUzi3YuxDzTj5FsjYjSyQEesKZT04
         PZI66pRl4Xn56FfGAY1014WoN58H5QI6U/N6Tk6VJPOknBer3h+xxEwsQrHtc0SMkSsi
         NrmtjDSsVrB6hW2fIdfha40V6LpdwXc18Yd5S25nOVmw2bujvBaoPiucR+Tgc+u+E7w4
         IAvQ==
X-Gm-Message-State: AOAM5305g2yv+53a1IhxtyloUzyoMcgfaOYFRuykbR9BFPAHOQCULuk9
        3LVKadM2zGFk/ip0EjCbMV0LgwBOeC/R4EVRwrI=
X-Google-Smtp-Source: ABdhPJyI2pmx8+lPM1JgxF+yy5uyJdgglEor+1ylscLzIEsfdUvuJPG9dpyE42u98D3mk7fECWwItQ==
X-Received: by 2002:a2e:2406:0:b0:24a:f1a1:3d09 with SMTP id k6-20020a2e2406000000b0024af1a13d09mr5164383ljk.336.1648756663167;
        Thu, 31 Mar 2022 12:57:43 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id h23-20020a056512339700b0044a15d1c6adsm32810lfg.26.2022.03.31.12.57.42
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 12:57:42 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id w7so1073621lfd.6
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 12:57:42 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr11433300lfh.687.1648756662109; Thu, 31
 Mar 2022 12:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220331110118.vr4miyyytqlssjoi@pengutronix.de>
 <CAHk-=wjeC-x28rn50T1oLXayZUm_xYhmRV+N8ewAXjJVZnyUAg@mail.gmail.com>
 <CAHk-=wjeYjkXDpdHwobJ1X+Tk+N8xYPe_O6CbB3zg=fKRVhYJg@mail.gmail.com> <20220331193139.x3mqngrci3tc6sqo@pengutronix.de>
In-Reply-To: <20220331193139.x3mqngrci3tc6sqo@pengutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Mar 2022 12:57:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit1MGUeFOycVt_qrk8TKBAAHf-9=ekqC=t0snMNpo29g@mail.gmail.com>
Message-ID: <CAHk-=wit1MGUeFOycVt_qrk8TKBAAHf-9=ekqC=t0snMNpo29g@mail.gmail.com>
Subject: Re: building Linux for ARMv7 with llvm breaks sparse
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Mar 31, 2022 at 12:31 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> No :/
>
> | clang: error: unknown argument '-meabi=gnu'; did you mean '-mabi=gnu'?
>
> The documentation says no "=":
>
> | https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang-meabi

Wow. What a horrible inconsistency. Every single other '-mxyz arg'
thing seems to use '=', so it's really -meabi that stands out as being
broken.

Oh well. Sparse does handle these kinds of architecture things in
other places, but I'm not personally really very motivated to fix it
due to just being pissed off at clang idiocy.

               Linus
