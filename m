From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/7] put struct symbol & friends on diet
Date: Sat, 1 Jul 2017 14:03:28 -0700
Message-ID: <CANeU7Q=9mbkmWA+zciYW_oiAYQXWkY=zA6gucrQgdkwpKBDHsg@mail.gmail.com>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qn-+q8nDRLkLGMQUQxyLS73RC0awYN2LrCrbrE1z3+BQg@mail.gmail.com> <20170701083915.27ogssgsakjgjz4s@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35668 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751996AbdGAVD3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 17:03:29 -0400
Received: by mail-pg0-f52.google.com with SMTP id j186so78162082pge.2
        for <linux-sparse@vger.kernel.org>; Sat, 01 Jul 2017 14:03:29 -0700 (PDT)
In-Reply-To: <20170701083915.27ogssgsakjgjz4s@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jul 1, 2017 at 1:39 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Meanwhile, I just looked at your numbers. At first sight, they look
> more or less as expected. I'm just surprised that the sys time is so
> high: around 45% of the user time (IIRC, in my measurements it was
> more like 10%, but I can be wrong).


For what is worth, I have rerun the test with less jobs:

Two run with -j6:

real 3m12.199s
user 12m47.617s
sys 5m30.896s

real 3m11.469s
user 12m44.292s
sys 5m29.944s

One run with one job:

real 14m21.460s
user 10m18.034s
sys 3m56.646s

As predicted, the system overhead come down dramatically with
less jobs. I think that sparse is the one with NR=29.

Chris
