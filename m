Return-Path: <SRS0=gthx=EM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A698BC2D0A3
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 17:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C5522228
	for <linux-sparse@archiver.kernel.org>; Fri,  6 Nov 2020 17:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604684747;
	bh=2HAjPTmuPHDsE1BvabYqu3CWbMzTqvp/t5pBACapH+A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TQztuiNx9UsJ+kY0ol9SCfZsWPmW0Bau4QTbVTaVa2oeUaiA9CQZLyX57fnxhkPY0
	 6fpuZg9yZyA/hS1lTNQnw8s1NmKMMX4Ya2O6fbVzQm3OaW7cIOCqkWqkURjTw4/c8G
	 hVzrfqErmJDqtChbjJSGGIIEdCYGN6d5HQ8SvTr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgKFRpr (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 6 Nov 2020 12:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgKFRpr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 6 Nov 2020 12:45:47 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1E1C0613CF
        for <linux-sparse@vger.kernel.org>; Fri,  6 Nov 2020 09:45:46 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id r19so751535lfe.6
        for <linux-sparse@vger.kernel.org>; Fri, 06 Nov 2020 09:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZNLPRHC1TXaAaGauanAopAI0YmG5BrhUTGpYulwYJgc=;
        b=HTPsRIL8grrSiAevYov8IDEKru5icoR6VnERm1bQjFhKw9UZzLHfX1IcskqB+VpTPO
         59j08vU8F6p/cMHpInObe2Kzj6dzStjO7QH4p/XMLRFOsvEJY4QwSNGVm8JjSkOSQQ46
         lWMuMGLwX2Ib1z2RyouwR+8uwmbtnJMtCERjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZNLPRHC1TXaAaGauanAopAI0YmG5BrhUTGpYulwYJgc=;
        b=PQ/X54SZ9d+3VTeyQYBWytKvZJZxcFRgJahZch5tDJ9rtnqbKGmNKvuVc4uiChw9z7
         +bpslcPohX6Aascp52s21lAWy4w8X/qn+bUKgEIEsnoiDe3RL0zozRysftTg6hj9AMXR
         5/15E4s8o1jlNCA0/8lk7eWx+HWLJ2dpYl6iX5UUoCQzWKKvEewkZRNppOBBoHzWwe17
         pa1kLhBsWet4ZyAOL4iDbndYbmUDaXeyjPtExVIA04/TwaN/cEtgkK2/PXueaXWg8QcQ
         FYNaqkJCl51ldW1hYB1LYqScYuT/3ECAB1Imj2OaljbhhgOfHsYNoTIntfTzQiQ+Sv3I
         +82w==
X-Gm-Message-State: AOAM531lHdiX6pr20VnZWz24v+VrUIz7WpiG9rXGfRisqnEu2Y8Hs+ge
        tj00bcIdycNhXwZ3ZS6RqyYFEZZTdrnUNg==
X-Google-Smtp-Source: ABdhPJwhpS8RFhfNhixP9HQsVdW0GqoKHOY9JYGFPg+YiWYxuLrMKje+2Ey/g4ygfI+vtdg/7qm7Wg==
X-Received: by 2002:a19:4890:: with SMTP id v138mr1250480lfa.254.1604684744266;
        Fri, 06 Nov 2020 09:45:44 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id w17sm238026lfq.86.2020.11.06.09.45.43
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2020 09:45:43 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id u18so3062931lfd.9
        for <linux-sparse@vger.kernel.org>; Fri, 06 Nov 2020 09:45:43 -0800 (PST)
X-Received: by 2002:ac2:5f48:: with SMTP id 8mr1395034lfz.344.1604684742619;
 Fri, 06 Nov 2020 09:45:42 -0800 (PST)
MIME-Version: 1.0
References: <4126C08B-532F-4B6A-A3C2-9F7928EA2806@fb.com> <20201105211342.6mglug2a74bi5hvd@ltop.local>
 <CAHk-=wjgKzHvGYbHpJ6DJj6W73b54QqNK0LSjY-jYdU3kxhWMQ@mail.gmail.com>
 <20201105215023.wvekadtkdwgz7yim@ltop.local> <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
In-Reply-To: <B8E674A7-1B84-4E64-A688-EF226A947AB3@fb.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Nov 2020 09:45:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
Message-ID: <CAHk-=wiTAFVdMCF=oADAOFwVWff2Rs1qqD1Wqj8rF0zTgbLYag@mail.gmail.com>
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

On Fri, Nov 6, 2020 at 9:30 AM Song Liu <songliubraving@fb.com> wrote:
>
> I know very little about sparse internal. But I feel this is more
> like a minor bug.

It's not really a bug, and the pattern you show isn't actually all
that easy to see for a compiler.

> Here is the simplified inlined code of htab_map_delete_elem()
>
>         if (some_condition) {
>                 ret = -EBUSY;
>         } else {
>                 spin_lock();
>                 ret = 0;
>         }

So here the issue for the sparse optimizer is that while both "ret"
and "spin_lock" is tied to "some_condition", it's not really obvious.

A compiler would have to follow all the value analysis - and good
compilers do that, but sparse is not a "great" compiler, it's more of
a "solid and not horribly stupid" one.

>         if (ret)
>                 return ret;

So I'd really suggest you make the code more obvious - it will be more
obvious to humans too.

Write it as

        if (some_condition)
                return -EBUSY;
        spin_lock();

instead, and now sparse will see that obviously spin_lock() and
"some_condition" are mutually incompatible.

               Linus
