Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73B0C433E0
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 17:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A569864E74
	for <linux-sparse@archiver.kernel.org>; Sun, 28 Feb 2021 17:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhB1RrS (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 28 Feb 2021 12:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhB1RrR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 28 Feb 2021 12:47:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9831C061756
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 09:46:36 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id v9so3924534lfa.1
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 09:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PYbd8W2ERsYmeYVUmOtaj2jhrGyioWCUfE9oukXAhNE=;
        b=ESt51xZ6j8z3R2C13hvhPuz4+dqFbpWeLIYeBC/785+e7TMpGjVvwbZTyBbXYiywNg
         tUHY8gJUP0ZFuwgthF/ITRSf89SQUxz6/1OZcinYsJAnQktW5vMYNpGD6j8iTXw9vQic
         +l1XcmZmM6okfi0xWyf/k8Pd9YahI3rTnu4CM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PYbd8W2ERsYmeYVUmOtaj2jhrGyioWCUfE9oukXAhNE=;
        b=ud8O2e1l0MRKqzk8MtFv8VnYyWgJWHDdgWVA73OaDqNas2vX7maI5RV8QmQHUnpOg0
         ncMWB5tJEEOq5Y9zxXEUCEf1IZGr1ukdokENIsjE+yuXrACYnQI+4ETHY2kyWUlrwUY/
         YR34vOZOhzUHjIGAsMLaemzGSJDKFiOEHPvvLjEZa30Z10cCX1Q98xshSRAnQekTuM1+
         3rA4NUwGvLm1LtvN+OTXqAkrV3KQsOhwdFylSkkOpfrT84EFKgzGHS4uDYaDjB58ecMA
         eMLv/l/q0IXKGIt3785cVCVyBY4v7nqLGsIUHjlNSwJeHKLFtXPg/olXmQ+xXxKFsJVQ
         Ppcg==
X-Gm-Message-State: AOAM533cvGv2Ai8k+5YdYK4jcbXwkQPTB2T+M9TsxdADQjf9kDDl/sSo
        yg7GZxnNiZvUFtZBR6EwpKouvJuBloro4A==
X-Google-Smtp-Source: ABdhPJw57uJHPAxf16lcD1d5I+p0I2aItKTh33JRP6V2RaNIJc8CexaZDCC9x6pjNzGf+H3ZR+j9Yg==
X-Received: by 2002:ac2:5232:: with SMTP id i18mr7409157lfl.30.1614534394954;
        Sun, 28 Feb 2021 09:46:34 -0800 (PST)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id r66sm2024514lff.93.2021.02.28.09.46.34
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 09:46:34 -0800 (PST)
Received: by mail-lj1-f182.google.com with SMTP id h4so16500384ljl.0
        for <linux-sparse@vger.kernel.org>; Sun, 28 Feb 2021 09:46:34 -0800 (PST)
X-Received: by 2002:a05:651c:3c1:: with SMTP id f1mr6158938ljp.507.1614534393744;
 Sun, 28 Feb 2021 09:46:33 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
In-Reply-To: <YDvLYzsGu+l1pQ2y@localhost.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Feb 2021 09:46:17 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
Message-ID: <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Feb 28, 2021 at 8:57 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> This is bulk deletion of preprocessor include guards and conversion
> to #pragma once directive.

So as mentioned earlier, I'm not 100% convinced about the advantage of
#pragma once.

But I decided to actually test it, and it turns out that it causes
problems for at least sparse.

Sparse *does* support pragma once, but it does it purely based on
pathname equality. So a simple test-program like this:

 File 'pragma.h':

    #pragma once
    #include "header.h"

works fine. But this doesn't work at all:

    #pragma once
    #include "./header.h"

because it causes the filename to be different every time, and you
eventually end up with trying to open   "././....../pragma.h" and it
causes ENAMETOOLONG.

So at least sparse isn't ready for this.

I guess sparse could always simplify the name, but that's non-trivial.

And honestly, using st_dev/st_ino is problematic too, since

 (a) they can easily be re-used for generated files

 (b) you'd have to actually open/fstat the filename to use it, which
obviates one of the optimizations

Trying the same on gcc, you don't get that endless "add "./" behavior"
that sparse did, but a quick test shows that it actually opens the
file and reads it three times: once for "pramga.h", once for
"./pragma.h" and a third time for "pragma.h". It only seems to
_expand_ it once, though.

I have no idea what gcc does. Maybe it does some "different name, so
let's open and read it, and then does st_dev/st_ino again". But if so,
why the _third_ time? Is it some guard against "st_ino might have been
re-used, so I'll open the original name and re-verify"?

End result: #pragma is fundamentally less reliable than the
traditional #ifdef guard. The #ifdef guard works fine even if you
re-read the file for whatever reason, while #pragma relies on some
kind of magical behavior.

I'm adding Luc in case he has any ideas of what the magical behavior might be.

Honestly, I think #pragma once is complete garbage. It's really is
fundamenetally more complicated than the #ifdef guard, and it has
absolutely zero upsides.

I'm not taking this pramga series unless somebody can explain why it's
a good thing. Because all I see are downsides.

               Linus
