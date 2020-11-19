Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708FEC5519F
	for <linux-sparse@archiver.kernel.org>; Thu, 19 Nov 2020 00:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E952225E
	for <linux-sparse@archiver.kernel.org>; Thu, 19 Nov 2020 00:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WSZlnc7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgKSA6r (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 18 Nov 2020 19:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgKSA6r (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Nov 2020 19:58:47 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4B1C0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 16:58:47 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id h23so4385897ljg.13
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 16:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TwFBK46EGGdt43lGaAiruD+v7ybcXSQ/XnG8VCdyOMU=;
        b=WSZlnc7rUuV1wSIa8oFCUJ3sewRV588M5zLmiQaiH9Bvs4gnWUKOXw7kiBbRsQPww8
         vmf0GMkbfyz+IQMkw4XSKpbF2EiknTiwBiSDOUBRkdCJrtqyyNQTDtIAot1rrTzlVY9h
         AyrbgRILxuxN6P+Hqw6lfDq7exOfro7wjasow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TwFBK46EGGdt43lGaAiruD+v7ybcXSQ/XnG8VCdyOMU=;
        b=osnF/IDZpT4waLsQiWjnG7TfEjdcUXNvk0HsMMXAjOGMkCPgWjBUnHAY8rO/6q6GKL
         2GESPFY+yCL+6YKECwfj7NFpw7NXWNE7M1XnQP/X15JS/ORNU7jxbgEEOkWXKBqU71hR
         81yKqjqd92oBwBSvRsq9sI/6zYs51fvc6zX/MfKG1Prhyi5dSIWls3yplP3Z6PqHx2Sj
         QcStxSLJFO0d7kjwkOfQRfUtOyLP8uI1gcQjX+lwR9y+Huo1NddwBpIJNdWJmpGcOMjN
         0l1ifSMYQm6mgUDiDrHs14rcdkOZM/QBVSbb4jGTleWin/Kc+CiR2kOA8sW2eg8sPNX/
         cGGA==
X-Gm-Message-State: AOAM5322fciz1VA7Tu16GfFG3FG9u7uWfvrHh6rdEEoG3XLnukJBtGRT
        gnfCgHFkWqaLr48cqlK52S/0suuTLh7pAA==
X-Google-Smtp-Source: ABdhPJwjsA/fwHXms3fLvtbVQHc4dVGUkghQSpTzGqIfcmPViNuSt4IDAAnDpPpMSCKH5CG+AZnkDA==
X-Received: by 2002:a2e:80c5:: with SMTP id r5mr4537992ljg.297.1605747524626;
        Wed, 18 Nov 2020 16:58:44 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id e15sm3778880lfn.292.2020.11.18.16.58.43
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 16:58:43 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 74so5775736lfo.5
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 16:58:43 -0800 (PST)
X-Received: by 2002:a19:f243:: with SMTP id d3mr4282837lfk.534.1605747522943;
 Wed, 18 Nov 2020 16:58:42 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
 <20201117212829.99552-1-luc.vanoostenryck@gmail.com> <CAHk-=wgtL1LPYev5cwhZqd=7RyaGrzx3mS-ydVZAQuYrf0XNuQ@mail.gmail.com>
 <CAHk-=wi-XUPMduO16mvNeou58O-LrxnSk33WBg+vbbqCpzHgOw@mail.gmail.com>
 <20201118191737.oq2e2t5h2wo3us3c@ltop.local> <CAHk-=wjB+c+1ykVzRz5yKX486hHNMMNVAhrwwvbRuuo9eO5gfg@mail.gmail.com>
 <20201118213027.3o74il23b5nesx3d@ltop.local>
In-Reply-To: <20201118213027.3o74il23b5nesx3d@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Nov 2020 16:58:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgYd+L_FVX7uny9_i2hNqB6=EryCKV4wtFwa+scaYnmHw@mail.gmail.com>
Message-ID: <CAHk-=wgYd+L_FVX7uny9_i2hNqB6=EryCKV4wtFwa+scaYnmHw@mail.gmail.com>
Subject: Re: [PATCH] casts should drop qualifiers
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Nov 18, 2020 at 1:30 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> If I read the standard correctly (big 'if'), in:
>         volatile int x;
>         typeof(++x) y;
> 'y' should have the type 'volatile int' and GCC interpret it so.

That sounds extremely odd to me. I think it should have the same type
as "x += 1" or "x = x+1",  no?

And what gcc does is clearly not indicative of anything, since gcc
gets the comma expression wrong, so..

clang seems to have a better track record, and clang drops qualifiers
on "typeof(++x)". Stupid test-case:

    int *fn(volatile int p)
    {
        extern typeof(++p) x;
        return &x;
    }

results in no warnings with clang (but warns about dropped volatile with gcc).

           Linus
