From: Christopher Li <sparse@chrisli.org>
Subject: Re: SMATCH indicates warning to almost all files in Linux Kernel + ARM
Date: Thu, 14 Sep 2017 11:55:23 -0400
Message-ID: <CANeU7QmvVRtO6kddNwG0C8yv1+g=8tbcfqy9++Vy=wsDvH-rTQ@mail.gmail.com>
References: <8760clkby1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35205 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbdINPzZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 14 Sep 2017 11:55:25 -0400
Received: by mail-yw0-f196.google.com with SMTP id u134so1956226ywu.2
        for <linux-sparse@vger.kernel.org>; Thu, 14 Sep 2017 08:55:25 -0700 (PDT)
In-Reply-To: <8760clkby1.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 14, 2017 at 3:01 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Christopher
>
> I'm using SMATCH for Linux Kernel + ARM compile.
> It indicates below warning for almost all files on ARM compile.
> Thus, it is difficult to check "real" CHECK.
> Is this my/kernel fault ?

Adding linux sparse mailing list.


>   CC      sound/soc/soc-dapm.o
>   CHK     kernel/config_data.h
> linux/arch/arm64/include/asm/lse.h:14:28: warning: Unknown escape 'l'
> linux/arch/arm64/include/asm/lse.h:14:37: warning: Unknown escape 'l'
> linux/arch/arm64/include/asm/alternative.h:172:28: warning: Unknown escape 'o'

This is cause by the assembly syntax in arm header file.

> ...
> .macro alt_lse, llsc, lse
>         alternative_insn "\llsc", "\lse", ARM64_HAS_LSE_ATOMICS
> .endm
> ...
>

It seems that ARM has some very interesting assembly
directly embed into the C source code. That is not support
by sparse. Those section of code is protected by
__ASSEMBLY__ macro.

Can you try to turn off  __ASSEMBLY__ definition in the
sparse invocation?

As far as I can tell. That should get rid of the warning.

Chris
