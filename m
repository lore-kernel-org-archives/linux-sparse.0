From: Christopher Li <sparse@chrisli.org>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Fri, 4 Aug 2017 10:51:04 -0400
Message-ID: <CANeU7Qm8XKLavw=vWcKDyPkpnLVJ3kva17hkQhYqsi8QHZ2ArQ@mail.gmail.com>
References: <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local> <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local> <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
 <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com>
 <CANeU7QmzundH7qpdYhQqDJgBv+5pPemwft+1uH5oVQ1POnoQDw@mail.gmail.com>
 <CAMHZB6E0NYy_bNJftB5n4BFZ4-fNf___n0RN1OPb+jkV4Ry-Dw@mail.gmail.com>
 <20170803214906.dvvyibtf53j3ah6m@ltop.local> <20170804113329.54u5dzon5hrucohg@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33800 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751944AbdHDOvF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 10:51:05 -0400
Received: by mail-pg0-f54.google.com with SMTP id u185so8949080pgb.1
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 07:51:05 -0700 (PDT)
In-Reply-To: <20170804113329.54u5dzon5hrucohg@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Fri, Aug 4, 2017 at 7:33 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Thu, Aug 03, 2017 at 11:49:08PM +0200, Luc Van Oostenryck wrote:
>> 1) some numbers:
>> - GCC compile both preprocessed files in .9s with -O2.
>> - sparse check the O0 file in 1.93s and O2 file in 13s.
>> Thus even on the O0 file, the time is already too high because generaly
>> sparse is roughly 10 times faster than gcc -O2, here is twice as slow.
>> ...
>> 4) if we replace 'inline' by 'inline __attribute__((always_inline))'
>>    GCC needs roughly 58s to compile the O0 or O2 file.
>
> With the patch I sent, sparse now need 2.1s to compile the O2 file.

Wow, that is great. You are the man.

I will include that patch, I am going to take a closer look now.
Too tired last night.

Chris
