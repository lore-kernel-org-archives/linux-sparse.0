Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285A5C4332F
	for <linux-sparse@archiver.kernel.org>; Thu,  9 Nov 2023 17:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344886AbjKIR6J (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 9 Nov 2023 12:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344898AbjKIR6J (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2023 12:58:09 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98FD3AA9
        for <linux-sparse@vger.kernel.org>; Thu,  9 Nov 2023 09:58:06 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9d2e7726d5bso187962066b.0
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2023 09:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699552685; x=1700157485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8wecaRSjJdSteghYXVOtsF+9kjggPC+ACQitgoijs5Y=;
        b=g2v/ZXtYD0iLdWsYBKnjNJ1cJs0uAsR6qFrp84qXX6LHGK//6hM867JkTrIHuYkFJ7
         LXwc1ktKgxiwApzns7yHfDu1wNXKbyywYeTyYu5yUxFeKsyeLn6S3ByNxx437mN932ig
         4Ds9xYD6n8JoEkVWys+wv08pk8lX2Jx/KXsmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699552685; x=1700157485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wecaRSjJdSteghYXVOtsF+9kjggPC+ACQitgoijs5Y=;
        b=DbWVLPS69aivDevP2rHzLYmV1Cd2oZ+PfJAXzd7/Cr8P/CEAyXxgYfAbBa+q1Ysm8t
         1eh08mUq5VO8PYOwMW+g8cHuByJTchJCVHQPVmenGcKnIHNToviLtmgvlifZzTNQVBSu
         xnpTuLL1X6NhVnzAIBO0o/N2PzBTx7Aj1G7UmhmrTqLhF0aykRP9e2VWeww7K5TlgEQ2
         E6RZbnfsY1d0coAaET7CQEdebvN8yk/R0+OvyCpaDrJ7DApSa60rDQ/t1IhHjIpD/oIB
         I5kLzJAonUkVOHZ64xD2IXdqNL7USXWKxBhhWxcxntBwhBnD47aFQosCTjA3xFwmiwqw
         Z4DA==
X-Gm-Message-State: AOJu0Yyht8LZVWXb82uqNbAeOiXlokA1+PUifA4N+EFUEQ7goA33AOEt
        R2kVF1uiIdZ1t30Y5Axq9jqraFdSUFzM3lZYgmA3Cg==
X-Google-Smtp-Source: AGHT+IFgGFJ1in55lKBmQvDKRkurYW1Isb9KdW4+pnRpEqEKpbFWmyu+vDcaLwx7N/8b4ULuof9Zfg==
X-Received: by 2002:a17:906:7309:b0:9d3:8d1e:ceb with SMTP id di9-20020a170906730900b009d38d1e0cebmr5384665ejc.23.1699552685078;
        Thu, 09 Nov 2023 09:58:05 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id q11-20020a17090622cb00b0098e78ff1a87sm2834437eja.120.2023.11.09.09.58.04
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 09:58:04 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9be02fcf268so184328466b.3
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2023 09:58:04 -0800 (PST)
X-Received: by 2002:a17:907:7f8f:b0:9bf:f20:8772 with SMTP id
 qk15-20020a1709077f8f00b009bf0f208772mr5537864ejc.26.1699552684177; Thu, 09
 Nov 2023 09:58:04 -0800 (PST)
MIME-Version: 1.0
References: <ZUxoJh7NlWw+uBlt@infradead.org> <CAMHZB6G_TZJ_uQGm5an0-bhG8wCxpEQrUCShen7O61Q9arAf+Q@mail.gmail.com>
 <ZUxuY13JnQ8IIFd1@infradead.org> <CAMHZB6H7Y0m2Y-ZD0PMKiGDeo7_sy=scDrzbBbBuUJfuzLK-Lg@mail.gmail.com>
 <ZUxx1kvWH7dSIazw@infradead.org>
In-Reply-To: <ZUxx1kvWH7dSIazw@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Nov 2023 09:57:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiq873oXRfSqaM3mZzkoJbncWyWFGyi5yxHAogciRwMBQ@mail.gmail.com>
Message-ID: <CAHk-=wiq873oXRfSqaM3mZzkoJbncWyWFGyi5yxHAogciRwMBQ@mail.gmail.com>
Subject: Re: sparse feature request: nocast integer types
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, 8 Nov 2023 at 21:45, Christoph Hellwig <hch@infradead.org> wrote:
>
> For my use case it'd treat it exactly like __bitwise except for also
> allowing arithmetics on it.  Bonus for always allowing 0 withou explicit
> __force cast just like __bitwise.

It's too long for me to really remember, but I think that was the
*intention* of the "nocast" attribute originally.

The whole "nocast" thing goes back to pretty early in sparse (first
few weeks of it, in fact), and is almost entirely undocumented.

The commit that starts parsing it doesn't actually even mention it -
it mentions the *other* attributes it also starts parsing, but not
'nocast'.

Iirc, what happened was that one of the opriginal goals was that I
really wanted to have that "warn about any implicit integer casts",
and added "nocast" quite early, before the sparse type system was even
very strong. But it ended up being almost just a placeholder.

And then later on, Al came in, and he did the much stronger 'bitwise'
thing, which was immediately useful for all the byte order handling,
and 'nocast' ended up falling by the wayside.

Anyway, I think what you ask for is what 'nocast' was always supposed
to be, but just plain isn't.

                   Linus
