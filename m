Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E966C388F7
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 18:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AED20888
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 18:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604774307;
	bh=3Gskvty0BAJoDwRxp2eUFmc0rRrgWCzH2tdl3EbLAn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QSismS7eqlJQ1DJgMsYEFd4eOoRlRjWTl2KD6AE1r1T7oSGPZx22NuEIygA/D4Mta
	 rpzPbeaYVjLwddjrGOnu95h5E2SJLYyIBkw9yJNH+M3O+QgloUM0LPCnBfmC352ev9
	 /PMG81sj/3E0QlrR+esXhoONSUW3MJcBwKSmdZm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgKGSi0 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 13:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGSi0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 13:38:26 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBECC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 10:38:26 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id 74so6547278lfo.5
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 10:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHe/4Aap1K3TFjB2f0y3X4XLIs6ED1FEPJgEgNgzbYA=;
        b=Psj6nyjajsgRFZgGdo1oTJsGNtKzFlkx5GvHTGpyiuQVOLsdm+nYJeDWLYWunxoP3H
         UXjB22+2vTMdeNjnbhlhlLzxmF1PeWbwTFb6GQzOwnLROaHeeA0UHDukkoNiMGo45UKi
         EexTNritWb3dNFnp+OYe+P9nLZaMqwNLb4AgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHe/4Aap1K3TFjB2f0y3X4XLIs6ED1FEPJgEgNgzbYA=;
        b=j4q1bjl2FbyGMZn3uQe98u9jvAVgiBaRzo1aTpB6xgMMvNuERKQTcnrDBiaYPG0QX7
         Ev7myHCmEZt4Ktu56zOjHSwnwklU1VMj8JrEu3oMK9nxjjQDbc2ZqH7YRcQ5kZmOfL7U
         Qh7GCrZBaLrSyc/ONd/XYb5HXFdo+X3WTF0KgPdqPhpKrTnQZoe5p+zuO4eZDUSifPya
         ECSfbA883i5fjUeAlghDC5nidJ255ppfTL6lD373ll5dFxyoaVy3ET/5agPIkU7FTPzY
         WyWniDKAAJlU2AwuGbgoC3DaVlUa49fsUD5qeuvWo4ta4wKbmXnW/shYj7pWYmnbwXFh
         txBg==
X-Gm-Message-State: AOAM532DaHMva574xdJlwMIKYU5TeagrN+LP4+EsaLavGw5sRz/8jGir
        U5LdrObF+C2xOQ6WLuYJxZNh8+AgkiE/Jw==
X-Google-Smtp-Source: ABdhPJxoSxwA7jhuhsnTr7/8Lxg3QhqoBcYtWZyXI7asylq4UDdVF6LtZ/j+77UCOHo/wA/E1weI6w==
X-Received: by 2002:ac2:4211:: with SMTP id y17mr2864006lfh.133.1604774304232;
        Sat, 07 Nov 2020 10:38:24 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id b12sm493947ljj.133.2020.11.07.10.38.22
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 10:38:23 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id d17so3158190lfq.10
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 10:38:22 -0800 (PST)
X-Received: by 2002:a19:4815:: with SMTP id v21mr3189503lfa.603.1604774302679;
 Sat, 07 Nov 2020 10:38:22 -0800 (PST)
MIME-Version: 1.0
References: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20201107114222.11866-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Nov 2020 10:38:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvvkQm3zTobKUY2OuUfNACa13mhYeTPwVJcT0HVeRkjg@mail.gmail.com>
Message-ID: <CAHk-=wjvvkQm3zTobKUY2OuUfNACa13mhYeTPwVJcT0HVeRkjg@mail.gmail.com>
Subject: Re: [PATCH 0/5] simplify SEL(SEL, ...), ...)
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Nov 7, 2020 at 3:42 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> These patch add a few simplifications when the condition of a
> select is another select and have constants as operands.

Looks good to me.

I think there's a couple of others, like

  SEL(x, x, 0) -> x

which looks insane, but I think these are the kinds of things that end
up showing up when you inline things that return errors, and then you
test them for zero etc.

I haven't thought them all through, and didn't check your cases deeply
and just took your word for them, but it looked all sane to me.

            Linus
