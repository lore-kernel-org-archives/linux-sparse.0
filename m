From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Tue, 1 Aug 2017 23:46:49 +0200
Message-ID: <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com>
References: <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com>
 <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
 <CAMHZB6FjKnPojtirh0csQMXhZC-TT=hHRPne+z7q74joDHYdbg@mail.gmail.com>
 <CANeU7QnRQG84w+e-gTjp2yOZYdwq+itgExg_UTG-zUuRT8FYLg@mail.gmail.com>
 <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
 <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local> <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local> <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:37741 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbdHAVqu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 1 Aug 2017 17:46:50 -0400
Received: by mail-qk0-f176.google.com with SMTP id z18so17050519qka.4
        for <linux-sparse@vger.kernel.org>; Tue, 01 Aug 2017 14:46:50 -0700 (PDT)
In-Reply-To: <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Tue, Aug 1, 2017 at 11:09 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Aug 1, 2017 at 4:33 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> When I try the command you gave with -rc4 sparse I get:
>>         real    0m3.281s
>>         user    0m3.175s
>>         sys     0m0.097s
>> wich is very far from the 23-30s you got. Dunno what the difference could be.
>
> Did you run it with all the parameter?

I did

> If I just run the sort version:
>
> time sparse -m64 -c -o usp10.o usp10.c -I. -I../../../include
> -D__WINESRC__ -D_REENTRANT
>
> It is:
> real 0m4.532s
> user 0m4.436s
> sys 0m0.075s
>
> But if I run with all parameter.
>
> sh -x slow.sh
>
> + sparse -m64 -c -o usp10.o usp10.c -I. -I../../../include
> -D__WINESRC__ -D_REENTRANT -fPIC -Wall -pipe -fno-strict-aliasing
> -Wdeclaration-after-statement -Wempty-body -Wignored-qualifiers
> -Wshift-overflow=2 -Wstrict-prototypes -Wtype-limits
> -Wunused-but-set-parameter -Wvla -Wwrite-strings -Wpointer-arith
> -Wlogical-op -gdwarf-2 -gstrict-dwarf -g -O2
> /usr/include/sys/sysmacros.h:79:1: warning: constant
> 0xfffff00000000000u is so big it is unsigned long
> /usr/include/sys/sysmacros.h:80:1: warning: constant
> 0x00000ffffff00000u is so big it is unsigned long
> ...
>
> real 0m24.771s
> user 0m24.447s
> sys 0m0.213s
>
> Again, I haven't dig very deep with this yet. Might be a bug some where indeed.

Here, both give essentially the same time.
Which is quite normal as none of the 'additional' options
should make any difference in how sparse is processing
things: it's just some more flags for warnings and none of
-fPIC -pipe -fno-strict-aliasing -gdwarf-2 -gstrict-dwarf -g
has any effects for sparse and the only effect of -O2 is
to define __OPTIMIZE__.

-- Luc
