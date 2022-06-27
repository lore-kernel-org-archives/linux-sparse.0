Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5136C433EF
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 19:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbiF0TOz (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240396AbiF0TOx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 15:14:53 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BBB62C5
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:14:47 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ej4so14443869edb.7
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sn/cgXFmKBv81IJP3+SRVhUyyYNzgySYLSgLECHA9c4=;
        b=f8J++LJ5bpDRrq9lGsVb4E3qjveHPXCwnx/zGdKHM9E0k5bjGTJfFC7JIvzptZeGwJ
         gFaWMO05NPmVBv3qCz5ADeZ3s4DLla5E2Ih5aMPe/LBux4HX2yEBJERp2cI4DVkPL0sz
         yNvnT5LRwye2UO3qN8v4GbzCQsQdPb8e6dPC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sn/cgXFmKBv81IJP3+SRVhUyyYNzgySYLSgLECHA9c4=;
        b=nVTXBktvtnJUz2aWvFNSHwcN1ZdeTvwoejzVZL6OHI0cc9Wgy14aKgzBGxN93vfA9v
         DkN94mcJ+AIi5T+3M+1ax8IdT9qnSEx1AMmLJ/dWFYCy6qCMKDJb/GYKh8mpKuQ+O/50
         61+ywhDTj5LgBJvXboTHt/vAbRQSOtsGErlmzEQYBX4ymZ4E85eHiBsWvwp8InPpEvII
         W0ek6GHlj1dJus+oWhbqHakQF3fP6SdtRYsTcS6W/woqbzTAX+XM9d4leEJLnVTaArAl
         lTIDpxpAlcD//SMUO5oqz9Ll6e3CUoutwBGcMtpyACtpybhLgmIUuMnWnu7Peo29tCmt
         2/Sg==
X-Gm-Message-State: AJIora908O/KptoWJKI1F3oY782XDvQBd7JI/j09Sm490u1Qe+XQklGU
        m0GujcqkuMqLT/MUAKrjXAe6T9VE7r1xxZMma8E=
X-Google-Smtp-Source: AGRyM1uE5Z+3r9S4DVsp/X1zbLx+rU34F3YsQTcJTTwxJGx5kluTO63UCGAqxjpb6pEpdyPjqHpAUw==
X-Received: by 2002:aa7:d7c4:0:b0:435:6a5b:b02f with SMTP id e4-20020aa7d7c4000000b004356a5bb02fmr18585305eds.365.1656357286102;
        Mon, 27 Jun 2022 12:14:46 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id d10-20020a17090648ca00b0070b8a467c82sm5372601ejt.22.2022.06.27.12.14.45
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 12:14:45 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id q9so14401917wrd.8
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:14:45 -0700 (PDT)
X-Received: by 2002:a5d:48c1:0:b0:21a:3574:e70c with SMTP id
 p1-20020a5d48c1000000b0021a3574e70cmr13878351wrs.97.1656357284904; Mon, 27
 Jun 2022 12:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
 <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jun 2022 12:14:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRzOgEXT95o+ZQUawKbwBaGHoy=TSzB1dN2Uh26CZfCQ@mail.gmail.com>
Message-ID: <CAHk-=wiRzOgEXT95o+ZQUawKbwBaGHoy=TSzB1dN2Uh26CZfCQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] allow -1 and compares in bitwise types
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Jun 27, 2022 at 12:05 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
>         #define is_signed_type(type)  (((type)-1) <= 0)

Side note: the reason we *don't* use this form in the kernel is
because broken compilers will complain about compares with zero in
unsigned types.

Using "<=" like you do may be an acceptable way to avoid it (the most
obvious thing is to use "< 0"), but it makes me nervous.

Regardless, I think you need the cast of the zero. I think "type"
might be a pointer, and sparse should be complaining about the horrid
use of a bare 0 as NULL.

Similar issues might happen for enums, where various compilers will
complain about comparing an enum to a non-enum.

So I'm pretty sure you would want casts on both values, instead of
assuming "it's an integer type, I don't need to cast 0".

But yeah, maybe

  #define is_signed_type(type)  (((type)-1) <= (type)0)

works fine and avoids warnings in all the cases.

Famous last words. Warnings can happen for almost anything, and I
wonder if that use of "1" had some other reason.

           Linus
