Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19317C433E6
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 21:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C93E9650CC
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 21:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCFVRc (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 16:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhCFVRS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 16:17:18 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DEEC06174A
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 13:17:18 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id m22so12607112lfg.5
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 13:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0oVCzq0jNeLOontu1JlmnROMMA6mCdmuZr2oyDQelGQ=;
        b=X8pUa3niaUCE9UPZwbgb/5tFRn+ziPMh+Wn2W9A0BRQvAlq4+GjZe6Z1RgUKva/7cn
         hOz0HUw8abtsQ86VKUvibS7hp6EYgwoggIDcxDoDglOq3k2RQpuRwxuBBWVSEQZoAfVo
         jQQvvubmoxz5/6Jgd9mED90TzbHHK7KrjTpls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0oVCzq0jNeLOontu1JlmnROMMA6mCdmuZr2oyDQelGQ=;
        b=A04IzvXndRtzYK03FahgqTzR0JX5qVzI/AOnAsr4jMRgjs9vniP2GJFbXux2VAB9gU
         Z6qzWt3Wzj2C5pZBRxc8s7pcrCbgX4HOhpMfDvaobkiv56VQfhY7Tl7RBjd+QYLw1dQS
         MpjatnGgTGg2OtUYoXMhPNCphxIXiO+QfxoyUrCUuyiXHxANmfLAI9SVUVawks3mXaO1
         351cmDeYJnwtm3Zr2x8wrAf6Pz8ECgfxdK8xugAzEM+aKNgPmc/Qqjr83hmEV/0SzZ1t
         Vq0oVc307L4RmBsOZV7dGKeN6wB4NhLYm+mFW+bjlDjenskS9zDSGEhshtX0+AZbdGvj
         UM/w==
X-Gm-Message-State: AOAM530f2yFFuCaNYLkIRCIgbaJAizjgQk1Em6rVJwUVLEEiaFqX8RKY
        vb9vSnxxtEklp45/g8lvzNQK1Tr1JV8U1w==
X-Google-Smtp-Source: ABdhPJznsTM073hV3LLj7I9jxLLy7Lw0qxCEXULEPilvZuRvTjuFuuLubK/TGaeyuw2gSoX3kbZYqg==
X-Received: by 2002:ac2:5234:: with SMTP id i20mr7070757lfl.471.1615065436733;
        Sat, 06 Mar 2021 13:17:16 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id o19sm766628lfu.182.2021.03.06.13.17.16
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 13:17:16 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id v9so12669688lfa.1
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 13:17:16 -0800 (PST)
X-Received: by 2002:ac2:41d5:: with SMTP id d21mr9356122lfi.487.1615065435784;
 Sat, 06 Mar 2021 13:17:15 -0800 (PST)
MIME-Version: 1.0
References: <20210306141111.38187-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20210306141111.38187-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Mar 2021 13:17:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgag7YOqPrDHaNSfVRKu=nGdhcRnH575R+uMS32NEkA3Q@mail.gmail.com>
Message-ID: <CAHk-=wgag7YOqPrDHaNSfVRKu=nGdhcRnH575R+uMS32NEkA3Q@mail.gmail.com>
Subject: Re: [PATCH] phi-sources can only have a single user (or none)
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Mar 6, 2021 at 6:12 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> So, replace the list by a simple pointer to hold the unique phi-node
> using it and keep this link updated during all its lifetime.

Ack. It should always have done this.

And all your ptrlist cleanup patches look like "obviously the right
thing to do(tm)" to me tpop, for that matter.

           Linus
