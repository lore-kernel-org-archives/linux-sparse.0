Return-Path: <SRS0=cH/F=EN=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CF5C388F9
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 22:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66D7420719
	for <linux-sparse@archiver.kernel.org>; Sat,  7 Nov 2020 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604787627;
	bh=P4WcqBmIc6+KLJfY9XpVetAqEDomZ0+xBBU+ElO5nVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yFdGWwvGXKh8sgGHPHzm0z8rDx0zpDI+WFCir5l0FarXgZq4F+/kO3AJoqnU39x3J
	 nNCXvvhzwvhE1PAJrx7iAwpzOZT19XQVsFpsjJIb92g2ZIhG0TilTdEvbc3XaSCATf
	 ufBUZg6/QCi5DwH85LObn9xSmUI0LZltFHGECdxk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgKGWU1 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 7 Nov 2020 17:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKGWU0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 7 Nov 2020 17:20:26 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F91C0613CF
        for <linux-sparse@vger.kernel.org>; Sat,  7 Nov 2020 14:20:26 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 11so5509657ljf.2
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 14:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDbOt+tEacyAuA19fGIiA/u50PO6V1jZ8nHH5wD+t1A=;
        b=bFKvH2jEAuKRmwU9o91WMQ725E6AVlF5MXIcDs4W5lUzFxkUBDYd08UNLTRpRzN9Pn
         R5tdezx6/VVI1J0uZLD2enVEYa2I176nnnAK2KStRcc6ViwjDHTMRRbC8Xk3jCawjoBD
         1mfXgqWl2ymGIMfQb6rkZN0neb9Pe+vbX8wbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDbOt+tEacyAuA19fGIiA/u50PO6V1jZ8nHH5wD+t1A=;
        b=jTMd29jS/cURtGfJ1uuqYoxvATHD0T4UEquWWPiI+5zOLB/fbunhpqbKBOc5oAOI/b
         IhsNzy8YqIO7WkLBlAv2DSm0hfdWJbHgRVBeKvNZGZZ0xe5vsMUHF7PGqpA1M521F2as
         vX5WRlQFIrcT7aCWYN5+knSwIUEOz6kd9whF8DVosjQnCdNI8tsW6U4t+ZVUfEFG/MrX
         aqtE0RQxGQa3kr3jLo/X+LElUe6ZBQ6rnQtvJ1v0BR2wewi7cPC2tw02m3rZdlWFNcMl
         HqQem77PHUozzsZcGwdp2fFwZrF+/xIH0rkLMzyjGP/luidikEFZW5yovJAexk16XQhS
         NRug==
X-Gm-Message-State: AOAM531uyxJrSezKA9PCG12tVR0HkcPgoq4duJpid1PqjICxNsqZ6FI8
        1xQEQe3lzoe1/1d71xRf2UvZKI30lLsxbQ==
X-Google-Smtp-Source: ABdhPJw9BnjidivnHqyh+Cnj8e14Ru0mBD6Ff0ZNzwRyF3YNXtDvTu5wmoDYVSLsI/eW7Iio5tpHAA==
X-Received: by 2002:a2e:9d99:: with SMTP id c25mr3350379ljj.213.1604787621804;
        Sat, 07 Nov 2020 14:20:21 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id m84sm578841lfd.46.2020.11.07.14.20.20
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2020 14:20:20 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id y16so5515642ljk.1
        for <linux-sparse@vger.kernel.org>; Sat, 07 Nov 2020 14:20:20 -0800 (PST)
X-Received: by 2002:a05:651c:110:: with SMTP id a16mr3385705ljb.285.1604787619925;
 Sat, 07 Nov 2020 14:20:19 -0800 (PST)
MIME-Version: 1.0
References: <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com> <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
 <246A7DB8-75D8-46B6-8AE4-BDACD5714EC2@fb.com> <CAHk-=wjbOjD_3HBas10sb9VKyNGvDrs9vXGj=rVc5TdPSPMDMA@mail.gmail.com>
 <20201106221917.n3is2fnud7jqa3x5@ltop.local> <CAHk-=whbo09hM0xW-qDLsZF4XunVDs5YwzH7a5G=5O+0qrPy_A@mail.gmail.com>
 <20201107013255.xpsfeamyco7ggnru@ltop.local> <CAHk-=wj0rBc0o_-u9H5_4-ZUnPOx-be3c1Dd-_WBWfPzEQtKRQ@mail.gmail.com>
 <20201107200924.fpybgapomro4xzxe@ltop.local> <CAHk-=wgCTM2HWeVFTvg7Dg1UQeYn1Md49e8VGCWELWq=c15_qg@mail.gmail.com>
 <20201107212327.js6dlr2tuzey4kz6@ltop.local>
In-Reply-To: <20201107212327.js6dlr2tuzey4kz6@ltop.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 7 Nov 2020 14:20:03 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8qsQ7Pu3umbw_kgT1OtSZY-dAaj2c6i4=xY_2=Q4C5w@mail.gmail.com>
Message-ID: <CAHk-=wg8qsQ7Pu3umbw_kgT1OtSZY-dAaj2c6i4=xY_2=Q4C5w@mail.gmail.com>
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

On Sat, Nov 7, 2020 at 1:23 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Yes, but the branch simplifications depend on the simplifications
> that can be made on the condition. For the moment there is a focus
> on select because it often happens when the condition is simple but
> for these context imbalance the general case is something like:
>         stuff
>         if (arbitrary condition)
>                 take lock
>         do other stuff
>         if (same arbitrary condition)
>                 release lock
>
> and the problem is (at least) twofold (but partially related):
> 1) recognize that the second condition is the same as the first one
> 2) avoid that partial optimizations of the first condition 'leak'
>    into the common part because this often inhibits doing 1)
>    [Sorry, if this is not very clear. I need to find some small
>     examples to illustrate this].
>
> When the condition is very simple, it is converted into a select
> but very often it's more complex, involves a memory access and/or
> some function calls or some asm.

Note that if the condition is complex and involves memory etc, it's
generally actually a bug in the kernel.

Because if it could possibly change between the lock taking and
releasing, you are now broken.

So I wouldn't want to accept code like that _anyway_. Any complex
conditional needs to be written as

     lock = complex_conditional;
     if (lock)
          take lock
     do other stuff
     if (lock)
          release lock

and if sparse handles _that_ case well, then all is ok.

If sparse complains about the fragile "repeat complex conditional that
couldn't be simplified to show that it was obviously identical", then
that's actually a _good_ thing.

Because we want to complain about stuff where it's not obviously clear
that the conditional is 100% the same.

Now, even in the above, if we'd want sparse to say that is ok, then
we'd actually need to make the context tracking itself able to deal
with "conditional on this pseudo", which it doesn't do right now.

So right now it requires that much simpler case where you actually end
up not ever having that shared case in the middle at all, and the
simplification really ends up showing that the real path is really

     error = complex_conditional;
     if (error)
          return error;
     take lock
     do other stuff
     release lock

which apparently sparse now - with your simplification - can see that
the code actually ends up doing .

Which is even better.

I'd much rather have the lock context tracking show that locking is
simple, and that we don't have any code that sometimes is called
locked, and sometimes is not.

Because even if you can prove - with some kind of conditional context
tracking - that the context at least _nests_ correctly (ie you always
properly unlock something you locked), that isn't actually the big
problem. The big problem really is "why did that 'do-other-stuff'
sometimes run without locking, and sometimes with locking?"

So the lock context tracking is fairly inflexible on purpose. It's
_meant_ to not just do "unlock matches a lock" matching. It's meant to
also track "ok, there is no odd 'sometimes locked, sometimes not'
code".

             Linus
