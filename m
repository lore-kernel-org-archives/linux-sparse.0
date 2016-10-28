From: Christopher Li <sparse@chrisli.org>
Subject: Re: NiosII GCC Compiler Built-Ins Question
Date: Fri, 28 Oct 2016 22:46:40 +0800
Message-ID: <CANeU7Q=8Dk_R_auTPpZ72OnfPJVsHGd92O+uXpO9phQWpV=BwA@mail.gmail.com>
References: <2a743451-2dda-a16c-6eec-a43e223c5c53@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:35214 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755530AbcJ1Oql (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 28 Oct 2016 10:46:41 -0400
Received: by mail-yw0-f178.google.com with SMTP id h14so88954422ywa.2
        for <linux-sparse@vger.kernel.org>; Fri, 28 Oct 2016 07:46:41 -0700 (PDT)
In-Reply-To: <2a743451-2dda-a16c-6eec-a43e223c5c53@opensource.altera.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: tthayer@opensource.altera.com
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Oct 28, 2016 at 10:21 PM, Thor Thayer
<tthayer@opensource.altera.com> wrote:
> Hi,
>
> When I'm running sparse on my NiosII Linux build, I'm seeing many errors
> concerning an undefined identifier which is actually a GCC built-in for the
> NiosII architecture [1].
>
> ./arch/nios2/include/asm/irqflags.h:34:9: error: not a function <noident>
>
> Googling this error led me to 2 possible solutions.
> 1. Comment it out in the Linux source [2].

That is not the way to go.

> 2. Additions in the sparse lib.c file [3].

How about add the prototype in sparse and protect it by
#ifdef condition. Then sparse still need to have some way to
introduce the architecture flags. Maybe the default will pick the
host architecture and allow command options to overwrite the
architectures. If gcc has similar architecture options we should
reuse those in sparse.

I am open to other suggestion as well.

Chris
