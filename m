Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECB3C43334
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 16:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiFZQeU (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 12:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiFZQeU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 12:34:20 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F2BBCA0
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 09:34:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id q6so14275739eji.13
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mScxwT9DzL3m/fse9Qa13RHznVT8wiBux8yUPiA/65w=;
        b=Fv68tSKqZvEHCHdmDpfHlKLYttzkO7ojxHn2al/Pb7IdSsasPmpYAK2+TpzX4qQDqt
         oFjxvUfBmPnTQHGF+agmqW3JDOYDlGeS0gNC05KfbkWpTkkuK0w3mcidoo0C4Q2p+jH+
         qnQ/2ntK72Zq3JYUI5Z4Y8+t5KpSct0oU8lBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mScxwT9DzL3m/fse9Qa13RHznVT8wiBux8yUPiA/65w=;
        b=Ggyp3lfqR6CqXGjiMb8UbwbUZu+oEJvJHKnd8CpY3qbdHSt342QpnWqQ1CeKt4zix0
         J886feo4LKS9uIH4b03Sd+48KtDHTBtxBowlJvDqaOAereDUB5Vn25DY4MMqShlyybme
         WLykFMzC84BX1JO3T3fJOtabxMiejfOC+ivU69hZfxs04tYpg7aihEH/4n6m4STldieg
         142zpXLAvVHHqgUtnScMS8FYl/pJGD7IIBOD5hzgovm/djPfll0mLgcLfFokpYBc78ed
         XaF7Sbp9wMHAdGv52lz1B+DEyCykngfqX02LBQH6fIDOj+GxrDQt2a82WjiEcUpVMe85
         QXjw==
X-Gm-Message-State: AJIora/A36SHa0x1y4u73VoidTkpj7SUJuuwps3wcssGUo7bOt89jkva
        xnN3lpgVa7yeQxZCfORvTaggREr6cCBmWQwU
X-Google-Smtp-Source: AGRyM1s1z3IWtMD3bx8++ph1TKvr3Yz3/jHePiYACt9VQC9w+gTuY8HALFVuxVSA95JwjCHLIM9LQA==
X-Received: by 2002:a17:906:9c82:b0:6e1:2c94:1616 with SMTP id fj2-20020a1709069c8200b006e12c941616mr8885151ejc.64.1656261257867;
        Sun, 26 Jun 2022 09:34:17 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709064d4700b0070f6855b90bsm3953949ejv.170.2022.06.26.09.34.14
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 09:34:15 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id o16so9847238wra.4
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 09:34:14 -0700 (PDT)
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id
 j17-20020a056000125100b0021aefae6cbemr8209393wrx.281.1656261253928; Sun, 26
 Jun 2022 09:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220623180528.3595304-1-bvanassche@acm.org> <20220623180528.3595304-52-bvanassche@acm.org>
 <20220624045613.GA4505@lst.de> <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
 <20220625092349.GA23530@lst.de> <3eed7994-8de2-324d-c373-b6f4289a2734@acm.org>
 <20220626095814.7wtma47w4sph7dha@mail>
In-Reply-To: <20220626095814.7wtma47w4sph7dha@mail>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jun 2022 09:33:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
Message-ID: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Jun 26, 2022 at 2:58 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> What about I would add to sparse something to strip away the bitwise/
> recover the underlying type? Something like __unbitwiseof() or
> __underlying_typeof() (some better name is needed)?

Please no, we don't want to make random macros have to have sparse
logic in them when it's not actually sparse-related.

I think it would be better if sparse just recognized some of these
kinds of situation. In particular:

 (a) for the casting part, I actually suspect we should drop the
warning about castign integers to restricted types.

Note that this is actually one of the main causes of "__force" use in
the kernel, with code like

        VM_FAULT_OOM            = (__force vm_fault_t)0x000001,
        VM_FAULT_SIGBUS         = (__force vm_fault_t)0x000002,
        VM_FAULT_MAJOR          = (__force vm_fault_t)0x000004,
        VM_FAULT_WRITE          = (__force vm_fault_t)0x000008,

and I think that we could/should just say that "explicit casts of
constants are ok".

That would remove two of the four warnings right there, and probably
make bitwise types more convenient in general.

We already treat "0" as special (because for bitwise things, zero is
kind of the universal constant), and we should continue to warn about
_implicit_ casts of restricted types, but I think the use of "__force"
in the kernel does show that the explicit casts are probably a bad
idea.

 (b) I think we could also recognize "comparison of constants" to be
something that doesn't necessarily require a warning.

And here in particular the "compare with zero" and "compare with all
bits set" - which is exactly that "-1" case.

In fact, there's a very good argument that "-1" is as special as zero
is ("all bits set" vs "all bits clear"), so for that (a) case, I think
at a _minimum_ we shouldn't warn about that particular constant.

So I think we could silence this sparse warning entirely, without
really introducing any new syntax, and actually improving on how
bitwise works.

                 Linus
