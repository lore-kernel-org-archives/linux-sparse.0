From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Sun, 6 Aug 2017 19:01:29 -0400
Message-ID: <CANeU7Qk3trZmFqyGuhOxBLzFBOT131o=HhNhwQrzLrHoO2PQ1Q@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34575 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751352AbdHFXBa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 19:01:30 -0400
Received: by mail-pg0-f52.google.com with SMTP id u185so26857066pgb.1
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 16:01:30 -0700 (PDT)
In-Reply-To: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 6, 2017 at 4:26 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Since it seems to be some interest on the subject and
> to avoid duplicated work, here is a rewrite of sparse's
> construction of the SSA form.
>
> It's not using one of the classical algorithm but is
> using something newer, simpler and often faster.
> It's main advantage beyond the simplicity is that you don't
> need to first build the whole CFG & linearized code to
> to directly throw it away (or heavily transform it) as
> it builds the SSA form directly during the linearization.

OK, great.

May I ask the question that, the SSA form you are building
from this codes. Does it violate the SSA dominance property
define as:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
=CE=A6-Functions are placed in all basic blocks of the
Dominance Frontier.

Dominance Property of SSA:
1. If x is used in a Phi-function in block N,
then the definition of x dominates *every* <=3D=3D=3D=3D notice "every"
predecessor of N.
2. If x is used in a non-Phi statement in N,
then the definition of x dominates N
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D

In other word, does it produce the "usage before
define" IR similar to this?

        and.32      %r3 <- %r4, $-65
         or.32       %r4 <- %r3, $64

> It's not finished code but it's working well (and is
> effectively a bit faster and use less memory).

The correct behavior is the most important one.
Then performance.

> What's interesting for sparse now is that:
> - the phi-noes are correctly placed

In the dominance frontier, right? That is great.

> - uninitialized variables can be handled much more easily.

That I am very curios how it was done. See the above
question. I might not have time to go through your code
very quickly. I will do my best when I have some time.

Chris
