From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC] rationale for systematic elimination of OP_SYMADDR instructions
Date: Thu, 10 Aug 2017 11:01:22 -0400
Message-ID: <CANeU7QkJy-G4EXuJ94KBcmo3Bc0Pei0uQSTeYr-u4DxsSK==uQ@mail.gmail.com>
References: <20170309142044.96408-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkhQJrGifw5zvRoN27yVEfmU23B+HG5KQy3R9G3aKWUgw@mail.gmail.com>
 <CAMHZB6EE93YSm0gVUr=dhNpsTZ1vU8acJ9msyh3VSdTOTVUq-w@mail.gmail.com>
 <CANeU7Q=zV+MAFOA6SzANEF9_7NB0rY719bzkesPnvUS9AqR+hw@mail.gmail.com>
 <CAMHZB6Gj0pS-z_tSPS+6tXhg2mAjGhDYxBLZXn0wmmAYePtZyg@mail.gmail.com>
 <CANeU7Qk7czDA+RJzxyZHRa9zJdvv19s0NYExfDoW+34HmkB4dA@mail.gmail.com> <CAMHZB6EvJss-53X2oyXGHTRpAjDnoK8W5dCbng2tqUmjMykORA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:35906 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbdHJPB0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 11:01:26 -0400
Received: by mail-yw0-f176.google.com with SMTP id u207so6242363ywc.3
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 08:01:26 -0700 (PDT)
In-Reply-To: <CAMHZB6EvJss-53X2oyXGHTRpAjDnoK8W5dCbng2tqUmjMykORA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Apr 26, 2017 at 7:02 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>> Does the address of the symbol ever change inside a function?
>> I assume it does not change. If that is the case, can we skip the CSE
>> and replace all the symbol address reference to one OP_SYMADDR?
>>
>> For example, for each symbol access in the function we insert OP_SYMADDR
>> after the entry:
>> foo:
>> <entry-point>
>>         %r1 <- a
>>         %r2 <- b
>> ...
>>
>> Then all reference of symbol address of "a" and "b" inside the function
>> foo will use %r1 and %r2.  Notice that we still keep the OP_SYMADDR
>> instruction, just move to function entry.
>>
>> Is that illegal or bad?
>
> The address of a symbol will of course not change.
> So yes, all the OP_SYMADDR could move to the top of the function.
> It wouldn't be illegal and it could be advantageous in some cases.
> It would be bad, though, if these addresses are in fact not used
> (because of a conditional). I'm thinking to something like:
>         if (unlikely(some cond)) a++;
> Of course, doing so would also need a register to hold these addresses
> so pre-calculated. What if the function access a lot of symbols?

Sorry for reply to a very old email. Still catching up the my backlogs.

I think the function access a lot of symbols will need to have more
OP_SYMADDR, at least one instruction per symbol if you want to
have the OP_SYMADDR. You can't do better than that.


> In my opinion, we should handle these OP_SYMADDR just like
> any other instructions (in other words: near where they are used).

I think in the current IR, how close it is to be used is not a big issue.

If you want to get it close and have one OP_SYMADDR per symbol.
The OP_SYMADDR should be place at immediate D(N), where N is the
block that use the symbol. In other words, place the OP_SYMADDR
at where N blocks join in the dominator tree. You can't do better than
hat.

Please correct me if I am wrong.  I still think:
1)  OP_SYMADDR can be generated from the symbol node and where
     to place them (immediate D(N)).

2) If one of the back end needs them. Go ahead and generate OP_SYMADDR.
   However, I don't think sparse checker need to use the OP_SYMADDR
   so it will be more optimal  for sparse checker to avoid OP_SYMADDR.

   Am I missing some thing?

Chris
