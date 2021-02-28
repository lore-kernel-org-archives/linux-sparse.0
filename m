Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8A1C433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 20:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7974264E31
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 20:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhB1UBX (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 28 Feb 2021 15:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbhB1UBW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 Feb 2021 15:01:22 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034AEC061756
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 12:00:41 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id a17so16939384ljq.2
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 12:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fcxmznsEmcLxGBbW8cWc2lbwaA1/eqUxRmZQ/MkhaM=;
        b=dVTI/0oFaQfcowiF91H3OWQLFKuOaYt1Tpw+fVNyC32xb4OSnfyiVjTkCYepoi56j1
         KiISP1eU7G1330E0O6ENAV+rXwb0oLRA6iLLDOT0H+YiXIXtKvXQ9XCeJGItJRZuXnO3
         KMaNsZ1chmXi+ZDhNQ4hQczbnVsN+s1iCb7dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fcxmznsEmcLxGBbW8cWc2lbwaA1/eqUxRmZQ/MkhaM=;
        b=p6xyyJZco8Y8M/otFJ5AwcJZQ3vRZno+bcCN4fs/LUKLy/A2zP3f1FpmlL/6ew8IWo
         50N3JSyN25GD70H4Vm6EraFM3fqESAqmuKSneeDhkM1kjuznQEVifAcKztCcA5k4hdyB
         mF/DDHvQR6/HL+dnf4H19bTPbH1FhTrIrEpj5MKbcouJ6bPgxt8tEUPANjTR656qRsRX
         I0FFzVqQNVG1Gvy5xK53JkqnVBY71g8SmExYB09vY6neJ3xdMe2RG2hkBCUS0dvTwDvk
         Y/LTWVq19Lviu1x+VieJ/rkKLXdFugAVFDORUDCrF57sPwlfR8e+D/SMVNyGKtzg1pfg
         KPlw==
X-Gm-Message-State: AOAM531ojii+I4zKbR4Etli7LSunVvh7rN1LGUYp8fCPuKw8nQaCfNKj
        CXuqmcSsDYzNAycv6Bvqx374yg3qxu52VQ==
X-Google-Smtp-Source: ABdhPJx6Zzld5TK5aIlZF2HIf7TMHkGRrklXxHZDDAptkEoBClHAEE6O/rmi3esW60dMhpxcYNGsaQ==
X-Received: by 2002:a2e:b531:: with SMTP id z17mr7313694ljm.405.1614542439926;
        Sun, 28 Feb 2021 12:00:39 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u22sm160425ljk.6.2021.02.28.12.00.38
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 12:00:38 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id f1so22081500lfu.3
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 12:00:38 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr7223200lfu.40.1614542437955;
 Sun, 28 Feb 2021 12:00:37 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain>
In-Reply-To: <YDvwVlG/fqVxVYlQ@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Feb 2021 12:00:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
Message-ID: <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Feb 28, 2021 at 11:34 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> >
> > End result: #pragma is fundamentally less reliable than the
> > traditional #ifdef guard. The #ifdef guard works fine even if you
> > re-read the file for whatever reason, while #pragma relies on some
> > kind of magical behavior.

You continue to not even answer this very fundamental question.

"#pragma once" doesn't seem to have a _single_ actual real advantage.

Everybody already does the optimization of not even opening - much
less reading and re-parsing - headers that have the traditional #ifdef
guard.

And even if you _don't_ do that optimization, the #ifdef guard
fundmentally semantically guarantyees the right behavior.

So the #ifdef guard is
 (a) standard
 (b) simple
 (c) reliable
 (d) traditional

and you have yet to explain a _single_ advantage of "#pragma once".

Why add this incredible churn that has no upside?

So no. We're not using #pragma once unless y9ou can come up with some
very strong argument for it

And no, having to come up with a name for the #ifdef guard is not a
strong argument. It's simply not that complicated.

               Linus
