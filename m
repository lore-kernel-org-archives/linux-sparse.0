From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 23:50:39 +0100
Message-ID: <CACXZuxduhq5BxN4162NZL8z0hY3O7xMp7UKxXCBumRQSAnc-LQ@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
 <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com> <CAExDi1SS9VWX=G5nQ5uOjZAzh_PHOOovbzGZQs_izAXk4aYv-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35640 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbdHMWuk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 18:50:40 -0400
Received: by mail-ua0-f196.google.com with SMTP id d29so4261144uai.2
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 15:50:40 -0700 (PDT)
In-Reply-To: <CAExDi1SS9VWX=G5nQ5uOjZAzh_PHOOovbzGZQs_izAXk4aYv-w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On 13 August 2017 at 23:36, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Aug 14, 2017 at 12:12 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>
>>
>> Actually after RC5 merge there is a change in behaviour.
>>
>> Previously it would would fail to compile when simplifications were turned on.
>> Now:
>>
>> 1) Without single store shortcut it fails to compile. The error generated is:
>>
>> error: no result for pseudo
>> minilua.c:5593:24: error: failed to output instruction load.64*
>> %r13018 <- 16[VOID]
>>
>> minilua.c:5593:24: error: failed to output load.64*    %r13018 <- 16[VOID]
>
> Yes. Please forget about the single store shortcut: it's broken.
> But I'm not sure: do you mean "without the shortcut" or
> "without the patch that remove the shortcut"?

Sorry this one is with the patch that removed the shortcut.

>
>> 2) With single store shortcut it appears to compile successfully but
>> when the executable is run against the 'dynasm' test the test fails.
>> The un-simplified version works however.
>
> But I understood you had tried with the SSA I sent  link.
> Have I misunderstood?

I haven't incorporated your new SSA yet. This one is with single store
short cut restored.

>
>> Here are the linearized outputs:
>>
>> I am not sure this helps you.
>
> Not really, I was expecting the result of the preprocessing to avoid
> header dependencies and use the code as you're using it.
> For example, sparse doesn't know about the __DMR_C__ macro,
> we're not using the same header files, not even the same platform.

I can save the pre-processed output if that helps. Will send you a
link. The __DMR_C__ macro is just to help me avoid constructs that
Sparse LLVM cannot handle.

> But really, having small testcases with a clear description of exactly
> what is wrong, help a lot.

Well I think that we need a combination of tests - real world
programs, as well as short, to the point, tests. The way I see it - if
we get problems with a real world program, we then start digging and
end up with short test that reproduces the problem. Just creating
simple short tests does not tend to cover all scenarios as it is
impossible to construct a comprehensive test suite (unless we can
reuse someone else's test suite - which is something I am trying to
do).

Regards
Dibyendu
