From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 00:23:52 -0400
Message-ID: <CANeU7Qmq8N7Bqg0pWNONC8NkZ5J7p07B+UPBB-0eF9dTAOBYYg@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com> <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33902 "EHLO
        mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdHPEXy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 00:23:54 -0400
Received: by mail-yw0-f172.google.com with SMTP id s143so16016768ywg.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 21:23:53 -0700 (PDT)
In-Reply-To: <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 15, 2017 at 4:43 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> I do think you're too hung up about the placement of the phi nodes.
>
> It may be an issue for simple models that just walk the linearized
> code directly and try to turn it into code. But the original intent of
> the existing phi node code was to just be as sources of the pseudo's -
> the location should be largely immaterial.
>
> IOW, you could think of the phi nodes as being "outside" the
> instruction flow entirely, and just being the definition of the pseudo
> they define. They have to be placed somewhere, but the "somewhere" is
> somewhat arbitrary.

I am actually with Luc on this one. The placement of the phi node
is critical if you want to do the minimal phi node implementation.
Even you are not doing the minimal phi node, you can't do less than
the minimal phi node.

Ignore the not reachable phi node for the following discussion.  if we
are missing one of the phi node where the minimal phi node place it
(aka dominance frontier) . We are doing some thing wrong, the SSA
dominance property has been violated.

To reason about this, we can reference back to the SSA dominance
property. When dominance of a definition ends, (in other words, dominance
frontier). It need to place a phi node to join the other definition of
the variable
from all predecessors. Without that particular phi node, all successor
of this join block will no longer able to distinguish how the multiple define
merge. We can have more phi node than this, but the phi node on the
dominance frontier *must not* be skipped. Skipped it cause SSA dominance
property being violated. The variable is not static any more.

If sparse only place the phi node on where the loads are, which a lot of
case happen to be the DF (dominance frontier). In the case that DF
does not have loads, that is where current sparse do wrong, sparse
does not place a phi node  there. Which violate the SSA property.

Chris
