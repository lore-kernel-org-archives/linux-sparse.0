Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52695C433DB
	for <linux-sparse@archiver.kernel.org>; Sat,  2 Jan 2021 19:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15452206A1
	for <linux-sparse@archiver.kernel.org>; Sat,  2 Jan 2021 19:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbhABTxi (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 2 Jan 2021 14:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbhABTxh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 2 Jan 2021 14:53:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD5EC061573
        for <linux-sparse@vger.kernel.org>; Sat,  2 Jan 2021 11:52:56 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id x20so54823196lfe.12
        for <linux-sparse@vger.kernel.org>; Sat, 02 Jan 2021 11:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EgMEV9l7KvbmwRNlS5fClD/uaL/c395AozL+oO5cpd8=;
        b=BwuCYDQhVp8r3M5Faz2pNtdToMrlZC6JaaXjPMq8rD0koPwK1v37BtcPhj+q1qtsZ3
         sZz0xZ24aPByHodl/E+2FhgEV0jzsemoCMLfmdtCCjoYjHaNejyaWn1Tf7bzEVjOp1Aw
         dGx6RvHiiBM6boOxPKqntKz3+F8Vw2R/QeZ5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EgMEV9l7KvbmwRNlS5fClD/uaL/c395AozL+oO5cpd8=;
        b=abT8YysiU0Sa/6vKwXkWpZNN3ybY4tQddOPfPKKAFP/nJuF4eEZNGviejejbzgQ7Ad
         NkeyiXafgKrxhUd5aT117jidf3yg+QBCkCYQ3L0QgLW0EFNhIkphiIrRCJcSxYcyO225
         ajCLU6aXW2q/VvsAddzEOpxpT+kcmbAe5iqCvrEzxwmaHfl3okYHQ+GbEtcE59thND77
         ns1uNmiv8pm5QcHqbPVHr5FGnl//P2QK5laBnZDI5Ex1vTiWB58/pQhhRmVd2quC408F
         vF84IdbmTGf2147c2IEh7aSrwzug658Cy/x84KVuO14y8cPWUL6UPQXO0itmEiiqUUyO
         eTnQ==
X-Gm-Message-State: AOAM531bf2YtgWi0AN6z5me++p3P+YbI9iiPm5+KkJjV6nPxrvnO1ZMK
        1jZ9dn1fhReg2/xcXKD/KhP8UMs41FdTEA==
X-Google-Smtp-Source: ABdhPJwJg3utdCCUANl8mXBdOgqFqgYKpKP075jgnIZ2vHGewZYMqMd4uONXpMAnASq/wo45eYMMQQ==
X-Received: by 2002:a19:8bc6:: with SMTP id n189mr27558119lfd.291.1609617175024;
        Sat, 02 Jan 2021 11:52:55 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id o138sm6435679lfa.171.2021.01.02.11.52.53
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Jan 2021 11:52:54 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id m25so54803262lfc.11
        for <linux-sparse@vger.kernel.org>; Sat, 02 Jan 2021 11:52:53 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr31109975lji.251.1609617173449;
 Sat, 02 Jan 2021 11:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20210102100934.28459-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20210102100934.28459-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Jan 2021 11:52:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiYyR8gLPPBTwbDf97GiJLOH+EEQED7ARcXR2xyhK4r-w@mail.gmail.com>
Message-ID: <CAHk-=wiYyR8gLPPBTwbDf97GiJLOH+EEQED7ARcXR2xyhK4r-w@mail.gmail.com>
Subject: Re: [PATCH] RFC: problems with cast optimization at evaluation time
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Jan 2, 2021 at 2:09 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> It's easy enough to add a test to only allow this on 'true' integer types
> like done in the patch.

We already linearize casts to different ops for the different cases
(integer/pointer/fp/bool). So yeah, we should do it at that level.

> Again it's easy enough to add some checks but I wonder if all this
> is really worth.

I agree. Remove it from the evaluation phase, and add it to the
linearized SSA format instead.

Note that even on RISC architectures that don't even _have_ truncated
operations (ie an "add" or "not" is always done on the whole
register), doing the truncation to minimal bits is worth it, because
it ends up being just a "upper bits don't matter" and will remove a
_lot_ of sign-extension or zero-extension crud.

So I think the simplification should be done, but I agree it's done in
the wrong place.

Once you do it at the instruction simplification level, all of the
confusion goes away, because a "cast to floating point" is a
fundamentally different operation than "zero-extend integer" at that
level.

            Linus
