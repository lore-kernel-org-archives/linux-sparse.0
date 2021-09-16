Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFFBC433F5
	for <linux-sparse@archiver.kernel.org>; Thu, 16 Sep 2021 17:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65887610A4
	for <linux-sparse@archiver.kernel.org>; Thu, 16 Sep 2021 17:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhIPRyn (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 16 Sep 2021 13:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357085AbhIPRvY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Sep 2021 13:51:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB3BC09B116
        for <linux-sparse@vger.kernel.org>; Thu, 16 Sep 2021 09:25:57 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p29so20711234lfa.11
        for <linux-sparse@vger.kernel.org>; Thu, 16 Sep 2021 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+MrqPwjGprB21xOrKUeLYED8somKhoDI07GyEYlbbo4=;
        b=giK/CoBDhVKoZODX7QaMWenK7M0Ef7/VMrMC+JpDOGq7hzKKMIt4+9kYx+W6zhvGu1
         ySoWjCQyGMBQPbPsmJ+MdLSpu5kCyHc8//rajgrLTwILPMxsnm4mLr03RxEorH1wc86u
         czJJF+ua9fGukgNanz1FEl1kMG76Vh0A/SWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MrqPwjGprB21xOrKUeLYED8somKhoDI07GyEYlbbo4=;
        b=otcGdnI6Hfi2iE/1cjO6CZEDTzDSJ4HtOUE6dxj3/6UfW/LsuDSJRkJmmeOMr0/jpb
         pq6ybl0GSkS7J2jzc0Fn6R7clv/M1gvLjZ65rUViZJ8EImzKLMZvJ3yCQuKWYglxMw2w
         ISOXh+/ton4ZYfac3DIrJHlMgQsSUtMQnK+atferMDbKByGNJrn4IAI3opn9uxKnY8y/
         OMqp16n5rwWwW8Dfk6sYorwo0AkG0MoxtK58A9CDnZNEahCfjoGzD8tKIfrck9nCMf5X
         3EzRa36VrvT1/tNeIzW//PLF1ZjkhE8VUD3qD0birXcEaytV0R1jhoCqMr+YDvXXRKws
         8sUg==
X-Gm-Message-State: AOAM531UesCEYs56Q3x15M+BatytvrNgbiFiqkc90F4NyIJQ7TsT4lW1
        z3GIkz7Tiqb/iwrfI7FugnneHNA7fZdZYxV5
X-Google-Smtp-Source: ABdhPJwvyEuAWuwVDI8J9kivzUm2ftkS5GDyB1v71SPsGJg20sGY0Y0Q4YiIybOH39LHIjFU0lsppQ==
X-Received: by 2002:a05:651c:17a5:: with SMTP id bn37mr5653074ljb.514.1631809555465;
        Thu, 16 Sep 2021 09:25:55 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id k12sm387234ljm.65.2021.09.16.09.25.54
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 09:25:55 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id bq5so20908978lfb.9
        for <linux-sparse@vger.kernel.org>; Thu, 16 Sep 2021 09:25:54 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr5452535ljg.31.1631809554490;
 Thu, 16 Sep 2021 09:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210915035227.630204-1-linux@roeck-us.net> <CAHk-=whSkMh9mc7+OSBZZvpoEEJmS6qY7kX3qixEXTLKGc=wgw@mail.gmail.com>
 <CAHk-=wjynK7SSgTOvW7tfpFZZ0pzo67BsOsqtVHYtvju8F_bng@mail.gmail.com> <5497691.DvuYhMxLoT@alarsen.net>
In-Reply-To: <5497691.DvuYhMxLoT@alarsen.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Sep 2021 09:25:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh84ks6FN2fBWrGZNKNhOmTZL-r5xZG7gYZ==jESG2GgA@mail.gmail.com>
Message-ID: <CAHk-=wh84ks6FN2fBWrGZNKNhOmTZL-r5xZG7gYZ==jESG2GgA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Anders Larsen <al@alarsen.net>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Sep 16, 2021 at 12:02 AM Anders Larsen <al@alarsen.net> wrote:
>
> On Wednesday, 2021-09-15 23:19 Linus Torvalds wrote:
> >
> > But hey, maybe it just works so well for the very specialized user base ...
>
> it's actually the latter (although I guess the user base is shrinking)

Hey, so if it's actively used, maybe you can answer a question or two
that I have just because I looked at the code..

In particular, the inode number calculation is odd. Is there a reason
for the "-1"? Because iboth the link case and the direct inode case
have it, but t's a _different_ "-1":

For the "inode_entry", it does

                ino = blknum * QNX4_INODES_PER_BLOCK + ix - 1;

but it's worth noting that "ix" is zero-based (index within the
block), so this kind of oddly removes one from a zero-based thing, and
the 'ino' for the very first entry ends up being -1.

Of course, it's possible that the first entry is always empty, but it
does seem a bit odd.

For the "link_info" case, it does

            ino = ( le32_to_cpu(de->link.dl_inode_blk) - 1 ) *
                    QNX4_INODES_PER_BLOCK +
                    de->link.dl_inode_ndx;

so now it takes the _block_ index, and does that "-1" on it, and then
multiplies it by the "entries per block" number, and adds the index.

So now if both are zero, the inode number is -8, not -1.

But all of this matches what the *lookup* code does. It's very odd, though.

But to make it stranger, then in "qnx4_iget()", the calculations all
makes sense. There it just does "take the inode number, and look up
block and index into the block using it".

Very strange and confusing. Because it means that iget() seems to look
up a *different* inode entry than "lookup" and "readdir" actually look
at.

I must be missing something. I obviously didn't touch any of this
logic, I was just doing the "make the type system clearer for the
compiler".

Also, I have to say, since I was looking at compiler output, the
calculations in readdir() are made much worse by the fact that the
dir->pos is a "loff_t". That's signed. And then you use "%" to get the
index within a block. Using '%' instead of bitops is fairly
equivalent, but only for

 (a) unsigned types

 (b) when the divisor is a compile-time power-of-2

In the qnx4 case, (b) is true, but (a) is not.

Not a big deal. But usually, I tell people to avoid '% ENTRIES',
because it really has very different behavior from '& MASK' for signed
numbers.

                  Linus
