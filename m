From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] avoid infinite loop during simplification
Date: Sat, 12 Aug 2017 10:34:26 -0400
Message-ID: <CANeU7QnNeum7M0YrNP_amH82JED0c5GOGyVXQnj010e6mMhjdA@mail.gmail.com>
References: <20170812125525.34044-1-luc.vanoostenryck@gmail.com>
 <CANeU7QmjFd17UTFGSe_FOR+0jTn+azzaHvwq_FtG6sSGL1sx+Q@mail.gmail.com>
 <CANeU7QmgTDZYP+NRH-b0581e5izaCXd9oGjA788UgOBEmhv8zg@mail.gmail.com> <CAExDi1SsOsdADxpMMBd+gc-HMkuZ0P0ozZT0A=JANPBz8O_k_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33801 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750980AbdHLOe1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 10:34:27 -0400
Received: by mail-yw0-f181.google.com with SMTP id s143so36089730ywg.1
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 07:34:26 -0700 (PDT)
In-Reply-To: <CAExDi1SsOsdADxpMMBd+gc-HMkuZ0P0ozZT0A=JANPBz8O_k_A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 12, 2017 at 10:22 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> uh no.
> It's exactly how it's already working now.
> But it's exactly what is the problem when something
> silly, caused by an internal bug, change at *each*
> cycle and this it's what this patch avoid.

If there is change at each cycle then the change
flag will not help. I haven't seen those dead loop
so I did not know what is the nature of those.
I assume there is also other kind of deadloop
if we think there is some thing can CSE but no
actual change to the CFG.

>
> Of course, there is plenty of ways to do the same
> or something similar or something which will have
> the same result. This patch is just a very simple,
> no non-sense way to do it.
>

Sure. It is simple enough.

Chris
