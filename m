From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 01:03:32 +0200
Message-ID: <CAExDi1TG6mLN6VL5f-4KnfnW9hSJjU2JcGptDcq-2+EtdUNmqw@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
 <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com>
 <CAExDi1SS9VWX=G5nQ5uOjZAzh_PHOOovbzGZQs_izAXk4aYv-w@mail.gmail.com> <CACXZuxduhq5BxN4162NZL8z0hY3O7xMp7UKxXCBumRQSAnc-LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:34533 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdHMXDd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 19:03:33 -0400
Received: by mail-oi0-f51.google.com with SMTP id x3so71129149oia.1
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 16:03:33 -0700 (PDT)
In-Reply-To: <CACXZuxduhq5BxN4162NZL8z0hY3O7xMp7UKxXCBumRQSAnc-LQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Mon, Aug 14, 2017 at 12:50 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>>> 1) Without single store shortcut it fails to compile. The error generated is:
>>>
>>> error: no result for pseudo
>>> minilua.c:5593:24: error: failed to output instruction load.64*
>>> %r13018 <- 16[VOID]
>>>
>>> minilua.c:5593:24: error: failed to output load.64*    %r13018 <- 16[VOID]
>>
>> Yes. Please forget about the single store shortcut: it's broken.
>> But I'm not sure: do you mean "without the shortcut" or
>> "without the patch that remove the shortcut"?
>
> Sorry this one is with the patch that removed the shortcut.

OK.

>>> Here are the linearized outputs:
>>>
>>> I am not sure this helps you.
>>
>> Not really, I was expecting the result of the preprocessing to avoid
>> header dependencies and use the code as you're using it.
>> For example, sparse doesn't know about the __DMR_C__ macro,
>> we're not using the same header files, not even the same platform.
>
> I can save the pre-processed output if that helps. Will send you a
> link.

Yes, it really helps for lots of reasons.
For example, I wasn't able to reproduce the Wine bug with the plain
file because triggered the problem was in a header file for platform X
version Y and I hadn't any problem here.

> The __DMR_C__ macro is just to help me avoid constructs that
> Sparse LLVM cannot handle.

Yes, I saw that.

>> But really, having small testcases with a clear description of exactly
>> what is wrong, help a lot.
>
> Well I think that we need a combination of tests - real world
> programs, as well as short, to the point, tests. The way I see it - if
> we get problems with a real world program, we then start digging and
> end up with short test that reproduces the problem. Just creating
> simple short tests does not tend to cover all scenarios as it is
> impossible to construct a comprehensive test suite (unless we can
> reuse someone else's test suite - which is something I am trying to
> do).

Sure, I also use some big files for testing too, some very big, but
before you can really begin to look at things you need at least have
an idea of what is wrong and having a small problem save a lot of time.
Yes, finding a small reproducer can be a lot of work.

Regards,
-- Luc
