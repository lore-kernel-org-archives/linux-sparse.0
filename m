From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 15:02:29 -0800
Message-ID: <CA+55aFxetVdvXef_hF4UixNtxqL4uRZ3E4Hao_C_rNRfS-ZYeg@mail.gmail.com>
References: <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
 <20170311123039.tcpo2dcajfmxwmsm@macbook.local> <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
 <20170311141201.kptzqgn4qpu3gaic@macbook.local> <CACXZuxfojJBjZBibhBOUT9z0K8JLWRKmxwHCMqEYShd7vR5zhQ@mail.gmail.com>
 <CAFtxgO5T6Lrb3OYX+OgG4chZrFWG7Jk1Gp2HWtLu5yPU_+QKuw@mail.gmail.com>
 <20170311155135.kjxkiymcn7jo2ez2@macbook.local> <CACXZuxdZMf=j+kn7CRoasb+Gf+BWQER71uVFAkRRr8dwrmEP=A@mail.gmail.com>
 <20170311204432.ahvs2w7ewd6jcoh4@macbook.local> <CACXZuxcViP8VddEdJ0dAUAuA4cmkL1g-gkRKfmi+gUcBrpCj7Q@mail.gmail.com>
 <20170311223056.dgmyobmxvgpfn3fj@macbook.local> <CACXZuxfwk4OVaOBRZh8P=LL8aOf5Uic9B5p+ZYQgm5p5W3SviA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:35072 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752022AbdCKXCb (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 18:02:31 -0500
Received: by mail-it0-f53.google.com with SMTP id m27so13396400iti.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 15:02:30 -0800 (PST)
In-Reply-To: <CACXZuxfwk4OVaOBRZh8P=LL8aOf5Uic9B5p+ZYQgm5p5W3SviA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Jeff Garzik <jeff@garzik.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

On Sat, Mar 11, 2017 at 2:57 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Why the division? That seems incorrect to me.

Pointer differences are not byte differences, but index differences.
So with an "int *" you need to divide the difference by 4 (you don't
see the subtraction, since subtracting NULL ends up being a no-op).

                   Linus
