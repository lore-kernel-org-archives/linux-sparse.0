Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D07FC388F9
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 22:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EE7221F7
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 22:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NVU8REuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgKUWHz (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 17:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgKUWHz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 17:07:55 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29AC0613CF
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 14:07:54 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id i17so13902626ljd.3
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 14:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1At7BX3Qv19a6tj5NIcuO18/7wL1HCDBdiQPuhNVRk=;
        b=NVU8REuQN4aJmL//Jl9rU+micVwjfwGQTzxeWCmm/bGN0dNOvBSIDm5ey/+JG44IJ8
         88aeN/FojKXI4RYt+1zIZMJ1l2/vJgUQ7/gQx8GV7EUare8S2lBvDuD5rcZtL5DqTTNM
         xiyVAbq+DIdBzsooHXx4G+jwJSY32CUlFy69g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1At7BX3Qv19a6tj5NIcuO18/7wL1HCDBdiQPuhNVRk=;
        b=EdF9/q+AztMVmxkZk9k3EYqi6588u/ADAoNjTLzezOEcjL0F791Ek45pZ45DENjEHc
         cDk+NJ4A5jaLpV/ztB/ojtaocka958TD7kY4VP31fl+aAlv72+kqDMYmLgJmK/f1sEb2
         m/MHdCUJBpklGqlklD1r3GIcdJ5JaRbd4GKVJIQimSTbFrhSfAYGgm0MKCKIUTG1ZuLI
         C1mo9xyNG3tbtL6mcpg3HDuOcvCKP0vQJUxZffzZj/+MWmCvUr8Y0g6l94qLsadBpsRY
         +wsg2fwEnoLyF5hyYxm0slLGLKF+Y3ZapdVsq/XQAK3pzPa9N5jNjTyw9oeE6lecZ1GR
         7uOA==
X-Gm-Message-State: AOAM5325o2Ezec3daStOME5h/o3gV5YDgU9JU5TWKcPbhZWiEcVieOWO
        hP14PG+5ER0tswjS3bTPDm/n4SDiJpxJDw==
X-Google-Smtp-Source: ABdhPJx1Dc0lze+Id3/VJ+yP7Uz6idEqO53qZ24gkIJ/xNu2ABcHeGKkIujNX457IrMZQuLdpjtAow==
X-Received: by 2002:a2e:a17c:: with SMTP id u28mr10750634ljl.453.1605996472948;
        Sat, 21 Nov 2020 14:07:52 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id y63sm330298lff.196.2020.11.21.14.07.51
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2020 14:07:51 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id d17so18522418lfq.10
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 14:07:51 -0800 (PST)
X-Received: by 2002:a19:3f55:: with SMTP id m82mr403415lfa.344.1605996471508;
 Sat, 21 Nov 2020 14:07:51 -0800 (PST)
MIME-Version: 1.0
References: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
 <CAHk-=whC2Kygu6Vpgt+vnzVGAG-ZYHk1ucOcv7b9AcvmdrY-Eg@mail.gmail.com> <20201121214026.kv4pgimxlyykfb26@ltop.local>
In-Reply-To: <20201121214026.kv4pgimxlyykfb26@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 21 Nov 2020 14:07:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_Zf6DdY234UX=WMPKjJiGGP2PN5Xibx0xRA2a4EzdKQ@mail.gmail.com>
Message-ID: <CAHk-=wh_Zf6DdY234UX=WMPKjJiGGP2PN5Xibx0xRA2a4EzdKQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] simplification of computed goto
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Nov 21, 2020 at 1:40 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Bah, they're not really from real life.

Ok, I was worried I was missing something, and you'd find some really
odd kernel code ;)

             Linus
