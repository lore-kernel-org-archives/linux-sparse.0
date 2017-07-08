From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Sat, 8 Jul 2017 08:43:55 -0700
Message-ID: <CANeU7Q=zb6kNUW7UnMuanCo1YtKiDJWVBs-P7oBSTanhf+iZQw@mail.gmail.com>
References: <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
 <CA+55aFyUN-anJrFmo25tATO2wJS8+24S8TK=PAZBEYr0LvZN8g@mail.gmail.com>
 <CANeU7Q=XzVrNoUOScCJjtautBsc0ittc_Okh+0wESuV4rRqing@mail.gmail.com>
 <20170707082802.gphim2wpqsncqoyh@ltop.local> <CANeU7Qk3s90N35co_HOT0vfHhZDjthMv5=5dT9Hy72JQFfc=ng@mail.gmail.com>
 <CACXZuxf5JSfECtZni5OLmh3_iTarC39nu9-DqRNsivTT6iHb7g@mail.gmail.com>
 <CAExDi1TRKuokxpUH3BNC5rQ8TFfpHH=Xoj-M3DU1TfVMopKFeA@mail.gmail.com>
 <CACXZuxcaR7DbmgxVyLHWuEJW-_aCqsxtd=ajsKVXjksnqcf2vg@mail.gmail.com> <20170707134713.3kirm7f4lqexxrot@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36260 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbdGHPn5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 8 Jul 2017 11:43:57 -0400
Received: by mail-pg0-f49.google.com with SMTP id u62so30132624pgb.3
        for <linux-sparse@vger.kernel.org>; Sat, 08 Jul 2017 08:43:57 -0700 (PDT)
In-Reply-To: <20170707134713.3kirm7f4lqexxrot@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jul 7, 2017 at 6:47 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> We have to do something more (or something less :)) otherwise
> the refcount can only be used to detect a problem. In other words,
> having a situation like "OK, I can't safely do XYZ here" is maybe
> better than the current situation but doesn't help when you need
> to do XYZ.

Right. The real implementation will replace the die with some code to
handle those situation. I am also considering a debug version of
sparse which performance those extra test at a performance penalty.

Just generate two executable. One for normal production use. The
other one for developer to find out potential issue. Some of the code
have to be compile differently(ptrlist), it is not easy to implement as turn on
by a command line options.

Chris
