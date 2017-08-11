From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: master branch for upcoming RC5
Date: Fri, 11 Aug 2017 17:15:28 +0200
Message-ID: <CAExDi1QDakpqyS9m1=a6NNYx=tFvx+Lz=FuQOaEzHheRvqbgSA@mail.gmail.com>
References: <CANeU7QnAL0XxRHXifJunkPi1+My-vUJ84neaMPjPR+v7-UQmSQ@mail.gmail.com>
 <CACXZuxeQoL-zfoAqxwMLfRKCEt_TbZp-8gONQJgkWn98WF7=sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:36460 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752915AbdHKPP3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 11:15:29 -0400
Received: by mail-oi0-f52.google.com with SMTP id g131so35909400oic.3
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 08:15:29 -0700 (PDT)
In-Reply-To: <CACXZuxeQoL-zfoAqxwMLfRKCEt_TbZp-8gONQJgkWn98WF7=sA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 11, 2017 at 5:00 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> Were these two issues caused by recent changes - or are they bugs in
> the released version of Sparse?

Both have been there since essentially forever.
It's only recently that we discovered how bad the situation was

> I ran the test case kill-unreachable-phi.c in my repository and did
> not see an infinite loop. My repository is way behind the latest
> changes in Sparse as I last synced up earlier this year so maybe I am
> not seeing this issue?

It's possible. It's the kind of things that is very sensitive to
details like the exact ordering of different operations.

It's probably another change somewhere that triggered a chain
and finally, this bug showed up.

-- Luc
