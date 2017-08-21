From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: RFC: One strange idea inspired by the SSSA
Date: Mon, 21 Aug 2017 22:37:56 +0200
Message-ID: <CAExDi1QFp_GpsJen-7c32f_HzbN-c7g2pa1qLMHiaOv4rk9gNw@mail.gmail.com>
References: <CANeU7Qn2zyruhC5r1bMM8uOzCvk_6xvezQCWdV_U6jAxQiVuDg@mail.gmail.com>
 <CAMHZB6EuyzzTiJdwPC5p727628uDhyt1aRQFdg+Yj6V3hmDozw@mail.gmail.com>
 <CANeU7QkZD4OFjdpTH3Dz5Yq6XMxRvi=+L=G2K5soxFTycDxi_Q@mail.gmail.com>
 <CAMHZB6H9VAT8STaXSuR=waaS3rggky4DE+QRtF6S0vYKWLuRLA@mail.gmail.com>
 <CANeU7Qmh5HjMykETwV24o0a4EEaVKqdGUgqSiu9Bc1txq2b+NQ@mail.gmail.com>
 <CAMHZB6FFO=gdC-i=z5KkHXG+mDrKq5gOiU7=2jQCM=gZ1=uF4A@mail.gmail.com> <CANeU7QnRHKHoRENikvLbfToFEisGyur8F+SyFSgSARA0MKP3RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:32997 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753492AbdHUUh6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 16:37:58 -0400
Received: by mail-oi0-f43.google.com with SMTP id f11so166638784oic.0
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 13:37:57 -0700 (PDT)
In-Reply-To: <CANeU7QnRHKHoRENikvLbfToFEisGyur8F+SyFSgSARA0MKP3RQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 21, 2017 at 9:50 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Mon, Aug 21, 2017 at 3:02 PM, Luc Van Oostenryck wrote:
>>
>> Do you have some numbers for rc4 vs. rc5 ?
>>
> ============rc4 ====================
> 1166.81user 437.91system 1:14.20elapsed 2162%CPU (0avgtext+0avgdata
> 238036maxresident)k
> 8inputs+12776outputs (0major+128364597minor)pagefaults 0swaps
> 1166.99user 436.69system 1:14.23elapsed 2160%CPU (0avgtext+0avgdata
> 238100maxresident)k
> 0inputs+12776outputs (0major+128364667minor)pagefaults 0swaps
>
> ============rc5====================
> 1175.79user 438.58system 1:14.59elapsed 2164%CPU (0avgtext+0avgdata
> 238028maxresident)k
> 0inputs+12768outputs (0major+128881556minor)pagefaults 0swaps
> 1175.76user 439.47system 1:14.55elapsed 2166%CPU (0avgtext+0avgdata
> 238024maxresident)k
> 0inputs+12768outputs (0major+128881539minor)pagefaults 0swaps
> 1174.53user 438.69system 1:14.54elapsed 2164%CPU (0avgtext+0avgdata
> 238112maxresident)k
> 0inputs+12768outputs (0major+128880926minor)pagefaults 0swaps

Thanks!
So that make rc5 taking 0.4 - 0.7% more time than rc4.

> I really enjoy this server. The timing run is very precise.

Yes, it's certainly quite useful to have very repeatable measurements.

-- Luc
