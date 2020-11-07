Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA86C388F9
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 21:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0BF3206DB
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 21:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cwt7UwF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgKGVXb (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 16:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGVXb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 16:23:31 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00939C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 13:23:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id w13so6837591eju.13
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 13:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B3Y6iPhGH7+VAA4dnO3Zsyik8+g/i/Femh7OnMWM1Jo=;
        b=Cwt7UwF0DHS8ZhipVqGrQSye9Rl0jFmVd44JTgvr5vUQIvpcaNzgVYHrG4o1Yzv/WL
         8pI7YeD59jWGvCVblTmwjqaievy7TZsakd8QKB2fR2rN5fwaCh0T+Pm2AgZ+3l3ZKfWh
         EoksI9mwrDGjj4PRD/q2qsl+wEHtDRd8YEn03h6742GDcjLtWih1Rf4cqBtGIPpEKUIS
         vaUNlghUHDG4xHN27i0RtlJZMOePHCvOgoYeWq4xGMBSgp/tJZURVhkLTQnwtn2pZ5wa
         2o5JQU8lyUpfmFWCbfAjwac3Z3oJ98eKe4BMiYnpLbJ4iENi8CvtPz60aZq/gFNV93vO
         Svmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3Y6iPhGH7+VAA4dnO3Zsyik8+g/i/Femh7OnMWM1Jo=;
        b=BovgdtZbTcsQacLpQWZH+pzfGMzMVzMtUy35OlToPcheO5LoQiE1D51UiPs7r4DQ5h
         QO0ZuvyA05ybr9S7YIvRdZ0dqrXvIZQhE3tkeGIQce3+CCN4PobAmMEgkB1n5wLq5zxG
         huySlhudxYtWtPx5bmlFB2p+HIs6t1qQeUgUR9j3kl4FYlJuhChN906CJOFReF/tl6JH
         Kxmv30l2qYWcDl/XAHXqZ1nLvISJVkcAgIFrpO/1n7OXHnAwFHsthtbIrp1l42qFeBRo
         WFddKa/tBUyly5OAsjZhSuxo2jXkWM3MSdd8q2RwRdWnWqO6TaEfd4EVZ6Pj7SfTSaxP
         AISg==
X-Gm-Message-State: AOAM532/wa0f4myncZ7gf/MAJRzZL5XJCNUiCgh/RSnGURB8T11t/DG8
        tYjKEcb0LUOljvqYkLcM1+A=
X-Google-Smtp-Source: ABdhPJzRCfaZjwCKcmHgohHCbJ/00aytSJKSunQk6XA5aZKZtQTE1RmtPt7F9ItO+bCut+MAg/7LsQ==
X-Received: by 2002:a17:906:adcd:: with SMTP id lb13mr7818448ejb.362.1604784209727;
        Sat, 07 Nov 2020 13:23:29 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:6c5a:4211:18a4:b21e])
        by smtp.gmail.com with ESMTPSA id a9sm4289790eds.50.2020.11.07.13.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 13:23:28 -0800 (PST)
Date:   Sat, 7 Nov 2020 22:23:27 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
Message-ID: <20201107212327.js6dlr2tuzey4kz6@ltop.local>
References: <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
 <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
 <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com>
 <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
 <20201106221917.n3is2fnud7jqa3x5@ltop.local>
 <CAHk-=whbo09hM0xW-qDLsZF4XunVDs5YwzH7a5G=5O+0qrPy_A@mail.gmail.com>
 <20201107013255.xpsfeamyco7ggnru@ltop.local>
 <CAHk-=wj0rBc0o_-u9H5_4-ZUnPOx-be3c1Dd-_WBWfPzEQtKRQ@mail.gmail.com>
 <20201107200924.fpybgapomro4xzxe@ltop.local>
 <CAHk-=wgCTM2HWeVFTvg7Dg1UQeYn1Md49e8VGCWELWq=c15_qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgCTM2HWeVFTvg7Dg1UQeYn1Md49e8VGCWELWq=c15_qg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Nov 07, 2020 at 12:33:52PM -0800, Linus Torvalds wrote:
> On Sat, Nov 7, 2020 at 12:09 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Yes, once the SEL(SEL(x,C,0),C,0) is handled this all simplify to
> >         .L0:
> >                  <entry-point>
> >                  select.32   %r6 <- %arg1, $0xffffffff, $0
> >                  cbr         %arg1, .L6, .L4
> >         .L4:
> >                  call        spin_lock
> >                  # call      %r4 <- errno, %r1
> >                  call        spin_unlock
> >                  br          .L6
> >         .L6:
> >                  ret.32      %r6
> >
> > but to me, this seems a very very special case, so not much interesting.
> 
> Oh, ok, so just fixing the missing simplification does actually fix it.

This case, yes. And I suppose will solves the problem Song had.
But, for example, none of the select simplifications I posted
yesterday (not the 'move-everything-up', of course) have any effect
on v5.10-rc1. I mean, I'm sure it they have some effect on the
generated code but not on the context imbalance warnings (or any
other warning).

> And I'm not sure how special-case this is. Because I think we _do_
> actually generally doing the if-conversion "later", even if it's not a
> separate phase, simply because we end up doing it at the "OP_PHI"
> instruction, which should always end up linearizing after the branches
> that should have been simplified.

Yes, but the branch simplifications depend on the simplifications
that can be made on the condition. For the moment there is a focus
on select because it often happens when the condition is simple but
for these context imbalance the general case is something like:
	stuff
	if (arbitrary condition)
		take lock
	do other stuff
	if (same arbitrary condition)
		release lock

and the problem is (at least) twofold (but partially related):
1) recognize that the second condition is the same as the first one
2) avoid that partial optimizations of the first condition 'leak'
   into the common part because this often inhibits doing 1)
   [Sorry, if this is not very clear. I need to find some small
    examples to illustrate this].

When the condition is very simple, it is converted into a select
but very often it's more complex, involves a memory access and/or
some function calls or some asm.

 
> So sometimes the ordering can be simply due to the order we see and
> react to instructions.
> 
> > > Have we done that if_convert_phi() simplification too early?
> >
> > Absolutely. I've often observed that it inhibits other simplifications
> > related to conditionals. And, even when it doesn't, I think that many
> > select simplifications would already be handled at SETxx + CBR level
> > (like your previous SEL(x,x,0)).
> 
> Yeah, the problem with doing multiple passes, though, is that you
> inevitably end up wanting to repeat them, because a later phase will
> cause you to be able to then do earlier phases again.
> 
> So there's never any one "correct" order to do things in, and I think
> you always end up with those "oh, unlucky, we did that one
> simplification that then made another one harder" regardless of what
> you do.

Yes, sure, I think it's in general inevitable. But I think that for the
if-conversion here it wouldn't be much of a problem because, in itself,
it doesn't create other 'functional'/value-related simplifications.
It only may create an empty BB that can then be simplified away with
some branch simplifications. Maybe I'm just an optimist.

But sure, it's hard to predict exactly the effect. I should experiment
a bit to see the impact on quality, complexity and time.

-- Luc
