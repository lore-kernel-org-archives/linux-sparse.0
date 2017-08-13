From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 20:56:31 +0100
Message-ID: <CACXZuxfz1B7L10QVP3-zYNSExFv359wZ4GD4JR6uwzpBn03xrg@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com> <CANeU7QkMPKycTmOD_ifV5shHSzMQwzd6Nj=7AwVEJHo5EXc-Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f171.google.com ([209.85.217.171]:38568 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752064AbdHMT4c (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 15:56:32 -0400
Received: by mail-ua0-f171.google.com with SMTP id w45so30441347uac.5
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 12:56:32 -0700 (PDT)
In-Reply-To: <CANeU7QkMPKycTmOD_ifV5shHSzMQwzd6Nj=7AwVEJHo5EXc-Bw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

Hi Chris,

On 13 August 2017 at 20:20, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Aug 13, 2017 at 3:10 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> I have to disable simplifications anyway to get correct IR in some
>> cases. With the single store shortcut test that sets bitfield succeeds
>> even when simplifications are on - but even so, I cannot turn
>> simplifications on in practice because of other failures.
>
> So you are saying even the last change does not make
> you to turn on the simplification.
>

That is correct.

The good news is that I have completed the merge of RC5 into my
project and have run the Sparse tests as well as my own tests. I have
not faced any new issues other than the one above.

With my version of the LLVM backend I am able to compile and run a
fairly large program (after turning off simplifications of course). As
this is a language interpreter - I am able to then run this
interpreter to compile another JIT! You can see the details here:

https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/minilua/run.sh
https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/minilua/dynasm/run.sh

Of course until you are able to merge all the Sparse-LLVM fixes you
will not be able to run these tests, but it shows that we are making
good progress!

Regards
Dibyendu
