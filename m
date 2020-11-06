Return-Path: <SRS0=gthx=EM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E1DC2D0A3
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 19:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDE62151B
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 19:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604691863;
	bh=DdCpTprnO1ZI6JKFQr8PD4d7/Bd3T2Y8fb/hNNN1WY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mbraBFr8baGyx+9Jp1NmsdxJ0b6ihG2XfRritz5F7l2BYqpdTkFDGLNxXp4g9tWLW
	 PAxEUUNASUrVqb7uU7yAfVdQo/ZU59O53KcoSAH5aCeHJ52wT9Hg7iF0PdsmjfGEJ3
	 JJ90tp3MjFngDglsnHwBk5sTT8nDnZT0u8dI130I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgKFToX (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 6 Nov 2020 14:44:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFToX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Nov 2020 14:44:23 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C48AC0613CF
        for <linux-sparse@vger.kernel.org>; Fri,  6 Nov 2020 11:44:21 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id a25so2641747ljn.0
        for <linux-sparse@vger.kernel.org>; Fri, 06 Nov 2020 11:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZeVm4Vn1vgo+vYJ/eMNCkFqR1hi5MA41DoIbZO5It3Y=;
        b=c9b1+yx5SnDHTVHySrbkdGojeRGlYBuFsAALAeShOTw3KvfvBjYc/cXDY0LlEgC2s4
         +itQpm5F/+WCeZOKxBIix6O+SyXpTuZTbl1jhEL41zEXux+reKoIasMgV0MHI1XxfezO
         IWpTkTwsIcbNZ66XJYZ9bQt4ahQ9Me9iH4+uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZeVm4Vn1vgo+vYJ/eMNCkFqR1hi5MA41DoIbZO5It3Y=;
        b=IfIno9CHUmL4sKD4lsk66PW9lddJOWTC0Y55T0JEMqdtfKDNGAS8Gv2GUbkxNrCCY1
         K0ZTNWX7LwDPPMuLivpYs34HH4PqRA3GMDqT3crhXIJVrIqJD7zTVP0hLpETvROwSB6o
         fu0RafZyhEwq8xJ9FPdLV05/LnixrJRCNMKGc/QopSdlMqf+vZbJLzXm5QMz68AJ0zEg
         shIPDQxwFaof0FeKnflTptH8jAYnFf8bnfr1TFEw+kuZM7jcTIzA1iLoR65FTuQPQ70D
         aG92zu1O7nrq6cFRVC/1lSaaMEDItcefgh3nntvJJpPFaIMD3u4KBILr3AVVcH1L6M55
         CHew==
X-Gm-Message-State: AOAM530T3cuk1g9kvjiFrkhIpuI4PABzeL1d6nbWwlWs+k6+SjztftXA
        v1DOslc9c/IHhRhVjuqGo8US97lu0psqLg==
X-Google-Smtp-Source: ABdhPJwxZlUVj6CjBqN9LM4HazzS1cNfU/mXxb9fY9d3EQBheHKhTp8+oqUSTbIDeAuzR+W0OozM/g==
X-Received: by 2002:a2e:740d:: with SMTP id p13mr1150557ljc.306.1604691859355;
        Fri, 06 Nov 2020 11:44:19 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id b15sm237053ljk.33.2020.11.06.11.44.17
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 11:44:17 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id v144so3484447lfa.13
        for <linux-sparse@vger.kernel.org>; Fri, 06 Nov 2020 11:44:17 -0800 (PST)
X-Received: by 2002:a05:6512:3317:: with SMTP id k23mr1327585lfe.352.1604691857100;
 Fri, 06 Nov 2020 11:44:17 -0800 (PST)
MIME-Version: 1.0
References: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com> <20201105211342.6mglug2a74bi5hvd@ltop.local>
 <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
 <20201105215023.wvekadtkdwgz7yim@ltop.local> <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
 <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com> <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com>
In-Reply-To: <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Nov 2020 11:44:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
Message-ID: <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
Subject: Re: "warning: context imbalance" in kernel/bpf/hashtab.c
To:     Song Liu <songliubraving@fb.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Nov 6, 2020 at 11:05 AM Song Liu <songliubraving@fb.com> wrote:
>
> Thanks for your suggestion! This pattern didn't trigger the warning.
> We still need some work to apply this to actual code, because the lock
> part is in an helper:
>
> inline int htab_lock_bucket()
> {
>         if (some_condition)
>                 return -EBUSY;
>         spin_lock();
>         return 0;
> }

So inlining does end up being important, because then sparse can see
the pattern in the caller.

But yes, as-is you end up with the same issue that sparse then may not
be able to see the "return value goes together with the spinlock".

That said, in the form you have it now in, it might be easier for
sparse to see that, by just adding a branch following phase.

Branch following is much simpler than value analysis, but "much
simpler" is still not the same as "entirely trivial".

Here's a test-case for this behavior for sparse, in the hope that Luc
goes "that's easy enough to do":

    extern void spin_lock(void);
    extern void spin_unlock(void);

    static inline int errno(int arg)
    {
        if (arg)
                return -1;
        spin_lock();
        return 0;
    }


    int cmp(int i)
    {
        if (errno(i))
                return -1;
        spin_unlock();
        return 0;
    }

and right now sparse linearizes this to

    cmp:
    .L0:
        <entry-point>
        select.32   %r4 <- %arg1, $0xffffffff, $0
        cbr         %arg1, .L5, .L4

    .L4:
        call        spin_lock
        br          .L5

    .L5:
        # call      %r4 <- errno, %r1
        select.32   %r6 <- %r4, $0xffffffff, $0
        cbr         %arg1, .L6, .L2

    .L2:
        call        spin_unlock
        br          .L6

    .L6:
        ret.32      %r6

because sparse isn't smart enough to do a couple of simple optimizations:

 (a) the conditional following for the return value:

        select.32   %r4 <- %arg1, $0xffffffff, $0
        select.32   %r6 <- %r4, $0xffffffff, $0

Note how it doesn't trigger CSE, because it's not the same instruction
(%arg1 vs %r4), but sparse *could* see that a select that depends on a
previous select that has constant arguments can be simplified to be
conditional on the original select value instead, so it *could* be
CSE'd into one single thing.

So the second "select" could be optimized away by realizing that it
really gets the same value as the first one. That *should* be trivial
to do in sparse by just having a simple pattern for select
simplification.

And once that optimization is in place, the second optimization would be

 (b) trivial branch following: "conditional branch to conditional
branch with the same condition".

ie we'd have the pattern of

        cbr         %arg1, .L5, .L4
        ...
    .L5:
        cbr         %arg1, .L6, .L2

and now a trivial branch following optimization would see "oh, the
first target of the first cbr is to another cbr that has the same
condition, so we can rewrite the first cbr as

        cbr         %arg1, .L6, .L4

instead.

And once you've done that trivial branch following, the .L5 target has
only that fallthrough source from .L4, and the code becomes

    cmp:
    .L0:
        <entry-point>
        select.32   %r4 <- %arg1, $0xffffffff, $0
        cbr         %arg1, .L6, .L4

    .L4:
        call        spin_lock
        cbr         %arg1, .L6, .L2

    .L2:
        call        spin_unlock
        br          .L6

    .L6:
        ret.32      %r4

which still isn't good enough, because it still has that conditional
branch that is now pointless.

Removing the second conditional branch entirely would require having a
"look, it's now dominated by a previous conditional branch on the same
condition, so it can't trigger".

That's the only remaining optimization that isn't purely local.
Dominance analysis is always painful. sparse does do it (for memory
accesses), but it's a *lot* more complex than just some local
single-instruction pattern that looks at the source or the target of
that single instruction.

Anyway - this is all doable, but it's the end of the week so my pull
requests for the kernel are starting to pile up and I already spent
more time than I should have at looking at sparse.

Maybe this gives Luc some ideas, though.

Or maybe Luc will point out that even my "simple" optimizations are
slightly more painful than I think they are for some reason that I
haven't looked at.

              Linus
