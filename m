From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] rationale for systematic elimination of OP_SYMADDR instructions
Date: Wed, 26 Apr 2017 09:15:27 -0700
Message-ID: <CA+55aFxY_yMJxF2rLpBVYHPwNaWnvvXH-P0Ud1tYi8rE1g7tqg@mail.gmail.com>
References: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com> <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:35961 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdDZQP2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 26 Apr 2017 12:15:28 -0400
Received: by mail-io0-f182.google.com with SMTP id p80so5942529iop.3
        for <linux-sparse@vger.kernel.org>; Wed, 26 Apr 2017 09:15:28 -0700 (PDT)
In-Reply-To: <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Apr 25, 2017 at 7:49 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Roughly, once you begin to play with code generation, something like
> OP_SYMADDR is an operation that you will really do.
> Depending on the relocation, it can even be something relatively costly:
> I'm thinking static code on a 64bit machine where you can only generate
> 16bit constants, others cases may be not at all cheaper.
> So it's something that soon or later will need to be exposed and
> doing CSE on the address is good.

Ack. I think the OP_SYMADDR elimination was wrong, and your patch is
the right thing to do.

It was done to roughly approximate the 32-bit x86 code, making the
pseudo-asm that the linearizer outputs look more like x86 address
generation, but you're right, it's bogus.

                 Linus
