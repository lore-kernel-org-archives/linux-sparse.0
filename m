From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: RFC: One strange idea inspired by the SSSA
Date: Mon, 21 Aug 2017 18:57:37 +0200
Message-ID: <CAMHZB6H9VAT8STaXSuR=waaS3rggky4DE+QRtF6S0vYKWLuRLA@mail.gmail.com>
References: <CANeU7Qn2zyruhC5r1bMM8uOzCvk_6xvezQCWdV_U6jAxQiVuDg@mail.gmail.com>
 <CAMHZB6EuyzzTiJdwPC5p727628uDhyt1aRQFdg+Yj6V3hmDozw@mail.gmail.com> <CANeU7QkZD4OFjdpTH3Dz5Yq6XMxRvi=+L=G2K5soxFTycDxi_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36288 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753636AbdHUQ5i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 12:57:38 -0400
Received: by mail-vk0-f42.google.com with SMTP id u133so51941260vke.3
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 09:57:38 -0700 (PDT)
In-Reply-To: <CANeU7QkZD4OFjdpTH3Dz5Yq6XMxRvi=+L=G2K5soxFTycDxi_Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 6:40 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> Do you have insight then why the SSSA is 2% slower than
> the RC5 without the short cut case? I expect with simpler
> effective approach it should be at least similar or faster.
> It do less work than RC5 in terms of finding dorminator etc.

I just made a small change to the ptrmap and I'm back to slightly
faster than rc5. With all March's pending fixes it's even a bit faster.
We're talking of something like twice 2%.
With smaller ptrlist it's yet another 2%.


>>> If we take that as an assumption. Then I have this idea similar
>>> to the SSSA paper in the sense that it take advantage of the
>>> source file that is reducible graph. Instead of inserting the phi
>>> instruction on all possible block join point.
>>
>> Mind to explain what you mean by 'all possible block join point' and
>> why you believe the method do this?
>
> I am reading the paper there seems to be recursive go through
> the parents.

Otherwise you could only process block local vars.
But going recursively through the parents is not something
expensive, especially since very few is done at each steps.

>> Don't you need the whole CFG for this (when you have
>> a loop, for example)?
>
> I haven't play out all the detail yet. The idea about the loop:
>
> while (expr_a()) {
>       loop_body_blocks;
> }
> after_loop_blok;
>
> We known that every variable declare in the loop_body_blocks
> with indentation level == 2 is going to dominate the rest of the
> loop_body_blocks where line number > the current define place.
>
> And we know that that define domination ends at the last block
> in side loop_body_blocks for the same indentation level.
>
> We can have a stack system while we recursive linearize
> the statement. That is the idea. I haven't plan out the detail.

Sorry, but for my part I'll give my trust to a published and well
received method.

-- Luc
