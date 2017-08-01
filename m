From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 0/7] fixes for rare issues
Date: Wed, 2 Aug 2017 00:10:25 +0200
Message-ID: <CAExDi1Th4amvy61BKD_oD8wLUTBgdZtB4o3oHKBO5oC5zip5pg@mail.gmail.com>
References: <20170731203624.58971-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qk4cRLtKmPxSVCEe9WJLEb8VajdCiokNV=ic4YALvKcqw@mail.gmail.com>
 <CAExDi1TQh2kFXbyMgX_1tTG0b2F-k-_+CNDJeiKiBW0T0Q4nEA@mail.gmail.com>
 <CAExDi1Qoq21smgUvkqmdTxeJwdYJikC8taFYTdzBmx6Zea5tYg@mail.gmail.com>
 <CAExDi1Sm1dUM3FQ838_5kr2maejva6tzc8NYzRtxV1KprgijhA@mail.gmail.com>
 <CAExDi1Tq2SuzS9iCyR0ct00uw8ACnGBiAND58drfeXSUoFd5LQ@mail.gmail.com> <CANeU7QmOoZuYiAtDzpoY+b9Pgt1MhTQTXV3-y+s=DUBfUxfMVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:36851 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbdHAWK1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 1 Aug 2017 18:10:27 -0400
Received: by mail-ua0-f176.google.com with SMTP id k43so13126152uaf.3
        for <linux-sparse@vger.kernel.org>; Tue, 01 Aug 2017 15:10:26 -0700 (PDT)
In-Reply-To: <CANeU7QmOoZuYiAtDzpoY+b9Pgt1MhTQTXV3-y+s=DUBfUxfMVg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Michael Stefaniuc <mstefani@mykolab.com>

On Tue, Aug 1, 2017 at 11:49 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Aug 1, 2017 at 4:46 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>>
>> OK. That was a false alert, I was still running with debug on.
>
> My sparse full kernel test shows that:
>
> With -rc4:
> 1145.61user 517.15system 2:36.62elapsed 1061%CPU (0avgtext+0avgdata
> 235532maxresident)k
> 0inputs+12744outputs (0major+126771950minor)pagefaults 0swaps
>
> With fix-fuzzy-crashes-v3:
> 1128.17user 514.33system 2:34.92elapsed 1060%CPU (0avgtext+0avgdata
> 235556maxresident)k
> 0inputs+12744outputs (0major+126769380minor)pagefaults 0swaps
>
> It seems about the same or slightly faster. Obviously only one run of each here.
> I have another run before that to warm up the machine, that run also
> shows V3 is slightly faster.
> But not enough run to say for sure. It is within the variance of run to run.

Yes, it's what I really have too.

-- Luc
