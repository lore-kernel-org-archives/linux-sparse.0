From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Trying to understand linearized output
Date: Sun, 12 Mar 2017 18:20:51 +0100
Message-ID: <20170312172050.24fwpfamwb3iivru@macpro.local>
References: <CACXZuxfTBH2hr8kOXepJ7VGCrfvjMU3h8GhDfZhtPEA6Ynw6jA@mail.gmail.com>
 <20170312171021.ivhh2fjyyj3xcgb5@macpro.local>
 <CACXZuxdX3ANytHJ+MPEm9gqcV0D8wJt7cWq4vSVkU7ffmDHFuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34845 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933837AbdCLRUz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 13:20:55 -0400
Received: by mail-wr0-f177.google.com with SMTP id g10so90978970wrg.2
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 10:20:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxdX3ANytHJ+MPEm9gqcV0D8wJt7cWq4vSVkU7ffmDHFuw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 12, 2017 at 05:15:54PM +0000, Dibyendu Majumdar wrote:
> On 12 March 2017 at 17:10, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > On Sun, Mar 12, 2017 at 02:11:37PM +0000, Dibyendu Majumdar wrote:
> >> ...
> >>
> >> My question is:
> >>
> >> phisrc.64   %phi98(current) <- %r333
> >>
> >> The phi98 above is presumably referencing a pseudo which has number
> >> 98. But this is not part of this function, so I am confused. Does this
> >> look right?
> >
> > I didn't checked all the details by it looks right.
> >
> > The %phi98 is not referencing a pseudo which has the number 98.
> > It is a pseudo numbered 98 and which is of type PSEUDO_PHI.
> > Those kind of pseudos are exclusively created by 'phisrc' instructions
> > and used by 'phi' instructions.
> > Here this %phi98 is used by the phi instructions at block .L127
> >
> > These 'phi' instructions are the core of the SSA representation of
> > intermediate code. If needed Wikipedia gives a good introduction:
> >          https://en.wikipedia.org/wiki/Static_single_assignment_form
> 
> 
> Thanks. I am familiar with phi instructions in LLVM, but the phisrc
> instructions in Sparse are new to me.

Good. I wasn't sure.

Those phisrc are unimportant, you can consider them as a kind of 'move'
which is only but systematically used for each pseudo feeded to a phi
instruction. They ahev no special semantic, they just make some things
little bit easier for sparse.

Luc
