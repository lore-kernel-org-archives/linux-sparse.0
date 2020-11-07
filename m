Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA2FC388F7
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 20:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E626620B1F
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604781252;
	bh=Xi78biNhkBTrXNmCOiSMelJM3amdGF5dxxUkz6fyrNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=leXo+atFdlRgKHYqbB3UjQKJhnCpzqjlXnNtkfBcK4vR8QghyijrqncRQPuWJtsjn
	 EW/aR0CVsKWbYaSfmAbNT2spuxALOGLG1Ar2bCFgoSHWXRzyLASSbyrWNIG8Sl52tZ
	 P5hFaSnqohRGDlTgNU6TQ2OtBmxfHhOEWYPQgg0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgKGUeM (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 15:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKGUeM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 15:34:12 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D404DC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 12:34:11 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d17so3408142lfq.10
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 12:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYfweZ0yGtZtP8NrhE1B3VK9FnVt205QizMf2PywpBk=;
        b=VPQFt4bBOGPxEp8LwxNLgWeEqMlaXbdeojhj6Sf3hqsj4/YctlF7w870ALV7KsTFyI
         cTjvGyrl/JxQK8igXbyukrK18nNrapcGw9s01ECwr+cqPmngy3qORtSx1VPNJ9N2WX/v
         o7e1dzzuhzJL8hOdK/ZrC4auTaxGl/ylQdHqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYfweZ0yGtZtP8NrhE1B3VK9FnVt205QizMf2PywpBk=;
        b=jfv661Ma2j3ioet97UL1kV3xAAt1dmnFG3j1vmrTIJgnkExENGFJoK+WBH5oGOPI+l
         4UR1M2Gt5pBIKL7BZ/7NpKEVIiFrBJ77EXdubNikHA/ZhzvSIlHk7NQu4d6Rr8I5air5
         mYSS/Q+xu8aIx2a4guuEw7Zqe+WfW/MlD1lr2WYXMJuIy/N7nChT6zbrx2tDnB2P0veA
         NTL5L2TMcNWFd0uWqrJKF0C235//F2t14irn6IiXDWpdkHglBRq8mPnHfJXnlM01D4QC
         pMs/LctiJvf/EDD4xUtrPt3s9stNl4rN2JAPmTBLw03YY1bdDhF/14s46itubQO6+ZlP
         GV5g==
X-Gm-Message-State: AOAM531GvJB1hSdmR82ruTYvepwS61Mv9Sk4l6yt+TEQl3sPIOEj1CcA
        4VPph1pVC/WtEXIlTKTvQaWyugL8n3RKug==
X-Google-Smtp-Source: ABdhPJyQyomfRHQgM49Bo9aaKr6c1lf08/wu+IkIMc4rPsYGGOZblxygsSwyn4+7i3OuYBVh4AiPcg==
X-Received: by 2002:a05:6512:3606:: with SMTP id f6mr1006171lfs.12.1604781249731;
        Sat, 07 Nov 2020 12:34:09 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id m22sm681195lfb.27.2020.11.07.12.34.08
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 12:34:08 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id a25so5348318ljn.0
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 12:34:08 -0800 (PST)
X-Received: by 2002:a05:651c:110:: with SMTP id a16mr3251237ljb.285.1604781248210;
 Sat, 07 Nov 2020 12:34:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
 <20201105215023.wvekadtkdwgz7yim@ltop.local> <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
 <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
 <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com> <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
 <20201106221917.n3is2fnud7jqa3x5@ltop.local> <CAHk-=whbo09hM0xW-qDLsZF4XunVDs5YwzH7a5G=5O+0qrPy_A@mail.gmail.com>
 <20201107013255.xpsfeamyco7ggnru@ltop.local> <CAHk-=wj0rBc0o_-u9H5_4-ZUnPOx-be3c1Dd-_WBWfPzEQtKRQ@mail.gmail.com>
 <20201107200924.fpybgapomro4xzxe@ltop.local>
In-Reply-To: <20201107200924.fpybgapomro4xzxe@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Nov 2020 12:33:52 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgCTM2HWeVFTvg7Dg1UQeYn1Md49e8VGCWELWq=c15_qg@mail.gmail.com>
Message-ID: <CAHk-=wgCTM2HWeVFTvg7Dg1UQeYn1Md49e8VGCWELWq=c15_qg@mail.gmail.com>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Nov 7, 2020 at 12:09 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Yes, once the SEL(SEL(x,C,0),C,0) is handled this all simplify to
>         .L0:
>                  <entry-point>
>                  select.32   %r6 <- %arg1, $0xffffffff, $0
>                  cbr         %arg1, .L6, .L4
>         .L4:
>                  call        spin_lock
>                  # call      %r4 <- errno, %r1
>                  call        spin_unlock
>                  br          .L6
>         .L6:
>                  ret.32      %r6
>
> but to me, this seems a very very special case, so not much interesting.

Oh, ok, so just fixing the missing simplification does actually fix it.

And I'm not sure how special-case this is. Because I think we _do_
actually generally doing the if-conversion "later", even if it's not a
separate phase, simply because we end up doing it at the "OP_PHI"
instruction, which should always end up linearizing after the branches
that should have been simplified.

So sometimes the ordering can be simply due to the order we see and
react to instructions.

> > Have we done that if_convert_phi() simplification too early?
>
> Absolutely. I've often observed that it inhibits other simplifications
> related to conditionals. And, even when it doesn't, I think that many
> select simplifications would already be handled at SETxx + CBR level
> (like your previous SEL(x,x,0)).

Yeah, the problem with doing multiple passes, though, is that you
inevitably end up wanting to repeat them, because a later phase will
cause you to be able to then do earlier phases again.

So there's never any one "correct" order to do things in, and I think
you always end up with those "oh, unlucky, we did that one
simplification that then made another one harder" regardless of what
you do.

Although we do already have "passes" with some things clearly done
before others (like turning symbols into pseudos before doing any
other optimizations). But those tend to be very clear "convert the
tree into the proper format for the next stage", not this kind of "one
optimization then causes/hinders others".

            Linus
