From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 23:30:56 +0100
Message-ID: <20170311223056.dgmyobmxvgpfn3fj@macbook.local>
References: <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
 <20170311123039.tcpo2dcajfmxwmsm@macbook.local>
 <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
 <20170311141201.kptzqgn4qpu3gaic@macbook.local>
 <CACXZuxfojJBjZBibhBOUT9z0K8JLWRKmxwHCMqEYShd7vR5zhQ@mail.gmail.com>
 <CAFtxgO5T6Lrb3OYX+OgG4chZrFWG7Jk1Gp2HWtLu5yPU_+QKuw@mail.gmail.com>
 <20170311155135.kjxkiymcn7jo2ez2@macbook.local>
 <CACXZuxdZMf=j+kn7CRoasb+Gf+BWQER71uVFAkRRr8dwrmEP=A@mail.gmail.com>
 <20170311204432.ahvs2w7ewd6jcoh4@macbook.local>
 <CACXZuxcViP8VddEdJ0dAUAuA4cmkL1g-gkRKfmi+gUcBrpCj7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36402 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755049AbdCKWbB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 17:31:01 -0500
Received: by mail-wr0-f195.google.com with SMTP id l37so15654767wrc.3
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 14:31:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxcViP8VddEdJ0dAUAuA4cmkL1g-gkRKfmi+gUcBrpCj7Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

On Sat, Mar 11, 2017 at 09:21:34PM +0000, Dibyendu Majumdar wrote:
> On 11 March 2017 at 20:44, Luc Van Oostenryck > But there is still
> some bad issues that remains,
> > for example pointer subtraction with NULL and some
> > optimization that destroy correct typing info.
> > They're bad enough to make me doubt of the value of this change.
> >
> > Here are some failing cases:
> >         #define NULL ((void *)0)
> >         int  tst(int  *ip) { return !ip; }
> >         int  foo(int  *ip) { return ip != NULL; }
> >         long bar(void *vp) { return vp - NULL; }
> >         long baz(int  *ip) { return ip - ((int *)0); }
> >
> 
> I only get a failure on the last one. But I am synced with master - so
> it may be an issue with sparse-next branch?

It's on my development branch:
	next
	+ today's 2nd serie
	+ today's 1st serie - 2 patches now unneeded.
So it's normal that you don't the same.

> For the last one, looks like linearized output is incorrect?
> 
> baz:
> .L6:
>         <entry-point>
>         divs.64     %r13 <- %arg1, $4
>         scast.32    %r14 <- (64) %r13
>         ret.32      %r14

It's not incorrect, only that the scast is unneeded.
But strangely, I don't see that cast here.

-- Luc
