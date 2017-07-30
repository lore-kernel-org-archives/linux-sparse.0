From: Christopher Li <sparse@chrisli.org>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Sun, 30 Jul 2017 00:15:40 -0400
Message-ID: <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
References: <CANeU7QkRxYFB41o9dTMp=n=epsNTZLr1ZsjowW=DigRiVNkPjg@mail.gmail.com>
 <20170729130116.b5jd4rvkiwzgsfwt@ltop.local> <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com>
 <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
 <CAMHZB6FjKnPojtirh0csQMXhZC-TT=hHRPne+z7q74joDHYdbg@mail.gmail.com>
 <CANeU7QnRQG84w+e-gTjp2yOZYdwq+itgExg_UTG-zUuRT8FYLg@mail.gmail.com> <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36825 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdG3EPm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 30 Jul 2017 00:15:42 -0400
Received: by mail-pg0-f54.google.com with SMTP id 125so125725862pgi.3
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 21:15:41 -0700 (PDT)
In-Reply-To: <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sat, Jul 29, 2017 at 5:47 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> We do, more or less.
> Once the code is linearized and inlining is done we:
> - never add new BBs
> - remove some BBs (some removing edges from the CFG)
> - do several kinds of branch simplification (that's moving
>   edge, so technically it's adding edge to the CFG, not sure it
>   change the dom tree though).
>
That is merging nodes right? Two nodes combine as one.
If we consider the two nodes and one sub graph. The combine
sub graph does not reach to new node. In other words, it does
not extend its reachability. My guess is that should be fine.

Moving block to another place is another story.
>
> Yes, but this calculation is not correct at all.
> - each time a node is removed, the total number of nodes is smaller
>   and so the next time is a bit faster (this would correspond to a factor
>   of 2)

if N >> M then it does not matter much.


> - much more importantly, each time kill_unreachable_bbs() is called
>   *all* the currently dead BBs are removed at once. So single call
>   can kill several BBs. Of course, it will be different for each CFG/input
>   files.

Yes, that would be linear to the number of blocks removed. It still
need to go through the blocks to clean up the instructions usage etc.

>> In the memops finding dominating store is doing a lot worse. That is
>> why gcc complete that file almost instantly. Sparse takes 30 seconds
>> on my machine. One big problem is it did not cache the dominating
>> result. It is redoing the finding again and again.



>
> Uh?
> Which input file your talking about?

This ptrlist testing wine source file that takes  23 second for sparse to run.
I take a brief look at it, it is doing a lot of dominating search.

>
> *smile* Feels like linear?
> Did you try with several input files, some with big functions?
I just try some sparse source file. The largest one is in parse.c.

The paper has more detail report on using huge number of nodes.
Tested on real code and random generated CFG for really large
number of nodes. I am not going repeat it here.

BTW, I just find out LLVM was using the exact same algorithm at
some point. Not sue what they are using now. They might not build
the whole tree any more.

Chris
