From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 00/27] LLVM fixes
Date: Sat, 11 Mar 2017 21:44:33 +0100
Message-ID: <20170311204432.ahvs2w7ewd6jcoh4@macbook.local>
References: <CACXZuxc8rbcGSO9dTkFSKST8UJkDgc2ifFae5=Y+cojtm5qb3Q@mail.gmail.com>
 <20170311114903.zrhufw6ydneky3ya@macbook.local>
 <CACXZuxcL4NHa2Ahdtu91rANDFTUw8hY9BizN-9pLgpyQ2wPf-w@mail.gmail.com>
 <20170311123039.tcpo2dcajfmxwmsm@macbook.local>
 <CACXZuxc4F-PgDQO0p-nYB0D6NkrJf7cS0qWB=SkO5tQJzGFpxQ@mail.gmail.com>
 <20170311141201.kptzqgn4qpu3gaic@macbook.local>
 <CACXZuxfojJBjZBibhBOUT9z0K8JLWRKmxwHCMqEYShd7vR5zhQ@mail.gmail.com>
 <CAFtxgO5T6Lrb3OYX+OgG4chZrFWG7Jk1Gp2HWtLu5yPU_+QKuw@mail.gmail.com>
 <20170311155135.kjxkiymcn7jo2ez2@macbook.local>
 <CACXZuxdZMf=j+kn7CRoasb+Gf+BWQER71uVFAkRRr8dwrmEP=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37228 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755049AbdCKUoi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 15:44:38 -0500
Received: by mail-wm0-f54.google.com with SMTP id n11so16449874wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 12:44:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxdZMf=j+kn7CRoasb+Gf+BWQER71uVFAkRRr8dwrmEP=A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Pekka Enberg <penberg@kernel.org>

On Sat, Mar 11, 2017 at 06:08:04PM +0000, Dibyendu Majumdar wrote:
> On 11 March 2017 at 15:51, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Sat, Mar 11, 2017 at 10:10:27AM -0500, Jeff Garzik wrote:
> >> On Sat, Mar 11, 2017 at 9:16 AM, Dibyendu Majumdar
> >> <mobile@majumdar.org.uk> wrote:
> >> > I still think pseudo values should have a type - then we won't need
> >> > all the complexity!
> >>
> >> Yep, agreed - giving pseudos a type is both natural and intentional -
> >> it is a natural outcome of the operation, and should be available
> >> without any further lookups.  Giving pseudos a type actually
> >> simplifies complexity and makes tree manipulation (optimizer) easier.
> >>
> >>  ...of course we need to maintain that type information correctly in
> >> all cases and through all transformations...
> >
> > OK. The mini-serie I just posted *should* give (correct?) type
> > information to all PSEUDO_VALs.
> >
> > Dibyendu, can you look if we can make good use of it?
> >
> 
> Sure. We may need to rework some of the previous changes but one case
> comes straight to mind - that of variadic functions such as printf.

Yes, two patches from series can be dropped.
But there is still some bad issues that remains,
for example pointer subtraction with NULL and some
optimization that destroy correct typing info.
They're bad enough to make me doubt of the value of this change.

Here are some failing cases:
	#define NULL ((void *)0)
	int  tst(int  *ip) { return !ip; }
	int  foo(int  *ip) { return ip != NULL; }
	long bar(void *vp) { return vp - NULL; }
	long baz(int  *ip) { return ip - ((int *)0); }

For variadic functions, this is yet another story.

-- Luc
