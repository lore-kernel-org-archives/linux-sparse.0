Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB32C433B4
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 17:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C8FB60FE5
	for <linux-sparse@archiver.kernel.org>; Sat, 17 Apr 2021 17:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236728AbhDQRRT (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 17 Apr 2021 13:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbhDQRRT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 17 Apr 2021 13:17:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290FAC061574
        for <linux-sparse@vger.kernel.org>; Sat, 17 Apr 2021 10:16:51 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m7so23729123ljp.10
        for <linux-sparse@vger.kernel.org>; Sat, 17 Apr 2021 10:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CzvVfomXvrq/PDPH96J96agD0uM1TWi4i3Ti2IZY1VE=;
        b=dXLVksekIY3cFnEGK31fM1ct6jYu5KjR3V40/loDlXgVlFF0a2gqMYCEIkeQfksZCa
         ERmaHjxcm4A1CaCal+1o2tyk92er+rdFsQL4m8vAqk7cFWalBV/pVyQaUS61p+driL6o
         ZYv16ibb1FkrA0O7X9lBqaNh+czJczdmehvTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CzvVfomXvrq/PDPH96J96agD0uM1TWi4i3Ti2IZY1VE=;
        b=tE8RxdHNNXkdfE+uf2KhCcme2tpMwMJL6b9rt/QeeRgEMGS5GRuwvKvFklTrvBSmL3
         2ZRYvjk17MNE71tRTBGoyibEIWTSd2vOAs0T1E5uIiBiQth0HYZTA/9rHKDi8Cvnk3Xs
         R/fnwlKyATkHDLgfeMZC9TDpaYBUtQMWRvwdmwyUtIrKqqmbxkmGSSiN5YNPg3qMDefC
         hrQ8CYj8tn49i96J7crLF9kpC3yUdxCeT/BjOkAefdFxSrCT4CE0lBA/a4HB236rFAyN
         lvmLvJOJdu7kThioTdjkf6xpfzmTHF4RVKgKleQc4o/fiEVfk4fsCfL4hxBOrx8hqoQU
         SkDQ==
X-Gm-Message-State: AOAM530v3sfD4eDDILc+8FfPXyZI61Z7Au4JV2l0vC9NdRcFIHb+ZHNu
        VpkncNqFGTMDt15aI/+gqpAzL9h/LXd433yI
X-Google-Smtp-Source: ABdhPJyhn8QEwdF/VjJES0QojQ2cLV0KI1gRMN+fD5mq4LrX0DrOVAffAd5vgKYVaz24dQ+NQN5N1w==
X-Received: by 2002:a2e:878c:: with SMTP id n12mr6031059lji.492.1618679807959;
        Sat, 17 Apr 2021 10:16:47 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id x4sm1308827lfa.173.2021.04.17.10.16.47
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Apr 2021 10:16:47 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x19so19173028lfa.2
        for <linux-sparse@vger.kernel.org>; Sat, 17 Apr 2021 10:16:47 -0700 (PDT)
X-Received: by 2002:a05:6512:3763:: with SMTP id z3mr6411606lft.487.1618679807245;
 Sat, 17 Apr 2021 10:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20210126220432.58265-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 17 Apr 2021 10:16:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO=9N_Qz6MsXB2SVUGXHX53bFEvNDbmLHB6_W+dEBN-A@mail.gmail.com>
Message-ID: <CAHk-=wgO=9N_Qz6MsXB2SVUGXHX53bFEvNDbmLHB6_W+dEBN-A@mail.gmail.com>
Subject: Re: [PATCH 00/10] simplify and canonicalize signed compares
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Jan 26, 2021 at 7:45 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> This series fixes and improves the simplification and the
> canonicalization of signed compares.

Hmm. Sorry for not replying earlier, but I just checked the most
common simplification of signed compares, and it didn't work.

This:

    _Bool test(int a)
    {
        return a >=0 && a < 16;
    }

should simplify to be the same as

    _Bool test(int a)
    {
        return (unsigned)a < 16;
    }

but it doesn't. It generates the silly - but straightforward - "two
comparisons and a 'and' of the result".

In fact, the recent canonicalizations means that the compare against
zero is actually pessimised, and ">= 0" becomes "> 0xffffffff", which
is often a much more expensive operation.

This came up because I was looking at some kernel code that did
exactly that "check that a signed value is within proper bounds", and
the zero check is a very common bound.

               Linus
