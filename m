Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C3BC433FE
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 18:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E9422B2E
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 18:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgLDSQa (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 4 Dec 2020 13:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgLDSQ3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Dec 2020 13:16:29 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C0C0613D1
        for <linux-sparse@vger.kernel.org>; Fri,  4 Dec 2020 10:15:49 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so8926517lfh.2
        for <linux-sparse@vger.kernel.org>; Fri, 04 Dec 2020 10:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfW7nC/Km02pcGLzusB+nZMBbs+X8EPyMTxJXshX3vs=;
        b=XIHX9Jn0nL6M/htRxRc1/3CBpxGd1oIB2qijXkjhtvOeyDUhPEQqn0JDj/rhIAcRJ1
         u4/A4uwvL3XVmCDYROqmV2wZf0uy+PAwrIHsginb2eeS7iYSIfGiMpYR25OnWPT+f9kt
         hqLKc8v7RxaxyLj3/VDdR1mBm9191BnUTVzxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfW7nC/Km02pcGLzusB+nZMBbs+X8EPyMTxJXshX3vs=;
        b=lHfIG8B1FKMTicJ9e/YWt7wPB1VigHd5KSvqcbQoYPxVMRpce6ThFW8NLidunbRuuQ
         p+Rni/2Z1oyHeFFt1F6wxIt6JikAae6l6p+/o6ipXVW+hPznKCeGLHvHh+QeiWXCWJfZ
         93Bo4qQrPt8Z+fF9NYy8fkCaOruA4x5Dc7Yek2MJULkcVHFbkzMPY17LBxcpGRgMUL42
         BZjAObKxUYRlIQFaN9oexvV3keggf73ygHTwlQUCeiY/sEphc9JnCwf5AHdW3HWfE1Rk
         9b33lUVk0o5eGhWRvvabPD6lX8X+JBKf7U1OHPNAxxyW2OCgFnek8SIKIh4zQiYd65ig
         pk1g==
X-Gm-Message-State: AOAM533temt9EqlG8XbAnyh0yu+PwMLRztCbpz3HBqh/lGrQguoS4Zuv
        3/7+Kg1iiOqFlsKL4N4ruOWLHM1DiwwTvg==
X-Google-Smtp-Source: ABdhPJwQR+CsFMeYVYC8wpQ/qIzrqyRR93bsU59xWqN1CJGd1b0y2jWPEIpQ14B/gQPlyayxD8cl4w==
X-Received: by 2002:a19:f702:: with SMTP id z2mr3557265lfe.257.1607105747504;
        Fri, 04 Dec 2020 10:15:47 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id l16sm1982584ljb.69.2020.12.04.10.15.46
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 10:15:46 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id j10so7618512lja.5
        for <linux-sparse@vger.kernel.org>; Fri, 04 Dec 2020 10:15:46 -0800 (PST)
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr3924366ljj.312.1607105746100;
 Fri, 04 Dec 2020 10:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20201204163315.68538-1-luc.vanoostenryck@gmail.com>
 <CAHk-=witmTznTY4oH7KDr7aTufXey17w1fTaTBiMChk+4NUQ1Q@mail.gmail.com> <20201204174502.5wkqf7xashx2poet@ltop.local>
In-Reply-To: <20201204174502.5wkqf7xashx2poet@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Dec 2020 10:15:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh15fTgsd+D7_goVzZY3NFPVke8ENTPtUdu5HYi2Pkgbw@mail.gmail.com>
Message-ID: <CAHk-=wh15fTgsd+D7_goVzZY3NFPVke8ENTPtUdu5HYi2Pkgbw@mail.gmail.com>
Subject: Re: [PATCH] experimental: code sinking
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Dec 4, 2020 at 9:45 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> > There might be cases where instruction sinking makes sense even
> > outside the "can we empty this bb entirely" issue. Not that I can
> > think of any, but I wonder if this could be used to actually shrink
> > liveness regions (if both the inputs to the sunk instruction are live
> > _anyway_ at the target, then sinking the instruction should actually
> > improve liveness in general, for example).
>
> I don't think I understand this. In the case of an UNOP, sinking it
> increase the liveness and decrease the liveness of the output, so
> it should not matter much.

Right. The UNOP case should be a no-op from a liveness perspective, but:

> In the case of an BINOP or select, sinking
> it will decrease the liveness of the unique output but increase the
> liveness of the inputs. So, it seems to me that sinking would
> globally increase the liveness (contrary to moving up instructions).
> Am I missing something?

No, moving a binop could actually *shrink* liveness under the right
circumstances - namely when the sources of the binop are live
regardless.

Completely stupid example that makes no sense, and only exists to
illustrate the issue:

    int diff(int x, int y);
    int fn2(int x, int y, int sum, int diff);

    int test(int x, int y)
    {
        int sum = x+y;

        return fn2(x, y, sum, diff(x,y));
    }

which generates

    add.32      %r3 <- %arg1, %arg2
    call.32     %r9 <- fn1, %arg1, %arg2
    call.32     %r10 <- fn2, %arg1, %arg2, %r3, %r9
    ret.32      %r10

but it would actually improve liveness if that "add" was moved down -
because even though it "expands" the liveness of %arg1/arg2 by moving
the use of those down, both of those argument pseudos have later uses
_anyway_. So that expansion of liveness is a non-issue.

Instead, it shrinks the liveness region of %r3. Ergo, it actually
shrinks liveness region in the big picture.

Now, the above stupid example is one single bb, so in that sense it's
not really relevant for your inter-bb movement, but that doesn't
actually change the argument at all. Insert a conditional in there to
get a multi-bb case.

              Linus
