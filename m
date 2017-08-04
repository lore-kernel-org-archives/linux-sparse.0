From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Fri, 4 Aug 2017 13:33:30 +0200
Message-ID: <20170804113329.54u5dzon5hrucohg@ltop.local>
References: <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local>
 <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local>
 <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
 <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com>
 <CANeU7QmzundH7qpdYhQqDJgBv+5pPemwft+1uH5oVQ1POnoQDw@mail.gmail.com>
 <CAMHZB6E0NYy_bNJftB5n4BFZ4-fNf___n0RN1OPb+jkV4Ry-Dw@mail.gmail.com>
 <20170803214906.dvvyibtf53j3ah6m@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34836 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdHDLdh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 07:33:37 -0400
Received: by mail-wr0-f172.google.com with SMTP id k71so15711858wrc.2
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 04:33:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170803214906.dvvyibtf53j3ah6m@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Aug 03, 2017 at 11:49:08PM +0200, Luc Van Oostenryck wrote:
> 1) some numbers:
> - GCC compile both preprocessed files in .9s with -O2.
> - sparse check the O0 file in 1.93s and O2 file in 13s.
> Thus even on the O0 file, the time is already too high because generaly
> sparse is roughly 10 times faster than gcc -O2, here is twice as slow.
> ...
> 4) if we replace 'inline' by 'inline __attribute__((always_inline))'
>    GCC needs roughly 58s to compile the O0 or O2 file.

With the patch I sent, sparse now need 2.1s to compile the O2 file.

-- Luc
