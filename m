Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16038C433EF
	for <linux-sparse@archiver.kernel.org>; Thu, 31 Mar 2022 19:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239667AbiCaTTr (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiCaTTq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 31 Mar 2022 15:19:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE84F232111
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 12:17:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id e16so835240lfc.13
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PFXzqcLRZNjMdgT/q9WWNbQF/XlXHucaXUZ/Ewc48t0=;
        b=EQIuAAiNQsLNCtLQcrwHm9P9bMKINsUFiUhNhWVecXtsFihAABKFO3KLpgn/UJlwhp
         r8OGPXKCWfpRq+Yr21ykjIqIgLtWRVCYn29l6BASAytb1cQB2QEXr2uyFsdbq3XJze5X
         hwFSv5B/glpnW00bzsm/WWZoolJJZkTphsRh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PFXzqcLRZNjMdgT/q9WWNbQF/XlXHucaXUZ/Ewc48t0=;
        b=Obu9Rdfscy7kOGaznXPVkip2kil2JkuiFdVASycllALS4LVcEb0YDQbOgO/1k7JhWo
         PzTpqH84hitiC0lQb+wm8coOfz/3iE9Rs0jrK+8H4sExpbu6ziKG9Wk06RaSQl9gPEgV
         IiLNHIAza9IU5TcAB4aQStaXLHuCMcnI+9Q8wmBljYmCW0kqsgc54o+UtoUL8Krvn90i
         f6uKkQCkubJppGDQprTO2iNz96WMB0yLaku151LJ2dvsUS80Cy68WJTkYrxsvDQEbWWa
         LTJXcNIbtU3s4p5YQn8JnxxtZ1LE5wyEhJdu/dypAI84Z88keKTO7j8aD7c04Z+PTx73
         7pKg==
X-Gm-Message-State: AOAM5314rU23w4WNXv66CwK0UARCu5nQ0xgcwaqhDtJ+5GWEgAc7mP3d
        qql88/MNT34fNgi2GlISGZCCOU+idOXHWX1AIMY=
X-Google-Smtp-Source: ABdhPJzb0x9WTFFcnyF7UqueNvWk3FhUNOq386RwZM6lWPimu3VfyqdSf0bcu2hs5xk/3qOPBdlRiQ==
X-Received: by 2002:a05:6512:1698:b0:448:872b:4425 with SMTP id bu24-20020a056512169800b00448872b4425mr11475438lfb.377.1648754271027;
        Thu, 31 Mar 2022 12:17:51 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id m13-20020ac2424d000000b0044859fdd0b7sm22504lfl.301.2022.03.31.12.17.50
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 12:17:50 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id h7so946182lfl.2
        for <linux-sparse@vger.kernel.org>; Thu, 31 Mar 2022 12:17:50 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr8391329lfu.449.1648754269710; Thu, 31
 Mar 2022 12:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220331110118.vr4miyyytqlssjoi@pengutronix.de>
In-Reply-To: <20220331110118.vr4miyyytqlssjoi@pengutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Mar 2022 12:17:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeC-x28rn50T1oLXayZUm_xYhmRV+N8ewAXjJVZnyUAg@mail.gmail.com>
Message-ID: <CAHk-=wjeC-x28rn50T1oLXayZUm_xYhmRV+N8ewAXjJVZnyUAg@mail.gmail.com>
Subject: Re: building Linux for ARMv7 with llvm breaks sparse
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Mar 31, 2022 at 4:01 AM Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> | -meabi gnu
>   ^^^^^^^^^^

That's certainly technically valid syntax, but it's unusual, and it
breaks the normal sparse "ignore stuff we don't know about" thing.

Does it all work if we just make the kernel use the normal

  -meabi=gnu

syntax instead?

And by that "all work" I mean not just sparse, but the actual real
clang/arm build.

            Linus
