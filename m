From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 13:56:07 +0100
Message-ID: <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34956 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750908AbdHMM4I (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 08:56:08 -0400
Received: by mail-vk0-f42.google.com with SMTP id d124so25023385vkf.2
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 05:56:07 -0700 (PDT)
In-Reply-To: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

Hi Chris & Luc,

On 12 August 2017 at 15:15, Christopher Li <sparse@chrisli.org> wrote:
> It took longer than I thought. But we are finally there.
>
> I am very happy that the wine dead loop bug is nailed
> down and the looping while deleting bugs are stopped.
>
> Thanks Luc for a lot of hard work there.
>
> I hope this is the last RC for this release.
>
> Let's ship this release out. The work for the next release
> is already start to piling up.
>
> Thanks every one that contribute to this RC5.
>
> Again, please give it a good test.  Report back
> any issue you might have.
>

I am merging and testing this in my repository. I notice that after
applying the changes related to killing of BBs - there is a
significant slow down in Sparse.

Before the merge:

real: 4.3 minutes
user: 4.1 minutes

After the merge:

real: 18.9 minutes
user: 18.7 minutes

I just noticed this and these are my initial tests. But I thought it
worth letting you know.

BTW in my tests I do not see any change in the results after the
changes - i.e. the previous failures due to simplification are still
present. But there is now a degradation in performance - so my
question is - are these changes worthwhile?

Regards
Dibyendu
