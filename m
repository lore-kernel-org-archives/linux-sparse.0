From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 22:57:27 +0000
Message-ID: <CACXZuxfwk4OVaOBRZh8P=LL8aOf5Uic9B5p+ZYQgm5p5W3SviA@mail.gmail.com>
References: <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
 <20170311123039.tcpo2dcajfmxwmsm@macbook.local> <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
 <20170311141201.kptzqgn4qpu3gaic@macbook.local> <CACXZuxfojJBjZBibhBOUT9z0K8JLWRKmxwHCMqEYShd7vR5zhQ@mail.gmail.com>
 <CAFtxgO5T6Lrb3OYX+OgG4chZrFWG7Jk1Gp2HWtLu5yPU_+QKuw@mail.gmail.com>
 <20170311155135.kjxkiymcn7jo2ez2@macbook.local> <CACXZuxdZMf=j+kn7CRoasb+Gf+BWQER71uVFAkRRr8dwrmEP=A@mail.gmail.com>
 <20170311204432.ahvs2w7ewd6jcoh4@macbook.local> <CACXZuxcViP8VddEdJ0dAUAuA4cmkL1g-gkRKfmi+gUcBrpCj7Q@mail.gmail.com>
 <20170311223056.dgmyobmxvgpfn3fj@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:32781 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933216AbdCKW53 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 17:57:29 -0500
Received: by mail-io0-f182.google.com with SMTP id f84so65647346ioj.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 14:57:28 -0800 (PST)
In-Reply-To: <20170311223056.dgmyobmxvgpfn3fj@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

On 11 March 2017 at 22:30, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> >         long baz(int  *ip) { return ip - ((int *)0); }
>> >
>>
> baz:
>> .L6:
>>         <entry-point>
>>         divs.64     %r13 <- %arg1, $4
>>         scast.32    %r14 <- (64) %r13
>>         ret.32      %r14
>
> It's not incorrect, only that the scast is unneeded.
> But strangely, I don't see that cast here.
>

Why the division? That seems incorrect to me.

Regards
