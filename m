Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0570C32771
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Sep 2022 21:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiIZVHW (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiIZVHS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Sep 2022 17:07:18 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C88A1D53
        for <linux-sparse@vger.kernel.org>; Mon, 26 Sep 2022 14:07:16 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so7670643pgs.3
        for <linux-sparse@vger.kernel.org>; Mon, 26 Sep 2022 14:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=VUYHQIv2vL8pY0r5skq1FuqyyfYP1QoMOYkxGZwbp6o=;
        b=TxQD2fJTodac/gzds749N6eKDMqdv7Q8g+tPhsOiW/sX3qUzP3f31tYswj1cNjhZ+P
         GZ26rUT4PfJw2GQKkiXkOXyDG3qoXJdjcDtY3ngV/e6Eip/wNz2SxOqyLUFoEqou289d
         65H2ej14mtX4cRsJfIOnYU6qdCyop+wYz0PRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=VUYHQIv2vL8pY0r5skq1FuqyyfYP1QoMOYkxGZwbp6o=;
        b=IHG1IQ7LjoHmPnW+SeBB4zhKhMtj9Rlwgy8zkeYi1IJd1G3ZG6ZlIUx+2+Ugiwg2si
         lYb/561N53eZKZCWMgQGKsC1Ukamjqh17TU38RdqsBg21kGWoF+3SJNhaTqpOTdhnOuh
         9W3pr6u4Xu7DLlg/IFrhnX9WkbXPliE9GxFOnm192V4qo4aII97KBWeTy+/qW60wuxYb
         fZZWa+53eb6rUF2sU3iJgTDgR5f7YiOZfhiMZl6NN/6XuT1Q1rM0V7N+nRMOR2ImbgqO
         m+P6n/pfb4DBeMHALi6wDaxuViyUJee34fX/jiHrs+zqIAUJ4DJvSkMojoL5+8IP6l2T
         XZfg==
X-Gm-Message-State: ACrzQf36cCJZTq03Ov8CKAOH5SSySH2YrXt0QEQrkhvNv0Yqc+JtEBFJ
        Q9S8SFNcm18aDwGrGDU6VUTp2A==
X-Google-Smtp-Source: AMsMyM6ac5PcbdyiCXdkvj0iGPsWyVMYvQOqt4HWPCMIqT7ijtbq72queIktQfLMWxfsTRb46FTITA==
X-Received: by 2002:a63:441b:0:b0:439:103b:25a4 with SMTP id r27-20020a63441b000000b00439103b25a4mr21064706pga.487.1664226436243;
        Mon, 26 Sep 2022 14:07:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h6-20020aa79f46000000b00540ffb28da0sm13290247pfr.91.2022.09.26.14.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:07:15 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:07:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-sparse@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v2] overflow: Introduce overflows_type() and
 castable_to_type()
Message-ID: <202209261405.619441AC2F@keescook>
References: <20220926191109.1803094-1-keescook@chromium.org>
 <CAKwvOdmCjAQpaF40VStbFNf1ZqmTxTTZzy2v4TwSF0LVO08GYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmCjAQpaF40VStbFNf1ZqmTxTTZzy2v4TwSF0LVO08GYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Sep 26, 2022 at 01:17:18PM -0700, Nick Desaulniers wrote:
> + Arnd
> 
> On Mon, Sep 26, 2022 at 12:11 PM Kees Cook <keescook@chromium.org> wrote:
> > ---
> > v2:
> >  - fix comment typo
> >  - wrap clang pragma to avoid GCC warnings
> >  - style nit cleanups
> >  - rename __castable_to_type() to castable_to_type()
> >  - remove prior overflows_type() definition
> > v1: https://lore.kernel.org/lkml/20220926003743.409911-1-keescook@chromium.org
> > diff --git a/lib/overflow_kunit.c b/lib/overflow_kunit.c
> > index f385ca652b74..fffc3f86181d 100644
> > --- a/lib/overflow_kunit.c
> > +++ b/lib/overflow_kunit.c
> > @@ -16,6 +16,11 @@
> >  #include <linux/types.h>
> >  #include <linux/vmalloc.h>
> >
> > +/* We're expecting to do a lot of "always true" or "always false" tests. */
> > +#ifdef CONFIG_CC_IS_CLANG
> > +#pragma clang diagnostic ignored "-Wtautological-constant-out-of-range-compare"
> > +#endif
> 
> Any chance we can reuse parts of __diag_ignore or __diag_clang from
> include/linux/compiler_types.h or include/linux/compiler-clang.h
> respectively?

Hm, I'm not sure how those are supposed to be used. Those defines don't
seem to be used externally?

> Those are needed for pragmas within preprocessor macros, which we
> don't have here, but I suspect they may be more concise to use here.

Yeah, I was surprised when I had to wrap it in #ifdef given "clang" is
part of the string.

> 
> > +#define TEST_SAME_TYPE(t1, t2, same)                   do {    \
> > +       typeof(t1) __t1h = type_max(t1);                        \
> > +       typeof(t1) __t1l = type_min(t1);                        \
> > +       typeof(t2) __t2h = type_max(t2);                        \
> > +       typeof(t2) __t2l = type_min(t2);                        \
> 
> Can we use __auto_type here rather than typeof(macro expansion)?

I'd rather it stay explicit -- otherwise we start to wander into "oops,
we got lucky" territory for what should be a really distinct test case.

-- 
Kees Cook
