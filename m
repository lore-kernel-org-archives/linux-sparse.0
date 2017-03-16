From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 16 Mar 2017 22:19:05 +0100
Message-ID: <20170316211904.ac52l6nfag45v37z@macbook.local>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37628 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbdCPVTJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 17:19:09 -0400
Received: by mail-wm0-f43.google.com with SMTP id n11so2091906wma.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 14:19:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 16, 2017 at 01:43:05PM -0700, Linus Torvalds wrote:
> On Thu, Mar 16, 2017 at 1:19 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
> >
> > The issue is not with the type of %r6 but %arg3 and %arg4 if these
> > happen to be integer constants, and the function is variadic so we
> > cannot work out the type from the function prototype.
> 
> Yes. Ok, I see the problem.
> 
> I think we could add a 'size' to the pseudo, and solve it that way.
> CSE and other linearization artifacts may mean that the type is
> undefined, but the size should be well-defined.
> 
> Alternatively - and this might be the better solution - the OP_CALL
> instruction might be better off split up a bit. Instead of having just
> that
> 
>     struct pseudo_list *arguments;
> 
> that lists the arguments, maybe it should have a
> 
>     struct instruction_list *arguments;
> 
> with a new OP_ARG instruction to generate the argument.
> 
> That way all the arguments would have a size, and always a generating
> instruction.

Just to be sure of what you're suggesting, you mean that code like:
	int foo(int a)
	{
		printf("%d %d", a, 123);
	}

Would be linearized as something like:
	foo:
		<entry-point>
		set.64		%r1 <- "%d %d"
		arg.64		%r2 <- %r1 
		arg.32		%r3 <- %arg1
		arg.32		%r4 <- %123
		call.32		%r5 <- printf, %r2, %r3, %r4

with the %r2, %r3, %r4 in the call identifying their defining
instructions and the size of these OP_ARG instruction being,
of course, defined at linearization time with the type
of the corresponding expression?

-- Luc
