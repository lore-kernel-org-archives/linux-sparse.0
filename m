From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Fri, 17 Mar 2017 00:12:14 +0100
Message-ID: <20170316231213.kv5yvkyguqmtqckw@macbook.local>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
 <20170316211904.ac52l6nfag45v37z@macbook.local>
 <CA+55aFzD3K7XcXTwVqbY0sM5FirAprm7kMyOvP3x1S5uO2zSnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:36309 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbdCPXMi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 19:12:38 -0400
Received: by mail-wr0-f174.google.com with SMTP id u108so41790913wrb.3
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 16:12:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFzD3K7XcXTwVqbY0sM5FirAprm7kMyOvP3x1S5uO2zSnQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 16, 2017 at 03:28:10PM -0700, Linus Torvalds wrote:
> On Thu, Mar 16, 2017 at 2:19 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Just to be sure of what you're suggesting, you mean that code like:
> >         int foo(int a)
> >         {
> >                 printf("%d %d", a, 123);
> >         }
> >
> > Would be linearized as something like:
> >         foo:
> >                 <entry-point>
> >                 set.64          %r1 <- "%d %d"
> >                 arg.64          %r2 <- %r1
> >                 arg.32          %r3 <- %arg1
> >                 arg.32          %r4 <- %123
> >                 call.32         %r5 <- printf, %r2, %r3, %r4
> >
> > with the %r2, %r3, %r4 in the call identifying their defining
> > instructions and the size of these OP_ARG instruction being,
> > of course, defined at linearization time with the type
> > of the corresponding expression?
> 
> Close. I was thinking that the "OP_ARG" instructions wouldn't really
> generate any pseudo's, they'd just consume them (like the OP_CALL does
> now).
> 
> So taking your example, which currently linearizes as
> 
>   foo:
>       call.32     %r3 <- printf, "%d %d", %arg1, $123
>       ret.32      %r3
> 
> I was more thinking that you'd linearize it purely as a split of the
> OP_CALL into "OP_ARG* + OP_CALL":
> 
>   foo:
>       arg.64   "%d %d"
>       arg.32   %arg1
>       arg.32   $123
>       call.32   %r3 <- printf
>       ret.32   %r3
> 
> where the OP_ARG would act kind of like a OP_SETVAL instruction, but
> it wouldn't have a target pseudo (the target is the "call" instruction
> that follows).

OK, I see.
 
> Now, an alternative would be that we *do* give it a pseudo target, but
> not a regular one, but an "outgoing argument" one. We currently have
> those PSEUDO_ARG pseudos that are for incoming arguments, and we could
> split that into PSEUDO_ARG_IN and PSEUDO_ARG_OUT.
> 
> I dunno. My mental model was to just always have the OP_ARG
> instructions tie very closely to the OP_CALL that they are associated
> with.

I think it's good that there is no pseudos between these OP_ARG and
the corresponding OP_CALL since it's kinda a 'single use' value
that must not be part of CSE & simplification.
So I think your mental model is the good one even if it is a bit
different from what other instructions are doing, but of course
the argument passing is *not* like other instructions..
We can simply see these OP_ARG as a sort of pseudo-push instruction.

Anyway, thanks for the feedback.

-- Luc
