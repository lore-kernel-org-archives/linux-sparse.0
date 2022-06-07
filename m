Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F531CCA499
	for <linux-sparse@archiver.kernel.org>; Wed,  8 Jun 2022 00:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354515AbiFHAym (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1450068AbiFGXKs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Jun 2022 19:10:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DF218492B
        for <linux-sparse@vger.kernel.org>; Tue,  7 Jun 2022 13:48:16 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id y19so37556888ejq.6
        for <linux-sparse@vger.kernel.org>; Tue, 07 Jun 2022 13:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ae2EWsMHaQEpT2swz0aG6TlK+vgk2L1Smng6oIqSP+I=;
        b=UT4gln5aiVScnAr1coIUjJ4owtdcrNmMoY8IfIAH8Tcjkjtaf7VcU8XeuobljxvYaG
         xdLjZSzpPheoq33FlsH+zOOuUNAU4BcwHak8f6qKuT4+Ai4anusPI/hs18RkctBm4ex+
         ueMLAHHm4caGXjkRMSFn9GAdtrMCtL6D9MC6b7qGaw0H0qZGDZKogUIYJcXAAXgirbBd
         MWQ6Icolgd1S3wCK3JufqdQahGq148/oE10oC7GDbtYSkWySZBpWTEZLhqQVI5Ei6Xlu
         PhMCdC/LYtcXihQMExy09TqZD+mHe9s8WjqzoXzP8ZrzI8wzz4JHchgIlhNf7m+ynO96
         ajrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ae2EWsMHaQEpT2swz0aG6TlK+vgk2L1Smng6oIqSP+I=;
        b=qigtov6dG3HXPAyzHCRdrmhqxXZ5o8CPZmaWsbjx0BjjkrEdRN8XdAdQ0tDaepCV33
         FSDHoT+5rhjYH6vEuEcGFiaLZ/+MZDg0OenVpbVPaR7IF4BxPukl1T9oYD3eYQecpMoC
         VkJyIbLJriksS+yNTNOtMQDl7Sh3jy2yaQlaeSROHNRnU8B8ZP4VSPuykUFRC/xJY1H4
         Zf3Crp1jOppW5nIyM9VPQ40hgMzIoyw+Go3wvQ0QzzJEK/pencF2hpwz9dVOKspzfl9z
         ywsQfH5yj4aBhO1zjUGCTM5sNbUywpdlalfNG9LbN4nCc3QE2Iz4EhkfSXG6RUbOeiJT
         5VIg==
X-Gm-Message-State: AOAM533+CmZrxKv1um1m8YSF0JfImp3GxLYGVRSWcvONE5qTXcKmEokh
        Tg2lwMHKv4gWUX/zQI4MJ3o=
X-Google-Smtp-Source: ABdhPJwaZ0sUIBrFebLVwxgyhji0nPSm0meAcJb04X+flg/h2QjErb2C/IF7hvGUDcZJCFE6KA2nKA==
X-Received: by 2002:a17:907:9715:b0:711:ca06:ca50 with SMTP id jg21-20020a170907971500b00711ca06ca50mr13330983ejc.192.1654634894485;
        Tue, 07 Jun 2022 13:48:14 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id u1-20020a170906124100b006feb875503fsm8201357eja.78.2022.06.07.13.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:48:13 -0700 (PDT)
Date:   Tue, 7 Jun 2022 22:48:12 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luc Van Oostenryck <lucvoo@kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] allow show_token() on TOKEN_ZERO_IDENT
Message-ID: <20220607204812.g7kvxkdlz247ddf3@mail>
References: <20220607125441.36757-1-lucvoo@kernel.org>
 <CAHk-=wjYBPYsD-h_KkOG2zZTEXQ3yYEOzD_S83mnJqXjs1tcrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjYBPYsD-h_KkOG2zZTEXQ3yYEOzD_S83mnJqXjs1tcrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Jun 07, 2022 at 11:26:36AM -0700, Linus Torvalds wrote:
> On Tue, Jun 7, 2022 at 5:55 AM Luc Van Oostenryck <lucvoo@kernel.org> wrote:
> >
> > TOKEN_ZERO_IDENTs are created during the evaluation of pre-processor
> > expressions but which otherwise are normal idents and  were first tokenized
> > as TOKEN_IDENTs.
> >
> > As such, they could perfectly be displayed by show_token() but are not.
> > So, in error messages they are displayed as "unhandled token type '4'",
> > which is not at all informative.
> >
> > Fix this by letting show_token() process them like usual TOKEN_IDENTs.
> > Idem for quote_token().
> 
> Ack.
> 
> I do wonder if it should be marked somehow as being that special case.
> The main reason for 'show_token()' is debugging, after all, and
> TOKEN_ZERO_IDENT does have magical properties in how it either
> silently expands to the constant '0', or it generates a warning about
> undefined preprocessor symbol.
> 
> But considering that we've apparently reported it as "unhandled token
> type '4'" since 2005, I guess it's not exactly a big deal.

Yes, I first thought to do so but then choose not because I could not
convince myself that its special property was irrelevant in warning/error
messages. It looks to me more as an internal thing, more semantical than
lexical, and a non-faithful representation would be confusing in messages.

For context, the input text I had (from GCC's testsuite) was:
	#define empty
	#if empty#cpu(m68k)
	#endif
and the error message sparse issued was:
	error: garbage at end: #unhandled token type '4' (unhandled token type '4' )
with this patch it's:
	error: garbage at end: #cpu(m68k)
 
-- Luc
