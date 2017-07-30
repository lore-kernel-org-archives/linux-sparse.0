From: Christopher Li <sparse@chrisli.org>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Sun, 30 Jul 2017 11:49:16 -0400
Message-ID: <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
References: <CANeU7QkRxYFB41o9dTMp=n=epsNTZLr1ZsjowW=DigRiVNkPjg@mail.gmail.com>
 <20170729130116.b5jd4rvkiwzgsfwt@ltop.local> <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com>
 <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
 <CAMHZB6FjKnPojtirh0csQMXhZC-TT=hHRPne+z7q74joDHYdbg@mail.gmail.com>
 <CANeU7QnRQG84w+e-gTjp2yOZYdwq+itgExg_UTG-zUuRT8FYLg@mail.gmail.com>
 <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
 <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com> <20170730151254.xlnz7c4zphhnhump@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33182 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750817AbdG3PtS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 30 Jul 2017 11:49:18 -0400
Received: by mail-pf0-f181.google.com with SMTP id d67so44033958pfc.0
        for <linux-sparse@vger.kernel.org>; Sun, 30 Jul 2017 08:49:17 -0700 (PDT)
In-Reply-To: <20170730151254.xlnz7c4zphhnhump@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sun, Jul 30, 2017 at 11:12 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Sun, Jul 30, 2017 at 12:15:40AM -0400, Christopher Li wrote:
>> On Sat, Jul 29, 2017 at 5:47 PM, Luc Van Oostenryck
>> <luc.vanoostenryck@gmail.com> wrote:
>> >
>> > We do, more or less.
>> > Once the code is linearized and inlining is done we:
>> > - never add new BBs
>> > - remove some BBs (some removing edges from the CFG)
>> > - do several kinds of branch simplification (that's moving
>> >   edge, so technically it's adding edge to the CFG, not sure it
>> >   change the dom tree though).
>> >
>> That is merging nodes right? Two nodes combine as one.
>
> I was more thinking to things like done in try_to_simplify_bb().
>
>> Moving block to another place is another story.
>> >
>> > Yes, but this calculation is not correct at all.
>> > - each time a node is removed, the total number of nodes is smaller
>> >   and so the next time is a bit faster (this would correspond to a factor
>> >   of 2)
>>
>> if N >> M then it does not matter much.
>
> Indeed.
>
>> > - much more importantly, each time kill_unreachable_bbs() is called
>> >   *all* the currently dead BBs are removed at once. So single call
>> >   can kill several BBs. Of course, it will be different for each CFG/input
>> >   files.
>>
>> Yes, that would be linear to the number of blocks removed. It still
>> need to go through the blocks to clean up the instructions usage etc.
>
> Yes, but that's totally independent of how and how often the detection
> of dead code is done. At the end, every dead instructions will need
> to be cleaned up (the minimum is removing pseudo usage).
>
>> >> In the memops finding dominating store is doing a lot worse. That is
>> >> why gcc complete that file almost instantly. Sparse takes 30 seconds
>> >> on my machine. One big problem is it did not cache the dominating
>> >> result. It is redoing the finding again and again.
>>
>> > Uh?
>> > Which input file your talking about?
>>
>> This ptrlist testing wine source file that takes  23 second for sparse to run.
>> I take a brief look at it, it is doing a lot of dominating search.
>
> Is it possible to have a pathname or a link?

It is the very first email I send out:


git clone git://source.winehq.org/git/wine.git
cd win/dlls/usp10/tests

The test command:

time sparse -m64 -c -o usp10.o usp10.c -I. -I../../../include
-D__WINESRC__ -D_REENTRANT -fPIC -Wall -pipe -fno-strict-aliasing
-Wdeclaration-after-statement -Wempty-body -Wignored-qualifiers
-Wshift-overflow=2 -Wstrict-prototypes -Wtype-limits
-Wunused-but-set-parameter -Wvla -Wwrite-strings -Wpointer-arith
-Wlogical-op -gdwarf-2 -gstrict-dwarf -g -O2

I think gcc compile this file very fast but sparse spend a lot of time
on it. My impression it is spending time repeat finding dominating
stores. I did not look at it very deep, but I know sparse did not cache
any dominating information. It do fresh search every time.

> It's not the size of the file that matter here, it's the size
> (and complexity) of the function(s).

Yes, mean the complexity of the functions. How many blocks.
My impression parse.c has the largest one I saw so far. I have't
done it very scientifically. Other file all have relatively small functions.

Chris
