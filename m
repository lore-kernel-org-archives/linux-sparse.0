Return-Path: <SRS0=2wv3=EB=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9B2C4363A
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Oct 2020 22:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9F920709
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Oct 2020 22:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603753030;
	bh=PmL3OpDbb2/LyOchS/R+KJnwZwG//af8Mij2Z+/vbKk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sWYqyKhYOE3VbhxqhgkHG91QFvLiS2uZa7FV510E0XDu5QLQOHFYhUpmtmYoAKks9
	 gK2eMHfm+IlFavAnppapfptLEIvYE8jEiZRheHx044v7wBXqVBPcVIysVCNADSS8le
	 dqdAnrblGP3lEh6eFVqzoU30HSPepFp6lIdZJKKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394952AbgJZW5K (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 26 Oct 2020 18:57:10 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37862 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394947AbgJZW5K (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Oct 2020 18:57:10 -0400
Received: by mail-lf1-f66.google.com with SMTP id j30so14473376lfp.4
        for <linux-sparse@vger.kernel.org>; Mon, 26 Oct 2020 15:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YFZNO4VFL1ONAw3IG0s/yv/5yTWkkkbJxxEFvzgHh8k=;
        b=GPxHtn397IjwJg2lEstFSqgR6MG/IlTeXcTjMxSvPjCrVLtOjhjdYW2pAehFnQ+iYI
         DvqusxYDZHR9Ksfc6HrYEI8ZE2MG4FIidlYxR6Wg7AH9m62ImFEUYUhDwDEf8AhJqee+
         XkBLW3tbub6caZx+hr7TYrj3KmzW4mcHonH6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YFZNO4VFL1ONAw3IG0s/yv/5yTWkkkbJxxEFvzgHh8k=;
        b=ihkQslfNmHzxX/NKx1usQGZqKwgd0rahfthBp0R12b9cO2VKgmJZPYLwyb2oEAslOU
         Km8GUs9+145muFk9b5/gSMDrLFyVgW/75ghhG37+bEqchGIlgZIcgWZ97m/S/yQssBVk
         mtHe0QKjxvKF83K7LFEMclON4PDaPqLHBJSbPjrVWTDDBFqJz2RnneEpmKndhWIxFspy
         5t3qYFTMlfFUHC5wHzzy7caqGwF/1kbQh/RC3FXFmABvNegXjfxCVNx76Ad/utPuSyTB
         dqb/JQbc7f1LZG3n6oFVyKLE6NNZQV6k2cdWOW+EzyRCZnn76cNWwWplvQdT+QaUj4aK
         FQqg==
X-Gm-Message-State: AOAM532iUKnHSjFhX2XLwaiEdhYu0oL2bMOZFKW81S3rVUMudhEt5HKA
        Nos2i0hvNizujsXwRHbKdc14W3EPUZQ+Yg==
X-Google-Smtp-Source: ABdhPJykZz065VxevEWsUmTUbT7CihpWi8aV0SGYPTFaINDgAxzX+Qh3m+SkoBS53oHFI2Zbm8VCCw==
X-Received: by 2002:a05:6512:78a:: with SMTP id x10mr6752872lfr.340.1603753027248;
        Mon, 26 Oct 2020 15:57:07 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id u3sm1181841lfm.57.2020.10.26.15.57.06
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 15:57:06 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id c21so12294898ljn.13
        for <linux-sparse@vger.kernel.org>; Mon, 26 Oct 2020 15:57:06 -0700 (PDT)
X-Received: by 2002:a2e:8092:: with SMTP id i18mr6647776ljg.314.1603753025832;
 Mon, 26 Oct 2020 15:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201026045338.55218-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wigYApoRH_LS2wu-i7fNp0wF1eJz27od02oo124qXvBjw@mail.gmail.com> <20201026204847.h3uokzvm74g5ykcn@ltop.local>
In-Reply-To: <20201026204847.h3uokzvm74g5ykcn@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Oct 2020 15:56:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2ta_qhejh1C87sZcz09MfNTtxYU8EFy4zKQ0zQfVY=w@mail.gmail.com>
Message-ID: <CAHk-=wh2ta_qhejh1C87sZcz09MfNTtxYU8EFy4zKQ0zQfVY=w@mail.gmail.com>
Subject: Re: [PATCH] handle more graciously labels with no statement
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Arun Easi <aeasi@marvell.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Oct 26, 2020 at 1:48 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> On Mon, Oct 26, 2020 at 10:41:36AM -0700, Linus Torvalds wrote:
> > But can you point to the actual 5.10-rc1 problem? I haven't seen the
> > report, and afaik gcc will complain about this too ("label at end of
> > compound statement") so I'm surprised sparse hits it..
>
> Well, I was surprised it wasn't caught and was ready to send a patch
> but it can only happen when using sparse, see below, quite ironic:
>         drivers/scsi/qla2xxx/qla_tmpl.c:1052.
>         1050         }
>         1051
>         1052 bailout:
>         1053 #ifndef __CHECKER__
>         1054         if (!hardware_locked)
>         1055                 spin_unlock_irqrestore(&vha->hw->hardware_lock, flags);
>         1056 #endif
>         1057 }

Yeah, that "don't sparse this" pattern has been problematic before.

I removed it.

Bart, Arun - see commit 4525c8781ec0 ("scsi: qla2xxx: remove incorrect
sparse #ifdef").

              Linus
