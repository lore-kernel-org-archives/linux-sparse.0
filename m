From: Christopher Li <sparse@chrisli.org>
Subject: Re: Infinite loop with OOM while testing Sparse on Wine code
Date: Wed, 19 Jul 2017 09:26:29 -0400
Message-ID: <CANeU7Qkm_V8cYW3yKKBHo6PY9r0CA+XoTfJCVZbcOS14Am_PiA@mail.gmail.com>
References: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
 <CANeU7QnEui=yTjf+=TYU89mEhOrOj3b3X_W0csxJJ-eLRokWcg@mail.gmail.com> <CANeU7Qk37weXva_-_M4bXeTTAT-DYGcccy+6jYv8pO6gzZNLcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35718 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753897AbdGSN0a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 09:26:30 -0400
Received: by mail-pg0-f46.google.com with SMTP id v190so288582pgv.2
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 06:26:30 -0700 (PDT)
In-Reply-To: <CANeU7Qk37weXva_-_M4bXeTTAT-DYGcccy+6jYv8pO6gzZNLcA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@mykolab.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Tue, Jul 18, 2017 at 8:07 PM, Christopher Li <sparse@chrisli.org> wrote:
> ======================
> test_menu_iteminfo:
> .L0:
>         <entry-point>
>         phisrc.32   %phi3(ansi) <- $1
>         br          .L1
>
> .L1:
>         phi.32      %r1(ansi) <- %phi3(ansi), %phi4(ansi)
>         cbr         %r1(ansi), .L4, .L5
>
> .L4:
>         cast.64     %r3 <- (64) stringA
>         br          .L5
>
> .L5:
>         cbr         %r1(ansi), .L6, .L2
>
> .L6:
>         ptrcast.64  %r6 <- (64) %r3
>         ptrcast.64  %r8 <- (64) VOID
>         call.64     %r9 <- strcpy, %r6, %r8
>         br          .L2   <=============== L2 merge with L7
>
> .L2:
>         seteq.32    %r11 <- %r1(ansi), $0
>         phisrc.32   %phi4(ansi) <- %r11
>         cbr         %r1(ansi), .L1, .L3
>
> .L3:
>         ret
> ======================
> test_menu_iteminfo:
> .L0:
>         <entry-point>
>         br          .L4 <========= phisrc3 get optimize away. This seems wrong

I see more what is going on there now.
Basically we have %phi3 = 1, a constant.
There for when control flow go from L0->L1, %r1 = %phi3 = 1.
It will go to L4 for sure.

So L0 modify to goto L4 directly. That is fine.

>
> .L1:
>         phi.32      %r1(ansi) <- VOID, %phi4(ansi) <======= this seems wrong.
>         cbr         %r1(ansi), .L4, .L5

phisrc3 has only one usage on L1. phisrc3 can be optimize away
and replace it with value 1. Showing VOID there is wrong.
it should be:

phi.32 %r1(ansi) <- 1, %phi4(ansi)

This phi instruction can't be deleted. Even though the control flow
has skip L1 and go to L4 directly. Makes L1 seems unreachable.
But the %r1(ansi) inside L1 is still used.

I think that is the nature of this bug.

Once sparse mistakenly remove %r1(ansi), it goes all crazy.
It result in the
 "setne.32    %r11 <- %r11, $0 "

which does not make sense at all.

I have revert the change cause this problem on sparse-next.

Wine compile should be able to complete now.

Luc, do you have time to take a look at this? Without your input,
RC5 will be released with commit  11b1a83b disabled.

Chris
