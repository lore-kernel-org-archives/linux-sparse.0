From: Christopher Li <sparse@chrisli.org>
Subject: Re: Infinite loop with OOM while testing Sparse on Wine code
Date: Sat, 29 Jul 2017 16:05:12 -0400
Message-ID: <CANeU7Q=Yccus6M5rYo_rzGcennKJ+Zyd+5b5YoDPystG-58hWA@mail.gmail.com>
References: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
 <CANeU7QnEui=yTjf+=TYU89mEhOrOj3b3X_W0csxJJ-eLRokWcg@mail.gmail.com>
 <CANeU7Qk37weXva_-_M4bXeTTAT-DYGcccy+6jYv8pO6gzZNLcA@mail.gmail.com>
 <CANeU7Qkm_V8cYW3yKKBHo6PY9r0CA+XoTfJCVZbcOS14Am_PiA@mail.gmail.com> <20170729143914.amo3vkoiqv7rkvmz@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:34415 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdG2UFN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 16:05:13 -0400
Received: by mail-pf0-f178.google.com with SMTP id q85so107117327pfq.1
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 13:05:13 -0700 (PDT)
In-Reply-To: <20170729143914.amo3vkoiqv7rkvmz@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Michael Stefaniuc <mstefani@mykolab.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Jul 29, 2017 at 10:39 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> No it's fine. It's the way of displaying that the element have been removed.
>
>> it should be:
>>
>> phi.32 %r1(ansi) <- 1, %phi4(ansi)
>
> No, not really.
> L1 has now only a single parent, the phi-node is now a trivial one,
> not really a join anymore.
> An explicit way of displaying it should simply be:
>         phi.32      %r1(ansi) <- %phi4(ansi)

OK, Great. It seems my decode attempt did not go far at all :(
Nice try.
.
>
> Everything is correct until:
>         test_menu_iteminfo:
>         .L0:
>                 <entry-point>
>                 br          .L4
>         .L1:
>                 phi.32      %r1(ansi) <- VOID, %phi4(ansi)
>                 cbr         %r1(ansi), .L4, .L5
>         .L4:
>                 cast.64     %r3 <- (64) stringA
>                 br          .L5
>         .L5:
>                 cbr         %r1(ansi), .L6, .L3
>         .L6:
>                 ptrcast.64  %r6 <- (64) %r3
>                 ptrcast.64  %r8 <- (64) VOID                    <== wrong but unrelated
>                 call.64     %r9 <- strcpy, %r6, %r8
>                 br          .L2
>         .L2:
>                 seteq.32    %r11 <- %r1(ansi), $0
>                 phisrc.32   %phi4(ansi) <- %r11
>                 cbr         %r1(ansi), .L1, .L3
>         .L3:
>                 ret
>
> Then simplify_branch_branch() is called on L2 -> L1
> and wrongly succeed giving:

My original thinking was .L1:
Ophi.32      %r1(ansi) <- VOID, %phi4(ansi)

feeding the .L2:
cbr         %r1(ansi), .L1, .L3

Got the wrong result so I suspect some thing was wrong with
%r1(ansi).  I admit I don't know what exactly simplify_branch_branch()
was doing there.

.L5: also have
cbr         %r1(ansi), .L6, .L3
I don't know why this one is fine.


>                 seteq.32    %r11 <- %r1(ansi), $0
>                 phisrc.32   %phi4(ansi) <- %r11
>                 cbr         %r1(ansi), .L4, .L3                 <== bad change
>         .L3:
>                 ret
>
> This will then trigger the wrong simplifications:
>         %phi4 <- %r11
> and
>         %r1   <- %r11
> giving finally:
>                 setne.32    %r11 <- %r11, $0
>
> As far as I can see, simplify_branch_branch() needs something
> like the bb_defines_phi() I had to add to try_to_simplify_bb()
> (basically it's bb_depends_on() which is not 'strong' enough).

Thanks you so much for the excellent diagnose.

> At this point I don't think anymore that the revert is the most
> appropriate thing to do.

That is what I am looking for. I want to find out if there is any
thing else like this on -rc4+.

Thanks again.

Chris
