From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Sat, 29 Jul 2017 23:47:57 +0200
Message-ID: <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
References: <CANeU7QkRxYFB41o9dTMp=n=epsNTZLr1ZsjowW=DigRiVNkPjg@mail.gmail.com>
 <20170729130116.b5jd4rvkiwzgsfwt@ltop.local> <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com>
 <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
 <CAMHZB6FjKnPojtirh0csQMXhZC-TT=hHRPne+z7q74joDHYdbg@mail.gmail.com> <CANeU7QnRQG84w+e-gTjp2yOZYdwq+itgExg_UTG-zUuRT8FYLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35247 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbdG2Vr6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 17:47:58 -0400
Received: by mail-qk0-f174.google.com with SMTP id d145so127339633qkc.2
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 14:47:58 -0700 (PDT)
In-Reply-To: <CANeU7QnRQG84w+e-gTjp2yOZYdwq+itgExg_UTG-zUuRT8FYLg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sat, Jul 29, 2017 at 9:33 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Jul 29, 2017 at 12:35 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>>> You can't do that once cycles are involved. You need something
>>>> like the marking algorithm used by kill_unreachable_bbs() for that.
>>>> And it was such a  cycle that created the problem with the false
>>>> "crazy programmer" warning.
>>>
>>> No I don't think so. The find dominator already taking the cycles into
>>> account. By definition if X dominate Y, means every execution flow
>>> from entry point to Y will need to go through X. If X was not reachable,
>>> nor does Y. It does not change where the block get deleted. It just don't
>>> not need to do the marking algorithm. That is the point of dominator tree.
>>
>> OK, I misread and misunderstood that you was talking about  the
>> dominator *tree*.
>
> I was confused after your misunderstood as well. Well for a few minutes.
> The dominator tree does not have back edges. So if the edge on CFG
> we are removing is matching the edge on dominator tree. In other words,
> we are removing an edge from the dominator tree,  the whole branch
> of that tree can be removed as dead code.

Mmmm, interesting.

>> The real problem with such a tree is that you need to maintain it as
>> it potentially changes each time there is a change in the CFG.
>
> Right. So far most of the case is removing edges and blocks. That should
> be relative trivial to update the dominator tree. I haven't try it so we will
> see.
>
> Do we have a case actually *add* edge or block to the CFG?
> I don't recall one.

We do, more or less.
Once the code is linearized and inlining is done we:
- never add new BBs
- remove some BBs (some removing edges from the CFG)
- do several kinds of branch simplification (that's moving
  edge, so technically it's adding edge to the CFG, not sure it
  change the dom tree though).

>> And of course, building this tree is not linear (in the number of BBs)
>> while finding the dead BBs is linear.
> Find one round of dead BBs is linear, N number of BBs. Right now we
> mark and sweep the CFG for every node removed, total of M dead nodes.
> Then the total is M*N.

Yes, but this calculation is not correct at all.
- each time a node is removed, the total number of nodes is smaller
  and so the next time is a bit faster (this would correspond to a factor
  of 2)
- much more importantly, each time kill_unreachable_bbs() is called
  *all* the currently dead BBs are removed at once. So single call
  can kill several BBs. Of course, it will be different for each CFG/input
  files.

> In the memops finding dominating store is doing a lot worse. That is
> why gcc complete that file almost instantly. Sparse takes 30 seconds
> on my machine. One big problem is it did not cache the dominating
> result. It is redoing the finding again and again.

Uh?
Which input file your talking about?

BTW, two months ago or so, I posted a sort of mini-report about
quadratic behaviour with the current code. This quadratic behaviour
doesn't exist with the series I have for the misplaced phi-nodes.

> The algorithm I am using is this one:
>
> Cooper, Keith D.; Harvey, Timothy J.; and Kennedy, Ken (2001).
> A Simple, Fast Dominance Algorithm
> https://www.cs.rice.edu/~keith/EMBED/dom.pdf
>
> It is O(N^2), in practice it is faster than  Lengauer and Tarjan
> which is O(E *log(N)).
>
> Most of the sparse source code I try converge within 3 rounds.
> For practical purpose it feels like linear.

*smile* Feels like linear?
Did you try with several input files, some with big functions?

> Chris
