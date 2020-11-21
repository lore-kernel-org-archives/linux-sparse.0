Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBA4C5519F
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 21:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E346821D91
	for <linux-sparse@archiver.kernel.org>; Sat, 21 Nov 2020 21:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+07TmMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgKUVk3 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 21 Nov 2020 16:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUVk3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 21 Nov 2020 16:40:29 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF959C0613CF
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 13:40:28 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so14555808wrg.7
        for <linux-sparse@vger.kernel.org>; Sat, 21 Nov 2020 13:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kqN/cTQFeNqm33NJ6iWTfM36INmXbvJJj2teZbKEYZU=;
        b=K+07TmMw/IeA6iJ4iKJIxYO7PclDzL40RCJrlgp2Md2bB7B0Y+xh07KPinVlILNjUM
         WxzJRU6NXDvc5Q94SYxtIol35lNcwoC8y9v1IzlWOTFvrIEOcO0cqUGqXXa9YvqQwKep
         OhF5xqzTiC9J3/bW93ObYfgW/zJc6LpuqcRIi3zj87jSQ6Oo0o7Ff9IUMDpBUSjQHZw5
         DnrqkTXhD9wn/i6+dp0fILTFsOK4UYgp8XSO7VZixfu2fyz51heZptmI7UME3BJNau9T
         tIxcKHftZP4Gqaoa81D/PuzLT1y2TnY8UebK3LWIP1vGor8UVtKdd2bmHWeDQjgkX1VA
         bWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kqN/cTQFeNqm33NJ6iWTfM36INmXbvJJj2teZbKEYZU=;
        b=O2dW5zu1Lnpw9s9yY8FEgi29k+Dv3dYTFCJFjyjCXLnQBT/LhQdgdoGsNP/VoJlrhD
         KLVBRIWZ/niFCjtVHY+B7PhliuYPZ9HGVFP2O+k//37Ah6OYqUubvkwQ9u6mymvpsMwk
         qcEFK537dLwe5NAbqt2PgKt3y2+g2sa06MgBU0QjsDjE8W6CEYsN7c9jzNCwCPhFVFFz
         HAiDAyseUP3fiqIHvmNqNwZf1fUNYPDMmU/pYQjzZGQoWjjHZwS/JV/4ruiyD62lzN5X
         crBavPAEBo41mxZZDUvWwJ0o8w8IZhtMUbPOst90MyDWZI3StXMHDYZFTZrpNQmXt7lP
         03OA==
X-Gm-Message-State: AOAM531zXP9IbNeIHGF6kF+z9Ai6DwjWCdvTnkSlWsz2VMBfEvc6V1ob
        h3mv5lM0fje0RVBBKxyP6s0ggl7IaE4=
X-Google-Smtp-Source: ABdhPJzxLIvs+DIsHAv5HDgzo9dYXhfhY2IODOTxn/Q+bJHI0kSTHjccFyk2gKYEfE7YEpC3K+GVow==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr16776993wrt.19.1605994827451;
        Sat, 21 Nov 2020 13:40:27 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:dcb6:7e9c:ccbf:c450])
        by smtp.gmail.com with ESMTPSA id n9sm8607188wmd.4.2020.11.21.13.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 13:40:26 -0800 (PST)
Date:   Sat, 21 Nov 2020 22:40:26 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 0/4] simplification of computed goto
Message-ID: <20201121214026.kv4pgimxlyykfb26@ltop.local>
References: <20201121205300.94642-1-luc.vanoostenryck@gmail.com>
 <CAHk-=whC2Kygu6Vpgt+vnzVGAG-ZYHk1ucOcv7b9AcvmdrY-Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whC2Kygu6Vpgt+vnzVGAG-ZYHk1ucOcv7b9AcvmdrY-Eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Nov 21, 2020 at 01:09:50PM -0800, Linus Torvalds wrote:
> On Sat, Nov 21, 2020 at 12:54 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > This series contains some simplification of computed gotos with
> > 1 or 2 possible target as well as a new instruction which now
> > really allows the CSE of 'labels-as-values'.
> 
> Looks sane, but where did you actually find cases of this in real life?
>
> I think we have one computed goto in the kernel, that does an array
> label load. They are very rare, and when they are used, that tends to
> be the normal pattern.
> 

Bah, they're not really from real life.
When IR and optimizations are concerned, I'm using code from some
testsuites (GCC, LLVM, some benchmarks, code I've generated myself)
to check for anything abnormal and sometimes when inspecting the
results I fall on some testcases that doesn't make sense. Sometimes
it's because of some errors from my part but it also happens it's
one of these silly/exotic transformations.

So, yes, I'm fully aware that these patches (and some other
'optimizations' I'm sometimes adding) have practically no values
but they just make things easier for me when comparing results.

> Just about the only place I've ever seen them are in that kind of
> interpreter loops for instruction dispatch tables.

Yes. They were also fundamental to a prolog-to-C compiler I wrote
many years ago. This maybe explains some fondness I've for them.

-- Luc
