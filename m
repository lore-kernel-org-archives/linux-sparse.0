From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC PATCH 00/48] fix promotion of symbol to register
Date: Wed, 23 Aug 2017 16:55:12 -0400
Message-ID: <CANeU7Qmrdy5+ikEAULAmRf6gRMC8i3WT+mFVFcN6Qj9n6c=a5Q@mail.gmail.com>
References: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35550 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932675AbdHWUzO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 23 Aug 2017 16:55:14 -0400
Received: by mail-yw0-f174.google.com with SMTP id s187so7877054ywf.2
        for <linux-sparse@vger.kernel.org>; Wed, 23 Aug 2017 13:55:14 -0700 (PDT)
In-Reply-To: <20170823201554.90551-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Aug 23, 2017 at 4:15 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This series fixes the promotion of symbols accesses from
> memory to pseudos.
> The fix in itself is in the few of the last patches (40-43)
> but is preceded by an extensive rework of the whole thing.
>
> As is, it seems to work quite well and of course more
> accesses are promoted than the Simple SSA was able to do
> (SSSA only cared about purely local vars of which the address
> was never ever taken).
>
> For performance, the situation is highly dependent on the
> type of code: the amount of work that is done in
> simplify_loads() can easily take 80% of the time for complex
> files.
>
> Warning 1: this is for review & testing only
> Warning 2: it's not (yet) bissectable between patches 40 & 43

We might want to fix that. I will take a look later tonight.

> Warning 3: simplify_loads is still broken and will need the same
>            fix (but the code is currently disabled)
>
>
> This series is  available in the git repository at:
>
>   git://github.com/lucvoo/sparse.git mem2reg
>

Here comes the patch bombs again :-)

I will take a look at it tonight.

Thanks for the patches.

Chris
