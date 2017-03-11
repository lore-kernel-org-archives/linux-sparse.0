From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sun, 12 Mar 2017 00:12:10 +0100
Message-ID: <CAExDi1RBUA=7OcU6Mjs8mE--w4Lzhb7LEZjcMrMft89H9tywuQ@mail.gmail.com>
References: <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
 <20170311123039.tcpo2dcajfmxwmsm@macbook.local> <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
 <20170311141201.kptzqgn4qpu3gaic@macbook.local> <CACXZuxfojJBjZBibhBOUT9z0K8JLWRKmxwHCMqEYShd7vR5zhQ@mail.gmail.com>
 <CAFtxgO5T6Lrb3OYX+OgG4chZrFWG7Jk1Gp2HWtLu5yPU_+QKuw@mail.gmail.com>
 <20170311155135.kjxkiymcn7jo2ez2@macbook.local> <CACXZuxdZMf=j+kn7CRoasb+Gf+BWQER71uVFAkRRr8dwrmEP=A@mail.gmail.com>
 <20170311204432.ahvs2w7ewd6jcoh4@macbook.local> <CACXZuxcViP8VddEdJ0dAUAuA4cmkL1g-gkRKfmi+gUcBrpCj7Q@mail.gmail.com>
 <20170311223056.dgmyobmxvgpfn3fj@macbook.local> <CACXZuxfwk4OVaOBRZh8P=LL8aOf5Uic9B5p+ZYQgm5p5W3SviA@mail.gmail.com>
 <CA+55aFxetVdvXef_hF4UixNtxqL4uRZ3E4Hao_C_rNRfS-ZYeg@mail.gmail.com> <CACXZuxdm_iWwuMXSi=k-hi_is5gV+=hPnY=4mBis=s=dn9V4YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36681 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbdCKXMM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 18:12:12 -0500
Received: by mail-qk0-f193.google.com with SMTP id n141so33257093qke.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 15:12:11 -0800 (PST)
In-Reply-To: <CACXZuxdm_iWwuMXSi=k-hi_is5gV+=hPnY=4mBis=s=dn9V4YQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Garzik <jeff@garzik.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

On Sun, Mar 12, 2017 at 12:04 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> On 11 March 2017 at 23:02, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Sat, Mar 11, 2017 at 2:57 PM, Dibyendu Majumdar
>> <mobile@majumdar.org.uk> wrote:
>>>
>>> Why the division? That seems incorrect to me.
>>
>> Pointer differences are not byte differences, but index differences.
>> So with an "int *" you need to divide the difference by 4 (you don't
>> see the subtraction, since subtracting NULL ends up being a no-op).
>>
>
> Okay that makes sense.

Yes, as Linus explained.
In fact I made the test cases to create this as I suspected some difficulties
there since it's the kind of operation that by its nature mix different types.

-- Luc
