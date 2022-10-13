Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E4EC4332F
	for <linux-sparse@archiver.kernel.org>; Thu, 13 Oct 2022 23:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJMXVf (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 13 Oct 2022 19:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiJMXVe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Oct 2022 19:21:34 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D44433352
        for <linux-sparse@vger.kernel.org>; Thu, 13 Oct 2022 16:21:33 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-132af5e5543so4069469fac.8
        for <linux-sparse@vger.kernel.org>; Thu, 13 Oct 2022 16:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iPc8pvfIJSxW/Wiwd/fUtuGCAmZ/6zOC8JpfRpBd9KI=;
        b=fP2qUFE0vOWvhfih9MspoLU/0C/g7MUqPQxGcFvEM6En92oMpTilhoxf8EPzehB5lX
         eR5HYZEOOGzwf+b6IE4sVJwhoSvww540rz0OW9jGY7rEAXRrBWTjig84nypU+d8rq1XG
         yFMa8HR2aiwdJ0yr9wDeVoELhVVjVnRbbrAKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPc8pvfIJSxW/Wiwd/fUtuGCAmZ/6zOC8JpfRpBd9KI=;
        b=LLCnjH9vKQ24oPNRpYZbG8DFQNdkrptkyY0u1hZVEHPPLfP+h4NRT+t+2TS0IWqr3c
         swYIKK+aIQlIt6sD5ZM08fy5/CUqF8hn08ammNrUmBApMailZ9XsACeXY5sjNLs1+28a
         I7ntEK0lnOt1m8xjayNghpO5wvcqgMRnzaBfOSm0MaqMQqi1wuVWMHvdg2k3cZMKt9wQ
         15B2SBHJVNyj1+WtewxxJ2lOnyu/3iIbsZnGJrzcXtE72+U/rmV5VgBEjCqvagVV8EiG
         MpNQ1fs9WJbO8ITmCpDBWyRUlb3o/U+YWKWoGKx+o1GOgaNHVZty0g02703//KvQU4m+
         QHlw==
X-Gm-Message-State: ACrzQf0n5Q59yRWB9YRxg2He3LJplHHBVL2JKx4SIB3Q6SXwri5lGVK7
        ZsiHpXGKhO5oEpwW3jpojeoQ2RI7vwpGnw==
X-Google-Smtp-Source: AMsMyM68X0+FYfVGfl6B19UjkWAkzlA7NeYS5QrqbGmxfcHiG1rb9eQBTaPQae1U1CpitMjMfDq97g==
X-Received: by 2002:a05:6870:f629:b0:136:b5dd:8717 with SMTP id ek41-20020a056870f62900b00136b5dd8717mr1177376oab.33.1665703292139;
        Thu, 13 Oct 2022 16:21:32 -0700 (PDT)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com. [209.85.160.45])
        by smtp.gmail.com with ESMTPSA id f80-20020a4a5853000000b0044afc1ba91asm308507oob.44.2022.10.13.16.21.30
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 16:21:31 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-12c8312131fso4099382fac.4
        for <linux-sparse@vger.kernel.org>; Thu, 13 Oct 2022 16:21:30 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr1217630oad.126.1665703290616; Thu, 13
 Oct 2022 16:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <e583356b104fbef6940a06bf360aa59c42bba3c2.camel@redhat.com>
In-Reply-To: <e583356b104fbef6940a06bf360aa59c42bba3c2.camel@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Oct 2022 16:21:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_haaRm5SyXZdQOO2OFr2GFqaZuW2CvhraKkq8f1V+jA@mail.gmail.com>
Message-ID: <CAHk-=wg_haaRm5SyXZdQOO2OFr2GFqaZuW2CvhraKkq8f1V+jA@mail.gmail.com>
Subject: Re: address_space and noderef on non-pointer types
To:     David Malcolm <dmalcolm@redhat.com>
Cc:     linux-sparse@vger.kernel.org, linux-toolchains@vger.kernel.org,
        David Faust <david.faust@oracle.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Oct 13, 2022 at 12:37 PM David Malcolm <dmalcolm@redhat.com> wrote:
>
> Is it valid to apply the sparse attributes 'noderef' or 'address_space'
> to non-pointers, and if so, what does this mean?

It means that the thing itself is in said address space and cannot be
accessed directly.

IOW, if you have something like this (I'll just use "__percpu" as an
example from the kernel):

    # define __percpu __attribute__((noderef, address_space(__percpu)))

then

    int __percpu x;

means that you cannot access the value of 'x' directly, and that x
itself is in the "__percpu" address space.

Trying to use the value of 'x', eg

       printf("%d\n", x);

should cause a warning, along the lines of

     warning: dereference of noderef expression

and taking the address of 'x' should result in a pointer that is of type

   int __percpu *

which is entirely consistent (and then you'd have an inline function
or macro that then does the right magic to dereference a pointer in
that __percpu address space, in the kernel it would be
"this_cpu_read()" and friends).

> What is the intended meaning of "noderef" for a non-pointer?

Note that the pointer use is the common (and historical) use in the
kernel, but "noderef" really is not so much about the pointer, it's
about what the pointer points to.

IOW, notice that when you have a pointer to a __percpu variable, you
don't mark the *pointer* as being __percpu. It's not "int *ptr
__percpu", it's "int __percpu *ptr".

(Ok, "int *ptr __percpu" does conceptually exist, but it means that
the pointer itself is just an "int *", but it is in __percpu space, so
it's not about how the pointer cannot be dereferenced - you cannot
actually access the pointer value itself!).

So the type system is entirely consistent.

The documentation (and the naming) may be a bit pointer-centric, and
that in turn comes from the historical use of this originally only
being used for things like user pointers, but also from the fact that
internally in sparse, accessing a variable is actually the same as
dereferencing the symbol.

           Linus
