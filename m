From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: SMATCH indicates warning to almost all files in Linux Kernel + ARM
Date: Fri, 15 Sep 2017 06:37:35 +0200
Message-ID: <CAExDi1Rgdtb5T5HZZwD+-=EwALkfLOEkVWHattfPALbphZ4v5Q@mail.gmail.com>
References: <8760clkby1.wl%kuninori.morimoto.gx@renesas.com>
 <CANeU7QmvVRtO6kddNwG0C8yv1+g=8tbcfqy9++Vy=wsDvH-rTQ@mail.gmail.com>
 <CAExDi1QgpPJw1oAr=Q=myCTsgP+71EBU4=w5=3GiGAMsw3Tn9A@mail.gmail.com> <87lglgu56d.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:34797 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbdIOEhh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 00:37:37 -0400
In-Reply-To: <87lglgu56d.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Christopher Li <sparse@chrisli.org>, Dan Carpenter <dan.carpenter@oracle.com>, smatch@vger.kernel.org, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Sep 15, 2017 at 3:29 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Christopher, Luc
>
> Thank you for your help
>
>> >>   CC      sound/soc/soc-dapm.o
>> >>   CHK     kernel/config_data.h
>> >> linux/arch/arm64/include/asm/lse.h:14:28: warning: Unknown escape 'l'
>> >> linux/arch/arm64/include/asm/lse.h:14:37: warning: Unknown escape 'l'
>> >> linux/arch/arm64/include/asm/alternative.h:172:28: warning: Unknown escape 'o'
> (snip)
>> It seems that ARM has some very interesting assembly
>> directly embed into the C source code. That is not support
>> by sparse. Those section of code is protected by
>> __ASSEMBLY__ macro.
>>
>> Can you try to turn off  __ASSEMBLY__ definition in the
>> sparse invocation?
>
> I tried it, but it couldn't solve my issue.
> Doesn't smatch check #if ? see below.
>
> But it seems this issue was already solved (?)
>
>         > This is solved in sparse since commit f83c2b8f0b5fcb8f60342b5a2fa51a84901f355a:
>         >     "warn on unknown escapes after preprocessing"
>
> I couldn't find this commit on latest smatch git.
> Maybe it will be added/merged for next version ?
> I'm happy to update smatch then :)
>
...

>
> I tried variously things, and it seems smatch doesn't check #if ?
> This lse.h file is this construction.
>
> --- lse.h ----------
>         ...
>         #if defined(CONFIG_AS_LSE) && defined(CONFIG_ARM64_LSE_ATOMICS)

I'm sure that smatch does check #if, but the wrong warnings you saw about the
escaped 'l' & 'o' are issued during tokenization, before the
pre-processing took place.
So using #ifdef __ASSEMBLER  or anything using pre-processing won't help you.
The commit I gave here above is really needed.


Best regards,
-- Luc Van Oostenryck
