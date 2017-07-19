From: Christopher Li <sparse@chrisli.org>
Subject: Re: Infinite loop with OOM while testing Sparse on Wine code
Date: Tue, 18 Jul 2017 20:07:19 -0400
Message-ID: <CANeU7Qk37weXva_-_M4bXeTTAT-DYGcccy+6jYv8pO6gzZNLcA@mail.gmail.com>
References: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com> <CANeU7QnEui=yTjf+=TYU89mEhOrOj3b3X_W0csxJJ-eLRokWcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36726 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdGSAHU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 20:07:20 -0400
Received: by mail-pf0-f173.google.com with SMTP id o88so12286832pfk.3
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 17:07:20 -0700 (PDT)
In-Reply-To: <CANeU7QnEui=yTjf+=TYU89mEhOrOj3b3X_W0csxJJ-eLRokWcg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@mykolab.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Tue, Jul 18, 2017 at 7:12 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> OK, I have shrink the test program into the following code.
> It can still reproduce the dead loop. It is related to simplify
> the phi source.

So I add a show_entry() in side each of the CSE loop.
Here is what I have so far. Commends in <==========

Chris

====================== The original
test_menu_iteminfo:
.L0:
        <entry-point>
        phisrc.32   %phi3(ansi) <- $1
        br          .L1

.L1:
        phi.32      %r1(ansi) <- %phi3(ansi), %phi4(ansi)
        cbr         %r1(ansi), .L4, .L5

.L4:
        symaddr.64  %r2 <- stringA
        cast.64     %r3 <- (64) %r2
        br          .L5

.L5:
        cbr         %r1(ansi), .L6, .L7

.L6:
        ptrcast.64  %r6 <- (64) %r3
        ptrcast.64  %r8 <- (64) VOID
        call.64     %r9 <- strcpy, %r6, %r8
        br          .L7

.L7:
        br          .L2

.L2:
        seteq.32    %r11 <- %r1(ansi), $0
        phisrc.32   %phi4(ansi) <- %r11
        cbr         %r11, .L3, .L1

.L3:
        ret

======================
test_menu_iteminfo:
.L0:
        <entry-point>
        phisrc.32   %phi3(ansi) <- $1
        br          .L1

.L1:
        phi.32      %r1(ansi) <- %phi3(ansi), %phi4(ansi)
        cbr         %r1(ansi), .L4, .L5

.L4:
   ### <======= r2 getsymaddr get simplify away
        cast.64     %r3 <- (64) stringA
        br          .L5

.L5:
        cbr         %r1(ansi), .L6, .L7

.L6:
        ptrcast.64  %r6 <- (64) %r3
        ptrcast.64  %r8 <- (64) VOID
        call.64     %r9 <- strcpy, %r6, %r8
        br          .L7

.L7:
        br          .L2

.L2:
        seteq.32    %r11 <- %r1(ansi), $0
        phisrc.32   %phi4(ansi) <- %r11
        cbr         %r1(ansi), .L1, .L3

.L3:
        ret
======================
test_menu_iteminfo:
.L0:
        <entry-point>
        phisrc.32   %phi3(ansi) <- $1
        br          .L1

.L1:
        phi.32      %r1(ansi) <- %phi3(ansi), %phi4(ansi)
        cbr         %r1(ansi), .L4, .L5

.L4:
        cast.64     %r3 <- (64) stringA
        br          .L5

.L5:
        cbr         %r1(ansi), .L6, .L2

.L6:
        ptrcast.64  %r6 <- (64) %r3
        ptrcast.64  %r8 <- (64) VOID
        call.64     %r9 <- strcpy, %r6, %r8
        br          .L2   <=============== L2 merge with L7

.L2:
        seteq.32    %r11 <- %r1(ansi), $0
        phisrc.32   %phi4(ansi) <- %r11
        cbr         %r1(ansi), .L1, .L3

.L3:
        ret
======================
test_menu_iteminfo:
.L0:
        <entry-point>
        br          .L4 <========= phisrc3 get optimize away. This seems wrong

.L1:
        phi.32      %r1(ansi) <- VOID, %phi4(ansi) <======= this seems wrong.
        cbr         %r1(ansi), .L4, .L5

.L4:
        cast.64     %r3 <- (64) stringA
        br          .L5

.L5:
        cbr         %r1(ansi), .L6, .L3

.L6:
        ptrcast.64  %r6 <- (64) %r3
        ptrcast.64  %r8 <- (64) VOID
        call.64     %r9 <- strcpy, %r6, %r8
        br          .L2

.L2:
        seteq.32    %r11 <- %r1(ansi), $0
        phisrc.32   %phi4(ansi) <- %r11
        cbr         %r1(ansi), .L4, .L3

.L3:
        ret
======================
test_menu_iteminfo:
.L0:
        <entry-point>
        br          .L4

.L4:
        cast.64     %r3 <- (64) stringA
        br          .L5

.L5:
        cbr         %r11, .L3, .L6

.L6:
        ptrcast.64  %r6 <- (64) %r3
        ptrcast.64  %r8 <- (64) VOID
        call.64     %r9 <- strcpy, %r6, %r8
        br          .L2

.L2:
        setne.32    %r11 <- %r11, $0 <====== this seems very wrong
        cbr         %r11, .L4, .L3

.L3:
        ret
