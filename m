From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 21:21:34 +0000
Message-ID: <CACXZuxcViP8VddEdJ0dAUAuA4cmkL1g-gkRKfmi+gUcBrpCj7Q@mail.gmail.com>
References: <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com>
 <20170311114903.zrhufw6ydneky3ya@macbook.local> <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
 <20170311123039.tcpo2dcajfmxwmsm@macbook.local> <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
 <20170311141201.kptzqgn4qpu3gaic@macbook.local> <CACXZuxfojJBjZBibhBOUT9z0K8JLWRKmxwHCMqEYShd7vR5zhQ@mail.gmail.com>
 <CAFtxgO5T6Lrb3OYX+OgG4chZrFWG7Jk1Gp2HWtLu5yPU_+QKuw@mail.gmail.com>
 <20170311155135.kjxkiymcn7jo2ez2@macbook.local> <CACXZuxdZMf=j+kn7CRoasb+Gf+BWQER71uVFAkRRr8dwrmEP=A@mail.gmail.com>
 <20170311204432.ahvs2w7ewd6jcoh4@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:36895 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754480AbdCKVVg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 16:21:36 -0500
Received: by mail-it0-f53.google.com with SMTP id g138so13908921itb.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 13:21:35 -0800 (PST)
In-Reply-To: <20170311204432.ahvs2w7ewd6jcoh4@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

On 11 March 2017 at 20:44, Luc Van Oostenryck > But there is still
some bad issues that remains,
> for example pointer subtraction with NULL and some
> optimization that destroy correct typing info.
> They're bad enough to make me doubt of the value of this change.
>
> Here are some failing cases:
>         #define NULL ((void *)0)
>         int  tst(int  *ip) { return !ip; }
>         int  foo(int  *ip) { return ip != NULL; }
>         long bar(void *vp) { return vp - NULL; }
>         long baz(int  *ip) { return ip - ((int *)0); }
>

I only get a failure on the last one. But I am synced with master - so
it may be an issue with sparse-next branch?

For the last one, looks like linearized output is incorrect?

baz:
.L6:
        <entry-point>
        divs.64     %r13 <- %arg1, $4
        scast.32    %r14 <- (64) %r13
        ret.32      %r14
