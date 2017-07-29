From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Sat, 29 Jul 2017 18:35:59 +0200
Message-ID: <CAMHZB6FjKnPojtirh0csQMXhZC-TT=hHRPne+z7q74joDHYdbg@mail.gmail.com>
References: <CANeU7QkRxYFB41o9dTMp=n=epsNTZLr1ZsjowW=DigRiVNkPjg@mail.gmail.com>
 <20170729130116.b5jd4rvkiwzgsfwt@ltop.local> <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com> <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34680 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752633AbdG2QgA (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 12:36:00 -0400
Received: by mail-qk0-f177.google.com with SMTP id u139so70312209qka.1
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 09:36:00 -0700 (PDT)
In-Reply-To: <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sat, Jul 29, 2017 at 6:25 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Jul 29, 2017 at 12:04 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> You can't do that once cycles are involved. You need something
>> like the marking algorithm used by kill_unreachable_bbs() for that.
>> And it was such a  cycle that created the problem with the false
>> "crazy programmer" warning.
>
> No I don't think so. The find dominator already taking the cycles into
> account. By definition if X dominate Y, means every execution flow
> from entry point to Y will need to go through X. If X was not reachable,
> nor does Y. It does not change where the block get deleted. It just don't
> not need to do the marking algorithm. That is the point of dominator tree.

OK, I misread and misunderstood that you was talking about  the
dominator *tree*.

The real problem with such a tree is that you need to maintain it as
it potentially changes each time there is a change in the CFG.
And of course, building this tree is not linear (in the number of BBs)
while finding the dead BBs is linear.

-- Luc
