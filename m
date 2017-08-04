From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Sat, 5 Aug 2017 00:26:48 +0200
Message-ID: <CAExDi1SXUkfR1eNZWLy9cOdEsZSbEb_0rSsEbk6dO8CZkfRxQA@mail.gmail.com>
References: <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local> <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local> <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
 <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com>
 <CANeU7QmzundH7qpdYhQqDJgBv+5pPemwft+1uH5oVQ1POnoQDw@mail.gmail.com>
 <CAMHZB6E0NYy_bNJftB5n4BFZ4-fNf___n0RN1OPb+jkV4Ry-Dw@mail.gmail.com>
 <20170803214906.dvvyibtf53j3ah6m@ltop.local> <20170804113329.54u5dzon5hrucohg@ltop.local>
 <CANeU7Qm8XKLavw=vWcKDyPkpnLVJ3kva17hkQhYqsi8QHZ2ArQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33091 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752540AbdHDW0t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 18:26:49 -0400
Received: by mail-qt0-f174.google.com with SMTP id a18so16763337qta.0
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 15:26:49 -0700 (PDT)
In-Reply-To: <CANeU7Qm8XKLavw=vWcKDyPkpnLVJ3kva17hkQhYqsi8QHZ2ArQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Fri, Aug 4, 2017 at 4:51 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Fri, Aug 4, 2017 at 7:33 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> On Thu, Aug 03, 2017 at 11:49:08PM +0200, Luc Van Oostenryck wrote:
>>> 1) some numbers:
>>> - GCC compile both preprocessed files in .9s with -O2.
>>> - sparse check the O0 file in 1.93s and O2 file in 13s.
>>> Thus even on the O0 file, the time is already too high because generaly
>>> sparse is roughly 10 times faster than gcc -O2, here is twice as slow.
>>> ...
>>> 4) if we replace 'inline' by 'inline __attribute__((always_inline))'
>>>    GCC needs roughly 58s to compile the O0 or O2 file.
>>
>> With the patch I sent, sparse now need 2.1s to compile the O2 file.

I have investigated a little more because even 2.1 or 1.93s seems
too much to me.

My conclusion is that the file is (really too) big (but see the end).
For example, there is:
- about 1 million calls to clean_up_one_instruction
- and 2.6 million calls to  insn_compare()
OTOH there is only 56000 calls to try_to_cse()
and these results in 82000 calls to bb_dominates()
and 29000 calls to cse_one_instruction().

All this indicate that the CSE is rather efficient:
only 56000 real CSE checks, each calling roughly 3/2
calls to bb_dominates() and 1/2 calls to cse_one_insn().

And in fact, most of these calls are not even really expensive.

The real offending, taking about 75% of CPU time, is bb_dominates()
which while only directly called 82000 is a recursive function which
internally is called more than 71 million of time!
In other words, the mean recursion depth of bb_dominates() is 860,
which means that there are chains of bb->parent as long as 860.

By restricting the bb_dominates() in CSE to a reasonable depth of 32,
the compile time is reduced to .8s without changing a single bit in the
resulting code.

This may be a change we may consider for the future.

-- Luc
