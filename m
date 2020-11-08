Return-Path: <SRS0=7JZe=EO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B9AC388F7
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 00:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AF45208FE
	for <linux-sparse@archiver.kernel.org>; Sun,  8 Nov 2020 00:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604796744;
	bh=PKTyFzlVfGxfTgrHpiHot/KjzXmAi80TQOHQPTlaB6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PCrPYsCTQX8tB/Xgb9oZLprTY4yBfa09KWhVlXFdLjmWDWQGzY+ZMvGz8DbDYgFXU
	 vBJwHhjKDp28vRosqAr6WhpC7la0Oyz20ApUKXeh64UNqXSIIGd0kF3XnD5BOLrDz8
	 RjnAYukKSS6vQPNA8HbUxUQb4s2sKFOjZK8lXOwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgKHAwY (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 19:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKHAwX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 19:52:23 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F77DC0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 16:52:23 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d17so3828510lfq.10
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 16:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CV1Osw8LqiSD3pVJRrrcGguorOGTgzXjMaXIdMbpapM=;
        b=IVAZP/Zk2SlnevZS8DOgwQzLnTHbs63xYPIb/O1qfS3LYaBNJvB6otP6bkp4FbSIIc
         bvVPbkhknNf7gEBEA3NiVo4qcdhU9odDSOdrt+t6QhwXVAEsjT5gFI3qnI7TvSCtiwBh
         uqBEJvQin83kJ3RllI9js0ZNQZXWeutucIIak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CV1Osw8LqiSD3pVJRrrcGguorOGTgzXjMaXIdMbpapM=;
        b=Nj2tU1GIV3gDl/iPuTHViGvbARhUs5zLZr8ywr1HrXhZgGdyqrDjx2/Ql8KqOOTOig
         DeB2i2JRmzaKtW1+addVFz+B3o1Rzs9uPnuLJ9tJVqDUn21Hi8Y47ZdIqywu7rHHUXSj
         5msh9RU1fBrx1nNQ+0okvdhhDU4VgPE6o9DAT4RJnrQQ4M+HmKES34MONHQ1QVKIeLxh
         TyZVkdVLMhCC2M8nmcyOmwPCuDA4vgWWNy+vLDtw2LP/PvSbnJqlBnajWny0tfI0LC/g
         ONJCm6AuMSyHmr2mKQzuifTtuBgePgMJxECBQiIHrLYZSbVWNp/U0Wo3YPFhtw3zfZ0j
         6FmA==
X-Gm-Message-State: AOAM5317mnof+zWfbgIKz0pZ/3IatfV1MIyY8G5j57ikn/IYdULF4Oxu
        BIjIUTAVHHTwshPgD3LirgUTzGBg2LNo4w==
X-Google-Smtp-Source: ABdhPJy6YuxPC9t8PE6t0MRXUFdTMiXTTLoFb5ZRid8CiOpd2CVwcF8f6o6UUxcXG+vQZXLDJPFCQQ==
X-Received: by 2002:a19:614b:: with SMTP id m11mr3515329lfk.295.1604796741618;
        Sat, 07 Nov 2020 16:52:21 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id v9sm822426lfb.203.2020.11.07.16.52.20
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 16:52:20 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id d17so3828476lfq.10
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 16:52:20 -0800 (PST)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr3482469lfz.344.1604796740106;
 Sat, 07 Nov 2020 16:52:20 -0800 (PST)
MIME-Version: 1.0
References: <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com> <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
 <20201106221917.n3is2fnud7jqa3x5@ltop.local> <CAHk-=whbo09hM0xW-qDLsZF4XunVDs5YwzH7a5G=5O+0qrPy_A@mail.gmail.com>
 <20201107013255.xpsfeamyco7ggnru@ltop.local> <CAHk-=wj0rBc0o_-u9H5_4-ZUnPOx-be3c1Dd-_WBWfPzEQtKRQ@mail.gmail.com>
 <20201107200924.fpybgapomro4xzxe@ltop.local> <CAHk-=wgCTM2HWeVFTvg7Dg1UQeYn1Md49e8VGCWELWq=c15_qg@mail.gmail.com>
 <20201107212327.js6dlr2tuzey4kz6@ltop.local> <CAHk-=wg8qsQ7Pu3umbw_kgT1OtSZY-dAaj2c6i4=xY_2=Q4C5w@mail.gmail.com>
 <20201108004159.gwbwirczpltkm7c3@ltop.local>
In-Reply-To: <20201108004159.gwbwirczpltkm7c3@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Nov 2020 16:52:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4bx8A8dHnX612MsDO13st6uzAz1mJ1PaHHVevJx_ZCw@mail.gmail.com>
Message-ID: <CAHk-=wh4bx8A8dHnX612MsDO13st6uzAz1mJ1PaHHVevJx_ZCw@mail.gmail.com>
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

On Sat, Nov 7, 2020 at 4:42 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> But isn't a lot of code written to explicitly support this, with an
> argument or some other condition selecting between the locked mode
> or the unlocked mode?

A lot? No. I've actively discouraged it.

It does exist - don't get me wrong - but it shouldn't be the normal pattern.

> This one is fine for Sparse
>         static inline int cond_lock1(void)
>         {
>                 if (complex_cond()) {
>                         take_lock();
>                         minor();
>                         return 1;
>                 }
>                 return 0;
>         }
>         static void ok1(void)
>         {
>                 int cond = cond_lock1();
>                 if (cond) {
>                         major();
>                         drop_lock();
>                 }
>         }

That _is_ a somewhat common case, and it's basically the "first helper
tells the caller that it took the lock".

The _really_ basic version of that is the various "trylock()" things,
which has that "__cond_lock()" macro in the kernel for it, so that
sparse can catch that very special case.

That said, it's still not the _common_ case, which is just that the
code is straightforward

    take_lock();
    do something under the lock
    drop_lock();

> The next one corresponds to the situation Song Liu reported
>         static inline int cond_lock2(void)
>         {
>                 if (!complex_cond())
>                         return -1;
>
>                 take_lock();
>                 minor();
>                 return 0;
>         }
>         static int okish(void)
>         {
>                 int cond = cond_lock2();
>                 if (cond)
>                         return 0;
>                 major();
>                 drop_lock();
>                 return 1;
>         }

Yeah, this is a more complex version of the same.

Clearly sparse doesn't grok it today, but the fact that your patches
make sparse able to track it is a good improvement.

> The one that really annoys me is this one. It's very simple and, as
> far as I know, quite common in the kernel but kinda hopeless.
>         static void ko(int cond)
>         {
>                 if (cond)
>                         take_lock();
>                 major();
>                 if (cond)
>                         drop_lock();
>         }

This really is invalid code. "major()" is done in two different lock contexts.

Sparse _should_ complain.

             Linus
