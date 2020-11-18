Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEE3C5519F
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 21:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCA8246AD
	for <linux-sparse@archiver.kernel.org>; Wed, 18 Nov 2020 21:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU5HwbTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgKRVab (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKRVaa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 18 Nov 2020 16:30:30 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464DBC0613D4
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 13:30:30 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id m16so3601256edr.3
        for <linux-sparse@vger.kernel.org>; Wed, 18 Nov 2020 13:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MnDMGXV7xDPwvSb9PVk6iBVmZMcF0FN5yEWSksfURSg=;
        b=XU5HwbTd0S8awZKc5kBFsq+1K6dC41VIrEIdIjfD/RgaT0zobLsBs5BLRfrUlFXYos
         qtGo84PCyohKxOZd+swGIDDMCM0ZppNFFbM0Mi6WJoMoz+vnB2tSwKzfQgw6ZVhezxx7
         Dv1cpXxSQdCFhRnQUj+20Tdf9i3DnhqmcEdXonzLwkDJ1T5eXVrtiBnv6gR8tuxiifdC
         RaDfImXoyWs6nb6piE7baMIvWUN2Bhue1f/8ziMwp/GY8S1gPsgJu/D0b6UD0WQIzQUj
         6H1fm5O1cID2bF7cBMRVhHgAboGGRwkl3vyih3CRdbotP1d8C7A8R5YQq7mjfahTf5iF
         mgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MnDMGXV7xDPwvSb9PVk6iBVmZMcF0FN5yEWSksfURSg=;
        b=i3ZruPGQB6SjU1D3cqPoJBn43ejALhQXxzv2tOjAFUb3ADMzFxuX9d/QOpGuCIsMi/
         rm2UD8BtaZMkKH9E4yMiA+MM28akhRhayW6EutvZoabRuH3yKgRqYoWMBQNKf/xEFIda
         VhEm+sOqb9E7gXDMZjGoGaF+2uvgoERfv7R3hgZ7al2HOS0TWO6lzfXVKwtPywFFM5Gx
         PQnFTdYL4xZ35qEaBaV7jZ4FcS4R/3YE46p/SNAQB2FSKcMZSi6O4TndYa7tauJ87O9u
         d0HNcfCjhh2Xn4+GC8s3uAC59o8EUdpW3rRVMLuifTWaac13I4B1UnSc/lqmnKxKO/eI
         43FA==
X-Gm-Message-State: AOAM5312V5qh8rM33/7clNflW9OAslsCP7/qKl4rXBPGPfQdnDCvGkgS
        OVTpoNPZtOcXr3+N8T6ltSIeDVmvv+U=
X-Google-Smtp-Source: ABdhPJwm6BXvaRUhr+LZpXc6C/4KQWO0N+ONXAMH2PhGY7hqfvS8NTZrQO1TM6Vb2SRnrYc+4XV1GA==
X-Received: by 2002:a50:e61a:: with SMTP id y26mr28188858edm.71.1605735029038;
        Wed, 18 Nov 2020 13:30:29 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:491a:3e51:301b:6e24])
        by smtp.gmail.com with ESMTPSA id l20sm13575503eja.40.2020.11.18.13.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:30:28 -0800 (PST)
Date:   Wed, 18 Nov 2020 22:30:27 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] casts should drop qualifiers
Message-ID: <20201118213027.3o74il23b5nesx3d@ltop.local>
References: <CAHk-=wivBmCoux_bVz_tZ12byZS=oZ7+F2Og8OjJGM5aiM-KQQ@mail.gmail.com>
 <20201117212829.99552-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wgtL1LPYev5cwhZqd=7RyaGrzx3mS-ydVZAQuYrf0XNuQ@mail.gmail.com>
 <CAHk-=wi-XUPMduO16mvNeou58O-LrxnSk33WBg+vbbqCpzHgOw@mail.gmail.com>
 <20201118191737.oq2e2t5h2wo3us3c@ltop.local>
 <CAHk-=wjB+c+1ykVzRz5yKX486hHNMMNVAhrwwvbRuuo9eO5gfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjB+c+1ykVzRz5yKX486hHNMMNVAhrwwvbRuuo9eO5gfg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Nov 18, 2020 at 11:51:00AM -0800, Linus Torvalds wrote:
> On Wed, Nov 18, 2020 at 11:17 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > I don't think it's a good idea. The focus now is all about dropping
> > the qualifiers but in code like:
> >         const int x;
> >         typeof(c) y;
> > don't we want 'y' to also have the type 'const int'?
> 
> I assume you meant "typeof(x)". But yes, absolutely.

Yes, sure.
 
> Which is why my suggested example patch had that explicit test for
> "is_lvalue()".  So only for non-lvalues would it strip the qualifiers.
> 
> So "typeof(((void)0,x)) y;" would be "int", because that expression
> inside the typeof isn't an lvalue.

Oh yes, sorry. For some reasons I had things upside down.
 
> But if you have something that is already doing the generic case, then
> that's obviously better. My suggestion was more of a "we can zero in
> on just that typeof case" thing.

I just sent the series but it's not generic.

If I read the standard correctly (big 'if'), in:
	volatile int x;
	typeof(++x) y;
'y' should have the type 'volatile int' and GCC interpret it so.

-- Luc
