From: Christopher Li <sparse@chrisli.org>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Sat, 29 Jul 2017 11:53:28 -0400
Message-ID: <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
References: <CANeU7QkRxYFB41o9dTMp=n=epsNTZLr1ZsjowW=DigRiVNkPjg@mail.gmail.com>
 <20170729130116.b5jd4rvkiwzgsfwt@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:37682 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752596AbdG2Px3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 11:53:29 -0400
Received: by mail-pg0-f52.google.com with SMTP id y129so122132122pgy.4
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 08:53:28 -0700 (PDT)
In-Reply-To: <20170729130116.b5jd4rvkiwzgsfwt@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sat, Jul 29, 2017 at 9:01 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Interesting.
> My measurements showed much smaller differences (around 1-2%
> and smaller than the stdev). But I also saw that this difference
> was significantly bigger on older/less performant machines
> (which is not very surprising).

I guess my laptop can qualify as older/less performance machines :-)

A wild guess is that the modern CPU are better doing caching and
branch predictions etcs. The iterator is doing a lot of memory store
and load from the iterator struct, and a lot of call to the interator advance
function.

The reason it show up more on this C file is that, sparse is doing a lot
of recursive find domanitor store etc. There are very deep level of nested
ptrlist loop here. The performance penalty on the inner loop will amplify
by the level of nested loop.

BTW, I am writing some code to construct the dominator tree for
basic blocks. I think it will be useful to avoid repeat finding dominator.
It will also help you finding the dominator frontier for the phi locations.

Another possible use is that, we can do incremental remove of dead
blocks without visiting all the blocks. We can just find out what other
blocks dominated by this dead block, mark them for delete and repeat.

Some materials for the next release.

Chris
