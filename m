From: "Chris Li" <sparse@chrisli.org>
Subject: Re: [PATCH 5] Adding the NULL pointer checker.
Date: Mon, 29 Jan 2007 14:30:58 -0800
Message-ID: <70318cbf0701291430q629a9252r322ee4bb477d48b9@mail.gmail.com>
References: <20070117023918.GF962@chrisli.org>
	 <45BB0B65.7060403@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:32288 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbXA2WbA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Jan 2007 17:31:00 -0500
Received: by nf-out-0910.google.com with SMTP id o25so10512nfa
        for <linux-sparse@vger.kernel.org>; Mon, 29 Jan 2007 14:30:59 -0800 (PST)
In-Reply-To: <45BB0B65.7060403@freedesktop.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>, Linus Torvalds <torvalds@osdl.org>, linux-sparse@vger.kernel.org

> > --- sparse.orig/expand.c      2007-01-16 11:13:18.000000000 -0800
> > +++ sparse/expand.c   2007-01-16 11:13:28.000000000 -0800
> > -#define SELECT_COST 20               /* Cut-off for turning a conditional into a select */
> > -#define BRANCH_COST 10               /* Cost of a conditional branch */
> > +#define SELECT_COST 0                /* Cut-off for turning a conditional into a select */
> > +#define BRANCH_COST 0                /* Cost of a conditional branch */
>
> OK, I *think* that won't cause any harm.

Linus, any words here? I have a vague impression that it has some thing to
do with simplifying phi usage, but I am not sure what is the real side effect.

Any way, the back ends should be able to do this transform themselves if they
need to.

> Overall, this patch looks good, and I really like the idea of doing malloc
> checking with Sparse.  I have a few comments, interspersed below.

Thanks for the review and applying my other patches. I am going to
update the null-ptr  checker patch.

>
> The main issue, however: I can't seem to get it to generate any warnings.
> I've tried running it on the following program, and it produces nothing:
>
> #include <stdlib.h>
> int main(int argc, char *argv[])
> {
>         int *i = malloc(sizeof(int));
>         return *i;
> }
>
> Shouldn't this program provoke some warnings?  And could you supply some
> test code which does provoke warnings?
>
Oops, I forget to look at the pointer load case.

The following patch should fix it. I can add my test case to a patch as well.
It should be nice to have some regression test suit.

--- .pc/state-rewrite-3.quiltsave/check-nullptr.c       2007-01-28
17:21:14.000000000 -0800
+++ check-nullptr.c     2007-01-28 17:27:53.000000000 -0800
@@ -179,6 +179,7 @@ static void follow_pointer_usage(struct
                        follow_pointer_usage(useri, useri->target, index);
                        break;
                case OP_STORE:
+               case OP_LOAD:
                        if (pseudo == useri->src) {
                                struct instruction *use =
checker_instruction(useri, OP_USE_PTR,

       pseudo);


>
> > The interrupt checking is just a toy. Without cross function checking,
> > it is way too many false positive.
>
> I don't mind including it in an early stage, defaulting to off.

Just as you said in the later part of the comment, the interrupt checking is
not quite ready yet.

>
> > --- sparse.orig/checker.h     2007-01-16 11:13:28.000000000 -0800
> > +++ sparse/checker.h  2007-01-16 11:57:29.000000000 -0800
> > @@ -0,0 +1,108 @@
> > +#ifndef _CHECKER_H_
> > +#define _CHECKER_H_
> > +
> > +struct blob {
> > +     int len;
>
> size_t len, please.

I can change it to unsigned int, just to consistent with the allocation code.
But I think size_t is over kill here because blob has  the same limitation
as the allocation code. The size can't be bigger than the allocation chunk
size, which is 32K right now. It is wrong to use really big object any way.

>
> > +     unsigned char data[0];
> > +};
> [...]
> > --- sparse.orig/expand.c      2007-01-16 11:13:18.000000000 -0800
>
> Why this change, to use a NULL-terminated iteration rather than a counted
> iteration?  I don't see the benefit.

That is should be cleaned up. I used to add my function match code here.

>
> > @@ -211,14 +213,19 @@ enum opcode {
> >
> >       /* Needed to translate SSA back to normal form */
> >       OP_COPY,
> > +     OP_LAST,
> >  };
>
> Hmmm...
>
> > --- sparse.orig/check-interrupt.c     2007-01-16 11:13:28.000000000 -0800
> > +++ sparse/check-interrupt.c  2007-01-16 11:13:28.000000000 -0800
> [...]
> > +enum {
> > +     OP_CLI = OP_LAST,
> > +     OP_STI,
> > +     OP_RESTORE,
> > +};
>
> Ouch.  This will break if anything else attempts to extend the opcode list
> in the same way.

Nope, this is checker specific opcode, which is *private* to the
checker. Checker
does not modify the bb->insn list. These opcode is generated in the
private checker
struct.

If anything attempts to extend the opcode list, it is likely a backend,
e.g. the x86 back end.

The checker don't need to know any thing about x86 back end specific
instruction. If it really do, then the check can use the last opcode of x86
and extend that.

If you think private opcode is not fine, please explain why it will break
other stuff.

>
> Have you considered attempting to express interrupts as another form of
> context?  Now that the basic framework for multiple types of context exists,
> perhaps you could treat interrupts as another kind of context?

Yes, they can. That has been considered. But it need to modify the linux code
to add context into interrupt related functions. I try not to modify
the checking
source code in spirit of the Stanford checker.

I am leaning towards adding annotation information for inline functions
so the checker can find out which inline function has been called.

>
> > +static inline void scan_interrupt_insn(struct entrypoint *ep)
> > +{
> > +     struct basic_block *bb;
> > +     struct instruction *insn;
> > +
> > +     FOR_EACH_PTR(ep->bbs, bb) {
> > +             struct bb_state *bbs = bb->state;
> > +             FOR_EACH_PTR(bb->insns, insn) {
> > +                     if (!insn->bb)
> > +                             continue;
> > +                     if (insn->opcode == OP_RET) {
> > +                             add_instruction(&bbs->insns, insn);
> > +                             continue;
> > +                     }
> > +                     else if (insn->opcode != OP_ASM)
> > +                             continue;
> > +                     if (!strcmp(insn->string, "cli"))
> > +                             add_instruction(&bbs->insns, checker_instruction(insn, OP_CLI, NULL));
> > +                     else if (!strcmp(insn->string, "sti"))
> > +                             add_instruction(&bbs->insns, checker_instruction(insn, OP_STI, NULL));
> > +                     else if (!strcmp(insn->string, "pushl %0 ; popfl"))
> > +                             add_instruction(&bbs->insns, checker_instruction(insn, OP_RESTORE, NULL));
>
> Ouch.  x86-specific, and specific to the exact strings from the Linux inline
> assembly.
>
> We really need the metalanguage part of Engler's paper that you referenced.
> This kind of thing seems reasonable for random scripts written to check
> particular problems and interpreted by Sparse, but not for code going into
> Sparse itself.

As I said, the interrupt checking is a prove of concept. It is a demo for
checking state not bind to a specific pseudo.

>
> Also, modifying the instructions in bbs seems like it would conflict with the
> use of other checkers, due to the enum collision described above.

Why? bbs is private checker state information. Each checker will initialize its
own bbs pointer. It is up to the checker how to store information there. Again,
the bbs->insns is different from the bb->insns. It is the checker instruction.
Consider checker as a lower level back end.

About the metalanguage, I don't think we need it right now. The code here
try to find out the caller for "sti" and "cli". We still need to write
the matching
code in metalanguage, having the metalanguage does not magically solve the
problem. Maintain and debug code generate by such a metalanguage is going
to be painful. You are still going to know the internal of metalanguage to be
able to debug it.

I think there is benefit for writing checking in pure C. Each checker
is its own module. I think the example here is simple enough that we can have
the whole execution engine inside the checker. It runs faster than those call
back based trigger. It is easier to debug the code.

Maintaining the metalanguage is a lot of over head. It is not some thing
I plan to do any time soon. It add a lot of complexity as well.

> > +static inline void execute_pointer_usage(struct instruction *insn)
> > +{
> > +     if (reg_state(insn->src) & PTR_NULL)
> > +             warning(insn->pos, "funcion %s possible using NULL pointer",
> > +                     show_ident(insn->bb->ep->name->ident));
>
> s/funcion/function/; s/possible/possibly/.

Thanks for catching that.

> Idea for future work (not for this patch): we might want to make sure that
> memory allocated with a given malloc gets freed with a given free.

It has been considered. It should be a later feature.

>
> > +     static const char *noret[] = {
> > +             "panic",
> > +             NULL,
> > +     };
>
> We already have __attribute__((noreturn)); please use that rather than
> matching against a list here.

I wish I can used that as well. But it is definitely a different patch to fix
function attribute parsing. It is getting very hairy.

Chris
