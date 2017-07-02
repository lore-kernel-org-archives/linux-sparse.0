From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Adding ignored attribute optimize
Date: Sun, 2 Jul 2017 21:58:19 +0200
Message-ID: <20170702195818.2lhotikeq2ozjb2n@ltop.local>
References: <CANeU7QnNNL1u3BxhWLebFqzn+9Y7hHKABDo_mkEqfwF+VO963Q@mail.gmail.com>
 <20170629070437.o6j2bkv6wdbcknwa@ltop.local>
 <CANeU7QnfvQ5KNFKvGGeJ1u7CDpd5wigosY0BrGNT1H0KouPHuA@mail.gmail.com>
 <20170701092440.egmgcexgwuuybzj7@ltop.local>
 <CANeU7Q=Zj6LT1--TP-XGouwVZVTgJor8h1+2GZ1r0HCjVa5pmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36933 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbdGBT6X (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 2 Jul 2017 15:58:23 -0400
Received: by mail-wm0-f44.google.com with SMTP id i127so89655829wma.0
        for <linux-sparse@vger.kernel.org>; Sun, 02 Jul 2017 12:58:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=Zj6LT1--TP-XGouwVZVTgJor8h1+2GZ1r0HCjVa5pmw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jul 01, 2017 at 03:21:36PM -0700, Christopher Li wrote:
> On Sat, Jul 1, 2017 at 2:24 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Sure it make some sense.
> >
> > But how often it happen and when it happen how much developers
> > are impacted and for how long?
> 
> It actually happen right now with the kernel using require_context
> which is not supported by sparse. Sparse should report error
> on the sparse related syntax which it does not support. Gcc is
> no going to report error on those sparse related attributes because
> gcc never see them.

"should report error" ...
What error exactly? Is there something that doesn't work on sparse
or on GCC's side regarding this 'require_context'? What need to be
fixed exactly?
 
> Because we have noway to tell an unknown attribute is belong
> to sparse or gcc.

That's *exactly* why sparse should *not* report. You have no way to
tell if what you're reporting is legitimate or not. And in most
cases it's legitimate on GCC's side but you still want to report it.

> Sparse checker should report it. It is very bad
> silence on those sparse specific error and developer have no way
> to know it.

It is very bad to report about all those false warnings.
It make sparse less usefull, not more.

> As for the distro version of sparse is too old.
> I think the right thing to do is just get into the habit of release
> more often.

Yes, it makes the problem worse, but even doing a release every
week won't change the problem when you take in account the lifetime
of distros.

If you want sparse to be usefull, you need to seek forward
compatibility and not blindly reporting lots of false warnings
for some very rare true ones.

But well ... let's agree we disagree.

-- Luc
