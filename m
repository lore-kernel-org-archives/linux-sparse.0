From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v3 0/7] fixes for rare issues
Date: Tue, 1 Aug 2017 17:49:03 -0400
Message-ID: <CANeU7QmOoZuYiAtDzpoY+b9Pgt1MhTQTXV3-y+s=DUBfUxfMVg@mail.gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qk4cRLtKmPxSVCEe9WJLEb8VajdCiokNV=ic4YALvKcqw@mail.gmail.com>
 <CAExDi1TQh2kFXbyMgX_1tTG0b2F-k-_+CNDJeiKiBW0T0Q4nEA@mail.gmail.com>
 <CAExDi1Qoq21smgUvkqmdTxeJwdYJikC8taFYTdzBmx6Zea5tYg@mail.gmail.com>
 <CAExDi1Sm1dUM3FQ838_5kr2maejva6tzc8NYzRtxV1KprgijhA@mail.gmail.com> <CAExDi1Tq2SuzS9iCyR0ct00uw8ACnGBiAND58drfeXSUoFd5LQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35581 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbdHAVtE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 1 Aug 2017 17:49:04 -0400
Received: by mail-pf0-f175.google.com with SMTP id t86so12809676pfe.2
        for <linux-sparse@vger.kernel.org>; Tue, 01 Aug 2017 14:49:04 -0700 (PDT)
In-Reply-To: <CAExDi1Tq2SuzS9iCyR0ct00uw8ACnGBiAND58drfeXSUoFd5LQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Michael Stefaniuc <mstefani@mykolab.com>

On Tue, Aug 1, 2017 at 4:46 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> OK. That was a false alert, I was still running with debug on.

My sparse full kernel test shows that:

With -rc4:
1145.61user 517.15system 2:36.62elapsed 1061%CPU (0avgtext+0avgdata
235532maxresident)k
0inputs+12744outputs (0major+126771950minor)pagefaults 0swaps

With fix-fuzzy-crashes-v3:
1128.17user 514.33system 2:34.92elapsed 1060%CPU (0avgtext+0avgdata
235556maxresident)k
0inputs+12744outputs (0major+126769380minor)pagefaults 0swaps

It seems about the same or slightly faster. Obviously only one run of each here.
I have another run before that to warm up the machine, that run also
shows V3 is slightly faster.
But not enough run to say for sure. It is within the variance of run to run.

The warning output is exactly the same, no changes.

Chris
