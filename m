Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E830BC2D0A3
	for <linux-sparse@archiver.kernel.org>; Mon,  9 Nov 2020 21:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C81921D46
	for <linux-sparse@archiver.kernel.org>; Mon,  9 Nov 2020 21:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FtFAVWOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKIVrr (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIVrr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 9 Nov 2020 16:47:47 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306D4C0613CF
        for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2020 13:47:45 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id o24so5558395ljj.6
        for <linux-sparse@vger.kernel.org>; Mon, 09 Nov 2020 13:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h8513Bx9zQN4Uh1jKdKNLh6/m9D2NRObr801GtjzI8U=;
        b=FtFAVWObfDVqHR+ku7/Cmct0Mx//m8E6macvObb9DCzjCIddjT2y7lV4WVweoVvbCc
         SLjrzcfUGxrppawFed79YgP7XEr5+jsHO9QAtatxTzh/BhklHqO55ijZ4TlDr8MhBT9A
         VIYYfcEN5CdP/zoWYntsXaskRR227+RQ7Y78M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h8513Bx9zQN4Uh1jKdKNLh6/m9D2NRObr801GtjzI8U=;
        b=QjiQ7L1ACgo4OZOV8FeJjeERPks8thuy1plpNSRDpJL0sag7Ikqc9bifqHvnt80baQ
         QIXgAZF1DGPAvHStqITusgpRRPl9ZpONX9hz3LsKYp2PZlRa81MNatmrWSCZwyekbrFQ
         dFiMYGVKcTihOA6zyO+GlfEZSAs+ezCzb1j6o5b2KTT9ZlFSCI8S4otGg6LGo6QcNTbI
         HL5RisZdHQF7uvUPnAvMlZ3GMUFGAiMXZ5csHdhuknNGTl79CuuwT6dljT3JcYmuF0tm
         KukaqFu7gRLFFMUjg0vdjMMLr3jEPLr2ZX4+4fi6Hb2pylLXE8/hUhynvGTlJoOq4MvK
         F+qw==
X-Gm-Message-State: AOAM532pMr0R5/oEeqIGpos+7LQaxyRjhdh0GcfMq0oTK9WKDQV8d2iq
        pz85dGKdPNSW/K/mE83BWg0X9LRmCIV4Gg==
X-Google-Smtp-Source: ABdhPJwz8eNxD6uaEONkJHxR4zHJbPdsConlfEasFpMAmWjetQStW1Dc0QSXm/p87wOM8LHVNkiDpQ==
X-Received: by 2002:a05:651c:1198:: with SMTP id w24mr7428048ljo.383.1604958462285;
        Mon, 09 Nov 2020 13:47:42 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id b18sm1874839lfp.89.2020.11.09.13.47.41
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 13:47:41 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id f11so8313604lfs.3
        for <linux-sparse@vger.kernel.org>; Mon, 09 Nov 2020 13:47:41 -0800 (PST)
X-Received: by 2002:a19:ed0f:: with SMTP id y15mr1861601lfy.352.1604958460920;
 Mon, 09 Nov 2020 13:47:40 -0800 (PST)
MIME-Version: 1.0
References: <20201109211616.dyr7g62rz5oohseu@ltop.local>
In-Reply-To: <20201109211616.dyr7g62rz5oohseu@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Nov 2020 13:47:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjwbK1vjoJKCCERXQkykNHa2Bfpg8CsyDrEU4mGyHA7Kw@mail.gmail.com>
Message-ID: <CAHk-=wjwbK1vjoJKCCERXQkykNHa2Bfpg8CsyDrEU4mGyHA7Kw@mail.gmail.com>
Subject: Re: 'context imbalance' warnings
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Nov 9, 2020 at 1:16 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
>    There is no phi-source here and the CBR at .L3 could be merged
>    with the one at .L0, removing the false imbalance but it's not.
>    I thought that sparse was doing this sort of branch simplification
>    but it doesn't, or at least it doesn't in this (simple) situation.

The branch rewriting sparse does is very simplistic, afaik. It's also
confusingly written. I blame myself.

Honestly, in that example you quote:

                cbr         %arg1, .L1, .L2
        .L1:    context     1
                br          .L3
        .L2:    call        use, %r1
                br          .L3
        .L3:    cbr         %arg1, .L5, .L4     ;; false imbalance here

we never even try to combine the two cbr's, because they don't jump
directly to each other.

I think it would be easy to simplify if we just added some logic to
change "unconditional branch to conditional branch", and moved the cbr
up into L1 and L2, but I don't think we have any such logic (and it's
a simplification that might end up being the opposite of a
simplification - it would duplicate the conditional).

So we could try to remove L3 entirely, by moving it into both parents:

                cbr         %arg1, .L1, .L2
        .L1:    context     1
                cbr         %arg1, .L5, .L4
        .L2:    call        use, %r1
                cbr         %arg1, .L5, .L4

and at that point, the branch simplification we *do* have woudl see
that both of those duplicated conditional branches are now dominated
by the first one, and we'd end up with

                cbr         %arg1, .L1, .L2
        .L1:    context     1
                br         .L5
        .L2:    call        use, %r1
                br         .L4

and then we'd join L2 and L4 together and the end result would look nice.

But as it stands now, L3 isn't dominated by one side of the original
conditional branch (because we reach L3 from both sides), and the cbr
in L3 isn't something we can simplify without duplicating it and
moving it up into the parents.

Is duplicating the conditional branch worth it? In this case, clearly
yes. But in general? Maybe we could do it in cases like this, when the
*only* thing in a basic block is that conditional branch.

            Linus
