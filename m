Return-Path: <SRS0=XUoR=DI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E728FC4727E
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 19:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 949A120759
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 19:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEtBhPkM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbgJATRK (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 1 Oct 2020 15:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJATRK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Oct 2020 15:17:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C221EC0613D0
        for <linux-sparse@vger.kernel.org>; Thu,  1 Oct 2020 12:17:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so4308632wmj.5
        for <linux-sparse@vger.kernel.org>; Thu, 01 Oct 2020 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jAB9p+x0wni3sbtQ8j6Ov4gOc0tTo+4HvQTPmdt4gKM=;
        b=VEtBhPkMX4DE+5bikKS3UnL0OHq5FtQ0xxKggtDPK582vQJLhULqTGsrQgGGkjspHt
         VHMAJwDzxEchwkPjRPz2Mhx4l/vT9+VRvE4Lgv2yAPRK9lcjICJD2T/Kv8xlNIMTUL1P
         3Jo7O5fvK2FGfvdeygG8f73LzfZ4vosxYFdf7vkJDqiQmbqt2ZKOG47rFIdNz5T8gMaG
         tlG+rKQWk0cJsntSkgU77p8hQ9yupg3qZ68S2c6huzzlatkZ/0CeBHUgFDMauTwpNUI9
         fcxjaAWmys6Uief1JOLxpozrg3It7ZPq82blsx3RuyQESHubKBlBOSPZPV4Borj5GmGA
         xs2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAB9p+x0wni3sbtQ8j6Ov4gOc0tTo+4HvQTPmdt4gKM=;
        b=TdBMfxKpJv9rx61EUXCzVOEaLtevWmjlh5vFLLU+9kiQxA9XXtcOrvAlcdu33nY6pM
         lAx0MqsNEm0fxmAxlmZavWrwqMoM383I3trkVjncGR6CTdOe6jpQ963ZuqhHYZwbH39V
         TPtSn3KoPJB4sVEF9xpSEWw42m1bf9ntBqEdSSkBbGbac88scd2uNncxt2X3xhs3762v
         s9QXB0tjbnMdAZ2oYVyGoMlwPs615RSZDK2l1WF2m+x67iGVIWeZeeQlcNmjeuhpLAHK
         h0401OKyMqe1aWPutntXdbSKxby4nwEp1vKRw43gM6uVwWuIkH1O10X3FIU3PuteJQBw
         1vlg==
X-Gm-Message-State: AOAM530FAJ0zv38toK7R6FyOvnnvnI2Sz4oCI2B5REJ8xOA4ka8EbYdy
        EXPr0UWI/JC54hdTGvoIouncLaajw9I=
X-Google-Smtp-Source: ABdhPJyL7Ez3L0Wxry2Uqirq25ev9IfRgaeYXKE/eHLlABwQ/jQHh7GclUqJoFVjOQl/dLey5WKJlA==
X-Received: by 2002:a7b:c08c:: with SMTP id r12mr1426246wmh.184.1601579828455;
        Thu, 01 Oct 2020 12:17:08 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:fcee:6a86:103c:8482])
        by smtp.gmail.com with ESMTPSA id h4sm12212776wrm.54.2020.10.01.12.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:17:07 -0700 (PDT)
Date:   Thu, 1 Oct 2020 21:17:06 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 13/13] flex-array: warn when a flexible array member has
 some padding
Message-ID: <20201001191706.nefotol6m2oqrtcg@ltop.local>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
 <20200930231828.66751-14-luc.vanoostenryck@gmail.com>
 <CAHk-=wiyAWuHQuDPBC290V-Bx5Eyu1izPj9iSSN0hdkSM2a4iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiyAWuHQuDPBC290V-Bx5Eyu1izPj9iSSN0hdkSM2a4iQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Oct 01, 2020 at 09:34:37AM -0700, Linus Torvalds wrote:
> On Wed, Sep 30, 2020 at 4:18 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > If some padding is added because of the presence of a flexible
> > array member, the size of the structure will be greater than
> > the offset of this flexible array which can cause some
> > problems if the assumption is made that these 2 size must be
> > identical (which is easy to do since such flexible arrays are
> > conceptually 'after' the structure itself).
> 
> The warning seems pointless, and the explanation above is wrong.
> 
> Flexible array padding is normal and good. IOW, if you have
> 
>     struct odd_struct {
>         char c;
>         unsigned int flex[];
>     };
> 
> then the flexible array - and the structure - very much should be
> aligned on 'unsigned int', and both the offset of the flex-array and
> the (bogus) size of the structure is 4.
> 
> So this is a normal case and nothing wrong with it, and the above is
> the "flexible array caused padding" one (but sizeof and offsetof
> match).
> 
> And the case that causes sizeof() and offsetof() to not match is
> normal too: but is not that the flexible array member caused padding,
> but that *other* members did.
> 
> IOW, maybe you have a structure like this:
> 
>     struct other {
>         uint64_t a;
>         uint32_t b;
>         char flex[];
>     };
> 
> and now "offsetof(flex)" is 12, but "sizeof(struct other)" is 16,
> because the flex-array itself has no real alignment requirement and
> will just be laid out after the 12 bytes of a/b, but the structure has
> 8-byte alignment due to 'a'.
> 
> So I don't think the warning is interesting, because this is a
> perfectly normal condition too.
> 
> And I don't think your explanation for the warning makes sense,
> because you say "padding is added because of the presence of a
> flexible array member", but that's not at all what is going on. The
> padding is added because of *other* members.

Yes, my explanation is completely wrong. The warning is indeed just
about sizeof() != offset() and I added because it seemed odd to me
but ...

> Anyway, the above is just an example of why "sizeof()" itself makes no
> sense on these things. A "sizeof()" of a structure with a flexible
> array member is inherently pointless. You can't use it for anything
> really valid, and it doesn't have any sensible meaning.
> 
> But I don't think that has anything to do with warning about padding.
> The padding is right - it's the sizeof() itself that is nonsensical.

Yes, indeed, it's perfectly normal. I'll drop this patch.
 
> So in the kernel, we would
> 
>  - start warning about 'sizeof(flex_struct)'

Adding this warning by default annoys me slightly because it will
add 5700+ warnings to the 18000 already present and I think sparse
is already underused because it is very/too noisy. But I guess that
most occurrences come from a few macros and thus should be easy to
get rid off.

>  - make our "struct_size(s, m, N)" construct use
> "offsetof(m)+N*sizeof(*m)" instead of using sizeof().

This accounts for only 432 occurences of sizeof(flex-array),
leaving 5287 other ones.

> Of course, it may well be that we end up with trouble just because we
> end up _needing_ sizeof() for some reason. I can't think of any sane
> situation off the top of my head, but who knows what odd macros etc we
> might have that end up doing sizeof() as part of things..

Well, yes, for my part, I find the number of nested flexible arrays a
bit worrying and much less sensical than the sizeof but .. live and see.

-- Luc
