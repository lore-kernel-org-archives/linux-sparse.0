Return-Path: <SRS0=2wv3=EB=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CE6C4363A
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Oct 2020 23:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3C8206FB
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Oct 2020 23:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603755584;
	bh=sDjVh91WloypRKcMkXb1fUZbUde07KE6cYFFkDjneKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UgLMqmTvJUEmpWqMoNBhAHfGCTFhFhp4X9ifKtJKsdbRx+K5Z4122+FWWcq4fyHuW
	 aw1FOFOrVOHbqS8ouw6WJiPKIFvp6NK22ce5A7l200eZgTNKNYoAjr0jFGafOdHfjN
	 clCcjQePODUBS6pPgsTvqkvfaQmUd66HO1FRniMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407405AbgJZXjo (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 26 Oct 2020 19:39:44 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38599 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407403AbgJZXjo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Oct 2020 19:39:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id c141so14650163lfg.5
        for <linux-sparse@vger.kernel.org>; Mon, 26 Oct 2020 16:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1jEL8cPmkWKeOd+WgNdt/mkWga7qyVrhqTvK95kT8g=;
        b=cxbit/fupCLTVWUBK/2sGkfOpltaCyjhv4hvEkY7VAzaImiPWoqsfbeSBqU8DppjQU
         pUkMhqvqI8CTfGh/j3Zw5dos1CqeyzvfUE2EZdc99ZlQ+85URbnkia2cKM9IKkfe05eP
         IWID386ytVQyywH/ZX2Icrc3vAeU6nK4iqD2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1jEL8cPmkWKeOd+WgNdt/mkWga7qyVrhqTvK95kT8g=;
        b=k1aA2sbHFgZhswIBNOGayq+tUIgef35/KOtJMEvuseMAip3PaTWA/dKDT+dPN6gS20
         TK62CvXoAIsRtUGHavFlJtolHdWVNMZRd6eTt2wIg/g2r0JteRKgJi07tcNTuJB6Q8mv
         ZzxCPpsu5aO1DWz3FhfNSSVHxOmuoBl4SPHr/w5a8lB/iwvf59qzqbNVRwHRI50Jness
         OwWnUqw9njUHAAtWUcHmlSrVcgrpfaKdG+lCGA1pq821QDgsksN0mLc6JANB9JIS7OZj
         apb30z2Sy45Z4r8RPk/pIN1qJ6KF+T/+WkVeQHF+vtUa2hrqooOjNERZ5on6Us+H0qj3
         qFQQ==
X-Gm-Message-State: AOAM533rxfqsDa38fjQf6k3eVWWVfvj+FBFpGkAF6hfDVvZFbDDvoSZI
        JJmDI3zvAmVoeAmaGJfT1EbT2WeJWCCFeQ==
X-Google-Smtp-Source: ABdhPJxoXNxaUJvY9e+rTOIEbUS9YCKI2SD1+PGTvshiNONGmeqXb7bPbjNq1snkIsMuCK5bJ1N2NA==
X-Received: by 2002:a05:6512:3132:: with SMTP id p18mr5607915lfd.218.1603755581093;
        Mon, 26 Oct 2020 16:39:41 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id n4sm1190989lfe.106.2020.10.26.16.39.39
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 16:39:40 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id c141so14649992lfg.5
        for <linux-sparse@vger.kernel.org>; Mon, 26 Oct 2020 16:39:39 -0700 (PDT)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr6565233lfz.344.1603755579473;
 Mon, 26 Oct 2020 16:39:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201026045338.55218-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wigYApoRH_LS2wu-i7fNp0wF1eJz27od02oo124qXvBjw@mail.gmail.com>
 <20201026204847.h3uokzvm74g5ykcn@ltop.local> <CAHk-=wh2ta_qhejh1C87sZcz09MfNTtxYU8EFy4zKQ0zQfVY=w@mail.gmail.com>
 <3abeaeef-ddde-5c47-f79b-4c61a0820c08@acm.org>
In-Reply-To: <3abeaeef-ddde-5c47-f79b-4c61a0820c08@acm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 26 Oct 2020 16:39:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=Uf4DydFyii-nFe-a2SjRemPr9w0iw+aK8rL8_MjEYA@mail.gmail.com>
Message-ID: <CAHk-=wh=Uf4DydFyii-nFe-a2SjRemPr9w0iw+aK8rL8_MjEYA@mail.gmail.com>
Subject: Re: [PATCH] handle more graciously labels with no statement
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arun Easi <aeasi@marvell.com>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Oct 26, 2020 at 4:22 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> The #ifndef __CHECKER__ / #endif that I added in 2015 in the above code
> (commit 8d16366b5f23) was added because at that time I didn't see a
> better solution.

I think there are only a couple of callers, and all of them just have
a constant "device_locked" argument.

It should be easy to make the (I think single) use that _didn't_ lock
the device just do the locking, and then all of them have
"device_locked = 1", and then that argument can be removed and the
whole conditional be replaced by a lockdep assert.

Exactly like y9ou did in 8ae178760b23 ("scsi: qla2xxx: Simplify the
functions for dumping firmware") in other words.

But I didn't really look _that_ much into it, this is just from a
simple "grep" thing and maybe I missed something. I just did the
minimal "don't do invalid C" thing.

              Linus
