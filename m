From: Christopher Li <sparse@chrisli.org>
Subject: Re: Potential incorrect simplification
Date: Sun, 6 Aug 2017 08:46:10 -0400
Message-ID: <CANeU7Qk-4U2G_6CZ7KHbGZiqRe9=fpNOzE4eyfLjz3fnd_n3ww@mail.gmail.com>
References: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
 <CAExDi1TtcpZtnEV6ctyA9MacJA_9h4njmhd-MSA3KgOq8oK_gA@mail.gmail.com>
 <CACXZuxfxNNh+ThcT=7Xr98tToL2GimFi7UOTSwgNq6mfLLGNfA@mail.gmail.com>
 <20170328141113.kbrwdva6ttsrokts@macpro.local> <CACXZuxen9UFGNp8=-OQHoqRQJ5F__rwQoCJJ6TdkAo6HEXWOQw@mail.gmail.com>
 <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:35855 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbdHFMqL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 08:46:11 -0400
Received: by mail-pg0-f45.google.com with SMTP id v77so24085092pgb.3
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 05:46:11 -0700 (PDT)
In-Reply-To: <CA+55aFx6g3-+6tJ_6Uqu4K1pQoDnqcXrjSGYsryLjjksEtT06A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 28, 2017 at 12:20 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 28, 2017 at 7:19 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> Well the unsimplified output is correct. The problem appears after
>> simplification.
>
> No. The unsimplified output has the exact same bug:
>
>   main:
>   .L0:
>         <entry-point>
>         load.32     %r1 <- 0[s3]
>         shl.32      %r2 <- $1, $6
>         and.32      %r3 <- %r1, $-65
>
> That "load.32" loads an uninitialized value from the stack.
>
> The simplification then just simplifies the uninitialized load to just
> be an uninitialized pseudo instead. Exact same code.
>
> And arguably both unsimplified and simplified code is "correct" in the
> sense that it's exactly what the original source code does:
>
>    s3.onebit =3D 1;
>
> becomes
>
>         and.32      %r3 <- %r4, $-65
>         or.32       %r4 <- %r3, $64

Sorry I wasn't able to participate this discussion earlier. I am catching
up at the important sparse mailing list discussion. This is one of them.

This has puzzle me for a long time. From the looks it seems %4 was
used before it was define. Is that legal SSA form?

To answer my own question I have done some research myself and
ask some local expert who point me to more literature on the topic. I
would like to share my findings.

My conclusion so far is that, that is *not* valid SSA form regarding the
usage of %r4. Basically the %r4 on the RHS and the %r4 on the LHS
are *not* the same %r4. It has the problem of %r4 was use before
define.

It comes down to, in proper SSA form, the default value from the
uninitialized value is count as one (implicit) define as well.

This implicit define is *required* duo to the placement of phi function
and the dominance property of SSA.

BTW, the beginning of the loop is likely the DF because it
has one back incoming edge on top of the loop entrance.

There is online links for the above two statement so I don't need to
quote books
http://marcusdenker.de/talks/08CC/08IntroSSA.pdf
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=CE=A6-Functions are placed in all basic blocks of the
Dominance Frontier.

Dominance Property of SSA:
1. If x is used in a Phi-function in block N,
then the definition of x dominates *every* <=3D=3D=3D=3D notice "every"
predecessor of N.
2. If x is used in a non-Phi statement in N,
then the definition of x dominates N
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

There is actually not many books explicit discuss handle
of uninitialized variables. The best explicit description I can
find is in this book
"modern compiler implementation in java" by Andrew W. Appel
Chapter 19.1 page 402. After 6 list item of Path-convergence
criterion (of phi function).

Quote: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
We consider the start node to contain an implicit definition of
*every* variable., either because the variable may be a formal
parameter or to represent the notion of a <-- uninitialized with
special cases.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Also, it was mention in the book, the CFG transformation need
to make sure the dominance property of SSA can not be broken.
If one transformation broke the dominance property of SSA, that
transformation can't be done safely.

That lead to our infamous "crazy programmer" warning.
In the crazy programmer warning we have "add %r1 <- %r1, 4"
That already means, we have done some transformation
breaking the dominance property of SSA, that transformation
shouldn't be done.

Again, I am *not* an expert on compilers. I am still learning
compilers so that I want sparse do the right things. If I make a
mistake, I am very happy that some one please point it out to
me.

Chris
