From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Sat, 29 Jul 2017 18:04:46 +0200
Message-ID: <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com>
References: <CANeU7QkRxYFB41o9dTMp=n=epsNTZLr1ZsjowW=DigRiVNkPjg@mail.gmail.com>
 <20170729130116.b5jd4rvkiwzgsfwt@ltop.local> <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33329 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752644AbdG2QEs (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 12:04:48 -0400
Received: by mail-qk0-f171.google.com with SMTP id a77so34822597qkb.0
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 09:04:48 -0700 (PDT)
In-Reply-To: <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sat, Jul 29, 2017 at 5:53 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Sat, Jul 29, 2017 at 9:01 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> Interesting.
>> My measurements showed much smaller differences (around 1-2%
>> and smaller than the stdev). But I also saw that this difference
>> was significantly bigger on older/less performant machines
>> (which is not very surprising).
>
> I guess my laptop can qualify as older/less performance machines :-)

Hehe, maybe :)

> A wild guess is that the modern CPU are better doing caching and
> branch predictions etcs.

Indeed.

> BTW, I am writing some code to construct the dominator tree for
> basic blocks. I think it will be useful to avoid repeat finding dominator.
> It will also help you finding the dominator frontier for the phi locations.

I don't need it but it's indeed something that is generally needed.

> Another possible use is that, we can do incremental remove of dead
> blocks without visiting all the blocks.

You can't do that once cycles are involved. You need something
like the marking algorithm used by kill_unreachable_bbs() for that.
And it was such a  cycle that created the problem with the false
"crazy programmer" warning.

-- Luc
