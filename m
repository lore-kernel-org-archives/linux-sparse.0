From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Makefile: pass -Wno-vla to sparse while checking pre-process.c
Date: Sun, 30 Jul 2017 20:12:41 -0400
Message-ID: <CANeU7QmkqXGpXJMCNnve=CTGtoS0c45E8fRgH_644nkb7v+-cQ@mail.gmail.com>
References: <c318f85f-43e5-e902-3032-89eeddcb4ffa@ramsayjones.plus.com> <CANeU7QmEsrBCOW3sA_6iPZvC4XQKadhZ7Y9dDmQ=789NqZt8pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36489 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdGaAMm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 30 Jul 2017 20:12:42 -0400
Received: by mail-pf0-f172.google.com with SMTP id z129so74770633pfb.3
        for <linux-sparse@vger.kernel.org>; Sun, 30 Jul 2017 17:12:42 -0700 (PDT)
In-Reply-To: <CANeU7QmEsrBCOW3sA_6iPZvC4XQKadhZ7Y9dDmQ=789NqZt8pA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sun, Jul 30, 2017 at 8:05 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Jul 30, 2017 at 7:27 PM, Ramsay Jones
>
> You actually don't need to introduce CHECKER_FLAGS.
> You can just do:

Ah, I see what you mean here. You want to distinguish
CFLAGS for gcc, CHECKER_FLAGS for sparse specific
flags.

It is different than what I have in mind, I think  that is fine
too.

I will apply.

Chris
