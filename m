Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839C4C43334
	for <linux-sparse@archiver.kernel.org>; Sun, 26 Jun 2022 16:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiFZQvN (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 26 Jun 2022 12:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiFZQvM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 26 Jun 2022 12:51:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F9DECD
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 09:51:11 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id fd6so9991262edb.5
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0AO08N+O2HKOlo8aROzwAKUFuiNHFPdzCkY40TNdLQQ=;
        b=f/tdhmTVUX9v0vw9ziV6HKq8bXEGBCs9gjwEm4vyF5x0+OP6qJZfBnCGcZ8XDAin4X
         cgzRf+bmnc0mTwG0pLVJssCdJix5itYdFTCTaaTUOaLK+LTi6JzVRU+b67vGvl8+89CX
         gjcElCDgZ+6mVVdpxg8PHDPvWalzaGlhfLvOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0AO08N+O2HKOlo8aROzwAKUFuiNHFPdzCkY40TNdLQQ=;
        b=trZuJ11nVRee6KNuymJvpN4hoOeCI0zR89jF7SIK4lq8/rjKFSHGy8Y8Wibd0aKMKl
         ZUl4fge6689JbyBw25Q4Dkpkq924/XdKbtbIx3EVIU6rfK+MTTQ8HNgr6rVdY6FS1vNZ
         kKdfClB5Y8GlVuDUaYwZ9RFkSyfXpNoqtd9VdrRLHs5S8tLUKINlU8aZpNoV2AeOoQrA
         MeXeJbZg2kYpMXY0/pKG2pik2b6Urc3NL0mPNW6PRusvFH/pVGWQs9mvgwy+1oPfSaQ9
         LehFbEd+dDcMsHu9uCdfbP+6G4peNYnyflM3QjUWC/U0z4OcrbAJmrbNN+plO5M2Dcpo
         9CWw==
X-Gm-Message-State: AJIora8hP3EGTi05+bM7nBIgDosSdiViFJKulL/4o5c3tj/Gs07LDEN5
        QnC2ki4jzejnVSlvln0lYdVjAamxU5VLEUK/
X-Google-Smtp-Source: AGRyM1sNLM1gKjpyx8PvueR0kUl4BKvsV/n/gQZ+Mi1lDcccZWmPw2xvllSAZCCm8KFvx5M/4+W0xQ==
X-Received: by 2002:a05:6402:51ca:b0:437:79a9:4dd with SMTP id r10-20020a05640251ca00b0043779a904ddmr7175340edd.319.1656262270003;
        Sun, 26 Jun 2022 09:51:10 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id d20-20020aa7ce14000000b00435d4179bbdsm6227904edv.4.2022.06.26.09.51.06
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 09:51:07 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id q9so9855455wrd.8
        for <linux-sparse@vger.kernel.org>; Sun, 26 Jun 2022 09:51:06 -0700 (PDT)
X-Received: by 2002:a5d:48c1:0:b0:21a:3574:e70c with SMTP id
 p1-20020a5d48c1000000b0021a3574e70cmr8554876wrs.97.1656262266321; Sun, 26 Jun
 2022 09:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220623180528.3595304-1-bvanassche@acm.org> <20220623180528.3595304-52-bvanassche@acm.org>
 <20220624045613.GA4505@lst.de> <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
 <20220625092349.GA23530@lst.de> <3eed7994-8de2-324d-c373-b6f4289a2734@acm.org>
 <20220626095814.7wtma47w4sph7dha@mail> <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
In-Reply-To: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jun 2022 09:50:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMV0CAb66pJASCcAwMZNfJpRKrO=EwXcm-vWUnXF7gDA@mail.gmail.com>
Message-ID: <CAHk-=whMV0CAb66pJASCcAwMZNfJpRKrO=EwXcm-vWUnXF7gDA@mail.gmail.com>
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

On Sun, Jun 26, 2022 at 9:33 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  (a) for the casting part, I actually suspect we should drop the
> warning about castign integers to restricted types.

Heh. Trying that out, I find we seem to do this at the wrong point anyway.

I removed the check for "value of 0 is ok", and it continues to warn
about casting "-1".

Because it does that before "-1" has even been simplified, so it
actually sees it as an *expression* ("negate the constant 1") rather
than as the *value* -1, and it warns.

That's a bit sad since really -1 and ~0 really both should be ok for
the same reason plain zero is ok - regardless of the whole "do we just
allow it for constants in general" thing.

I think the bitwise thing was always a bit half-baked. It was designed
for detecting little-endian and big-endian issues, and "bitmask"
types. And it's wonderful for the basics of that, but I think it was
never really thought through for this kind of extended use where we
end up having generic macros that do still make sense for them, but
aren't that exact "avoid assigning bitwise values to other values"

                 Linus
