Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF77C433FE
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 17:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D0E22A83
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 17:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgLDRpv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 4 Dec 2020 12:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgLDRpv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Dec 2020 12:45:51 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58455C0613D1
        for <linux-sparse@vger.kernel.org>; Fri,  4 Dec 2020 09:45:10 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ce23so6102441ejb.8
        for <linux-sparse@vger.kernel.org>; Fri, 04 Dec 2020 09:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e8RzPgScIY0qoxSEhVG5lUFSm3d8pfDvIHCQ7otH9Ew=;
        b=ZTw1RIXtmrEjm8vwFSypX4lj1e8SS4cJJgbgxUcBNmZ6DMMnJgv0n2YAYKWSub6W3e
         ipqPcxOqORgyUkix5rPY8JF7uXthPm+5SOJrkN4XdwJyP66AB1LsPCaSzbe/ka5AalPR
         qNRHDZb8LSTgD0Gipauda1ngZ84BiOIPaysZKTJjvvWojNxm32aVfUbaRx4+EoCWvQj7
         oMnhtQ3Bxrce53b8gWz3cUJO9q/GKxdPDO9qmcrKgOelzXJu0yKWd6koY9/4dQ8rzBHd
         hhWuA8QMHyETU30jFEwKBfaRQTzWV3uzkuvVRh+7NM4BLVw8Db0B9qhyd9NrkLhpVF4/
         /bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e8RzPgScIY0qoxSEhVG5lUFSm3d8pfDvIHCQ7otH9Ew=;
        b=PIethwWEviQfqA8KU6GqSAxzFHAYyHrxR0+869pV/RTChix0hwMP9v1wGKOZcWgvry
         JxPpPUkiVrh1ZjhMjOxlONcnfz2CwwTtm45jks0b718WikQ38DXbP/TVBLpKTz68HL7u
         EDDHT5T+RePuOfTZlAwiCyedI6iO1CX4vGxDunRp0V77oGNIcfFACrliOKONHe2tNQLf
         IzctJns1UnwxsYQjnhpZ2YsqOgAb8ZKgjs/ofemXBfX7dJSqt1ejjRyVfxWJd2KP/dmR
         ckHc8JN8Y0DdcHGl9kga02rjBJiXHr2qjO25JKsGKMznUNij9h+mMJO1Hj5Ot9fABfxy
         wvhg==
X-Gm-Message-State: AOAM532fSM+IpIT+mGoWz8Don9NM1TlUHFI4RBbcZgYt+6k6DSb6yx9r
        L10MppOBcIbsRZ0G0qqIPWenUhNja4Q=
X-Google-Smtp-Source: ABdhPJxxz4ZjbbFy4xv5t9HtLuYhgO8S8ackB/WooZ8sHLWS0BcFLEECGPD+YNLhOn7zRvEK/C/xMw==
X-Received: by 2002:a17:906:e24f:: with SMTP id gq15mr6700726ejb.256.1607103909037;
        Fri, 04 Dec 2020 09:45:09 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:8183:34c1:3ce4:9984])
        by smtp.gmail.com with ESMTPSA id q24sm3905482edw.66.2020.12.04.09.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 09:45:05 -0800 (PST)
Date:   Fri, 4 Dec 2020 18:45:02 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] experimental: code sinking
Message-ID: <20201204174502.5wkqf7xashx2poet@ltop.local>
References: <20201204163315.68538-1-luc.vanoostenryck@gmail.com>
 <CAHk-=witmTznTY4oH7KDr7aTufXey17w1fTaTBiMChk+4NUQ1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=witmTznTY4oH7KDr7aTufXey17w1fTaTBiMChk+4NUQ1Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Dec 04, 2020 at 09:13:50AM -0800, Linus Torvalds wrote:
> On Fri, Dec 4, 2020 at 8:34 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > A lot of the false 'context imbalance' warnings are caused by
> > a potential jump-threading being blocked between 2 conditional
> > branches on the same condition because the second CBR belong
> > to a non-empty BB. Often the offending instructions can be moved
> > to some other BB, sometimes even with some added advantages.
> 
> I hope you don't just use the context imbalance as a sign of this
> being a good idea, because a lot of the context imbalances are likely
> real and valid.

Not exactly, but I confess that currently I'm focusing a lot on the
'*false* context imbalance' (those I can see in the C code or in
the IR that should be OK but sparse warning on them nevertheless). 
I've not a very clear idea of how much of those warnings are real
(but I'm begin to think more and more than most are real).

By far, the most common cause of these false warnings is a CBR-CBR
on the same condition that is not simplified away because the second
one is not empty.

> I do think moving the instruction to the (single) user sounds like a
> good idea in some cases, but I'm a bit worried about doing it quite
> this mindlessly. It can expand on liveness a lot - while the liveness
> of the result of the sunk instruction shrinks, the liveness of the
> sources to the sunk instruction can grow a lot.
> 
> That's obviously a non-issue for the use of sparse as an analysis tool
> (and that's clearly the primary use), but I'd still like to think that
> code generation might matter.

Yes, I agree for both points.

> So I think this might be better with more heuristics. And explaining
> them. Right now you have one heuristic: you only sink instructions
> from bb's that end with a conditional branch. I'm not entirely sure
> that I understand the reason for that heuristic, it smells a bit
> arbitrary to me (I suspect it was the case you saw when looking at
> examples).

Yes, indeed, it's arbitrary because it's the only case I'm interested
about for these 'false context imbalance'. But no worries, as explained
in the patch description, it's not my intention to merge this, certainly
not as-is. It's more a kind of experiment to play with, a kind of
exploratory tool.
 
> On that note: would also be lovely to actually see examples of what
> this results in - and not necessarily about just the context imbalance
> again.

Yes, I'll add this (but I'm not sure to have anything significant
not related to emptying a BB ending with a CBR).

> There might be cases where instruction sinking makes sense even
> outside the "can we empty this bb entirely" issue. Not that I can
> think of any, but I wonder if this could be used to actually shrink
> liveness regions (if both the inputs to the sunk instruction are live
> _anyway_ at the target, then sinking the instruction should actually
> improve liveness in general, for example).

I don't think I understand this. In the case of an UNOP, sinking it
increase the liveness and decrease the liveness of the output, so
it should not matter much. In the case of an BINOP or select, sinking
it will decrease the liveness of the unique output but increase the
liveness of the inputs. So, it seems to me that sinking would
globally increase the liveness (contrary to moving up instructions).
Am I missing something?

-- Luc
