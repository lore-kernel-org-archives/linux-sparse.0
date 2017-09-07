From: Christopher Li <sparse@chrisli.org>
Subject: Re: Simple SSA status
Date: Wed, 6 Sep 2017 22:20:57 -0400
Message-ID: <CANeU7QmuZ1rWr08ZzGvyHDqmTvfgL9Abjzep2qWS3xQq7DL2XA@mail.gmail.com>
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
Received: from mail-yw0-f175.google.com ([209.85.161.175]:36665 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752142AbdIGCU6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 22:20:58 -0400
Received: by mail-yw0-f175.google.com with SMTP id w204so26718382ywg.3
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 19:20:58 -0700 (PDT)
In-Reply-To: <20170907020312.yt6z5jsfb4xn6m2a@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Sep 6, 2017 at 10:03 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Mmmm, I think you're confused.
> The dominator tree is a function of the whole graph, not just
> some blocks. Also, after linearization, there is no more for(),
> while() & do-while() or gotos: all CFG edges are alike.

I am not confused. I might jump my sentence too fast.

> What was written here above is that, *during linearization*,
> when you have a branch from a structured-programming statement,
> you know what are all the possible parents of the current block.
> For branches coming from goto, it's not the case.
> This has nothing to do with the dominance tree as such.

I am referring to the "A Simple, Fast Dominance Algorithm"
If there is no goto. The function  CFG is reducible graph.
For reducible graph that algorithm converge in constant iteration.
So finding the dominator tree is pretty much linear if the graph
is reducible.

> [Of course, the presence of gotos *can* create irreducible graphs
>  and for those calculating their dominance tree *can* take a bit
>  more time, but that's all.]

Right, the irreducible graphs is the trouble maker account for
those nasty worse case performance.

Chris
