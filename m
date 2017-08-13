From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Sun, 13 Aug 2017 15:20:31 -0400
Message-ID: <CANeU7QkMPKycTmOD_ifV5shHSzMQwzd6Nj=7AwVEJHo5EXc-Bw@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com> <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35747 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdHMTUc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 13 Aug 2017 15:20:32 -0400
Received: by mail-yw0-f179.google.com with SMTP id l82so45067690ywc.2
        for <linux-sparse@vger.kernel.org>; Sun, 13 Aug 2017 12:20:32 -0700 (PDT)
In-Reply-To: <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Sun, Aug 13, 2017 at 3:10 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I have to disable simplifications anyway to get correct IR in some
> cases. With the single store shortcut test that sets bitfield succeeds
> even when simplifications are on - but even so, I cannot turn
> simplifications on in practice because of other failures.

So you are saying even the last change does not make
you to turn on the simplification.

> It is okay by me if you want to leave the change in - I have it so I
> can switch it on / off in my project.

Yes, I am still thinking about it. Thank you for letting me know.

Chris
