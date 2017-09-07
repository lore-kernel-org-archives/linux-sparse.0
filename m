From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Simple SSA status
Date: Thu, 7 Sep 2017 05:17:35 +0200
Message-ID: <20170907031723.pajy6pfuu6bgf577@ltop.local>
References: <CANeU7QmekgnTBVF_7kZRAL-LB+g2W4MZbchxrApnQVeQk32wDw@mail.gmail.com>
 <20170903202629.bipsxi7xnmh3y3oy@ltop.local>
 <CANeU7Q==zoxfgzGLKS00AqZ-M07Whr9Nu5gZtANd4PK_u3J47A@mail.gmail.com>
 <20170904200720.cxxfecd7rugyfskx@ltop.local>
 <CANeU7Q=KV7k+z=SYyvkVJGFLmXE-Un2x-WQeGBmydTb0mj=dbQ@mail.gmail.com>
 <20170905005553.lwwo3hcre3vlgafd@ltop.local>
 <CANeU7Q=SSLWZL-AYLT8JMh9CVkJLaGVtWz2u5x4jNbgq3SKrDg@mail.gmail.com>
 <20170907020312.yt6z5jsfb4xn6m2a@ltop.local>
 <CA+55aFxFJf4T4kQq1oRNatFQnXuonPA-Dk7=xNTeU8u9cVyUGA@mail.gmail.com>
 <CANeU7Q=OXu+rma4BLt80bdMMjTz7t8TGX34Q4FJVQ5zRx1huag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38727 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbdIGDRj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 23:17:39 -0400
Received: by mail-wm0-f50.google.com with SMTP id 187so1934857wmn.1
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 20:17:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=OXu+rma4BLt80bdMMjTz7t8TGX34Q4FJVQ5zRx1huag@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Sep 06, 2017 at 10:55:43PM -0400, Christopher Li wrote:
> On Wed, Sep 6, 2017 at 10:15 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > Even this is not the case.
> >
> > Not for a C compiler, it isn't.
> >
> > Sure, if you do compilers for toy languages, it might be, but a C
> > compiler has things like "switch()" statements that may not nest with
> > loops etc. So even without a goto, you can pretty much have arbitrary
> > flow.
> 
> I am trying to think if without goto statement, can we create irreducible
> graph. The for reducible graph, finding dominator has fast path.

Bah ...
Depending on the algorithm you use, irreducible graphs may indeed be a bit
faster to calculate but since you don't know in advance if your graph is
reducible or not, you can't take advantage of that. So, at least to me,
this doesn't make it a fast path.

> On way to look at the Simple SSA paper is that, it is taking advanctage
> of that fast path.

No. It takes advantage at every point where it is known that all the parents
have already been processed. That's all.

The part where reducibility matter is after the conversion is done, if
you whish to simplify what they call trivial phi-nodes. And again, since
you don't know in advance if your graph is reducible or not, there is no
fast path.

-- Luc
