From: Christopher Li <sparse@chrisli.org>
Subject: Re: ptrlist-iterator performance on one wine source file
Date: Tue, 1 Aug 2017 20:42:50 -0400
Message-ID: <CANeU7Qm3C7jzoE7TtdKSx9C3NPGZh3XWbTeSx8OdJAjHvif9wQ@mail.gmail.com>
References: <CANeU7QnGxae2dw_vU306nc+iUR2CuGczjDjp2fUYB5yPzye22w@mail.gmail.com>
 <CAExDi1Tkws5eRO1APi6tOdhGTzvaCpuHQ8k9h+T7odD5Yx3W3Q@mail.gmail.com>
 <CANeU7QnHbCmpTmD7ckokE7XezHB6-ZAFzX-h+J8cPe=wWxx3VA@mail.gmail.com>
 <CAMHZB6FjKnPojtirh0csQMXhZC-TT=hHRPne+z7q74joDHYdbg@mail.gmail.com>
 <CANeU7QnRQG84w+e-gTjp2yOZYdwq+itgExg_UTG-zUuRT8FYLg@mail.gmail.com>
 <CAMHZB6E8PwoeofUFRB_zdVx=HqqHM72UhcqwH1QPDa_U+4V-DQ@mail.gmail.com>
 <CANeU7Qne+bdhtzrVCi-qihDt9kyJ8wN6i3XTixYJNX5yFmiBpA@mail.gmail.com>
 <20170730151254.xlnz7c4zphhnhump@ltop.local> <CANeU7Q=5SycRKw4Z1NXHPuza_UbUjSF=E9wy6Ko6UEzSHPO2ng@mail.gmail.com>
 <CAMHZB6Emib_U7AtDLZ5Wc6KGXtZzMwhbT-N+sk-B05PUVbtfNg@mail.gmail.com>
 <20170801203357.4ywboptvr6tlytab@ltop.local> <CANeU7QkShNBJ2nWh0wvTN3fTvwX710BT-g=aFf+GS1upnD_Gxw@mail.gmail.com>
 <CAExDi1R9QZJorwhMq4=nRLvMet+S0RCpeiMurko=rNYLpu8c2A@mail.gmail.com> <CANeU7Qmxc6GR9wReqa-K0YwKXwX1qAxy8A7MMe+G3BxD-at6ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32796 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdHBAmw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 1 Aug 2017 20:42:52 -0400
Received: by mail-pf0-f182.google.com with SMTP id d67so14298424pfc.0
        for <linux-sparse@vger.kernel.org>; Tue, 01 Aug 2017 17:42:52 -0700 (PDT)
In-Reply-To: <CANeU7Qmxc6GR9wReqa-K0YwKXwX1qAxy8A7MMe+G3BxD-at6ZQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Tue, Aug 1, 2017 at 7:37 PM, Christopher Li <sparse@chrisli.org> wrote:
> So you can't reproduce it. Let me dig deeper to see what is going on.

#0  pseudo_in_list (list=0x7f5a6972de10, pseudo=0x7f5a7aa65d68) at
liveness.c:163
#1  0x0000000000427924 in add_pseudo_exclusive (list=0x7f5a7dcf3758,
pseudo=0x7f5a7aa65d68)
    at liveness.c:173
#2  0x0000000000427afe in track_bb_liveness (bb=0x7f5a7dcf3680) at
liveness.c:207
#3  0x0000000000427db9 in track_pseudo_liveness (ep=0x7f5a863d1010) at
liveness.c:250
#4  0x000000000041d313 in linearize_fn (sym=0x7f5a8c5fd8b0,
base_type=0x7f5a8c5fd990)
    at linearize.c:2260
#5  0x000000000041d3b1 in linearize_symbol (sym=0x7f5a8c5fd8b0) at
linearize.c:2291
#6  0x0000000000401a08 in check_symbols (list=0x7f5a8c685910) at sparse.c:282
#7  0x0000000000401afe in main (argc=29, argv=0x7fff1f8d99c8) at sparse.c:303

I take a closer look, it seems sparse is spending a lot of time in
track_pseudo_liveness.
Compile with -O0 does not change any thing. At this point it could be
any thing.
Looking more into it.

Chris
