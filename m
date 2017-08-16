From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] sparse SSA construction
Date: Wed, 16 Aug 2017 01:15:39 -0400
Message-ID: <CANeU7Q=vWytMCrUgHLYhhZ8RiCk1itzmmLbhFWXT6RsLzZ_0dw@mail.gmail.com>
References: <20170806202651.8763-1-luc.vanoostenryck@gmail.com>
 <CACXZuxchKzgv_cN7MzZnT09OX1thdODoinqSVzK8jSxdPCVK8w@mail.gmail.com>
 <CANeU7Qk9C-78+-a2TOGUWiLof9S_p9vO6bHyNf6xZqZ5X1CoUQ@mail.gmail.com>
 <CACXZuxeGgFmjDosHv-Exd9qRLfonFGUrD7sx-ucQejuR0jsD+w@mail.gmail.com>
 <CANeU7QmQ8DdeBLx9kDNf-xnTOUc=V7VNu95A+dAL4oUbLngonw@mail.gmail.com>
 <CACXZuxcb8YVcdkTjvo-0cxDughp0kveQCN_sDKWzxxE0QFs=+A@mail.gmail.com>
 <CA+55aFwXc6QDgZSv++ZUUTHEixsMoKUq6Wc-6sQ4g5po5ZmA5g@mail.gmail.com>
 <CAMHZB6GZCcOfAD3qkFs39hVQ1om5TdCM5CTTwAb2aqLH1Hbriw@mail.gmail.com>
 <CA+55aFzvNEGEbO=H9C5q29js7A57zMm00a8i5NqDfPsZAxpr2g@mail.gmail.com> <CAExDi1QQzTKeC1b=9sJYTANBvBDswqwqH1O1XsSED_oeYYVwnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:36203 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751452AbdHPFPl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 01:15:41 -0400
Received: by mail-yw0-f173.google.com with SMTP id u207so16452071ywc.3
        for <linux-sparse@vger.kernel.org>; Tue, 15 Aug 2017 22:15:41 -0700 (PDT)
In-Reply-To: <CAExDi1QQzTKeC1b=9sJYTANBvBDswqwqH1O1XsSED_oeYYVwnA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Aug 15, 2017 at 5:43 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Yes, what I thought for a long while,
> But when things like try_ti_simplify_bb() come in play,
> with pack_basic_blocks() on top the things become
> *very* messy I often you can't make sense of it anymore.

It is not only messy, it is plain wrong that SSA dominance property
has been violated.

>> IOW, you could think of the phi nodes as being "outside" the
>> instruction flow entirely, and just being the definition of the pseudo
>> they define. They have to be placed somewhere, but the "somewhere" is
>> somewhat arbitrary.
>
> It's true to a certain point, after it, you need to have them placed at
> the confluence point. I can't explain better for now. I'll have an
> example tomorrow.

I give one example in my other email. I think that arbitrary view is
actually wrong:

phi node is a function that select value depend on which edge the
control flow come from. Place it arbitrary cause the phi node
does not have access the edge information how the define joined.
It need to be place at the dominance frontier, which just barely
out of reach of the dominance of the define.

> Not directly related to that is that I really think we need to associate
> a ph-node's source to it's parent BB.

Exactly. Notice that parent ( predecessor) might not be the BB
that define the variable. It is where the definition not longer
dominance (dominance frontier).

Again, the simple way to explain this, it is the requirement of
the SSA dominance property.

Chris
