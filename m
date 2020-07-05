From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] test-inspect: reset locale after gtk_init()
Date: Sun, 5 Jul 2020 12:12:55 -0700
Message-ID: <CAHk-=wjqh1KOVWaP=xPZH_9grwDVtCMitWOb4vtKj+cB0jghBw@mail.gmail.com>
References: <20200705185013.8578-1-davidsondfgl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgGETNO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 15:13:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1178C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 12:13:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t9so21357195lfl.5
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 12:13:13 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 23sm7386859ljv.129.2020.07.05.12.13.11
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 12:13:11 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id g2so21383143lfb.0
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 12:13:11 -0700 (PDT)
In-Reply-To: <20200705185013.8578-1-davidsondfgl@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Davidson Francis <davidsondfgl@gmail.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Jul 5, 2020 at 11:51 AM Davidson Francis <davidsondfgl@gmail.com> wrote:
>
> The test-inspect tool uses GTK to visualize symbol nodes. It turns
> out that gtk_init() implicitly sets the locale to the system locale,
> and since Sparse uses strtod()/strtold() for parsing floating-point
> numbers in expressions, parsing becomes locale-dependent.

We probably shouldn't be using strtod/strtold in the first place
because of issues like this, but I think your patch is likely the
simplest fix.

It _might_ be a good idea to limit it to LC_NUMERIC instead of LC_ALL,
but who knows.. I'm not sure what else might be affected (and I'm not
sure how good LC_NUMERIC support is on all platforms)

               Linus
