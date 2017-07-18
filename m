From: Christopher Li <sparse@chrisli.org>
Subject: Re: Infinite loop with OOM while testing Sparse on Wine code
Date: Tue, 18 Jul 2017 13:11:14 -0400
Message-ID: <CANeU7QkGeMuX7hjfxw-3Mi1_urmBS8znrxRO0VFp5Q+gh7FPTQ@mail.gmail.com>
References: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34489 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbdGRRLP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 13:11:15 -0400
Received: by mail-pg0-f45.google.com with SMTP id 123so16095833pgj.1
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 10:11:15 -0700 (PDT)
In-Reply-To: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@mykolab.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Tue, Jul 18, 2017 at 10:47 AM, Michael Stefaniuc
<mstefani@mykolab.com> wrote:
>
> make[1]: Entering directory '/j/wine/build/sparse64/dlls/user32/tests'
> cgcc -c -o menu.o /home/michi/work/wine/dlls/user32/tests/menu.c -I. \
>   -I/home/michi/work/wine/dlls/user32/tests -I../../../include
> -I/home/michi/work/wine/include \
>   -D__WINESRC__ -D_REENTRANT -fPIC -Wall -pipe -fno-strict-aliasing
> -Wdeclaration-after-statement \
>   -Wempty-body -Wignored-qualifiers -Wshift-overflow=2
> -Wstrict-prototypes -Wtype-limits \
>   -Wunused-but-set-parameter -Wvla -Wwrite-strings -Wpointer-arith
> -Wlogical-op -gdwarf-2 \
>   -gstrict-dwarf -g -O2

Adding CC of Luc,

It is much easier to reproduce the error from the command line as above.
Just update the wine directory name is good enough for me.

I can see how it is loop on the CSE phase. It is trying to simplify the
set_ne constant follow by a branch. However it did not change the
instruction and keep setting the CSE flag. Need more digging.

My gut feeling is that we should fix this before the release.

Chris
