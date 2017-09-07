From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse-llvm question regarding handling of phi/phsrc instructions
Date: Thu, 7 Sep 2017 22:25:57 +0200
Message-ID: <CAExDi1RQ3HnnByw_y-jMpm1bH_yTMyQEVSLyCvGFzb8W9TpCXA@mail.gmail.com>
References: <CACXZuxfKGmGEtOm8DOz=J9f77eSMyQGT8NRpc_6tEBncuJuy7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33995 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755841AbdIGUZ7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Sep 2017 16:25:59 -0400
Received: by mail-lf0-f54.google.com with SMTP id l196so1581537lfl.1
        for <linux-sparse@vger.kernel.org>; Thu, 07 Sep 2017 13:25:58 -0700 (PDT)
In-Reply-To: <CACXZuxfKGmGEtOm8DOz=J9f77eSMyQGT8NRpc_6tEBncuJuy7A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

2017-09-07 18:04 GMT+02:00 Dibyendu Majumdar <mobile@majumdar.org.uk>:
> Hi,
>
> The following code snippet:
>
> static int test_do(void) {
>     int a = 0;
>     int count = 27;
>     switch (count % 8) {
>     case 0: do {  a++;
>     case 7:       a++;
>     case 6:       a++;
>     case 5:       a++;
>     case 4:       a++;
>     case 3:       a++;
>     case 2:       a++;
>     case 1:       a++;
>             } while ((count -= 8) > 0);
>     }
>     return a;
> }
>
> Results in following linear output:
>
> test_do:
> .L0:
>         <entry-point>
>         phisrc.32   %phi3(a) <- $0
>         phisrc.32   %phi4(a) <- $0
>         phisrc.32   %phi6(a) <- $0
>         phisrc.32   %phi8(a) <- $0
>         phisrc.32   %phi10(a) <- $0
>         phisrc.32   %phi12(a) <- $0
>         phisrc.32   %phi14(a) <- $0
>         phisrc.32   %phi16(a) <- $0
>         phisrc.32   %phi18(a) <- $0
>         phisrc.32   %phi20(count) <- $27
>         br          .L7
>
> .L10:
>         phi.32      %r3 <- %phi18(a), %phi19(a)
>         add.32      %r4 <- %r3, $1
>         phisrc.32   %phi17(a) <- %r4
>         phi.32      %r5 <- %phi16(a), %phi17(a)
> ...
>
> This is translated to following LLVM IR:
>
> define internal i32 @test_do() {
> L0:
>   %0 = alloca i32
>   %1 = alloca i32
>   %2 = alloca i32
>   %3 = alloca i32
>   %4 = alloca i32
>   %5 = alloca i32
>   %6 = alloca i32
>   %7 = alloca i32
>   %8 = alloca i32
>   %9 = alloca i32
>   store i32 0, i32* %9
>   store i32 0, i32* %7
>   store i32 0, i32* %6
>   store i32 0, i32* %5
>   store i32 0, i32* %4
>   store i32 0, i32* %3
>   store i32 0, i32* %2
>   store i32 0, i32* %1
>   store i32 0, i32* %0
>   store i32 27, i32* %8
>   br label %L2
>
> L1:                                               ; preds = %L2
>   %10 = load i32, i32* %0
>   %R4 = add i32 %10, 1
> ...
>
> It seems to me that 'a' ends up having 9 different slots on the stack,
> but it should really be merged into one slot, i.e. we should detect
> that the phis all related to the same symbol, and create only one
> alloca?


Yes and no. It's just one of the problem with the SSA conversion
as done in rc5.
If you try the same code with newssa, you have something much
saner, no?

-- Luc
