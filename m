From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: SSSA and some C pointer manipulation.
Date: Sun, 20 Aug 2017 18:18:09 +0200
Message-ID: <CAExDi1Tgs7UpXm0OCwLbLDVfZsAHQx2z-ygWEQ1fUnWVU1aNXg@mail.gmail.com>
References: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36834 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbdHTQSL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 12:18:11 -0400
Received: by mail-oi0-f45.google.com with SMTP id g131so134927235oic.3
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 09:18:11 -0700 (PDT)
In-Reply-To: <CANeU7Qm-k0xzRXwVx0bSg688+yFTa_PrC7EnKdyJY8HCWZT-uw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 19, 2017 at 4:46 AM, Christopher Li <sparse@chrisli.org> wrote:
Hi Chris,

> One thing I notices is that, if the use site is very far
> from define, there are a lot of blocks in between. That
> will cause a lot of possible phi node to be created.

That's not what's happenning or what should happening.
I know that in such situation the current SSA may
creates fewer phi-nodes because the creation of phi-nodes
are delayed to the point where the value is effectively
used, but the's precisely why this method is wrong.

On the other hand, I have some very nice examples
where you have N if-statements and the current SSA
method creates N^2 phi-nodes while only N are needed
and the new method only creates these N ones.

It's really dangerous to compare the new method with
the old one because the old one does it wrongly.

> Another thing I just realized is that, this SSSA conversion
> only works for *local* variable, not C pointers?

It's very confusing to use the word 'C pointer' here.
A pointer is just a value like any other. What's you're
talking about, I think, is variables accessed through a
pointer.

> ...
> There are two functions foo() and foo_ptr(),
> The are exactly the same, except foo_ptr() is using
> ptr to access the variable. The pointer is not used
> for another other purpose.
>
> You can see in the foo base, the variable b
> has been promote to SSA. However, in foo_ptr()
> the variable b has not been promote to SSA.

It's indeed a difference between the current method
and the new one. The new one simply hasn't yet enough
information to prove that these global vars can't be
modified by some external way between the
accesses.

You must also not forget that the current method also
can't convert all possible global vars to pseudo
during the SSA conversion (simplify_symbol_usage()).
Simplify_loads() which is called *after* the 'general' SSA
conversion convert some such accesses after (and do it
wrongly too!).

What I mean here is that it's normal to not be able to
convert all possible accesses directly. But yes, for sure,
the most we can convert early, the best it is.

> I look back the paper, the paper actually did not
> discuss pointer at all.

Of course, because this topic is unrelated to the method.
What's your talking about is:
1) decide/select which vars will be promoted to pseudos
    (and this will be concerned witht he SSA)
2) alias analysis
These are topics orthogonal to the conversion *method*
(which doesn't mean that all methods offer the same possibilities).

You must also not forget that the paper is an academic paper
about a method. It's not a step-by-step guide on how
you must engineer your compiler.


-- Luc
