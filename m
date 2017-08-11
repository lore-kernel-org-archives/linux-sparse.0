From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] rationale for systematic elimination of OP_SYMADDR instructions
Date: Thu, 10 Aug 2017 21:17:44 -0400
Message-ID: <CANeU7Q=cN1z6bimq8aK_0KKxMwLvkBgA6A9r8xts67VHb2y7=w@mail.gmail.com>
References: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com>
 <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com>
 <CANeU7Q=zV+MAFOA6SzANEF9_7NB0rY719bzkesPnvUS9AqR+hw@mail.gmail.com>
 <CAMHZB6Gj0pS-z_tSPS+6tXhg2mAjGhDYxBLZXn0wmmAYePtZyg@mail.gmail.com>
 <CANeU7Qk7czDA+RJzxyZHRa9zJdvv19s0NYExfDoW+34HmkB4dA@mail.gmail.com>
 <CAMHZB6EvJss-53X2oyXGHTRpAjDnoK8W5dCbng2tqUmjMykORA@mail.gmail.com>
 <CANeU7QkJy-G4EXuJ94KBcmo3Bc0Pei0uQSTeYr-u4DxsSK==uQ@mail.gmail.com> <CAExDi1QVzkOVRxe+mdsHEi4=wirRFKrO+UFRDH2498z43oZidw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33780 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752061AbdHKBRq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 21:17:46 -0400
Received: by mail-yw0-f181.google.com with SMTP id p68so14781384ywg.0
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 18:17:46 -0700 (PDT)
In-Reply-To: <CAExDi1QVzkOVRxe+mdsHEi4=wirRFKrO+UFRDH2498z43oZidw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

First of all, I want to clarify that I ask this question is
to satisfy my curiously why it is done this way,
either it is the best optimal way to do it.

It is not reason to reject your patch. I trust you have good
reason to do it, I will accept the patch even if I don't fully
understand it. I still want to understand it after applying
it.

On Thu, Aug 10, 2017 at 6:16 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> All this have already been explained during the initial discussion but:
> * those OP_SYMADDR represent the *calculation* that is needed to get
> the address of a symbol.

That is fine, nod.

> * depending on the architecture, the kind/linkage/visibility of the symbol,
>   compiler flag, ... this calculation can be very simple, like:
>   - just a constant (but a big one)
>   - just a load at a constant address & a constant address
>   - or much more complicated

Agree so far.

> * the OP_SYMADDR *abstract* away the *details* of this calculation
>    but it is important to expose it

OK. I have the question that sparse checker don't need it.
I will defer to later part of email to ask.

> * of the reasons we want to expose it is that we *want* to do CSE on
>   these calculations

Do CSE do you mean just CSE OP_SYMADDR or CSE the complicated
instruction expand from OP_SYMADDR.

Let say you have code like this, the symbol is assign in different
scope block.

Before CSE there is 3 OP_SYMADDR "a".  After CSE where is those 3
OP_SYMADDR "a" is likely to be combine into one? Where would the
CSE place the OP_SYMADDR if it is not one of the beginning or dominator
etc?


int a;
void fool (void)
{
                ...
               { a = 1 };
           ...
           {a = 2;}
                     ....
                     {a = 3};
}


> * there is absolutely no reasons why we should process them differently
>   than any other instructions. In particular, it would be absurd to:
>   - try to put all of them at the top
>   - try to place them ourself at some other special place (common parent,
>     dominator, ...)
>   because CSE will place them automatically at the best place: as near as
>   possible from where they are needed.

In that case, you might just place it before load or store. You don't seem
to need CSE to do it. Sorry I feel that I am still missing some big picture.
I am desperately trying to fill it.

I also think that you make the OP_SYMADDR a lower level IR than
what I original have in mind writing linearizer. I expect there is a separate
phase where you translate the sparse IR into machine level code, that
is where you can insert the equivalent of OP_SYMADDR. gcc also
have tree-ssa-sink.c which move the instruction closer to the place it is
used. So it is not sparse's IR's job to keep it close. For the same reason
sparse IR don't try to make the warm blocks close together etc. I consider
those are for the level level back end to do.

What I original have in mind is that, IR should contain all information for
back end to generate machine code. The IR should also be minimalism.
Which means that, if any information can be deduced from the IR, the IR don't
have to store them (as on disk byte code format). I am not saying we should
stay that way. I am just saying what I have in mind previously.

> * it would also be a very bad idea to *not* generate them and only let the
>   backend generate them because it would then mean that iether:
>   - no CSE on them
>   - backend need to reimplement CSE for them
>   The backend, just need to *expose the details*, maybe change those
>   SYMADDR in the appropriate loads & adds & loads or whatever but
>   they need to be already there and processed by the middle-end.

OK. For the sparse checker question. The sparse checker does not use
OP_SYMADDR, can it have a global option default to on. Sparse checker
before running any file, turn that option to off? I also feel it strange that
sparse checker don't need the OP_SYMADDR while we force it to see
OP_SYMADDR just to ignore it.

Right now we don't have a real compiler using sparse(yet). However the
checker is the most common usage case. I do want to squeeze any
bit of performance out of sparse checker. So having OP_SYMADDR
can perennially slowdown sparse while nobody is benefiting from it (yet).
It is not speeding up sparse isn't it?

Can we enable OP_SYMADDR when some back end actually start to
use it? That is actually the same as the global option thing. Who needs
OP_SYMADDR turn the option on. It is no extra step as a different pass.

We can still turn the option on for checker for testing purpose. Is that
acceptable to you?

Chris
