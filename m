Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8E1C2D0A3
	for <linux-sparse@archiver.kernel.org>; Mon,  9 Nov 2020 21:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 563D8206CB
	for <linux-sparse@archiver.kernel.org>; Mon,  9 Nov 2020 21:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a/QXdlNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgKIV6C (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 9 Nov 2020 16:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIV6B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 9 Nov 2020 16:58:01 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FF5C0613CF
        for <linux-sparse@vger.kernel.org>; Mon,  9 Nov 2020 13:58:00 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id j205so7236770lfj.6
        for <linux-sparse@vger.kernel.org>; Mon, 09 Nov 2020 13:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCw3ihkOhOqAAmDwwXC/e0ln05fHLJV9btsrGTxOMbY=;
        b=a/QXdlNAsaTDVCXYZGjGfI11Nhz97QhjB+C1APVU09/zt5StkXCg29gF91KHSeNotv
         O0JCwUPwQDi2cdfe42u7qCTEwWYX26Vbm2hPCqQigQPWH+K/jvfOYFTtmoQP142ho8RG
         gM/mGZPKaOjZ4rXOAWFsxLPBWjccytzA5X6uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCw3ihkOhOqAAmDwwXC/e0ln05fHLJV9btsrGTxOMbY=;
        b=kThliGVmJ24Wjo8MXFIpbQQs7dh987l49eEdk68Pyn+bB55cgSMMGib8msoif7H2kE
         MDiAEsO7SyhE/Nk7WjUsXoOiGMp5I12v0ChFHRtTnby5+Mms2AJU6we6HmO+tiFdsGbW
         4PkDvaCYh0XBDLAngSwJRWsU+f/7aYAY3hNTpvIuOE5+zOBcZAnE6dPVvUJgcmFHqGlB
         2oC8ZZAEz2DFT7cXoOWRrEMUzSnkE0Y1t4n/zIWgM9J33M87b+WQFG70/mr13LT/DP4O
         edyhlOR7hfGvRnBjfgu4xBeMqiULbuimkod8ktOrO4E3EEYV6hBvhU9e24SPm8WWs8/h
         3y4g==
X-Gm-Message-State: AOAM533kv5uGxpw7pcYUPXhRzFY8gKq8Vbfoab67PAI/CFbNuPIDNMJU
        7uCLdFFdrjcAl345MkkVLRnOD91zyyxUCA==
X-Google-Smtp-Source: ABdhPJy4ZohcOjTyrJvk6fe6PDj2jd5BegYuc6PJkLLse1//l049axLnowItrYWTMKaxDjPe4PbVpw==
X-Received: by 2002:a19:7d0b:: with SMTP id y11mr6870054lfc.305.1604959078581;
        Mon, 09 Nov 2020 13:57:58 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id a9sm1894316lfo.39.2020.11.09.13.57.57
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 13:57:57 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id r17so6628376ljg.5
        for <linux-sparse@vger.kernel.org>; Mon, 09 Nov 2020 13:57:57 -0800 (PST)
X-Received: by 2002:a05:651c:110:: with SMTP id a16mr7579055ljb.285.1604959077073;
 Mon, 09 Nov 2020 13:57:57 -0800 (PST)
MIME-Version: 1.0
References: <20201109211616.dyr7g62rz5oohseu@ltop.local> <CAHk-=wjwbK1vjoJKCCERXQkykNHa2Bfpg8CsyDrEU4mGyHA7Kw@mail.gmail.com>
In-Reply-To: <CAHk-=wjwbK1vjoJKCCERXQkykNHa2Bfpg8CsyDrEU4mGyHA7Kw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Nov 2020 13:57:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjPMXfxXiFEtYaa9h0rf1bbB-=QKzt=CT0oERE0wL8a3w@mail.gmail.com>
Message-ID: <CAHk-=wjPMXfxXiFEtYaa9h0rf1bbB-=QKzt=CT0oERE0wL8a3w@mail.gmail.com>
Subject: Re: 'context imbalance' warnings
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Nov 9, 2020 at 1:47 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Is duplicating the conditional branch worth it? In this case, clearly
> yes. But in general? Maybe we could do it in cases like this, when the
> *only* thing in a basic block is that conditional branch.

Actually, I think the correct thing to do would be not to move the
conditional branch into the parents, but instead:

 (a) if we see an unconditional branch to a bb with (only) a conditional one

then

 (b) we look if the current BB is dominated by the same conditional,
and if so, we follow the conditional one the right way.

and that would immediately get us to that

                cbr         %arg1, .L1, .L2
        .L1:    context     1
                br         .L5
        .L2:    call        use, %r1
                br         .L4

state, without that possibly expanding "duplicate the conditional
branches into the parent bb's".

But the current flow rewriting isn't smart enough to do even this
fairly simple thing.

               Linus
