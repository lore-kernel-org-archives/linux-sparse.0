From: Christopher Li <sparse@chrisli.org>
Subject: Re: Upcoming sparse release RC5
Date: Sun, 6 Aug 2017 22:06:40 -0400
Message-ID: <CANeU7Qm=wV4=+ak2-o8ZBRy6Ee_ZwpPqNESQDvpGA1EvfndMpg@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:37223 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdHGCGl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Aug 2017 22:06:41 -0400
Received: by mail-pg0-f45.google.com with SMTP id y129so28034760pgy.4
        for <linux-sparse@vger.kernel.org>; Sun, 06 Aug 2017 19:06:41 -0700 (PDT)
In-Reply-To: <CAExDi1Qshm920Te38c-HZsrWDtxVS-WP6HRXkeNujWySXX0mXg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 5, 2017 at 6:32 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> sparse-next is currently not fast-forwardable from master.
>

BTW, do you have any thing to add for RC5? If not I am going
tag the RC5 and hope that is the last RC for this release.

I still need to add two document for sparse. I assume I can
add it after RC5 into the release because there is no any
code changes. Maybe I should check in two place holder
file now so it does not mess up with the packaging for the
finial release.

Chris
