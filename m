Return-Path: <SRS0=CDBi=DG=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAAEC4727C
	for <linux-sparse@archiver.kernel.org>; Tue, 29 Sep 2020 20:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8542076A
	for <linux-sparse@archiver.kernel.org>; Tue, 29 Sep 2020 20:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIudEvYy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgI2UN2 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 29 Sep 2020 16:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgI2UN2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 29 Sep 2020 16:13:28 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC411C061755;
        Tue, 29 Sep 2020 13:13:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id f11so2981060qvw.3;
        Tue, 29 Sep 2020 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2yE8tLnNFogNu2DcQZ3zwF/fyfjhAGFtUaRsrh9630g=;
        b=BIudEvYyd7e1T8YFoEmamwmrXDhkLwQJxr4BDM05kapleUxs0tthYqNKmZe2im7Fg4
         hqZobpyIYcoNoi3aCrfE9xsIeVuG/nvtg60WkfSsIhiRxHrauZ3/kmFbm8zve6GAcLRe
         NfPPDG/F5nIBaBWcpAoNs9Jaj8p9OChDC+IfpR4TL4tn+jumhOdG7+L1+xhuEToq/p4I
         1c83r3GUGkjfpccGMNvxMABHMlq11fnH7DTbqKu69VJYdr9qG7GPD4PBLoIwQsmBOzav
         2SleYCY84l6fOPHP/XSRrHvvp4HhF0vSRGfPia6ybKVH5Cu9JEWVe/Bs1a6UmF6+EWmt
         zg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2yE8tLnNFogNu2DcQZ3zwF/fyfjhAGFtUaRsrh9630g=;
        b=FJ9IbHRFnmVtzZ3XKotQok3lGZCG+hiA0tHcASWFGYtpT2ucOot6d3IcgLnNkWeY5E
         ea3NUOQjgluFfd72AThUBtM5+lXVIrBeAJo34e1/0GKeIJzX3z4ADAa0bnvWz4HnZGcI
         NS7N7clIkiRXfKtLpMKo2Fl5picCyhk3cFD2LOtRNEMNAlZiU02IumUtPrnOzRTAKn52
         TqPO89Zg5Kxc6QIS87e3fKAOgjd+s7l3Wd0WLYVHS09Hgf5PQfHmLD2aadCTQCRPFHIn
         czDIcvihkc2IBgWUIfWkCKLDUhSUfBuPbytMdJm54hBbVMvpqWMKUPIt7tPfimrSB+Gf
         hN9Q==
X-Gm-Message-State: AOAM5309gBiKzCrSabdzbICOGeVx7EZgmvJ+p1/1+FFEi72B/MuBNc1C
        HyXFMoNn+O+txfx60IIqxotFrOz9XxoQFA==
X-Google-Smtp-Source: ABdhPJyzo/sh8biAN7ip8oRKWAQiwRLTYpJG2Fyd/mCxZt16Q4VCaIYRuBYqFS+C0odiRwqn2364UA==
X-Received: by 2002:a0c:d443:: with SMTP id r3mr6364147qvh.17.1601410406562;
        Tue, 29 Sep 2020 13:13:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c40sm7012393qtb.72.2020.09.29.13.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 13:13:26 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 29 Sep 2020 16:13:24 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] compiler.h: avoid escaped section names
Message-ID: <20200929201324.GB2668747@rani.riverdale.lan>
References: <20200929194318.548707-1-ndesaulniers@google.com>
 <20200929200801.GA2668747@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200929200801.GA2668747@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Sep 29, 2020 at 04:08:01PM -0400, Arvind Sankar wrote:
> On Tue, Sep 29, 2020 at 12:43:18PM -0700, Nick Desaulniers wrote:
> > The stringification operator, `#`, in the preprocessor escapes strings.
> > For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
> > they treat section names that contain \".
> > 
> > The portable solution is to not use a string literal with the
> > preprocessor stringification operator.
> > 
> > In this case, since __section unconditionally uses the stringification
> > operator, we actually want the more verbose
> > __attribute__((__section__())).
> > 
> > Link: https://bugs.llvm.org/show_bug.cgi?id=42950
> > Fixes: commit e04462fb82f8 ("Compiler Attributes: remove uses of __attribute__ from compiler.h")
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  include/linux/compiler.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 92ef163a7479..ac45f6d40d39 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -155,7 +155,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >  	extern typeof(sym) sym;					\
> >  	static const unsigned long __kentry_##sym		\
> >  	__used							\
> > -	__section("___kentry" "+" #sym )			\
> > +	__attribute__((__section__("___kentry+" #sym)))		\
> >  	= (unsigned long)&sym;
> >  #endif
> >  
> > -- 
> > 2.28.0.709.gb0816b6eb0-goog
> > 
> 
> There was this previous mini-thread:
> https://lore.kernel.org/lkml/20200629205448.GA1474367@rani.riverdale.lan/
> and this older one:
> https://lore.kernel.org/lkml/20190904181740.GA19688@gmail.com/
> 
> Just for my own curiosity: how does KENTRY actually get used? grep
> doesn't show any hits, and the thread from 2019 was actually going to
> drop it if I read it right, and also just remove stringification from
> the __section macro.
> 
> There are still other instances that need to be fixed, right?
> 
> Thanks.

Ignore the last question, I see you have separate patches for the rest.
