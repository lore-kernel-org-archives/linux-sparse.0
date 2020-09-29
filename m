Return-Path: <SRS0=CDBi=DG=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65E4C4727D
	for <linux-sparse@archiver.kernel.org>; Tue, 29 Sep 2020 21:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD9D2083B
	for <linux-sparse@archiver.kernel.org>; Tue, 29 Sep 2020 21:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlhR/VAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgI2Vio (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 29 Sep 2020 17:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2Vin (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 29 Sep 2020 17:38:43 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82606C0613D1;
        Tue, 29 Sep 2020 14:33:23 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u8so7325728lff.1;
        Tue, 29 Sep 2020 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3dwCE+v0GZtE62h3ykTPVjBYnltbx4TcDziVD3ADHYA=;
        b=UlhR/VAY11pK8/kOEEb2V2Sk7YVh2SsTM1fp5mhftb4GfVtcEep2R87RJMsy+h9OXL
         krMeEYwjr4v0WBWrZqXAdmcg3CZCIG9y4UIwZNFmg532h1UGruvcpqixRcWbfObLKwUt
         vzH6krIHv4D76CkP2FAYGIfF/z68FTakRAPjxd/yQxWIxysK+IyXFdY6+uQj0AnucBJj
         xdiFInw/+bHarzuzrVaDGhHBGTV9QXfMUnQzjNu52Kmrz2sj4rGdnkJdqs8X3N7AFm4X
         niM5GsUhSbL4JMLKy+YzgIxxfUeiDWyWPLQawpeJn0aloNvrFaZ276DtdHqjLZk2xpEn
         oGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3dwCE+v0GZtE62h3ykTPVjBYnltbx4TcDziVD3ADHYA=;
        b=Z/VHcr1L48r2C0DPVyal3oAWNcRiUtQS5m1t2d8cXVbIuFDgnizzL09/f/X/Kfa+MV
         dIJIARtg2kuuwIhWZVr6mEEVWAANsZ/hYyKOBN4q5kUkufsHXTgGy0CBVYFRhoKcOBD+
         GUUfIiNAzyaChLxEWj11qIEQAFUvxFCFhdr8azjAl3crxM/7w74UQ7VFmd+m5qfo3a+7
         jDh5gGJEX3qHsg5sKLiuoJNU31eccc/1di+7GWq9mkSqd4JlQ5cSVbRyHzGZZoybnBa3
         Ga3jjb12ohOJ2PfvtrCLHdNN9f8cZGEPh2vLIkIlRehhEMHxYMFFsW7l/2Vcl8P/oXkt
         BUsg==
X-Gm-Message-State: AOAM532fXu4234U4q/oD95qU+dY90xv6WMnvUz6SXsESXw0xiYO8Eqhv
        fVQHtyy+JD2cZ21xatWlgWK5/rkL9DuldEvRjuk=
X-Google-Smtp-Source: ABdhPJwqS5IANoo/oW2mikNdyZRaSnTl1fqaWN9i8aZ6P3HTe46KWMXy8Z5Zke8FjOd/AxUwUa/m8bEkIpN9BvJhHr0=
X-Received: by 2002:a19:e20b:: with SMTP id z11mr1939035lfg.440.1601415201947;
 Tue, 29 Sep 2020 14:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200929194318.548707-1-ndesaulniers@google.com>
In-Reply-To: <20200929194318.548707-1-ndesaulniers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 29 Sep 2020 23:33:10 +0200
Message-ID: <CANiq72kHEhTm3-7WbZwmoKQV5Qn9fD_sk+yrVrdj_K0AqT6dNQ@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: avoid escaped section names
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-sparse@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Hi Nick,

On Tue, Sep 29, 2020 at 9:43 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The stringification operator, `#`, in the preprocessor escapes strings.
> For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> they treat section names that contain \".
>
> The portable solution is to not use a string literal with the
> preprocessor stringification operator.
>
> In this case, since __section unconditionally uses the stringification
> operator, we actually want the more verbose
> __attribute__((__section__())).

Let's add a comment about this in the code -- otherwise we/someone
will convert it back without noticing. Also we could add another on
`__section` itself warning about this.

> Link: https://bugs.llvm.org/show_bug.cgi?id=42950

Is there a link / have we opened a bug on GCC's side too?

Thanks!

Cheers,
Miguel
