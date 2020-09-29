Return-Path: <SRS0=CDBi=DG=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA31C4742F
	for <linux-sparse@archiver.kernel.org>; Tue, 29 Sep 2020 20:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F512072E
	for <linux-sparse@archiver.kernel.org>; Tue, 29 Sep 2020 20:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTYMep3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgI2Urv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbgI2Urv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 29 Sep 2020 16:47:51 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D814C061755;
        Tue, 29 Sep 2020 13:47:51 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cy2so3054924qvb.0;
        Tue, 29 Sep 2020 13:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V3P4F4QWiuS/mi/zwuxmKRL+xPQc9F0a3ah2tRd6rKw=;
        b=vTYMep3x7skP/KJWvFFLIt273NsL+ED/CoxGQh1gMmwkoEds7iSTZ6UShchFs72/nz
         aZenBI+5VFJ4UgMk+QAmhiURn+oX+2EktjvIABTP9VQsIEXhjGrYo0D8h8OVBj+rlsat
         gyvdqo0dS7pTDP1MBsAZrRB2MThsibWF8xwXd53qOg2sygdMccIOGR6/co4JzAd/lJxK
         WNqXbGxbvjww4Z1neykbg4OTwy9+LDr1XY4P7zT208/h2U5z3mf5eOvMgdgYtFV92ql2
         q3xx/6ble05mIBSdqPE8hhs+gq/gt5OFe5YIxeOMZI49xVOC80TZ2YGyVhCEQi9TS2MO
         VmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=V3P4F4QWiuS/mi/zwuxmKRL+xPQc9F0a3ah2tRd6rKw=;
        b=h7Yp0l2nJbTPp8UJi8ZxqzdH66Ae9JrQ7SMkHZNUP+0EQtRKNmcHH1fXHYmNOSe6a7
         W48KihfOwpjTREsdXYR7PfVm59Es7JgdG3WnUBmEPFt1+GMLLUGQap/DTP0kyvC3fJC3
         s44lYCgPNA6eMEa746PcwmK7bxtul853DINyWska5KDTWHzarno8tLBhj+2Qn8h0ylIs
         0sHi081eNKWhw/Q11Futg7XydXwxxBlQbfpXd2JbCqTywzMqk3ozoAsfI5re6moSHhNZ
         tXns6N18SxpuFjb9KlTkmER+zVmTvTBZP5Da+zgn51sezL4zMOt1UZUSD/29KusscpaS
         X+zw==
X-Gm-Message-State: AOAM533TNWQhhDD+ztR1RRBvCdPYp7f0cbppP/VmNiqmm/CElGV+V/l7
        /+hmIUBpInMygMi2WeSjWfQ=
X-Google-Smtp-Source: ABdhPJwTn7VcT0oQIjGViXrIEyn0eM4IVKqOFomL08RKEFlmkD17GHRLw8UFTeGUNp2O4VUl8JBwgg==
X-Received: by 2002:ad4:408f:: with SMTP id l15mr6401654qvp.4.1601412470319;
        Tue, 29 Sep 2020 13:47:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m18sm5964723qkg.77.2020.09.29.13.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:47:49 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 29 Sep 2020 16:47:48 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH] compiler.h: avoid escaped section names
Message-ID: <20200929204748.GA2683578@rani.riverdale.lan>
References: <20200929194318.548707-1-ndesaulniers@google.com>
 <20200929200801.GA2668747@rani.riverdale.lan>
 <CAKwvOdm=H3GDOPo-dbgsqH7UXzC1twz1h2Rdcidh8OXtFtCY4Q@mail.gmail.com>
 <CAKwvOdmA746irmMVAzs5pJz4XgcWMBA8jWM2Ha1Z5c6hajWzJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmA746irmMVAzs5pJz4XgcWMBA8jWM2Ha1Z5c6hajWzJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Sep 29, 2020 at 01:30:22PM -0700, Nick Desaulniers wrote:
> On Tue, Sep 29, 2020 at 1:25 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Tue, Sep 29, 2020 at 1:08 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Tue, Sep 29, 2020 at 12:43:18PM -0700, Nick Desaulniers wrote:
> > > > The stringification operator, `#`, in the preprocessor escapes strings.
> > > > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > > > they treat section names that contain \".
> > > >
> > > > The portable solution is to not use a string literal with the
> > > > preprocessor stringification operator.
> > > >
> > > > In this case, since __section unconditionally uses the stringification
> > > > operator, we actually want the more verbose
> > > > __attribute__((__section__())).
> > > >
> > > > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > > > Fixes: commit e04462fb82f8 ("Compiler Attributes: remove uses of __attribute__ from compiler.h")
> > > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > > ---
> > > >  include/linux/compiler.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > > > index 92ef163a7479..ac45f6d40d39 100644
> > > > --- a/include/linux/compiler.h
> > > > +++ b/include/linux/compiler.h
> > > > @@ -155,7 +155,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> > > >       extern typeof(sym) sym;                                 \
> > > >       static const unsigned long __kentry_##sym               \
> > > >       __used                                                  \
> > > > -     __section("___kentry" "+" #sym )                        \
> > > > +     __attribute__((__section__("___kentry+" #sym)))         \
> > > >       = (unsigned long)&sym;
> > > >  #endif
> > > >
> > > > --
> > > > 2.28.0.709.gb0816b6eb0-goog
> > > >
> > >
> > > There was this previous mini-thread:
> > > https://lore.kernel.org/lkml/20200629205448.GA1474367@rani.riverdale.lan/
> > > and this older one:
> > > https://lore.kernel.org/lkml/20190904181740.GA19688@gmail.com/
> > >
> > > Just for my own curiosity: how does KENTRY actually get used? grep
> > > doesn't show any hits, and the thread from 2019 was actually going to
> > > drop it if I read it right, and also just remove stringification from
> > > the __section macro.
> >
> > Oh, sorry I didn't respond on that thread; I could have sworn I ran a
> > grep for KENTRY back then.
> >
> > $ git log -S KENTRY
> 
> Added by
> b67067f1176df6ee727450546b58704e4b588563 ?
> 

Yeah but nothing seems to have used it. I assume for LTO we use some
other technique to mark functions as used?
