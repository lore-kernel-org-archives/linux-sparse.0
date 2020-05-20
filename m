From: =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh
        <congdanhqx@gmail.com>
Subject: Re: [SPARSE PATCH] univ-init: conditionally accept { 0 } without
 warnings
Date: Wed, 20 May 2020 07:41:51 +0700
Message-ID: <20200520004151.GB12509@danh.dev>
References: <20200518235446.84256-1-luc.vanoostenryck@gmail.com>
 <2fcda487-733b-8ed1-e1f4-6c6204a68569@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETAly (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 19 May 2020 20:41:54 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DDAC061A0E
        for <linux-sparse@vger.kernel.org>; Tue, 19 May 2020 17:41:54 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nu7so464190pjb.0
        for <linux-sparse@vger.kernel.org>; Tue, 19 May 2020 17:41:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2fcda487-733b-8ed1-e1f4-6c6204a68569@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org, Junio C Hamano <gitster@pobox.com>

Hi Luc,

On 2020-05-20 01:22:22+0100, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> > In standard C '{ 0 }' is valid to initialize any compound object.
> > OTOH, Sparse allows '{ }' for the same purpose but:
> > 1) '{ }' is not standard
> > 2) Sparse warns when using '0' to initialize pointers.
> > 
> > Some projects (git) legitimately like to be able to use the
> > standard '{ 0 }' without the null-pointer warnings
> > 
> > So, add a new warning flag (-Wno-universal-initializer) to
> > handle '{ 0 }' as '{ }', suppressing the warnings.
> 
> Hmm, I didn't think this would use a warning flag at all!
> 
> I remember the discussion (on lkml and sparse ml) in which
> there was general agreement that '{}' would be preferred
> solution (if only it was standard C!). However, I thought
> that (since some compilers don't support it e.g. msvc) the
> next best solution would be for sparse to suppress the
> warning if given the '= { 0 }' token sequence. (ie. no mention
> of it being conditional on a option).

I'm also in the camp of favouring no -W at all.
But, have another -W is fine to me.

> > Suggestions for a better name than this -W[no-]universal-initializer
> > are warmly welcome.
> 
> Heh, you know that I am no good at naming things - but this may well
> give the impression of a C++ like 'int i{}' type initializer!

From this discussion in GCC's BugZilla [1], I think compiler people
tend to call that style as zero-initialization, or universal zero
initialization.

[1]: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=53119#c12



-- 
Danh
