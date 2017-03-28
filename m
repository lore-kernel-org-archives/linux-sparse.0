From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Potential incorrect simplification
Date: Tue, 28 Mar 2017 09:20:58 -0700
Message-ID: <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local> <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:35784 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755198AbdC1QWC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 12:22:02 -0400
Received: by mail-it0-f50.google.com with SMTP id y18so119414737itc.0
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 09:21:29 -0700 (PDT)
In-Reply-To: <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 7:19 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Well the unsimplified output is correct. The problem appears after
> simplification.

No. The unsimplified output has the exact same bug:

  main:
  .L0:
        <entry-point>
        load.32     %r1 <- 0[s3]
        shl.32      %r2 <- $1, $6
        and.32      %r3 <- %r1, $-65

That "load.32" loads an uninitialized value from the stack.

The simplification then just simplifies the uninitialized load to just
be an uninitialized pseudo instead. Exact same code.

And arguably both unsimplified and simplified code is "correct" in the
sense that it's exactly what the original source code does:

   s3.onebit = 1;

becomes

        and.32      %r3 <- %r4, $-65
        or.32       %r4 <- %r3, $64

where that "and" is obviously pointless (well, "obviously" to a human,
not so sparse ;), but it's basically the code sequence "leave the
uninitialized bits alone, set bit 6 to 1". And then comes the *truly*
stupid code that does

        lsr.32      %r6 <- %r4, $6
        cast.32     %r7 <- (1) %r6

which is "shift bit 6 down to bit zero, and cast (aka sign-extend) the
one-bit value to 32 bits" and then

        setne.32    %r8 <- %r7, $1
        br          %r8, .L1, .L3

test if the result is 1, do a conditional branch on the result.

So the code is "correct". It may be confusing, because simplification
turns a uninitialized load into just an uninitialized variable, and
what also happens is that since SSA means that (by definition) every
initialization dominates every use, we have this situation where the
first assignment to the pseudo becomes the dominator of even the
uninitialized *previous* use of the pseudo, which is why you see that
odd sequence

        and.32      %r3 <- %r4, $-65
        or.32       %r4 <- %r3, $64

which *initializes* the pseudo %r4 in the second instruction, but uses
it in the first one. That's a classic pattern of uninitialized pseudos
in sparse exactly because of the SSA logic.

But it is all internally consistent, and the simplification is
"correct". The simplification phase very much has a "garbage in,
garbage out" model.

                  Linus
