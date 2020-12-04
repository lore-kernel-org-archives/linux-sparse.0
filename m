Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49824C4361A
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 20:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D419722B40
	for <linux-sparse@archiver.kernel.org>; Fri,  4 Dec 2020 20:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgLDUYM (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 4 Dec 2020 15:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgLDUYM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Dec 2020 15:24:12 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD7DC0613D1
        for <linux-sparse@vger.kernel.org>; Fri,  4 Dec 2020 12:23:31 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id ck29so7139016edb.8
        for <linux-sparse@vger.kernel.org>; Fri, 04 Dec 2020 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40vRTN09h4HvPLAfLfqSdTJiFyD7/u7Gq51vSeEeGRQ=;
        b=ePpLkFiW8Lk5LWFngqbA8Aw7C80OYtImKs7/AKo0yRocwya9RWrCHw+IYVZuf3fAnh
         ls+cp0DHp0Q9WIaRLQHy6i04oID2j5ZSA//LVprGePieXQYlsYDB3KYE1oED20k6RuHS
         YWTk3SH6q5AkVgE3/8V2iehf2gCA9qoe3wKk/7RWLFtqpY3eN53q/YpnZ/PZHvZyTUnX
         nqdr4D1U/WYk4kI/2N7gvgzJ53Kzt6AcN+kJN0jFDIxOUM1wJz4m1ZPgXLf6iB+NtiEE
         VkWuh0OQiOQkSaFQoYBDpZku+PC3huTv5OnJMNC+SqVoy9pGjc9M3R3aKT8XI+WlZieh
         wGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40vRTN09h4HvPLAfLfqSdTJiFyD7/u7Gq51vSeEeGRQ=;
        b=HQ8ZhgZx3CnXNJTEAgKNqhed5vB/am2MR1KDfLCr+icE+i5WoWkJN52tz00HVo8+m6
         x4UYrZTrq1oZo59U+Nv3p8AW7NVcgocB5LXoQYfIBYYwXbgfA6B7CdXHSbVQclSoikru
         e1inUVlA0Gi52F5MvPaGoCaT5NaIGdOzfR/085S3lifuPM4Oo4Sb5g34V6QByWoc9pHT
         wGXEJJP9L5WSrCuyHg2wZfaZzf952tAFr0ZxDqyMSFAvnxcjs21NGmU888a98ftipn14
         1fddvBHhmFACdikSU4hxHkI18gGB4AvZlWLPcVck+LncOX3YANXRVxm40iTXmsLngxP8
         UjGA==
X-Gm-Message-State: AOAM530rGYPgbtcr6u2T2nmucbB6U0bEnZfb2SAes2XtuFoJKIG4udz4
        4l/Tgx/GwB6J1ljWhOMu0Fo=
X-Google-Smtp-Source: ABdhPJyB3kciCj66Dlh7FIAlHo0xQzYAdahEZSg9GOMYGcUVhV3XgSbXTIJ/mRdv9FMnxw9r86ml9w==
X-Received: by 2002:a05:6402:1803:: with SMTP id g3mr9444522edy.10.1607113410420;
        Fri, 04 Dec 2020 12:23:30 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:444b:827f:c281:8a68])
        by smtp.gmail.com with ESMTPSA id g3sm3952769edd.42.2020.12.04.12.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 12:23:29 -0800 (PST)
Date:   Fri, 4 Dec 2020 21:23:28 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH] experimental: code sinking
Message-ID: <20201204202328.tx2bgnqrq6szcxys@ltop.local>
References: <20201204163315.68538-1-luc.vanoostenryck@gmail.com>
 <CAHk-=witmTznTY4oH7KDr7aTufXey17w1fTaTBiMChk+4NUQ1Q@mail.gmail.com>
 <20201204174502.5wkqf7xashx2poet@ltop.local>
 <CAHk-=wh15fTgsd+D7_goVzZY3NFPVke8ENTPtUdu5HYi2Pkgbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh15fTgsd+D7_goVzZY3NFPVke8ENTPtUdu5HYi2Pkgbw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Dec 04, 2020 at 10:15:30AM -0800, Linus Torvalds wrote:
> On Fri, Dec 4, 2020 at 9:45 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > > There might be cases where instruction sinking makes sense even
> > > outside the "can we empty this bb entirely" issue. Not that I can
> > > think of any, but I wonder if this could be used to actually shrink
> > > liveness regions (if both the inputs to the sunk instruction are live
> > > _anyway_ at the target, then sinking the instruction should actually
> > > improve liveness in general, for example).
> >
> > I don't think I understand this. In the case of an UNOP, sinking it
> > increase the liveness and decrease the liveness of the output, so
> > it should not matter much.
> 
> Right. The UNOP case should be a no-op from a liveness perspective, but:
> 
> > In the case of an BINOP or select, sinking
> > it will decrease the liveness of the unique output but increase the
> > liveness of the inputs. So, it seems to me that sinking would
> > globally increase the liveness (contrary to moving up instructions).
> > Am I missing something?
> 
> No, moving a binop could actually *shrink* liveness under the right
> circumstances - namely when the sources of the binop are live
> regardless.

Hmm yes, indeed. I thought about that but I also implicitly thought
there was a dual effect for the output, but there isn't. And so the
'cost' is not the same before the 'last occurrence of other uses' than
after it. In short: "moving down is good but only when not too low,
unless it's an unop".

Anyway, the idea would be to do such moves only if they would effectively
empty and even then it's clear what is the exact advantage (other than
for imbalance). Also, moving it to the point where it is needed was very
easy. Moving it just past the CBR (or somewhere in the middle) will be more
complicated. I'll see.

-- Luc
