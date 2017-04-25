From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] rationale for systematic elimination of OP_SYMADDR instructions
Date: Wed, 26 Apr 2017 03:20:35 +0800
Message-ID: <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com>
References: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36533 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428771AbdDYTUh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 25 Apr 2017 15:20:37 -0400
Received: by mail-it0-f45.google.com with SMTP id g66so25557177ite.1
        for <linux-sparse@vger.kernel.org>; Tue, 25 Apr 2017 12:20:36 -0700 (PDT)
In-Reply-To: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Mar 9, 2017 at 10:20 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> While investigating some problems related to code generation
> I realized that OP_SYMADDR are systematically eliminated,
> the target address are simply replaced by the symbol itself.
>
> While it's not wrong per se as it all depends to the semantic
> we want to give to pseudos and the instructions and how high-
> or low-level we want to IR, I don't think it was the intention
> to remove them and more importantly I don't think it's desirable.
>
> Those OP_SYMADDR allowed to make a clear separation between a symbol
> (a name with a type and info for storage & linkage) and its address
> (which can be stored in memory or in a register and on which
> arithmetic operations can then be done on it). Once these addresses
> are replaced by the symbol itself, those symbols can appears almost
> everywhere in the linearized code:
> - in calls' arguments,
> - in adds and subs (while doing pointer arithmetic),
> - in casts,
> - in load & stores,
> - ...
> and they complicate things considerably once you begin to be
> interested concretly in things after linearization & simplification
> since soon or later you will need the address anyway.
>
> So my question is:
>         "is there a good reason to eliminate those instructions?",

This change is introduce in 962279e8 by Linus:

    Remove OP_SETVAL after symbol-pseudo simplification.

    We can just replace all users with the symbol pseudo
    directly.

    This means that we can no longer re-do symbol simplification
    after CSE, and we need to rely on the generic memop simplification.

I can see the reason to do that is simplify the CSE. Before this change,
every reference to the symbol will do a OP_SETVAL (or OP_SYMADDR now
days) to get the address into a new pseudo. That is extra work for the
CSE to discover that:  "Oh,  all those different pseudo are actually the same
address for the same symbol. Let's replace it with the same pseudo."

I haven't understand why things are more complicate after linearization
if we replace all the symbol pseudo into one? Even if we don't do it here,
wouldn't the CSE should do that any way?

The way I see it, the pseudo of the symbol *is* the address of the symbol,
I don't see a problem using the address of the symbol.

Maybe you have some specific usage case in mind. Can you give some
example?

Chris
