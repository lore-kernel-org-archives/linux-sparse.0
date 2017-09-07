From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Simple SSA status
Date: Wed, 6 Sep 2017 19:15:13 -0700
Message-ID: <CA+55aFxFJf4T4kQq1oRNatFQnXuonPA-Dk7=xNTeU8u9cVyUGA@mail.gmail.com>
References: <CANeU7Q=9nUo+D3R3ypCS=-kND2vD_Qx84ua59_bi0-VGftPuqA@mail.gmail.com>
 <CAExDi1QryT9Hc6+yY0_E4Y6opsq3JiYo0KOidSDSj4VGD0J1Nw@mail.gmail.com>
 <CACXZuxfkduQSVJjzmYow5akJff_prmBeOS6Os-OnqCNpCCictA@mail.gmail.com>
 <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local> <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local> <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local> <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
 <20170907020312.yt6z5jsfb4xn6m2a@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:38725 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbdIGCPO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 22:15:14 -0400
Received: by mail-it0-f50.google.com with SMTP id p6so1680308itb.1
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 19:15:14 -0700 (PDT)
In-Reply-To: <20170907020312.yt6z5jsfb4xn6m2a@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Sep 6, 2017 at 7:03 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> What was written here above is that, *during linearization*,
> when you have a branch from a structured-programming statement,
> you know what are all the possible parents of the current block.
> For branches coming from goto, it's not the case.

Even this is not the case.

Not for a C compiler, it isn't.

Sure, if you do compilers for toy languages, it might be, but a C
compiler has things like "switch()" statements that may not nest with
loops etc. So even without a goto, you can pretty much have arbitrary
flow.

So I think people should entirely stop thinking that "goto" is somehow
special. It isn't. It is only special in toy languages like Pascal,
not in the real world.

It's much better to get rid of that "goto is special" mindset, and
instead say "all control flow is just a goto in the end".

So yes, get rid of the *real* special cases - those structured flow
constructs. They are nice special cases, but they are nice for
*humans*, they aren't actually relevant to computers, and they
shouldn't be.

So the real special case is those simple "structured" loops. You
should never design around them, because it will just hurt later.

Turn those "structures loop" constructs into goto's as quickly as you
can, and just forget about the structure that they really never
enforced anyway.

                   Linus
