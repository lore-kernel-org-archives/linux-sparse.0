Return-Path: <SRS0=CDBi=DG=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D219CC47420
	for <linux-sparse@archiver.kernel.org>; Tue, 29 Sep 2020 20:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6015D20774
	for <linux-sparse@archiver.kernel.org>; Tue, 29 Sep 2020 20:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stCxwfWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgI2UIG (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbgI2UIF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 29 Sep 2020 16:08:05 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287DFC061755;
        Tue, 29 Sep 2020 13:08:04 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ef16so2964578qvb.8;
        Tue, 29 Sep 2020 13:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w5yusrSGveqthrL87NLW61j5LhSouuB+VXSBKe+YvgY=;
        b=stCxwfWfqQsHP0bifFMTY2W9Y79SiOjHN0oXfGlK4nFcGiRbjFy259Du1fg1GD+q2q
         B3royDGuBtVDnX7Q2W670LO80aVExEgQbzNyLwqSkAMf5hGGR6MmRyUxqeuqUyYq3Cpr
         RXClXxZfHuyYk8JFAwmBbAEDyxGYWbay4AF8KuMfevWZs71w2zr6XiA8w+f0iUPU0b9d
         4vxp/cJ1kkB71tpJZlErMoUMbsq0KXxhLdx5PYaSvDbikAlLZvxLHqrjHNCrIuQceP6P
         gSzAlxbv46DXiaO04BBtRRwq6PEnfG3lgiBFYjBMaee+BZ0oP/eIcTvbOzbGNciPl0D7
         CiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=w5yusrSGveqthrL87NLW61j5LhSouuB+VXSBKe+YvgY=;
        b=EZo0HlxM0R8hY0ucK01IbQ/LnYsbXMmniIXoO6gXjip3N8xycYTRRVArxpxrF6mjhU
         vErb/+TSNucAMgWQbJj9NMiAC1L41h9CmPJTou2gQbq3+pkFZtkzP19UUxexufArZCQi
         h3M30sIfVgMtq46Gj8oNAoKzZRmW+tDkztmlnTBWF/LRIxcRhXAeorcMMKPzjwosWrYt
         pAEcze7K8mX2iuS2NdHURlAnb2HL3C9dnR3RxYdN7Ly/J7ZZp4a8F2UX7FORa9YyAcPq
         lfRXfpzHrHjKQRWLIcsjA/rHWd+Egr8f14kFznrRZuaFHSL7YloUexV2kULzMu0goCCG
         J1Ew==
X-Gm-Message-State: AOAM532Cd55P5cF/uPlPSu7tODFGiG7TfL8s+zfam83UL1tC7eNVv9/u
        FBRVbtBBcO3xw5KL6PfnWjw=
X-Google-Smtp-Source: ABdhPJwjiIuVP3Xk7TyGP/QzYW2QusdhN0VPHhBdqJhqNvVth0VkbdVieKSOTOS9Z/lfyA1mt+wx7A==
X-Received: by 2002:ad4:5653:: with SMTP id bl19mr5770754qvb.7.1601410083317;
        Tue, 29 Sep 2020 13:08:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y30sm6932829qth.7.2020.09.29.13.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:08:02 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 29 Sep 2020 16:08:01 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] compiler.h: avoid escaped section names
Message-ID: <20200929200801.GA2668747@rani.riverdale.lan>
References: <20200929194318.548707-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200929194318.548707-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Sep 29, 2020 at 12:43:18PM -0700, Nick Desaulniers wrote:
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
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> Fixes: commit e04462fb82f8 ("Compiler Attributes: remove uses of __attribute__ from compiler.h")
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  include/linux/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 92ef163a7479..ac45f6d40d39 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -155,7 +155,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  	extern typeof(sym) sym;					\
>  	static const unsigned long __kentry_##sym		\
>  	__used							\
> -	__section("___kentry" "+" #sym )			\
> +	__attribute__((__section__("___kentry+" #sym)))		\
>  	= (unsigned long)&sym;
>  #endif
>  
> -- 
> 2.28.0.709.gb0816b6eb0-goog
> 

There was this previous mini-thread:
https://lore.kernel.org/lkml/20200629205448.GA1474367@rani.riverdale.lan/
and this older one:
https://lore.kernel.org/lkml/20190904181740.GA19688@gmail.com/

Just for my own curiosity: how does KENTRY actually get used? grep
doesn't show any hits, and the thread from 2019 was actually going to
drop it if I read it right, and also just remove stringification from
the __section macro.

There are still other instances that need to be fixed, right?

Thanks.
