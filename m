Return-Path: <SRS0=XUoR=DI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C57C4727E
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 19:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C332206C9
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 19:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601580497;
	bh=DFiFrREeGTXAoyknLl3epvwBmfb+Jq0tVb9xCTK9K0U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EdOBpw2gmSLqRTCDbbxf5RmyqWVfoCtJLIjyBB2M6Ponb42VuThgcwc8gLSGlhmt0
	 bd0gemBDCVWkiPQmMwt8S0zjKjyABq6Mro8SOx9UsX0hb4nZczIleWO6jL0KICedEF
	 V+zWRrljTIMDz7ju6igaiHBK2y1RknP3oNq+HJJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbgJAT2R (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 1 Oct 2020 15:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730045AbgJAT2Q (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Oct 2020 15:28:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A65C0613D0
        for <linux-sparse@vger.kernel.org>; Thu,  1 Oct 2020 12:28:16 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b19so5615236lji.11
        for <linux-sparse@vger.kernel.org>; Thu, 01 Oct 2020 12:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dN6wkeDzgwYsGylNqK7ZTus/h/w+ershP8jtU/E7CNw=;
        b=Q23zxBIE7+EZgnwIDHVFkByDXtI0jcqZGEGR0i9oVAdG5GkHe6pur6v5Eh53nz4UUk
         1BrgaFWRh4GG0tmflwB6Sa2Np4pXGiGHMkCFyxJEdSilfsu0HsSwuJ2xvLB58+Agwthd
         maHRfeof8Qm2hY/LJY4jbEh3pXKZCe+2WXq6s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dN6wkeDzgwYsGylNqK7ZTus/h/w+ershP8jtU/E7CNw=;
        b=dxQ25OCgBaeLjkFavmLI8BcXnmWNssfmdZp6tPIebfqsow7Q6tFwId4dSMpjeE/fWQ
         y20WWd59JzQkhp8oJgyJblqkAjK2uLviZh+IB29EbKRgp1NZMtno+o7eESa3oFzQQMUZ
         CMNE0kL6z5nQA+bFcDOx4SBcVxXRYEj9I3m5n+nCeDd1G4uHYTGiXWDjz3mt7VaV9wJl
         tlCHOw3PZhMjHmDixmCJX5+OApAz0+JLDpvCnAWH2PsikDHkpKECmS0xkijEnkPQGUqK
         1TitgHhrfzQ/rUHslcj6UDXj6nsPUvdlYnuYwMgbfIIJTEd3H2xln9zSKz1oR6+JNqlJ
         LQ3g==
X-Gm-Message-State: AOAM532kGMr4LnxmZWtG8aLgPDuRMRYExQ7HDS/QEZhiFA6Vvm9cIdQK
        FOKMTcGe1bzA9hC2ZcxWgvv5AAnjRcGkEA==
X-Google-Smtp-Source: ABdhPJzFETNuEZ2w6jecfJyst3yBmzrVxzKiA4qj+BRwXLpfyguCdzJU206dRFRnVwd/uaWainOiMA==
X-Received: by 2002:a2e:8146:: with SMTP id t6mr2602665ljg.259.1601580494381;
        Thu, 01 Oct 2020 12:28:14 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id s11sm536483ljh.56.2020.10.01.12.28.13
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 12:28:13 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id s205so5634231lja.7
        for <linux-sparse@vger.kernel.org>; Thu, 01 Oct 2020 12:28:13 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr2648456ljp.314.1601580492895;
 Thu, 01 Oct 2020 12:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
 <20200930231828.66751-14-luc.vanoostenryck@gmail.com> <CAHk-=wiyAWuHQuDPBC290V-Bx5Eyu1izPj9iSSN0hdkSM2a4iQ@mail.gmail.com>
 <20201001191706.nefotol6m2oqrtcg@ltop.local>
In-Reply-To: <20201001191706.nefotol6m2oqrtcg@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Oct 2020 12:27:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7LNGQ5aDtJeRzkLPUewUjgoc3eiKF_Yh81kfU-XPHCw@mail.gmail.com>
Message-ID: <CAHk-=wh7LNGQ5aDtJeRzkLPUewUjgoc3eiKF_Yh81kfU-XPHCw@mail.gmail.com>
Subject: Re: [PATCH 13/13] flex-array: warn when a flexible array member has
 some padding
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Oct 1, 2020 at 12:17 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> > So in the kernel, we would
> >
> >  - start warning about 'sizeof(flex_struct)'
>
> Adding this warning by default annoys me slightly because it will
> add 5700+ warnings to the 18000 already present and I think sparse
> is already underused because it is very/too noisy. But I guess that
> most occurrences come from a few macros and thus should be easy to
> get rid off.

Hopefully. I'll try to take a look. Do you have the sparse changes in
a git branch already so that I can just try that directly?

Or if you send me a couple of examples, maybe it's just the same
pattern over and over,..

            Linus
