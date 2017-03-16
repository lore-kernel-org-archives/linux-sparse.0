From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 16 Mar 2017 15:28:10 -0700
Message-ID: <CA+55aFzD3K7XcXTwVqbY0sM5FirAprm7kMyOvP3x1S5uO2zSnQ@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com> <20170316211904.ac52l6nfag45v37z@macbook.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:35143 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbdCPWgw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 18:36:52 -0400
Received: by mail-it0-f41.google.com with SMTP id m27so5075953iti.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 15:36:06 -0700 (PDT)
In-Reply-To: <20170316211904.ac52l6nfag45v37z@macbook.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 16, 2017 at 2:19 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Just to be sure of what you're suggesting, you mean that code like:
>         int foo(int a)
>         {
>                 printf("%d %d", a, 123);
>         }
>
> Would be linearized as something like:
>         foo:
>                 <entry-point>
>                 set.64          %r1 <- "%d %d"
>                 arg.64          %r2 <- %r1
>                 arg.32          %r3 <- %arg1
>                 arg.32          %r4 <- %123
>                 call.32         %r5 <- printf, %r2, %r3, %r4
>
> with the %r2, %r3, %r4 in the call identifying their defining
> instructions and the size of these OP_ARG instruction being,
> of course, defined at linearization time with the type
> of the corresponding expression?

Close. I was thinking that the "OP_ARG" instructions wouldn't really
generate any pseudo's, they'd just consume them (like the OP_CALL does
now).

So taking your example, which currently linearizes as

  foo:
      call.32     %r3 <- printf, "%d %d", %arg1, $123
      ret.32      %r3

I was more thinking that you'd linearize it purely as a split of the
OP_CALL into "OP_ARG* + OP_CALL":

  foo:
      arg.64   "%d %d"
      arg.32   %arg1
      arg.32   $123
      call.32   %r3 <- printf
      ret.32   %r3

where the OP_ARG would act kind of like a OP_SETVAL instruction, but
it wouldn't have a target pseudo (the target is the "call" instruction
that follows).

Now, an alternative would be that we *do* give it a pseudo target, but
not a regular one, but an "outgoing argument" one. We currently have
those PSEUDO_ARG pseudos that are for incoming arguments, and we could
split that into PSEUDO_ARG_IN and PSEUDO_ARG_OUT.

I dunno. My mental model was to just always have the OP_ARG
instructions tie very closely to the OP_CALL that they are associated
with.

                Linus
