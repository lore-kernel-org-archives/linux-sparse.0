From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-LLVM issue compiling NULL pointers
Date: Thu, 2 Mar 2017 18:18:43 +0100
Message-ID: <20170302171842.xuk535w6wrfxke3b@macpro.local>
References: <CAExDi1Sa3zDs--jht_43EmefT_nj5ThO_-QRdAFZJn=+rAw0iQ@mail.gmail.com>
 <CACXZuxeRe1Oe-Anht7hnsZgwZroP8sZdajvLBdO3oYCE1ofZ8Q@mail.gmail.com>
 <CACXZuxd2fO7-i84+nS5sC7ZHC68=_uJX3P9k75z05Y8vy2BAUA@mail.gmail.com>
 <20170302052124.fsqogvysufayy4to@macbook.local>
 <CACXZuxe_+-8H6SSA0NvpUdchWYzo_v=2KJq61QC9cVNYG3DGkQ@mail.gmail.com>
 <20170302135655.s742zcslis5r56if@macpro.local>
 <CACXZuxeiWM9zJZqtUC1YN6tFO6VsHkfTn9CZefr6P5nYUOpoRA@mail.gmail.com>
 <20170302160403.zz5efgh34jvjh5q5@macpro.local>
 <CACXZuxefWw7VT8VJPXuYZ2kBLK-N=eYGc6BF5Lnbg9vP-RqLWw@mail.gmail.com>
 <CACXZuxdr9ubL6S8PEzAHtOt9AT=PjYcv_8EotLD8_Cagc7ZGPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35268 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754672AbdCBR0f (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 12:26:35 -0500
Received: by mail-wm0-f51.google.com with SMTP id v186so141371893wmd.0
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 09:26:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxdr9ubL6S8PEzAHtOt9AT=PjYcv_8EotLD8_Cagc7ZGPw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Mar 02, 2017 at 04:30:53PM +0000, Dibyendu Majumdar wrote:
> >> Why I try your code (without LLVM assertions), I got indeed several
> >> problems:
> >>         Call parameter type does not match function signature!
> >>         i0 16
> >>          i64  %1 = call i8* @malloc(i0 16)
> >
> > I have the function argument fix so I don't get the malloc error.

Good.

> >>         Invalid bitcast
> >>           %27 = bitcast void <badref> to i8**
> >>         Both operands to a binary operator are not of the same type!
> >
> > I think this corresponds to the code that fails - the type of the LLVM
> > instruction is 'void' and the code is trying to cast to it or
> > something.

That's obviously wrong.

> >>           %R31 = add void <badref>, i64 %R30
> >>         Stored value type does not match pointer operand type!
> >>           store void %R31, i8** %46
> >>
> >
> > The code aborts at previous step
> >
> >> The first one is really weird but I think you don't see it.
> >
> > It is the function call issue, for which I have a fix I described.

OK.

> >> The next two I have no idea.
> >> The fourth have something obviously wrong with the type of its 'target'.
> >
> >> However, while running sparse-llvm on some code sample I use to test
> >> the linearization, I see that most errors are type errors and are
> >> related to pointer arithmetic, exactly where LLVM's getelemptr is used.
> >> Most offending instructions are OP_ADD (but since I have tests for
> >> bitfields I see also errors for OP_AND, OP_OR & OP_LSR).
> >> I guess that if you test OP_ADD instruction with pointer on one side
> >> and integer on tne other side and issue an appropriate LLVMBuildGEP(),
> >> things will already be much better.
> >>
> >
> > Here is the output from linearize. I think the way stores and loads
> > are handled is broken. It appears that the last store / load
> > instruction is stored in insn->target->priv, and then used later on
> > ... I do not understand what the code is trying to do. Is it trying to
> > optimize away stores and loads?

No, no.
What is stored in ->priv is the target's  LLVMValueRef (and for a store
the 'target' is what need to be stored).
And indeed there is a bug there: it's target_in that should be stored in
->priv (in fact, for a store, there is no need to put anything at all
in this field; at least I don't see any reason why it should).
Nice catch.
I don't know how it's related to your problem though.

Luc
