From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 15:10:32 +0200
Message-ID: <CAExDi1Qaa4+km-B-KHpBJ1dH5EOnOCzyU18yP8Y67ETfgbqagA@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34269 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750942AbdHMNKe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 09:10:34 -0400
Received: by mail-oi0-f44.google.com with SMTP id x3so65687434oia.1
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 06:10:33 -0700 (PDT)
In-Reply-To: <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Sun, Aug 13, 2017 at 2:56 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Chris & Luc,
>

Hi,

>
> I am merging and testing this in my repository. I notice that after
> applying the changes related to killing of BBs - there is a
> significant slow down in Sparse.
>
> Before the merge:
>
> real: 4.3 minutes
> user: 4.1 minutes
>
> After the merge:
>
> real: 18.9 minutes
> user: 18.7 minutes
>
> I just noticed this and these are my initial tests. But I thought it
> worth letting you know.

I very small slowdown is expected (and even it could have positive
effect too) but not at all something like this.
And what I (and I think Chris too) measured was indeed quite small.

Care to send your code, I can see where the problem could be?

> BTW in my tests I do not see any change in the results after the
> changes - i.e. the previous failures due to simplification are still
> present. But there is now a degradation in performance - so my
> question is - are these changes worthwhile?

This change (well I guess we're talking about the same) is needed
to ensure consistency: avoid to do things in unreachable code where
the conditions to do those things are not met and thus problems follow.

-- Luc
