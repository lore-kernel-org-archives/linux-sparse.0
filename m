From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Fri, 4 Aug 2017 02:11:24 +0200
Message-ID: <20170804001122.4ivc2sktypvg2w3i@ltop.local>
References: <20170730151254.xlnz7c4zphhnhump@ltop.local>
 <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local>
 <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
 <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com>
 <CANeU7QmzundH7qpdYhQqDJgBv+5pPemwft+1uH5oVQ1POnoQDw@mail.gmail.com>
 <CAMHZB6E0NYy_bNJftB5n4BFZ4-fNf___n0RN1OPb+jkV4Ry-Dw@mail.gmail.com>
 <20170803214906.dvvyibtf53j3ah6m@ltop.local>
 <CA+55aFzif2qNMQ0xniB6ubgGJu67h25K3G9jyGHPHa6o-unjTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36769 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751866AbdHDAL1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 3 Aug 2017 20:11:27 -0400
Received: by mail-wm0-f41.google.com with SMTP id t201so7495142wmt.1
        for <linux-sparse@vger.kernel.org>; Thu, 03 Aug 2017 17:11:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFzif2qNMQ0xniB6ubgGJu67h25K3G9jyGHPHa6o-unjTg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Aug 03, 2017 at 03:35:04PM -0700, Linus Torvalds wrote:
> On Thu, Aug 3, 2017 at 2:49 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > My conclusion is that most of the problem here comes from the fact that:
> >    - sparse always inlines function marked as inline
> >    - and does so very early, before any optimizations (so the extra macro
> >      code is inlined 2044 times and need to be processed 2044 times).
> 
> Yeah, I think that's sadly fairly fundamental to how sparse inlining works.
> 
> Sparse inlines things on a tree level, but most optimizations and
> simplifications are done on the SSA representation.
> 
> That very early inlining was actually a fairly big design decision
> originally - at some point I actually wanted to allow sparse to have
> inline functions act as untyped "templates" that it inlined, and that
> had their types evaluated only within the context of being used.

Yes, it makes sense.
 
> I have this memory of that actually even working to some degree at
> some point (ie you could leave arguments to inline functions untyped,
> and they would take their type from the invocation). But that may have
> been with special patches.
> 
> But yes, for this particular case it's apparently a horrible choice,
> exactly because it inlines very early before any actual evaluation of
> anything.

Well, if we'll want one day to have some sort of automatic inlining,
like for small functions or functions that are only called once,
we'll need to have inlining on linearized code. One more thing in
the todo list. Otherwise, for 'normal' sane usage, the current
inliner work well enough.

OTOH, I just saw that the heavy inlining is only a marginal part
of the problem here. The real problem is that __builtin_constant_p()
is not expanded because of a type mismatch in a conditional:
one operand is 0 while the other is the inline function which return void.
The type mismatch makes that the expression has no type so no expansion
is done.

-- Luc
