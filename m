From: Christopher Li <sparse@chrisli.org>
Subject: Re: [GIT PULL] llvm fixes
Date: Sun, 12 Nov 2017 09:04:43 +0800
Message-ID: <CANeU7Q=qa4Je13z65nHa_V=QAC4w-30GiO3e72Lp5C49QYcDVg@mail.gmail.com>
References: <20170918095135.12066-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qnu7h09YHhGVOY3r4M9FNOvOrs+kB_yJT-i0cSeLtKhAw@mail.gmail.com>
 <CANeU7QnFkJC4YePAdSTmKXNKiraCZHKJPSaNbKVPqdf01NhrYg@mail.gmail.com>
 <20171105171013.mktkihyuuagqthaq@ltop.local> <CANeU7QkXyUonK-wKjrGp_Ka6vBsFaJ65S3OvjMzLTKc8VUoW4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f170.google.com ([209.85.161.170]:43675 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdKLBEp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 20:04:45 -0500
Received: by mail-yw0-f170.google.com with SMTP id y75so10958038ywg.0
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 17:04:45 -0800 (PST)
In-Reply-To: <CANeU7QkXyUonK-wKjrGp_Ka6vBsFaJ65S3OvjMzLTKc8VUoW4w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

OK, this is the most difficult review for me to write, the OP_PUSH patch:
I have think this long and hard.

>commit 92fed40628f932a20a6cc95a67e4e5b03d280757
>Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>Date:   Fri Mar 17 11:49:42 2017 +0100
>
>    give function's arguments a type via OP_PUSH
>
>    The linearized code, sparse's IR, have no use of C's complex type
>    system. Those types are checked in previous phases and the pseudos
>    doesn't a type directly attached to them as all needed type info
>    are now conveyed by the instructions (like (register) size,
>    signedness (OP_DIVU vs OP_DIVS), ...).
>
>    In particular, PSEUDO_VAL (used for integer and address constants)
>    are completely typeless.

I think the PSEUDO_VAL being typeless is the problem here.

>    There is a problem with this when calling a variadic function
>    with a constant argument as in this case there is no type in the
>    function prototype (for the variadic part, of course) and there is
>    no defining instructions holding the type of the argument.

No only here as problem. As you hint in your change

======================quote ===========================
>commit e154d59f375bdb307c4d778bab8055a380e2840e
>Author: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>Date:   Wed Mar 8 08:19:50 2017 +0100
>
>    llvm: fix translation of PSEUDO_VALs into a ValueRefs
>
>    In sparse-llvm there is the assumption that a PSEUDO_VAL is always
>    of integer type. But this is not always the case: constant pointers,
>    like NULL, are also of the PSEUDO_VAL kind.
>
>    Fix this by adding a helper 'val_to_value()' and using the
>    instruction's type where this pseudo is used as the type of the value.
>
>    Note: while this patch improve the situation, like for example for the
>    test cases added here, it's still not correct because now we're making
>    the assumption that 'insn->type' is the type we need for the pseudo.
>    This is often true, but certainly not always.
>    For example this is not true for:
>    - OP_STORE/OP_LOAD's insn->src
>    - OP_SET{EQ,...}'s   insn->src[12]
>    - probably some  others ones
>    - in general, obviously, for any instructions where the target has
>      a different type than the operands.
========================quote ==========================

There is other place  want to have PSEUDO_VAL size which is not provide by
instruction type.

>
>    Fix this by adding a new instruction, OP_PUSH, which will be used
>    to pass arguments to function calls and whose purpose is to give
>    a correct type/size to function's arguments.

This OP_PUSH is fixing a uncommon case (function call variance part
has constant).

I did purpose a different way to fix this problem, actually also
suggested by Linus, you are CC on the email, back in Aug 13.

https://patchwork.kernel.org/patch/9897573/
https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=pseudo-sized-value

Compare OP_PUSH vs PSEUDO_VAL with size.

OP_PUSH:
- break sparse IR compatibility.
- Allocate more memory (mostly duplicate information)
- create special instruction that is not part of bb->insns. Push
instruction in insn.arguments.
- PSEUDO_VAL size still have other case not covered by instruction type.
- more verbose output on linearize instructions.

PSEUDO_VAL with size:
- compatible to previous IR if you don't care about the size.
- no extra memory allocation for storing the size part.
  (there will be extra memory allocation for same value with different size).
- fix other place PSEUDO_VAL size is needed but not provide by instruction type.
- less impact to the code all around.

So far I see PSEUDO_VAL with size has advantage over
OP_PUSH. If I am wrong, please correct me, I am listening.

I think that is the biggest worry I have on this series. The rest
of my feed back is kind of trivial I don't mind merge then fix it.


Chris
