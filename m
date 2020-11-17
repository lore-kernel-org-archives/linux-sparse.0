Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFA6C63777
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 23:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF582463B
	for <linux-sparse@archiver.kernel.org>; Tue, 17 Nov 2020 23:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2UiGxML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgKQXuF (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 17 Nov 2020 18:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgKQXuE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 17 Nov 2020 18:50:04 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E070C0613CF
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 15:50:04 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id y17so130987ejh.11
        for <linux-sparse@vger.kernel.org>; Tue, 17 Nov 2020 15:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e3dXZjljA8zRpyc27ASvSZJz81lWalOq6X3+4lmrWh8=;
        b=l2UiGxMLGPqW+cs1VN1Mldzf0gRmyRKaw1OmC8eGQORVtvt5jmKnu9WNeIBd2mNGg2
         T2Go3Ph5opbGTJGx8E0+wAAgnqsELgJp8p/9jd97TI537jRPGm2r554pdU4I5jXbM4Xv
         /6tkyyXDzjzabvB3WrM7P+YyPQuGnrS9UfZSox85RKN5PIhD2AkUjulu3jL5M+CnAkrZ
         8s3YpuLPvoRyKdUiPCBvSxxbbmgUCiz4hyKNIVZNmCUHtAJesSAXamlTcxYXqrvS4mMs
         Uh3igcohiCqL5BtktO1KN6lFmIpafAy613Mb4ybGK8bwp/f74/EZZZgqUGy13yApxUbJ
         yG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e3dXZjljA8zRpyc27ASvSZJz81lWalOq6X3+4lmrWh8=;
        b=L07DWANNpvtQkQ7d89moheEYVRvkCR/PJGnm3Zj0a8pv79z9WhmMhjj15AWzaxYIyS
         lpJ2cbpmTPrmLoGxKUWdVEkfh0gpgyLSGjHKp6l+2Ago+pXXpVy8bur7JkwMjG+h0945
         Xw4KIMxW1S9WbG+aSMajQ3un6CTDf0PyQAygtImeN2H8E7O2jCD3FUTkkqf+dWP1HJue
         ZcgkOT5/kPem5gGsrpxdLPiXqD8jyWWaObBJINZpJkE6yCaA06TkiyvF5EYd6N8v55n6
         e2KG0gxCR9icWzs10C5Qtd/BKUwT1QtgPPGTaPc+w0im7Gq4ZXUe3bhNca+IvgrJMCVJ
         GWSQ==
X-Gm-Message-State: AOAM5324nodenZRXgBaPvsF192wSQblF60dkPpg1EfBn9PEIgFxtDVZc
        bx0Tw7YgF26dGFbgXEZ7STc=
X-Google-Smtp-Source: ABdhPJxpI7JX8wAo4+Iqo41NEvH/nxwFS1wHFfDY594jYpGBREStm+A1SeuptYSZnjlhZHtjmmkxKQ==
X-Received: by 2002:a17:906:f207:: with SMTP id gt7mr22145824ejb.293.1605657003082;
        Tue, 17 Nov 2020 15:50:03 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:a97b:cf26:e505:4628])
        by smtp.gmail.com with ESMTPSA id dk8sm241686ejb.88.2020.11.17.15.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:50:02 -0800 (PST)
Date:   Wed, 18 Nov 2020 00:50:00 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] casts should drop qualifiers
Message-ID: <20201117235000.2x7im3v3aga6iart@ltop.local>
References: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
 <20201117212829.99552-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wgtL1LPYev5cwhZqd=7RyaGrzx3mS-ydVZAQuYrf0XNuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgtL1LPYev5cwhZqd=7RyaGrzx3mS-ydVZAQuYrf0XNuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Nov 17, 2020 at 03:22:21PM -0800, Linus Torvalds wrote:
> On Tue, Nov 17, 2020 at 1:29 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Casts should drop qualifiers but Sparse doesn't do this yet.
> >
> > The fix seems pretty simple: after having evaluated the type of
> > the cast, if this type is a SYM_NODE and contains qualifiers,
> > make a copy of the type with the qualifiers removed and use
> > this copy as the type.
> 
> Did you look at the lvalue conversion issue too?

I'm looking at it. 

> IOW, ((void)0,(x)) should end up also with qualifiers dropped on the
> end result, because the comma expression will have turned x from an
> lvalue to an rvalue.
> 
> Would doing the same unqualify_type() in degenerate() be sufficient?

For the comma, yes, I think it should be sufficient.
I'm checking a few things around but I'll finish this tomorrow.

-- Luc
