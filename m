Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1399CC388F9
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 20:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F72E20B1F
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 20:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsIDdgkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgKGUJ2 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 15:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGUJ2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 15:09:28 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD334C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 12:09:27 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id cw8so6729449ejb.8
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 12:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ze6D36/kwBREuF6/gfi58IYUCsOdlWcgYm0NXdZrSio=;
        b=RsIDdgkrQttXD3wQCFfs4Dz6bJ8dkCFwv2c828KzMEPt6LdhBuKrJvw4bUp9pUFBMM
         9cxA0Py0eFdBB+CU55OftCDL9/RDC1tZrilOBe1k7Yi/PNuhilQA+IePHWRPJxGrG/kj
         MXeRZ108EpGx3UUx5BgV7f4E0LR81uuUwUhXqiVvDaQeCHNZP4XPFdf4AMXmhZ7nLXoz
         16XS0neHY/0Ky1BwxhbkTHohwG+y1CS7fPVLN5LJ6fjQrJKmXmQ8z7yiqnTfqIhZg6Ap
         6tCia72b9Eqmi9graJkINbhroi8tLipiC7CGaONcYXBMMUi/KHINmc1uEMc1OHdKfYUe
         C4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ze6D36/kwBREuF6/gfi58IYUCsOdlWcgYm0NXdZrSio=;
        b=dXvK6Ll5FtbHJ59caGSMMLE6INAq2sbncWDQt5vF8BJ2/AGobywS2nR000gv4xX7zQ
         BXV8fGfWH5NDZKMkE4sMoho5wOBkpIugRbYKoYFd0M5Br9dIhNPqkyUT4LhTUrWHB/iX
         S32OtRzhroWqe6VoWqVz6m+gDy1qYxsosqJqffoPEdF9YZv0JhENQ2nnca7V3da7Jtgv
         oFkGtW7JJ3TQH6/IAqV1nB6r3H2BDJftqiW9lZnrzXviwDEZL6Fel8Ls8KkR330y/jEV
         W5dbV2GfyuPLPrrZHXlk4A9vlgJPPGmnBZBZd9ga20Gbf+LHgdXvVvZvrE464zmmHJF8
         uUiA==
X-Gm-Message-State: AOAM530r8WhhP3++CrYVcCer5zDvTq+q0X0btvdQkMipkq3IGuFYuFX7
        2SXWV1AXhpNI93qPxS7Mmc4=
X-Google-Smtp-Source: ABdhPJwhXRDHBNP+3AkXCjaBW4ZTT/UMKeQshgDsoWcUe7i792XGRjAU09cS1VUSvjee0NbX2Ajxgw==
X-Received: by 2002:a17:906:f148:: with SMTP id gw8mr7866603ejb.192.1604779766302;
        Sat, 07 Nov 2020 12:09:26 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:6c5a:4211:18a4:b21e])
        by smtp.gmail.com with ESMTPSA id b12sm4121403edj.12.2020.11.07.12.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 12:09:25 -0800 (PST)
Date:   Sat, 7 Nov 2020 21:09:24 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
Message-ID: <20201107200924.fpybgapomro4xzxe@ltop.local>
References: <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
 <20201105215023.wvekadtkdwgz7yim@ltop.local>
 <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
 <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
 <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com>
 <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
 <20201106221917.n3is2fnud7jqa3x5@ltop.local>
 <CAHk-=whbo09hM0xW-qDLsZF4XunVDs5YwzH7a5G=5O+0qrPy_A@mail.gmail.com>
 <20201107013255.xpsfeamyco7ggnru@ltop.local>
 <CAHk-=wj0rBc0o_-u9H5_4-ZUnPOx-be3c1Dd-_WBWfPzEQtKRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj0rBc0o_-u9H5_4-ZUnPOx-be3c1Dd-_WBWfPzEQtKRQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Nov 07, 2020 at 11:39:42AM -0800, Linus Torvalds wrote:
> On Fri, Nov 6, 2020 at 5:33 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > So, I think that the next questions are:
> > * which selects should be moved up?
> > * up to where should them be moved?
> 
> Honestly, it's not even clear they should be moved up. It could be
> moved down too, particularly in this kind of case where there is only
> one user of the result (ie move it down to just before the use).
> 
> Moving down to the use is in many ways is much easier than moving up,
> because then you don't need to worry about whether the sources to the
> select have been calculated yet. No need for any dominance analysis or
> anything like that for that case.

It's just that in my experience, in these situation with context
imbalance, very often 'something' had to move up, just before the
'if' where the imbalance is created.

> But my personal guess is that by default we shouldn't try to
> excessively move instructions unless we have an actual reason to do
> so.
> 
> So I don't think your patch a good simplification in general.
> Particularly the "move up" part, when you might just end up doing an
> entirely unnecessary select that would normally have been done only in
> some unusual conditional case.

I totally agree with this.
 
> Now, instead, I think the proper select simplification is to tie it
> together with the conditional branch. Look at what I had after the
> other select simplifications:
> 
>     .L0:
>         <entry-point>
>         cbr         %arg1, .L5, .L4
> 
>     .L4:
>         call        spin_lock
>         br          .L5
> 
>     .L5:
>         # call      %r4 <- errno, %r1
>         select.32   %r6 <- %arg1, $0xffffffff, $0
>         cbr         %arg1, .L6, .L2
> 
>     .L2:
>         call        spin_unlock
>         br          .L6
> 
>     .L6:
>         ret.32      %r6
> 
> and notice that
> 
>         cbr         %arg1, .L5, .L4
>     .L5:
>         select.32   %r6 <- %arg1, $0xffffffff, $0
> 
> sequence. In particular, notice how we have a conditional branch to a
> "select" that has the *same* conditional as the branch!

Yes, once the SEL(SEL(x,C,0),C,0) is handled this all simplify to
	.L0:
		 <entry-point>
		 select.32   %r6 <- %arg1, $0xffffffff, $0
		 cbr         %arg1, .L6, .L4
	.L4:
		 call        spin_lock
		 # call      %r4 <- errno, %r1
		 call        spin_unlock
		 br          .L6
	.L6:
		 ret.32      %r6

but to me, this seems a very very special case, so not much interesting.
 
> So I think the *proper* fix is to not think of this case as "move the
> select", but as a special case of branch following: the same way that
> a conditional branch to another conditional branch can be simplified
> if the condition is the same, you can simplify the case of
> "conditional branch to select with the same condition".
> 
> That said, that "proper fix" looks a bit painful. My gut feel is that
> we shouldn't have generated that "select" in the first place at all.
> We should have kept it as a conditional branch, then done branch
> following, and done the whole "turn a branch-over into a select" at a
> later stage.
> 
> Have we done that if_convert_phi() simplification too early?

Absolutely. I've often observed that it inhibits other simplifications
related to conditionals. And, even when it doesn't, I think that many
select simplifications would already be handled at SETxx + CBR level
(like your previous SEL(x,x,0)).

So, yes, the if-conversion is a very valuable simplification but I also
think it's done too early. And there are some other simplifications that
are valuable but only if not done too early (sorry, I've no concrete
examples at hand). It slowly begins time to organize the optimizations
in several phases.

-- Luc
