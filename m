From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Makefile: pass -Wno-vla to sparse while checking pre-process.c
Date: Sun, 30 Jul 2017 20:05:58 -0400
Message-ID: <CANeU7QmEsrBCOW3sA_6iPZvC4XQKadhZ7Y9dDmQ=789NqZt8pA@mail.gmail.com>
References: <c318f85f-43e5-e902-3032-89eeddcb4ffa@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35822 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdGaAF7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 30 Jul 2017 20:05:59 -0400
Received: by mail-pf0-f178.google.com with SMTP id t86so4315984pfe.2
        for <linux-sparse@vger.kernel.org>; Sun, 30 Jul 2017 17:05:59 -0700 (PDT)
In-Reply-To: <c318f85f-43e5-e902-3032-89eeddcb4ffa@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Jul 30, 2017 at 7:27 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>
> Introduce a $(CHECKER_FLAGS) variable to allow adding flags, using
> target specific variable assignments, to specific $(CHECKER) command
> invocations. In particular, in a new pre-process.cs target, include
> '-Wno-vla' in the flags while checking pre-process.c.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

Thanks, I want to apply it. But I have some very minor feed backs.

> +pre-process.sc: CHECKER_FLAGS += -Wno-vla
> +

You actually don't need to introduce CHECKER_FLAGS.
You can just do:

pre-process.sc: CFLAGS += -Wno-vla

The target specific CFLAGS will only impact pre-process.sc.

I would use CHECKER_FLAGS is for some thing impact all the
checker target.

>
>  %.sc: %.c sparse
> -       $(QUIET_CHECK) $(CHECKER) -c $(ALL_CFLAGS) $<
> +       $(QUIET_CHECK) $(CHECKER) $(CHECKER_FLAGS) -c $(ALL_CFLAGS) $<

If you use target specific CFLAGS, there is no need to use CHECKER_FLAGS.

Chris
