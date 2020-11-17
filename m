Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFBCC2D0E4
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 23:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D6A2222B
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 23:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KJAP3Gc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgKQXWm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgKQXWl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 17 Nov 2020 18:22:41 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C45C0613CF
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 15:22:41 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id z21so214207lfe.12
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 15:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P1qoUV/eEchza4a7fsyMF2t0mc0y5de0LpLm4l+MT9Y=;
        b=KJAP3Gc4bEQISf2BP+Cjl5S8hMgoliEelljrOI/prhw4JCxAQ7AQLxPC9ONuxMMQs1
         uOhEpZgdlgO8wskbakojhOfGBkqKfaG28E0RTU2+49yen1kb3ywBaMA8mHDPcWY74jVg
         5D4C//Auz5qKwQcp7IYZHhGvUqdru2OzqY7mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P1qoUV/eEchza4a7fsyMF2t0mc0y5de0LpLm4l+MT9Y=;
        b=ewctQnvAN+bskZMvccmS5slW78vokEfYyag/CyzokltLD+HvKojdkTDAg2/MjKualK
         PDEXh62WH1otr05tvb6z8lwJQ1tFGNWMxDJaypBk1smuBRih9S+KfG4yTWR9APPidgMT
         PtaYXEG7YS9ob9C/WXuf/D5q2N3S/30YL7OWnfx2cbgqnW7wl63pvqoVin7qlBj9zWDm
         rBZhtuZY8Bz0+fTXGwONC1oj2OugwkKV324NSCOFLdG6zV0B+zZpxVUtDBnx3+lxGaAy
         5HKW9pPD3FLeNKFkl26BSzFkKmuyRCn/eM/lx3FIVFI3LOSyWHJgNYF0EnAJy1Lyd5v/
         c5zg==
X-Gm-Message-State: AOAM533MewBivprgRKliXXYKDXa2qSrtDcSP+OjzYuJmjpyRyVPFjeN9
        jhQjMsh2Y2aV1qn0LQS5lqGSLhgOGic8yg==
X-Google-Smtp-Source: ABdhPJyWdLVm+FjMYiOsnnQca0ImZDk64FNdCrWNm8prHjr8ZZCzozt+WcZMctIH/nE0O3BDB99S4A==
X-Received: by 2002:a19:c602:: with SMTP id w2mr2579456lff.4.1605655359296;
        Tue, 17 Nov 2020 15:22:39 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id m25sm3321056lfh.205.2020.11.17.15.22.37
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 15:22:38 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id v20so235743ljk.8
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 15:22:37 -0800 (PST)
X-Received: by 2002:a2e:80c7:: with SMTP id r7mr1042378ljg.285.1605655356961;
 Tue, 17 Nov 2020 15:22:36 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
 <20201117212829.99552-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20201117212829.99552-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 15:22:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtL1LPYev5cwhZqd=7RyaGrzx3mS-ydVZAQuYrf0XNuQ@mail.gmail.com>
Message-ID: <CAHk-=wgtL1LPYev5cwhZqd=7RyaGrzx3mS-ydVZAQuYrf0XNuQ@mail.gmail.com>
Subject: Re: [PATCH] casts should drop qualifiers
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Nov 17, 2020 at 1:29 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Casts should drop qualifiers but Sparse doesn't do this yet.
>
> The fix seems pretty simple: after having evaluated the type of
> the cast, if this type is a SYM_NODE and contains qualifiers,
> make a copy of the type with the qualifiers removed and use
> this copy as the type.

Did you look at the lvalue conversion issue too?

IOW, ((void)0,(x)) should end up also with qualifiers dropped on the
end result, because the comma expression will have turned x from an
lvalue to an rvalue.

Would doing the same unqualify_type() in degenerate() be sufficient?

No, the kernel doesn't care, even with that suggested patch, so maybe
that all doesn't matter.

           Linus
