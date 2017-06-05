From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/3] allow to normalize the pseudos
Date: Mon, 5 Jun 2017 13:50:42 -0700
Message-ID: <CANeU7Q=7Tr4i7iTGq+B77TcC8AzDgy+EVdqbJ9BJuBVrezDLhg@mail.gmail.com>
References: <20170603073416.66808-1-luc.vanoostenryck@gmail.com>
 <20170603073416.66808-4-luc.vanoostenryck@gmail.com> <CANeU7QnyLhPVAMDTGHLFnmgzcXWLeedr6mW=sCHZDL3C6igX=Q@mail.gmail.com>
 <CAExDi1T7_8cniYqznotzTyJWSD_XJ1he2G-hpQJfTPc=EQ7HiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33984 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbdFEUun (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Jun 2017 16:50:43 -0400
Received: by mail-it0-f68.google.com with SMTP id d68so24189548ita.1
        for <linux-sparse@vger.kernel.org>; Mon, 05 Jun 2017 13:50:43 -0700 (PDT)
In-Reply-To: <CAExDi1T7_8cniYqznotzTyJWSD_XJ1he2G-hpQJfTPc=EQ7HiQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jun 5, 2017 at 12:54 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The problem that the patch here tries to solve is that *between* different
> versions of sparse, because of some subtle (or not so subtle) changes
> in the details of linearization or the optimization, a function, while
> having essentially the same intermediate code have in fact different
> name (here just the number) for its pseudos.
> And these differences are annoying when comparing results, during
> development and for the test suite. Also, given the 'problem', it's very
> fine to keep the code simple and only make the changes in a separate
> pass only used for dev & test.
>
> I have already tried several things in the past 6 months and anything
> a bit smart had some problems, it's why, finally, I opted for the brute force
> here in this patch.
>
> I think that what you propose here, will just allow to have consecutive
> pseudo numbers but I don't see how it will give the guarantee that
> "same code" will give "same pseudo numbers" and this will be easily
> be 'diffed out' so that only real differences will show up in diff output.

You will still need to reset the pseudo_base per show_entry().
That way, each function is reset the displaying pseudo to start
from 1. Same code should have the same pseudo number at the
same instruction, no?

As far as I can tell, behavior should be very  similar to your patch.
Just don't need to do a separate pass to go through each instruction.

> Well, it's true for now that we could reset the counter at each function
> and this would already 'solve' most of the cases I had. But what if
> we begin to add a second pass of automatic inlining?

That is still fine, each pseudo has its own memory allocation.
The number is just for show_instruction text output. Make sure
reset the pseudo_base inside show_entry() will force the inlined function
allocate new pseudo for different pseudo, base on the memory allocation.
If after inline two different pseudo has the same "nr", as long as they
both smaller than pseudo_base, they will be assign to different number
 in the new round.

> And keeping unique names every pseudo has advantages.

I think each pseudo do has unique pointer and storage so that did not change.
The "nr" is only for showing the text information.

If we want to be smart about comparing the output, we should have
a smarter diff against instructions. Right now if one of the basic block
use one more pseudo will likely impact other basic block because the
pseudo has shifted for other basic block, even it is the instruction code
is equivalent for other basic block.

Chris
