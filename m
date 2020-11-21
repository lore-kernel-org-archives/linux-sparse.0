Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4BFC388F9
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 21:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34C320936
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 21:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gQ9XlpUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgKUVKK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 16:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUVKK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 16:10:10 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE941C0613CF
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 13:10:09 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id u18so18432823lfd.9
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 13:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mqwEsCjkAg/0ThdoZZZj63wAtOkRqvI9hdJ498On1m8=;
        b=gQ9XlpUvZXjyyhFK52keSOy6wstF8B+uIyQbuE8zyy8rfVU6mOxSsbpIbhbaaVb8xE
         nyie6W33i++88zR4XGCQ+EXjUbnNRrKKe3a5mFvWeYamhB76vRJTNXpbyAeHAUs9tTeu
         V61Vs9+zJ5bfLft6CSLxL7Wt05jAWAoyUONbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mqwEsCjkAg/0ThdoZZZj63wAtOkRqvI9hdJ498On1m8=;
        b=C3O53wq7uVrEUbe6zljGjaqRt1FZm4enF5LFS6lZDCQ8QiNowUXuszAWDlJGcKUWw1
         PBUroZUaWYYR67vOV+cpsHQNiSYd6CYJN7pY7TBq+ZqwCsCAG4zsXfXLpKKuUBB+YqzP
         EassVwwZerbJNlx3Y0y2w2pliqC8t6CIiXCcRQkhVYCtl18ulZw/kAJJ5Ud4T6EYsrnP
         4Cx0orQ3Ql6wUfmUMqrBQ3DwINHJLB2nDV0wjfrovfow9bKgaOh8+jArY0Iyz1lW/E4a
         DOXCjehWFgwrdmV3rW6IKp+nCcPDzEoQVpnKezDO2MIE7TuLNSuMyqfc4N7cOtx2yIb+
         znsg==
X-Gm-Message-State: AOAM530wSDIKYSqTq0C2MPR7TDXd4Sob72SD60jGZjzSHAWL45QroDFq
        7l39/sOIgMUSUFaBUQTMG5uryl6oT9YATA==
X-Google-Smtp-Source: ABdhPJywNZAmeVeYxHXn7ozIhi+dggl9e6dhmkkambCBOzl+ROngV7U6cjoxxinzNvWKXs5aqvxLaw==
X-Received: by 2002:a19:40c7:: with SMTP id n190mr10141479lfa.185.1605993008166;
        Sat, 21 Nov 2020 13:10:08 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id h21sm197803lja.109.2020.11.21.13.10.06
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 13:10:07 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id t22so1434397ljk.0
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 13:10:06 -0800 (PST)
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr10966373ljj.312.1605993006682;
 Sat, 21 Nov 2020 13:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Nov 2020 13:09:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=whC2Kygu6Vpgt+vnzVGAG-ZYHk1ucOcv7b9AcvmdrY-Eg@mail.gmail.com>
Message-ID: <CAHk-=whC2Kygu6Vpgt+vnzVGAG-ZYHk1ucOcv7b9AcvmdrY-Eg@mail.gmail.com>
Subject: Re: [PATCH 0/4] simplification of computed goto
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Nov 21, 2020 at 12:54 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> This series contains some simplification of computed gotos with
> 1 or 2 possible target as well as a new instruction which now
> really allows the CSE of 'labels-as-values'.

Looks sane, but where did you actually find cases of this in real life?

I think we have one computed goto in the kernel, that does an array
label load. They are very rare, and when they are used, that tends to
be the normal pattern.

Just about the only place I've ever seen them are in that kind of
interpreter loops for instruction dispatch tables.

          Linus
