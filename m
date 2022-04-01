Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7A4C433F5
	for <linux-sparse@archiver.kernel.org>; Fri,  1 Apr 2022 17:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349647AbiDARQS (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349645AbiDARQR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 1 Apr 2022 13:16:17 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD7C181785
        for <linux-sparse@vger.kernel.org>; Fri,  1 Apr 2022 10:14:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p10so6042914lfa.12
        for <linux-sparse@vger.kernel.org>; Fri, 01 Apr 2022 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utfv8DeU9QsQM5/Vhd4xkBU7PeKTZq1L4vDvZwcxU/A=;
        b=RnYrwK0OqKnAVMAa4S1NjLBhVOO5o1T9pT3+R/Z0DJQ7ZgcmyVh1fGfFWydC77Dqk6
         hTO+1etbZAy6rFIPVfziiLYn8Bbd9Z/nyH1w1uyvvh+s3For3BVIs9E5KDS2UJIJ/4fI
         s8CBuVIr9splx36gLjUC3J3QaGOu8QUc2VPlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utfv8DeU9QsQM5/Vhd4xkBU7PeKTZq1L4vDvZwcxU/A=;
        b=iDhWUX4B3ckSpvl966DGlayPPiXQ4VRUvuqUnImc6rk8t55F6qKUZlSo/NN2c2riVw
         tnzvdpEdL9J7sJXSROTxXJKLIbnwPA0RUJA6J1msgBBwQATYv4XUtdW8PyXWP4DGZErT
         h/zwK8trp3tc4WcW+qBsWHK/pi23G8y9o/k6W+lP5ieqcYwbxB0Dxo9iLBAlw9ibIlNV
         QSIG02JKa9YkurCLHQmkfCu/fDwrv8hrY4x2HNaTcp8nnwnKwFzv0vV8WDnXtw1GdDQk
         pIpn0yfN6RYjD0FQQHLmcYzZ/SkM+nsQ04erRdRu2fJqiUSa1TWLo+DNF20leYgfN6ne
         tz1g==
X-Gm-Message-State: AOAM530p15AeaN2+V1hcFtgAmQtOH0xIjDSbSzUgmaFXmGH106DlVGuc
        TyW3Hp3Tld0ZLcLM8f7CwtEpQzMjtR81Dq+k0J8=
X-Google-Smtp-Source: ABdhPJzQZAxxMHhTNaqpHkCVlsgvTyJa9r772KWvrohiF3fPMZT4olP8yl7lmLmsICI/8uQXrP+K3A==
X-Received: by 2002:ac2:4107:0:b0:44a:3084:39f8 with SMTP id b7-20020ac24107000000b0044a308439f8mr14206427lfi.209.1648833264600;
        Fri, 01 Apr 2022 10:14:24 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id h6-20020a2e5306000000b00247e893075asm243608ljb.37.2022.04.01.10.14.20
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 10:14:22 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id s13so4776912ljd.5
        for <linux-sparse@vger.kernel.org>; Fri, 01 Apr 2022 10:14:20 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr14079887ljg.291.1648833259843; Fri, 01
 Apr 2022 10:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220126171442.1338740-1-aurelien@aurel32.net>
 <20220331103247.y33wvkxk5vfbqohf@pengutronix.de> <20220331103913.2vlneq6clnheuty6@pengutronix.de>
 <20220331105112.7t3qgtilhortkiq4@pengutronix.de> <CAHk-=wjnuMD091mNbY=fRm-qFyhMjbtfiwkAFKyFehyR8bPB5A@mail.gmail.com>
 <20220401065309.dizbkleyw44auhbo@pengutronix.de>
In-Reply-To: <20220401065309.dizbkleyw44auhbo@pengutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Apr 2022 10:14:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgv6rXFjTdaumFgDC4ixg6QMOL83sQ2XOqvJC0h5fLX2g@mail.gmail.com>
Message-ID: <CAHk-=wgv6rXFjTdaumFgDC4ixg6QMOL83sQ2XOqvJC0h5fLX2g@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix build with binutils 2.38
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Kito Cheng <kito.cheng@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        ukl@pengutronix.de,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Mar 31, 2022 at 11:53 PM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>
> | WARNING: invalid argument to '-march': 'zicsr_zifencei'

Gaah, it works but still warns because I cut-and-pasted those
zicsr/zifencei options from some random source that had them
capitalized and I didn't look closely enough at the reports.

Anyway, hopefully somebody can bother to fix up that. Possibly by
changing the strncmp to a strnicmp - but I don't know what the rules
for lower-case vs capitals are for the other options. I'm still busy
with the kernel merge window, so this gets archived on my side..

             Linus
