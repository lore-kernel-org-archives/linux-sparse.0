From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Sun, 30 Jul 2017 18:16:03 +0200
Message-ID: <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
References: <CANeU7QkRxYFB41o9dTMp=n=epsNTZLr1ZsjowW=DigRiVNkPjg@mail.gmail.com>
 <20170729130116.b5jd4rvkiwzgsfwt@ltop.local> <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com>
 <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
 <CAMHZB6FjKnPojtirh0csQMXhZC-TT=hHRPne+z7q74joDHYdbg@mail.gmail.com>
 <CANeU7QnRQG84w+e-gTjp2yOZYdwq+itgExg_UTG-zUuRT8FYLg@mail.gmail.com>
 <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
 <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local> <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:33024 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754344AbdG3QQE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 30 Jul 2017 12:16:04 -0400
Received: by mail-qt0-f175.google.com with SMTP id a18so79595584qta.0
        for <linux-sparse@vger.kernel.org>; Sun, 30 Jul 2017 09:16:04 -0700 (PDT)
In-Reply-To: <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sun, Jul 30, 2017 at 5:49 PM, Christopher Li <sparse@chrisli.org> wrote:

>>> >> In the memops finding dominating store is doing a lot worse. That is
>>> >> why gcc complete that file almost instantly. Sparse takes 30 seconds
>>> >> on my machine. One big problem is it did not cache the dominating
>>> >> result. It is redoing the finding again and again.
>>>
>>> > Uh?
>>> > Which input file your talking about?
>>>
>>> This ptrlist testing wine source file that takes  23 second for sparse to run.
>>> I take a brief look at it, it is doing a lot of dominating search.
>>
>> Is it possible to have a pathname or a link?
>
> It is the very first email I send out:
>
>
> git clone git://source.winehq.org/git/wine.git
> cd win/dlls/usp10/tests
>
> The test command:
>
> time sparse -m64 -c -o usp10.o usp10.c -I. -I../../../include
> -D__WINESRC__ -D_REENTRANT -fPIC -Wall -pipe -fno-strict-aliasing
> -Wdeclaration-after-statement -Wempty-body -Wignored-qualifiers
> -Wshift-overflow=2 -Wstrict-prototypes -Wtype-limits
> -Wunused-but-set-parameter -Wvla -Wwrite-strings -Wpointer-arith
> -Wlogical-op -gdwarf-2 -gstrict-dwarf -g -O2

OK, thanks. I'll take a look once the infinite loop problem will be closed.

> I think gcc compile this file very fast but sparse spend a lot of time on it.

Interesting.
On most input sparse is much faster than gcc, often by a factor or 10
or even more. But of course, if there is a problem with sparse ...

> My impression it is spending time repeat finding dominating stores.
Possible indeed.
> I did not look at it very deep, but I know sparse did not cache
> any dominating information. It do fresh search every time.

Yes. It's even done for each instruction to CSE (but most of the
time it's not much costly, still looking after a few parents though).

>> It's not the size of the file that matter here, it's the size
>> (and complexity) of the function(s).
>
> Yes, mean the complexity of the functions. How many blocks.
> My impression parse.c has the largest one I saw so far. I have't
> done it very scientifically. Other file all have relatively small functions.

I really don't think sparse has any function large enough to worry after
non-linearity (you would need at least a few hundred BBs).
IMO, the thing to look at/worry about is the constant factor.

> Chris
