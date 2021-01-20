Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA7C43219
	for <linux-sparse@archiver.kernel.org>; Thu, 21 Jan 2021 00:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98FD32389E
	for <linux-sparse@archiver.kernel.org>; Thu, 21 Jan 2021 00:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbhAUALI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390809AbhATW4B (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Jan 2021 17:56:01 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7727C06138D
        for <linux-sparse@vger.kernel.org>; Wed, 20 Jan 2021 14:55:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id 6so35840856ejz.5
        for <linux-sparse@vger.kernel.org>; Wed, 20 Jan 2021 14:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=prx4TgoAM0iGjwcSsf6XX8du+rp0vqdA31wC2Teo9qk=;
        b=dbk/tnT9mP8h7HdKE4U8pkVbb9bxIOMLdcYXhMM5NIPfqEG14EPh2Yi9whMffwuQ8b
         gSUEevNAyqr6cgwjsUkmOkEj6jIdksepXMhkovjp2UxC+ljkNEz6SyuVZ/ZjzUs552hn
         gSOP/wklOS+/01SrFOV+nDs4Y0a2QtAKhuLRIqAutqoyK5Wh2Y8rkACyPZrAC6xbVB0O
         HeP7DLPdREvCVD+XgVld37J1cJfVS7WLDvqPkgfpqe652KNUdIh80mPWRRh3rx7V+TWF
         fl0E6cz7JWhI6vGKHAiVn/VCI9TfU+3yj4nN2xYZlRljDjVw6kXtKWf9/rnmu+0FWMrB
         STow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=prx4TgoAM0iGjwcSsf6XX8du+rp0vqdA31wC2Teo9qk=;
        b=YsKOzLU0LDyA4Mswp6jdxiLZcVvposjAQNVJ2uSySbPC3Gxkc31px2RiBp6cKKlz8Y
         7xHJOyjFHPSQePkr2xAUVqEfF2sfLxC0bxDkeKKiAHbOip9ARLPdWEqxPPdMFYzymSsm
         jYoRHufySgtDcDIH3rqZU+fq3gIbFkUACEyWfhCKR4/iZuz7albmjaJD0J5Wd/E2L4JE
         FwFn6mCp9/RLieTZ2fv9lA31q0vjmDgJOoTYgHAd9txTweK0A1LmGsFrot+337BWyYKz
         MJuIP3uFf177IWRGGVmBu5wcR1JFuWno2yRaLCkLoY2iV6s65Z9Ch0eay1SR/PYfMuGi
         pUmQ==
X-Gm-Message-State: AOAM530FA9uWKIb2nC4Sob3h4xPGjKC/Kbu3eCFjCIp/SqIvmhDMgvlx
        jWgGUQaeGBlSPI4TzvrU92OqnFM7tjY=
X-Google-Smtp-Source: ABdhPJwDMD+rUJ8oEO7tEoiy6xokbGqSYtHtYSNI3aD+IaT6hl+NiIw/fxkZ1bp33jiAaGuNxOxrrQ==
X-Received: by 2002:a17:906:3553:: with SMTP id s19mr7220021eja.95.1611183319345;
        Wed, 20 Jan 2021 14:55:19 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:d67:6443:f51a:1cf4])
        by smtp.gmail.com with ESMTPSA id w18sm1462788ejq.59.2021.01.20.14.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:55:18 -0800 (PST)
Date:   Wed, 20 Jan 2021 23:55:17 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: 'const' unnamed structures
Message-ID: <20210120225517.hhckg3rtpbmxrkwu@ltop.local>
References: <CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Jan 20, 2021 at 11:21:46AM -0800, Linus Torvalds wrote:
> So the kernel was trying to use a unnamed struct to mark a group of
> fields as being 'const', and while gcc is perfectly happy with that,
> it turns out clang is not.

...
 
> Basically, I see two possibilities
> 
>  (a) since the const is there in the unnamed sub-struct, we can "fix"
> it at evaluate lo time, in find_identifier().
> 
>      We'd have to add a "unsigned int qual" as an argument - initially
> zero - to "find_identifier()", and then in the recursive unnamed
> union/struct case we'd or in the qualifiers for this one.
> 
>      And then we'd modify the symbol result as per the qualifier when
> we return it.
> 
> Honestly, (a) strikes me as ugly and wrong, but it might be simpler
> than what I think might be the right model:

Yes, and it would anyway need more than a simple "unsigned int qual"
because attributes (and alignment via _Alignas()) are also concerned.
But I don't think an additional argument is needed: merging the
modifiers, alignment and AS can be done inside find_identifier()
itself, in the recursive part. This would make it a little less ugly.

> Obviously, the third possibility is to say "ok, clang also gets this
> wrong, the clang people are trying to argue that the standard is not
> clear about it, and sparse might as well ignore this until it's a
> bigger problem".

Hehe, this third possibility is kinda tempting but for once the
standard seems quite clear to me (the grammar clearly allow it,
why it should then be ignored at the semantic level?).

I'll look at this in the next days.

-- Luc
