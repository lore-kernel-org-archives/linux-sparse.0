From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC v0 0/4] Give a type to constants too
Date: Thu, 16 Mar 2017 11:40:59 -0700
Message-ID: <CA+55aFw_0CRfvfROz=bg8CpEST2vXXBY3=TeqULfgM8F5b-FEA@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
 <CA+55aFyqMScsVe8-5T=omdpSsFaYmdD-PbK3KqKW=1gXgitMaA@mail.gmail.com>
 <CACXZuxcKbT66NV6cc1+VObmcKYUWtCXvp3U_CY1mPuT5tdSw9g@mail.gmail.com>
 <CA+55aFyVDASFQA=DsOKcTvLxA9NmsyZZpBOFovuTm8WJwb36vQ@mail.gmail.com> <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37707 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751663AbdCPSlC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 14:41:02 -0400
Received: by mail-it0-f49.google.com with SMTP id g138so55575290itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 11:41:02 -0700 (PDT)
In-Reply-To: <CACXZuxdfb8p2qtMZ9ggBFZ1oz-WM-MZFX22oPXkp58FK6Ura1A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Thu, Mar 16, 2017 at 11:24 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Agreed and we are doing that except that the function call instruction
> only has the type of the call, not the arguments (as far as I
> understand - apologies if I have got this wrong).

The "OP_CALL" should have the call type in the instruction itself:

                struct /* call */ {
                        pseudo_t func;
                        struct pseudo_list *arguments;
                        struct symbol *fntype;
                };

in that "fntype".

So you should not need it for the pseudo (that contains the address of
the function to call).

That was done exactly for the varargs issue, see commit ff527e2
("sparse, llvm: Make function declaration accessible to backend")

Now, that code may be *buggy*, of course, but it's actually very
important, exactly for the same kind of "one pseudo may be associated
with multiple types".

In particular, it's not uncommon to have auto-generated code (or
various handwritten interpreters) have the function be encoded as some
kind of void pointer, and then depending on use, the same pointer
value is used differently.

Eg code like this:

    typedef int (*binop_t)(int, int);
    typedef int (*unop_t)(int);

    #define BINOP 0

    unsigned int execute(int type, void *fn, int arg1, int arg2)
    {
        if (type == BINOP)
                return ((binop_t)fn)(arg1,arg2);
        return ((unop_t)fn)(arg1);
    }

which will linearize to something that does:

    call.32     %r7 <- %r6, %arg3, %arg4

in one branch, and

    call.32     %r13 <- %r6, %arg3

in another. Notice how it uses the same pseudo (%r6) in both cases,
even though the type of the function called is different.

So like all the other cases, the type of the operation (in this case,
a function call) has to be encoded in the instruction itself, not in
the pseudo.

               Linus
