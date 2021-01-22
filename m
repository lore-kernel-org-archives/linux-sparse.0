Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DF9C433E0
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 18:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FD823A6A
	for <linux-sparse@archiver.kernel.org>; Fri, 22 Jan 2021 18:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbhAVSKa (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 22 Jan 2021 13:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729958AbhAVSCr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 22 Jan 2021 13:02:47 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7EFC06174A
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 10:01:59 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id a12so601917lfb.1
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 10:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9PA3Pdb5SbKgSRENRecSz4ZiuQCKLl+1W3bKUwQzc38=;
        b=XQdWipo1ezPeeHj6bNnXIWmPoTu7rL/52ZZSTPybdnzZjSV5NK4/b+2NoGvbQ0WvTR
         YCsTHUjJs0JEG78+ycq4hPXp/g7NcJbIQHFUyc82OWkYJB1ivPpmF4eG+hpR9X8xVYdb
         RQxzenJkrHQ8lJIBgEld2B4lDu4Ui/d6S3SUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9PA3Pdb5SbKgSRENRecSz4ZiuQCKLl+1W3bKUwQzc38=;
        b=KD3IKw4ohtsqqyW+ytLSh6WrBLDh6GU9P4b0JXmU3srjB8iZpXZWc6tC1iy9w+7Ch7
         7/7J7fPNVH91zBKAp+ucYzmw8kzlfz/e4Nq9IPDyKX10KDZz70pMNFVAJKVb87QGTHCF
         HEm2kIPmjcG2aCCZZiVjt/Dx3ELcuUA2cd1EywPZkDOKb1GJ0wKE7Y1Oa2xuXUvQ6bYB
         9+MXRo7EmaU7+GF31EA6XqIMiy9Qz9aJUYg7OgNMST86q2H1L6EvE4VxXQdmjt96Brv+
         wpLNo9IAC9fkFzEVrNBpS4LSqT2CO6I8jhAit4BhLT/Uahcp4hv7kdUqg6q/EfTfNdgE
         SHJQ==
X-Gm-Message-State: AOAM532GzYCfmeMZzWXv6ratABkCKPHd2oUPWuV7m0OJ8IV3ShVrrZMk
        Lx+G0mYCxQbFe+HP/TUiF5SeHIMucCrW2g==
X-Google-Smtp-Source: ABdhPJxnQqhxprjjB05cQZwj42FxA3LNy/c97L9h6NUSM5mDGFN3H1oLNTcCY+0SnxDZNWsMM7BVgQ==
X-Received: by 2002:a19:c56:: with SMTP id 83mr2930679lfm.325.1611338518004;
        Fri, 22 Jan 2021 10:01:58 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id s3sm1049189ljo.41.2021.01.22.10.01.56
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 10:01:57 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id i17so7554863ljn.1
        for <linux-sparse@vger.kernel.org>; Fri, 22 Jan 2021 10:01:56 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr759595lji.251.1611338516683;
 Fri, 22 Jan 2021 10:01:56 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com>
 <20210122162625.73007-1-luc.vanoostenryck@gmail.com> <CAHk-=wj3v1hm3x0x_3ui1PQDLbn7V5PoxGyDf_UB6TCxMTgjQw@mail.gmail.com>
In-Reply-To: <CAHk-=wj3v1hm3x0x_3ui1PQDLbn7V5PoxGyDf_UB6TCxMTgjQw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Jan 2021 10:01:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGgNEWybdqu1pmV_zCXJ+woyni2ie3+2pnFZfzwY8NEA@mail.gmail.com>
Message-ID: <CAHk-=wiGgNEWybdqu1pmV_zCXJ+woyni2ie3+2pnFZfzwY8NEA@mail.gmail.com>
Subject: Re: [PATCH] handle qualified anonymous structures
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Jan 22, 2021 at 9:35 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, looks good, and obviously passes my trivial test-case.

Oh, and then I tried a slightly more complex test-case, and didn't get
the result I expected.

In this:

    struct dummy {
        const struct {
                int a;
                volatile struct {
                        int b;
                };
        };
        int c;
    };

    int *test(struct dummy *a)
    {
        a->a = a->c;
        return &a->b;
    }

I expected to also get a warning about how we return the wrong type
(ie "&a->b" is of type "const volatile *int", but "test()" returns an
"int *").

That seems to have nothing to do with the anonymous struct type,
though. It is just because we never warn about that pointer conversion
at all.

Interestingly, It does show up as a "ptrcast" instruction in the
linearization, so I can tell that yes, sparse saw that it was a
different pointer type. It just didn't care to warn.

Not a huge deal, but I thought I'd mention it since it showed up in my test.

             Linus
