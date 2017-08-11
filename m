From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Fri, 11 Aug 2017 13:49:38 +0200
Message-ID: <20170811114937.fqzgxdqcq64jlpgn@ltop.local>
References: <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com>
 <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
 <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
 <CACXZuxd6O_c39=So7ruVwus9OV70gVo+dkjdPGHJVwcrRjzuVg@mail.gmail.com>
 <CA+55aFzWLUXdTPRRfyN+SCxDvedZ4pnCOcaYMQ17zLA-id3tJQ@mail.gmail.com>
 <CANeU7Qmmopaz-+Vf6sQpJ_UTuvXpKxRhmPMKXqO7XGikjF+d=g@mail.gmail.com>
 <CAExDi1QJDpWGPkqMfMLk0ky3Yqx-ofTa2xw-QQkRJxqGBaOHEA@mail.gmail.com>
 <CACXZuxecqPvcnQ+3UbrPK8gbjns893gUNsOymbY6X+kinrVf3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37203 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752526AbdHKLtn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 07:49:43 -0400
Received: by mail-wm0-f51.google.com with SMTP id i66so45343165wmg.0
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 04:49:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACXZuxecqPvcnQ+3UbrPK8gbjns893gUNsOymbY6X+kinrVf3w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Fri, Aug 11, 2017 at 11:28:23AM +0100, Dibyendu Majumdar wrote:
> Hi Luc,
> 
> On 10 August 2017 at 23:34, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > * the OP_PUSH instructions do a perfect job of giving a type to functions
> >   arguments
> > * the OP_PUSH instructions also nicely abstract away the *operation* of
> >   argument passing that all architectures have. It's a good thing.
> >
> 
> It is true that OP_PUSH instructions resolved the issue I was having.
> However there is something odd about them as they are not really
> instructions in the instruction stream, are they? They get added as
> arguments to the OP_CALL instruction. The solution works great though.

Yes, they are somehow odd. I'm not totally sure by what you exactly
mean by "in the instruction stream", though.

Let's use an example:
	fun(1, a)

Currently it's linearized as:
	call	fun, 1, a

The first version of the patch gave:
	arg	%r1, $1
	arg	%r2, a
	call	fun, %r1, %r2

The current version gives:
	push	$1
	push	a
	call	fun
which is very much like a lot of functions really work.
And yes, the 'pushes' is somehow disocciated from the 'call',
or the 'call' is not a consumer of the 'pushes'.
It's the stack that is the consumer from those 'pushes' and
the 'call' (or more exactly the function 'fun') that is the
consumer of (what have been pushed on) the stack.

The 'args' were really only a 'move' or 'copy' in disguise,
they are not needed at this level (but OK they *also* gave
the type).

The 'pushes' are IMO the right thing needed here.

-- Luc
