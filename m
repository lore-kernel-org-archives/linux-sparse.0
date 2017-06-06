From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/3] allow to normalize the pseudos
Date: Mon, 5 Jun 2017 19:42:01 -0700
Message-ID: <CANeU7Q=53KK4i564s5RjQkYYOAZ_XaZVOvVJ3+aFDDX1P6KzSg@mail.gmail.com>
References: <20170603073416.66808-1-luc.vanoostenryck@gmail.com>
 <20170603073416.66808-4-luc.vanoostenryck@gmail.com> <CANeU7QnyLhPVAMDTGHLFnmgzcXWLeedr6mW=sCHZDL3C6igX=Q@mail.gmail.com>
 <CAExDi1T7_8cniYqznotzTyJWSD_XJ1he2G-hpQJfTPc=EQ7HiQ@mail.gmail.com>
 <CANeU7Q=7Tr4i7iTGq+B77TcC8AzDgy+EVdqbJ9BJuBVrezDLhg@mail.gmail.com> <CAMHZB6H0goAqdytZkyr_JypjYN-TVgb+VXSbygHs7m5YZkDaDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:37620 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbdFFCmC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Jun 2017 22:42:02 -0400
Received: by mail-it0-f53.google.com with SMTP id m47so95780508iti.0
        for <linux-sparse@vger.kernel.org>; Mon, 05 Jun 2017 19:42:02 -0700 (PDT)
In-Reply-To: <CAMHZB6H0goAqdytZkyr_JypjYN-TVgb+VXSbygHs7m5YZkDaDA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jun 5, 2017 at 3:10 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> You will still need to reset the pseudo_base per show_entry().
>> That way, each function is reset the displaying pseudo to start
>> from 1. Same code should have the same pseudo number at the
>> same instruction, no?
>>
>> As far as I can tell, behavior should be very  similar to your patch.
>> Just don't need to do a separate pass to go through each instruction.
>
> It would fro the simple/normal cases but not in general because simplify
> away an instruction and not creating this instruction at first don't have the
> same effect on the pseudo numbers.

If the instruction has been delete, the pseudo number for that instruction
target pseudo will be reassign to the next instruction. I think that
is justifiable.
You remove instructions you get different numbers.

> An example is the patch at https://patchwork.kernel.org/patch/9679745/
> which avoid to create a bunch of phi-nodes and phi-sources that will
> be simplified away (in fact not even used at all). After simplification
> most code is exactly identical with or without this patch, but for the
> pseudo numbers. And it this situation my patch will 'normalize' them
> while yours won't (if I understand it correctly).

If we do reset pseudo_base at show_entry(), I think in this example
the loop-linearization.c output should be the same. The diff in
loop-linearization.c did not show any instruction actually get deleted.
In my suggestion the number is driven by show_pseudo() usage.
If the instruction did not show up in the diff, it will have no impact
in the numbering. As far as I can tell that output should be the same.

>
> Yes, of course, just reseting the counter at each function entry would already
> eliminate most differences because it forces any possible differences to
> to stay local to the function and propagate to others.
>
> To would be a trivial changes if we don't mind for the pseudo-numbers to
> no more being unique within the file. I would gladly send a patch for it.

The text output is only there for human to read. I think localization of the
pseudo number is actually good thing. If needed, I don't mind adding
a pseudo_base into struct entrypoint so we don't have to reset them
if we haven't modify instruction in the function.

> But as I explained here above this wouldn't cover all my cases and I think
> that your proposal also won't.

That I haven't understand why it won't work. Maybe I miss some thing
obvious.

>
> And since the 'problem' being solved here is just some annoyance during
> development (and avoiding, after some changes, to have to update some
> unrelated tests), I think that this brute-force post-processing step only
> used on demand by test-linearize, keeping the normal code simple as it is,
> is the best thing to do.

I was hoping for if the simple way can work then we don't need the brute
force one. Even the brute force one will suffer from change in one basic
block will impact the numbering of other basic block.

>
> And about a smarter diff, yes of course. When I'm doing batch comparison
> of the output of test-linearize on 5500+ files, I often use a crude pre-diff
> processing step with a sed script that simply and purely strip off all
> pseudo-numbers! But maybe that should not be called a smarter diff but a
> dumber one :)

That is why I am actually tempting to rewrite test-suite using python so it
is much easier to do text manipulation and compare.

Chris
