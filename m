From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Question about Sparse Linear form and pseudos
Date: Thu, 7 Sep 2017 04:22:44 +0200
Message-ID: <20170907022242.mdhuijzvlzjn45e4@ltop.local>
References: <CACXZuxd4iKbuvZZ5M0q=xRRDMpxc5UjXp=4+vBjvF8rjdV4-=A@mail.gmail.com>
 <20170820151513.ddoxdwo7iwd2nefh@ltop.local>
 <CACXZuxenUKprEMjScasEMZNxYDFGeSy8soPpYxbDbd+1kWHY1w@mail.gmail.com>
 <CA+55aFwzXM1e+7uDA_3fSWn1Jof3YFQ4y+r16MaRYF09KU5Xcg@mail.gmail.com>
 <CACXZuxcsTb9mzX-4P6QGCHxVY_=MjTwJexF8BnoFErotCTFjdg@mail.gmail.com>
 <CA+55aFx1QVQg4fsgXtduexbx4YdQe1QBPQiA6GK37CVi=3cBpw@mail.gmail.com>
 <CAExDi1T8n+qqjCjA=dHK3K68hvcYqXOTiiUWX+qHzNcVHDSEmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35295 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752616AbdIGCWs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 6 Sep 2017 22:22:48 -0400
Received: by mail-wm0-f41.google.com with SMTP id f199so1274766wme.0
        for <linux-sparse@vger.kernel.org>; Wed, 06 Sep 2017 19:22:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAExDi1T8n+qqjCjA=dHK3K68hvcYqXOTiiUWX+qHzNcVHDSEmQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 06:45:09PM +0200, Luc Van Oostenryck wrote:
> On Sun, Aug 20, 2017 at 6:33 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I wouldn't guarantee it - I *think* it may be the case that even the
> > initial linearization is actually proper SSA (just with everything
> > going through memory)
> 
> It's odd to me to talk about SSA when there is no phi-nodes
> because all accesses are made via memory, but yes, I'm positively
> sure that even before we call simplify_symbol_usage() (which
> to me is where the real conversion to SSA is done) no pseudo
> is defined at two different places. So yes, the SSA properties is
> already true at the initial linearization.

There is at least one exceptional case, though:
	int foo(int c)
	{
		if (c)
			return 0;
	}

It's, of course, wrong code and should be somehow rejected but
currently, nothing wrong is detected and since returns are
linearized directly with phi-node, we end up with the exit
block having two parents but with a phi-node with a single
operands. It's annoying.

I don't know of any other situations at initial linearization.
So, nothing fundamental but some complications.

There is another whole class of problems concerning SSA correctness
other than the conversion to SSA. It's when correctness is destroyed
by some code transformations involving changes in the CFG:
- packing of BB
- branch simplification: insert_branch()
- possibly try_to_simplify_bb() too

-- Luc
