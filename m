Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF97C5519F
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 20:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98DBB20760
	for <linux-sparse@archiver.kernel.org>; Sun, 22 Nov 2020 20:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ERA49Cee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgKVUOH (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 22 Nov 2020 15:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgKVUOG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 22 Nov 2020 15:14:06 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD1C0613CF
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 12:14:06 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so20905859lfd.9
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 12:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rEkp71EARHkpnXSINU2G4FeoClSnx+qkVVNp7lHe+lw=;
        b=ERA49CeeBzdCJdsepETkp3rlEGu0nLn8Od11t1h5A775LyyawzpW3QJrtd5U5YIzUE
         pegZFPT2YA3TwjUn3TDXWu8Or/l98iylBb1DT7hAbSXJKBiIpngLA8NU7+Oh9qJ9Qp8t
         IR0p1ZYpwJvjjG/TYS/K0bwqsyPtRZwdc5w4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEkp71EARHkpnXSINU2G4FeoClSnx+qkVVNp7lHe+lw=;
        b=loNqQKY9l7/X8HQM5cDRhlxeOQ12/zTPD8WypRKCG5mi4FKFpKjAqxAbo7Ht/ylH8t
         Way8E3MS7htt95yF2g4sY5e+3VF5Nq1+0zOkDHtBlHkmO3ZX5z1hk0Br55Us4gnGQDp6
         EbxrmXKbCV6Gw8ROBpbjFfJkAGvKVq0Wo6MbECCMm19SobYjsYao3TQa7g730nt1/WRO
         g5m/UwX5LYwvKZ0K4YK29+XK2tLNjnIh9qHc0c91K7WEyPqc0GVp6dTZ7urt5Shyl75S
         Xedr9Avt28YlFT2DGSrBtesult23O1b7s/h/CYVKKRLJZsFIoolzqhgQ0IH+N+ohbo0c
         AX9A==
X-Gm-Message-State: AOAM5322lunAt4/IXlTcNezHkaWK7CCMMErQMRqCyiHE/47ula2nIr8l
        1D8XT0B7iQQXTDU3ISuk6aL+EkxMUkAYFw==
X-Google-Smtp-Source: ABdhPJy8AXxIdF1/1Ouwalb1Xccym7athOgDeP4ZKzebbBB8zV6ETuaEFgIzG/Hx6hupB3iTwBnqqw==
X-Received: by 2002:ac2:4831:: with SMTP id 17mr12453219lft.487.1606076044528;
        Sun, 22 Nov 2020 12:14:04 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id v20sm1136402lfd.267.2020.11.22.12.14.02
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 12:14:02 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id l11so20999085lfg.0
        for <linux-sparse@vger.kernel.org>; Sun, 22 Nov 2020 12:14:02 -0800 (PST)
X-Received: by 2002:a19:7f55:: with SMTP id a82mr13194013lfd.603.1606076042273;
 Sun, 22 Nov 2020 12:14:02 -0800 (PST)
MIME-Version: 1.0
References: <20201122152731.10994-1-luc.vanoostenryck@gmail.com>
 <20201122152731.10994-2-luc.vanoostenryck@gmail.com> <CAHk-=wjqwFDEJkGoPtjeTn1cDDpadz_eL_m1w-wk9G9Zmucosg@mail.gmail.com>
 <20201122195746.uq44lstsy2pissxi@ltop.local>
In-Reply-To: <20201122195746.uq44lstsy2pissxi@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Nov 2020 12:13:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
Message-ID: <CAHk-=wjoJXrG=2_vnOX37fro12eyZc+uo2WL+F-utk51g9WuBA@mail.gmail.com>
Subject: Re: [PATCH 1/7] not: add testcases for canonicalization &
 simplification of negations
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Nov 22, 2020 at 11:57 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> In the case here with your example, the if-conversion doesn't happen
> because the phi-sources is not defined in the top block because of
> the OR:

Ahh. Yes, it's more obvious with a more realistic test-case that
actually translates one set of bits to another set of bits (which is
something we do in the kernel for various reasons - different bit
"namespaces", for example user interfaces etc):

   #define BIT1   4
   #define BIT1x 16

   #define BIT2   8
   #define BIT2x 32

   int translate_bits(int x)
   {
        int y = 0;
        if (x & BIT1)
                y |= BIT1x;
        if (x & BIT2)
                y |= BIT2x;
        return y;
   }

and the first one gets nicely translated as

   and.32      %r2 <- %arg1, $4
   select.32   %r14(y) <- %r2, $16, $0

but then the second one doesn't for the reason you mention.

Honestly, particularly in the conditional form, the OP_SEL
optimization might not even be the right thing. It adds register
pressure.

So maybe a better model would be to not try to do jump-conversion, but
have some kind of general "can we simplify phi nodes", where jump
conversion to OP_SEL is just one of the options.

              Linus
