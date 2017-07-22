From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse-next and preview of 0.5.1-rc5
Date: Fri, 21 Jul 2017 23:55:09 -0400
Message-ID: <CANeU7QnovxzRQuhjyRHY==B2Vk5qU9Qk08rTDuvdwmARGci4Og@mail.gmail.com>
References: <CANeU7Qk-9RcNkWoEL5-0AKyd2Q30BvtjfivEG_KgD4kAH-aEdA@mail.gmail.com>
 <20170715182159.ltikqlbe6rktxfhz@ltop.local> <CANeU7Qkt4+QsgrrwUSwiiJ_V77gnJgb5YW0qSwwx1-uu9-GhLw@mail.gmail.com>
 <20170719221738.2gkctzmdjajz4uec@ltop.local> <CANeU7QkevpEdcp-WmM820sjJ4-LhVyPHeGHETh64WG3jPzewhA@mail.gmail.com>
 <20170720223554.54ohh7pfl7qm43dc@ltop.local> <CANeU7QkgF5N_Byw3j4G-dV1ZoWR6CW+y+UZa3MkrVcFNZmYz8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:37210 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753904AbdGVDzK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 21 Jul 2017 23:55:10 -0400
Received: by mail-pg0-f49.google.com with SMTP id y129so35737474pgy.4
        for <linux-sparse@vger.kernel.org>; Fri, 21 Jul 2017 20:55:10 -0700 (PDT)
In-Reply-To: <CANeU7QkgF5N_Byw3j4G-dV1ZoWR6CW+y+UZa3MkrVcFNZmYz8Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jul 20, 2017 at 11:40 PM, Christopher Li <sparse@chrisli.org> wrote:
> int *ptr;
> int foo( int i)
> {
> int *p;
> switch (i - i) {        // will be optimized to 0
> case 0:                 // will be the simple branch
> return 0;
> case 1:                 // will be optimized away
> do {            // will be an unreachable loop
>    *p++ = 123;
> } while (--i);
> }
> return 1;
> }
>
> Which will show "crazy programmer" in sparse-next but not your patch.

I dig out more, before it is showing the crazy programmer. This is the
IR it is working on:

Notice the "add.64      %r6 <- %r6, $4", that is very wrong.
Not valid SSA form at all.

I believe that is the one of the condition triggering the crazy programmer
bug.

This error actually reminds me the wine dead loop bug.
In the wine dead loop IR we have:

 setne.32    %r11 <- %r11, $0

This two bugs might actually be related.

We shouldn't have
"add.64      %r6 <- %r6, $4"
That already screw up very badly.
I confirm that "add.64      %r6 <- %r6, $4" was in your purpose
patch as well. It is just you pack the BB early so it does not
trigger the "crazy programmer".

I think your patch pack the BB early to avoid the "crazy programmer".
That sounds more like a cover up rather than a proper fix up.

If we have the proper SSA form, the "crazy programmer" shouldn't
pop up at all.

BTW, that is exactly why I want to get a test C test file to expose
the bug. From the description of the bug does not show as much
detail as the test C code. Different people will have different
views of how the bug happen and how to fix it. Given enough eye
ball, all the bug will be obvious.

Chris


<entry-point>
phisrc.32   %phi3(i) <- %arg1
br          .L2

.L2:
phisrc.32   %phi1(return) <- $0
br          .L4

.L3:
br          .L5

.L5:
add.64      %r6 <- %r6, $4 <============ this is very wrong
store.32    $123 -> 0[%r6] <========== cause crazy programmer here.
br          .L6

.L6:
phi.32      %r7 <- %phi3(i), %phi4(i)
sub.32      %r8 <- %r7, $1
phisrc.32   %phi4(i) <- %r8
cbr         %r8, .L5, .L7

.L7:
br          .L1

.L1:
phisrc.32   %phi2(return) <- $1
br          .L4

.L4:
phi.32      %r4 <- %phi1(return), %phi2(return)
ret.32      %r4
