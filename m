From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 00:36:13 +0200
Message-ID: <CAExDi1SS9VWX=G5nQ5uOjZAzh_PHOOovbzGZQs_izAXk4aYv-w@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com> <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34957 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdHMWgP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 18:36:15 -0400
Received: by mail-oi0-f44.google.com with SMTP id e124so70992635oig.2
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 15:36:14 -0700 (PDT)
In-Reply-To: <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Mon, Aug 14, 2017 at 12:12 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:

>
> Actually after RC5 merge there is a change in behaviour.
>
> Previously it would would fail to compile when simplifications were turned on.
> Now:
>
> 1) Without single store shortcut it fails to compile. The error generated is:
>
> error: no result for pseudo
> minilua.c:5593:24: error: failed to output instruction load.64*
> %r13018 <- 16[VOID]
>
> minilua.c:5593:24: error: failed to output load.64*    %r13018 <- 16[VOID]

Yes. Please forget about the single store shortcut: it's broken.
But I'm not sure: do you mean "without the shortcut" or
"without the patch that remove the shortcut"?

> 2) With single store shortcut it appears to compile successfully but
> when the executable is run against the 'dynasm' test the test fails.
> The un-simplified version works however.

But I understood you had tried with the SSA I sent  link.
Have I misunderstood?

> Here are the linearized outputs:
>
> I am not sure this helps you.

Not really, I was expecting the result of the preprocessing to avoid
header dependencies and use the code as you're using it.
For example, sparse doesn't know about the __DMR_C__ macro,
we're not using the same header files, not even the same platform.

>>> Note also that I have a couple of workarounds in my repository:
> ...
> Maybe we can look at these ones later ...

Sure.
But really, having small testcases with a clear description of exactly
what is wrong, help a lot.

Personally, I don't look at the output of sparse-llvm because I don't
find it very interesting and even more so because I know there are
lots of problems already in the IR we feed sparse-llvm with.
But if you send some specific problems, I can for sure at least look at them.

Regards,
-- Luc
