Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB14C433DB
	for <linux-sparse@archiver.kernel.org>; Thu,  4 Mar 2021 20:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0DB64F69
	for <linux-sparse@archiver.kernel.org>; Thu,  4 Mar 2021 20:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238654AbhCDURZ (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 4 Mar 2021 15:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238688AbhCDURP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 4 Mar 2021 15:17:15 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8385C061756
        for <linux-sparse@vger.kernel.org>; Thu,  4 Mar 2021 12:16:34 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id y12so22043043ljj.12
        for <linux-sparse@vger.kernel.org>; Thu, 04 Mar 2021 12:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YjhX4vGwI1K4CFToyjn6YznaWoJYyk/puE7QxM9iXFo=;
        b=ctbA/bdJlwbzYgJS6nRGDxwkOD9+s6jTr3aqVwxCYv7gQh4fSGtHv3xdQnYIMoliAR
         PLBk2cofcNBAoxciu+qka+TQZ/4qL3wtDOVyfkfdTDH24sSycsDv16pd3UrCS1YhZSJX
         FcDKfRjQNG1zdj/NdyPu33TyznUIjlGqoumvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YjhX4vGwI1K4CFToyjn6YznaWoJYyk/puE7QxM9iXFo=;
        b=NKs0zOW6bMglhFRQyxBm457SDC/h2JIqmx9tMdkgn4NxvYXMFPsfMoXONwKTejUj+c
         b4+YRCWBPdEzBK4uABTpplhYzUt3kmnxF+D2S1ntuQ2pFBuNSL886seDlH2DNprhLHIq
         Y+LiPTqtX4tQvC5w+3uKJ/eFwrvrHPtnjVGe+kIweM1EMczh0vgaQCDdWb6UvWCeBxem
         60GN4NJSituSEYg0nVcC5Xl/U1lNuHw9JEvgSVenZsBCKD3VOd5swrE2mzOXlU0++SMT
         Vt1Hw4dE5jueDtsAc6PJORvaKuwOoNjkcZzV0GqYKhI4MMLsehQ8z8PIwBGM2JMZ5Pjy
         fTwg==
X-Gm-Message-State: AOAM530p8/MuYMLwOxVxeinGmZ1RSjxc7lFB4gzSNIA896yvI77N+UcL
        Vd6ASJWUyXkaOw7zd5YCtKjKoFV1pebVGQ==
X-Google-Smtp-Source: ABdhPJxLud815rQFQU3cgwsmuEDaLKRPYcE+97hshxu6ZiBGEpBR+ZBLiGVRFrafmR23QwTtjRbP1A==
X-Received: by 2002:a2e:9887:: with SMTP id b7mr3182582ljj.464.1614888993038;
        Thu, 04 Mar 2021 12:16:33 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id e20sm47271lfc.20.2021.03.04.12.16.31
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Mar 2021 12:16:31 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id f1so45405637lfu.3
        for <linux-sparse@vger.kernel.org>; Thu, 04 Mar 2021 12:16:31 -0800 (PST)
X-Received: by 2002:a05:6512:398d:: with SMTP id j13mr3168683lfu.41.1614888990923;
 Thu, 04 Mar 2021 12:16:30 -0800 (PST)
MIME-Version: 1.0
References: <YDvLYzsGu+l1pQ2y@localhost.localdomain> <CAHk-=wjFWZMVWTbvUMVxQqGKvGMC_BNrahCtTkpEjxoC0k-T=A@mail.gmail.com>
 <YDvwVlG/fqVxVYlQ@localhost.localdomain> <CAHk-=wi54DEScexxpMrO+Q2Nag_Tup+Y5YBHc_9_xGLeRfP8pA@mail.gmail.com>
 <877dmo10m3.fsf@tromey.com> <CAHk-=wi13+FLcRo4zmnRUmmY=AAns-Yd5NR_mVdcAd6ZrPq2fA@mail.gmail.com>
 <4835ec1d2ecc40b285596288a0df4f47@AcuMS.aculab.com>
In-Reply-To: <4835ec1d2ecc40b285596288a0df4f47@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Mar 2021 12:16:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh8PptzH-=ak1D7C5Zp6EJ8eurYqVqGdQauupAFaNuG4g@mail.gmail.com>
Message-ID: <CAHk-=wh8PptzH-=ak1D7C5Zp6EJ8eurYqVqGdQauupAFaNuG4g@mail.gmail.com>
Subject: Re: [PATCH 00/11] pragma once: treewide conversion
To:     David Laight <David.Laight@aculab.com>
Cc:     Tom Tromey <tom@tromey.com>, Alexey Dobriyan <adobriyan@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Mar 4, 2021 at 5:55 AM David Laight <David.Laight@aculab.com> wrote:
>
> >  (a) the traditional include guard optimization HAS NO HIDDEN SEMANTIC
> > MEANING. It's a pure optimization that doesn't actually change
> > anything else. If you don't do the optimization, absolutely nothing
> > changes.
>
> And if the parser is well written the optimisation is probably
> irrelevant compared to the compile time.

That's actually surprisingly not even remotely true.

People always think that the optimization phases of a compiler are the
expensive ones. And yes, there are certain optimizations that can be
*really* expensive, and people just don't even do them because they
are _so_ expensive and are exponential in time.

And yes, there can be some patterns that expose bad scaling in some
compiler algorithms, and histyorically that has often been seen when
people use generators to automatically generate huge functions (or
huge initializers), and then the compiler has some O(n**3) thing in it
that is entirely unnoticeable for normal code written by a human, but
means that a million-entry initializer takes five hours to compile.

But in reality, on very real normal code, the *front end* of the
compiler is often the most costly thing by far. Very much just the
lexer and the simple parser. Things that are "simple" and people think
are fast.

But they are are often the slowest part in C style languages, because
you have to lex and parse _everything_. You include maybe a dozen
header files, maybe more. Those in turn often include another dozen
support header files. You easily end up tokenizing and parsing
hundreds of header files for even the simplest programs - and 99,.9%
of that isn't ever *used*, and never actually generates any code that
needs to be optimized. Think of all the complex macros and functions
and type definitions you get when you include something basic like
<stdio.h>. Trust me, it's a _lot_ of small details that get tokenixed,
parsed and memoized.

And then all you do is a 'printf("Hello world");' and the amount of
actual code generation and optimization by the back-end is basically
zero.

And C++ is about an order of magnitude worse, because you really take
this whole approach and turn it up to 11 with templates, namespaces,
STL, and a lot of all that infrastructure that is there for all the
possible cases, but that most files that include it only use a small
tiny portion of.

So in C-style (and particularly C++) languages, reading header files,
tokenizing them and parsing them can _easily_ be the bulk of your
compile time. Absolutely every single serious C/C++ compiler
integrates tbe preprocessor _into_ the compiler, because the
traditional model of having a separate "cpp" phase actually made the
tokenization problem happen _twice_: once by the pre-processor, and
then a second time by the compiler. Integrating the two phases, so
that you can use just one tokenizer, and one single set of
identifiers, actually speeds up compile speed _enormously_.

Yes, yes, tokenization and parsing really is the simple part of a
compiler. Good register allocation is _hard_. SSA makes a lot of the
basic optimizations actually fairly straightforward and simple, but
more complex transformations (loop invariant stuff, vectorization,
various things like that) are really much much much more complex than
the simple front-end.

But that simple front end is the thing that touches absolutely
_everything_, whether it actually generates code or not.

And yes, this is mainly a C-style language problem. If you have
hardcoded modules approach and not the "include files that describe
all the different interfaces", you don't end up in that situation
where you spend a lot of time parsign the possible interfaces over and
over again.

And C++ really is hugely worse, and takes this issue to another level.
You can have simple single C++ files that end up basically having to
parse hundreds of thousands of lines of fairly complex code, because
they use several complex libraries, and that's how the library header
files are set up,m with multiple levels (ie the GUI header files
depend on, and include the lower-level object header files, which in
turn depend on "simple" core libraries like STL and Boost.

This is why pretty much every compiler out there does that include
file header guard optimization. Because avoiding having to read and
parse a file multiple times really does show up as a big big win. Even
when it's all hidden behind the #ifndef/#define/#endif guarding logic,
the cost of reading the file and lexing and parsing it enough to _see_
those guards is not cheap. Doing it once is required and important,
but then you memoize the fact that "oh, all the stuff I needed to
parse was behind this macro test, so next time I see this file, if
that macro is set, I can just ignore it".

So it is actually a very important optimization. It's just that the
optimization is better done with that explicit guard memoization than
it is with '#pragma once'

                       Linus
