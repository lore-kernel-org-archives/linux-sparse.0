From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: SMATCH indicates warning to almost all files in Linux Kernel + ARM
Date: Thu, 14 Sep 2017 19:33:56 +0200
Message-ID: <CAExDi1QgpPJw1oAr=Q=myCTsgP+71EBU4=w5=3GiGAMsw3Tn9A@mail.gmail.com>
References: <8760clkby1.wl%kuninori.morimoto.gx@renesas.com> <CANeU7QmvVRtO6kddNwG0C8yv1+g=8tbcfqy9++Vy=wsDvH-rTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:33171 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbdINRd5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 14 Sep 2017 13:33:57 -0400
In-Reply-To: <CANeU7QmvVRtO6kddNwG0C8yv1+g=8tbcfqy9++Vy=wsDvH-rTQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Dan Carpenter <dan.carpenter@oracle.com>, smatch@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Sep 14, 2017 at 5:55 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Sep 14, 2017 at 3:01 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
>>
>> Hi Christopher
>>
>> I'm using SMATCH for Linux Kernel + ARM compile.
>> It indicates below warning for almost all files on ARM compile.
>> Thus, it is difficult to check "real" CHECK.
>> Is this my/kernel fault ?
>
> Adding linux sparse mailing list.

Adding Dan & smatch mailing list.

>>   CC      sound/soc/soc-dapm.o
>>   CHK     kernel/config_data.h
>> linux/arch/arm64/include/asm/lse.h:14:28: warning: Unknown escape 'l'
>> linux/arch/arm64/include/asm/lse.h:14:37: warning: Unknown escape 'l'
>> linux/arch/arm64/include/asm/alternative.h:172:28: warning: Unknown escape 'o'
>
> This is cause by the assembly syntax in arm header file.
>
>> ...
>> .macro alt_lse, llsc, lse
>>         alternative_insn "\llsc", "\lse", ARM64_HAS_LSE_ATOMICS
>> .endm

This is solved in sparse since commit f83c2b8f0b5fcb8f60342b5a2fa51a84901f355a:
    "warn on unknown escapes after preprocessing"

-- Luc Van Oostenryck
