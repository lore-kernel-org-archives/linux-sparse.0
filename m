Return-Path: <SRS0=CDBi=DG=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BF3C47427
	for <linux-sparse@archiver.kernel.org>; Tue, 29 Sep 2020 20:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851F1205F4
	for <linux-sparse@archiver.kernel.org>; Tue, 29 Sep 2020 20:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="axx8TiEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgI2Uaf (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgI2Uaf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 29 Sep 2020 16:30:35 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D42C061755
        for <linux-sparse@vger.kernel.org>; Tue, 29 Sep 2020 13:30:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s14so4262933pju.1
        for <linux-sparse@vger.kernel.org>; Tue, 29 Sep 2020 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNC5fTqGhjDI7cT1AmjU6kFmKGf9yB5nGgyQEW4+Bsw=;
        b=axx8TiExSk0p5FtHRt9FKGv1zcK/7MOWGXHlDL4gC0+4qkMbRrwsgaAaPBajbDG6T+
         7PGPiWz3p4TJOqH14sjLDztVavaBNjx87aGzR6ZmRc9BaAptZViaatLd62AdzJGdS06W
         XZI9mm9TIBGwoouUqmBfFXZdc4Ipy/gcn2esg9FLWZW0/E81QgKlqmmAT0BgY4f+Rtdc
         XGCzs2zk8XmwodkyBNjwrtjg+p65YHAdP1RnYvMXiIrJI8VedFLAbOw4Jy+PbP2ZUtID
         5R9WKgicPA9VrK5E845sIXBS9JPtHizoLOipSGg1ZbTRc9HwuuRopeggVlQQswp5AytE
         JNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNC5fTqGhjDI7cT1AmjU6kFmKGf9yB5nGgyQEW4+Bsw=;
        b=pSr+jKJhYqaJapi7av/eMCruddkNPCh83cagfmA2wHdgKS3aaPXiSoACc8lvwuwUjo
         dmP+MNlUQxQCQxir0sj9u/YPaEdCsMQrI86W+oh+r1KWVwrNbstN5tjpxQzTbXhnxKea
         NI+0ZZx6kwbseB7RCqKsX6mS/bPiZ1DyuagyRAFp8t/+F9CjKykxmIUSjBkUOshvSI35
         dlrPBaqaFG4Br5BGNzpXOaOcG+xlsPDZZvo/OrUsHcPCqWC0Pg2/pITgUN+aeUQo6OkB
         VqeRY4da71rjPHgFmaqRCQE0PuCYmB3jztyAOd/L8FvJswprO/JCvRvT0Tm/J+zZmTrn
         d9Gg==
X-Gm-Message-State: AOAM530ZadKabqrOPFI/TygR5JTw3/62mchy3MTaTSjRfD7lHiCUvXK+
        AeJqhJQz3FhSw6roXfd8XL2T5W05CIAd/h1hZ1fFtA==
X-Google-Smtp-Source: ABdhPJwKhyBPNifNOVJozWPUCv/8xC+wXlwRu41ZuH9dLT2NRRHEQuPi6ui/UWE4V7nLXNZqqh1WksLR26st0rlWoT8=
X-Received: by 2002:a17:90a:cc16:: with SMTP id b22mr5463999pju.32.1601411434147;
 Tue, 29 Sep 2020 13:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200929194318.548707-1-ndesaulniers@google.com>
 <20200929200801.GA2668747@rani.riverdale.lan> <CAKwvOdm=H3GDOPo-dbgsqH7UXzC1twz1h2Rdcidh8OXtFtCY4Q@mail.gmail.com>
In-Reply-To: <CAKwvOdm=H3GDOPo-dbgsqH7UXzC1twz1h2Rdcidh8OXtFtCY4Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 29 Sep 2020 13:30:22 -0700
Message-ID: <CAKwvOdmA746irmMVAzs5pJz4XgcWMBA8jWM2Ha1Z5c6hajWzJw@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: avoid escaped section names
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Sep 29, 2020 at 1:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Sep 29, 2020 at 1:08 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Sep 29, 2020 at 12:43:18PM -0700, Nick Desaulniers wrote:
> > > The stringification operator, `#`, in the preprocessor escapes strings.
> > > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > > they treat section names that contain \".
> > >
> > > The portable solution is to not use a string literal with the
> > > preprocessor stringification operator.
> > >
> > > In this case, since __section unconditionally uses the stringification
> > > operator, we actually want the more verbose
> > > __attribute__((__section__())).
> > >
> > > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > > Fixes: commit e04462fb82f8 ("Compiler Attributes: remove uses of __attribute__ from compiler.h")
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > ---
> > >  include/linux/compiler.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > index 92ef163a7479..ac45f6d40d39 100644
> > > --- a/include/linux/compiler.h
> > > +++ b/include/linux/compiler.h
> > > @@ -155,7 +155,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > >       extern typeof(sym) sym;                                 \
> > >       static const unsigned long __kentry_##sym               \
> > >       __used                                                  \
> > > -     __section("___kentry" "+" #sym )                        \
> > > +     __attribute__((__section__("___kentry+" #sym)))         \
> > >       = (unsigned long)&sym;
> > >  #endif
> > >
> > > --
> > > 2.28.0.709.gb0816b6eb0-goog
> > >
> >
> > There was this previous mini-thread:
> > https://lore.kernel.org/lkml/20200629205448.GA1474367@rani.riverdale.lan/
> > and this older one:
> > https://lore.kernel.org/lkml/20190904181740.GA19688@gmail.com/
> >
> > Just for my own curiosity: how does KENTRY actually get used? grep
> > doesn't show any hits, and the thread from 2019 was actually going to
> > drop it if I read it right, and also just remove stringification from
> > the __section macro.
>
> Oh, sorry I didn't respond on that thread; I could have sworn I ran a
> grep for KENTRY back then.
>
> $ git log -S KENTRY

Added by
b67067f1176df6ee727450546b58704e4b588563 ?

>
> Doesn't seem to get any hits, so I'm not sure what I should use for a
> proper Fixes tag in the event we just remove it.  Let me grab lunch,
> then I'll send a v2 that just removes the KENTRY block.  Thanks for
> the reminder!
>
> And I don't remember what ever happened to Joe's script for treewide
> conversion of __section.
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
