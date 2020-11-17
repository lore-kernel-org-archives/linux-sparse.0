Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F4C6379D
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 19:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE472222E
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 19:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WAp/QY/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbgKQTrZ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgKQTrZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 17 Nov 2020 14:47:25 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6204C0617A6
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 11:47:24 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id r9so31785841lfn.11
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 11:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnkyAVecp11EuaSSIHVUkvuhVPfRdL80axLrsSWvTGU=;
        b=WAp/QY/oph8KADFqhaQD5BfzLlD2oUQ2fAPHb+hMhPpU6g0TfPytQoH2QHQbBHqu2A
         gB+u6Q++wNy0w4W5HoCIW8XuelQ5MT04pmzM6xUEXAF3oFrFcGo9e+dtWyckb8T3ddMk
         oXPoDtLh3hNhaVoswhG/BRsXttfBviPFnJDzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnkyAVecp11EuaSSIHVUkvuhVPfRdL80axLrsSWvTGU=;
        b=nYK5UBGZ1Qzcn3Fu+Z0DdYDbPfRgwP/29zm6FhQ/IpbPOs3wlG07IUWKiEyDj5cBLz
         xmechfRxEJZTTRWOuD6srvqZ5p9L8mpJP80zAT1BJKCG8oxGlShoaPQXpWKdK/xe2zmV
         LoU+XCwSMGomLz7Js/tI5c6B1h43lMXz9z2VsgU6YtjE9MeNShGaeIDYiFnaxZ2+undb
         +7Hb3s9tD8dfZBf0ecY8xbNkwdD7+xFtmwj5qEJ/dO00HyLgoWPk137G+ZypK0qS1Kpw
         1zPq36P1bSDZicQCDlT8lYNoO5bbrrdXgTM33vEi/Ox7ZuUU5i1vBZQWvd5JbHQIJ443
         AnPg==
X-Gm-Message-State: AOAM532RJbw4f6KxNWOG3zI/xuoO0wKFlFwt6k8PsQrsZzNE4l2fURC2
        gjbfd3f6/7joxVLJXe56HC7BORlpM2AS3Q==
X-Google-Smtp-Source: ABdhPJyhLsFvL/cE921cWUFZ3NXXFBJxAbBXcN3+cpOSfXSciMdnxrV34rsBQLr6XafinRUkNZAnvw==
X-Received: by 2002:a19:5c8:: with SMTP id 191mr2208110lff.111.1605642442679;
        Tue, 17 Nov 2020 11:47:22 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id q22sm3278439lfj.145.2020.11.17.11.47.20
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2020 11:47:21 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id l10so25669229lji.4
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 11:47:20 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr2455992ljo.371.1605642440080;
 Tue, 17 Nov 2020 11:47:20 -0800 (PST)
MIME-Version: 1.0
References: <1605437478.5370.9.camel@med.uni-goettingen.de>
 <CAFiYyc1-qtU+4Tj3mkz=c608zeP8feyuD6UyRhQv19qjKjJcvg@mail.gmail.com>
 <20201116111056.GA3121378@hirez.programming.kicks-ass.net> <CAHk-=wh_kn11vXfi2Ns8E4F0GgmUprQtD-=RnU6Eg+N7coY5gw@mail.gmail.com>
In-Reply-To: <CAHk-=wh_kn11vXfi2Ns8E4F0GgmUprQtD-=RnU6Eg+N7coY5gw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Nov 2020 11:47:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
Message-ID: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
Subject: Re: Re: typeof and operands in named address spaces
To:     Peter Zijlstra <peterz@infradead.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Richard Biener <richard.guenther@gmail.com>,
        "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>,
        "amonakov@ispras.ru" <amonakov@ispras.ru>,
        "ubizjak@gmail.com" <ubizjak@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        linux-toolchains@vger.kernel.org, Will Deacon <will@kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Nov 17, 2020 at 11:13 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> > +#define __unqual_typeof(type)  typeof( (typeof(type))type )
>
> that's certainly a much nicer version than the existing pre-processor
> expansion from hell.

Oh, and sparse doesn't handle this, and doesn't remove any qualifiers
for the above. And so this horror-test-case fails:

    #define __unqual_typeof(type)  typeof( (typeof(type))(type) )

    int *function(volatile int x)
    {
        extern __unqual_typeof(x) y;
        return &y;
    }

with

  t.c:6:17: warning: incorrect type in return expression (different modifiers)
  t.c:6:17:    expected int *
  t.c:6:17:    got int volatile *
  t.c:3:5: warning: symbol 'function' was not declared. Should it be static?

adding Luc and the sparse mailing list to the participants list.

But it does work with both gcc and clang for me.

For Luc, quoting some earlier emails:

> > lvalue conversion drops qualifers in C.  In GCC, this is not
> > implemented correctly as it is unobservable in standard C
> > (but it using typeof).
> >
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=97702
> >
> > A have a working patch in preparation to change this. Then you
> > could use
> >
> > typeof( ((void)0, x) )

on another thing that fails with sparse. But since gcc gets that wrong
too and it only works with clang, that's not so relevant for the
kernel.

Luc - same test-case as above, just

    #define __unqual_typeof(x) typeof( ((void)0, (x)) )

instead.

           Linus
