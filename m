From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] avoid infinite loop during simplification
Date: Sat, 12 Aug 2017 16:22:32 +0200
Message-ID: <CAExDi1SsOsdADxpMMBd+gc-HMkuZ0P0ozZT0A=JANPBz8O_k_A@mail.gmail.com>
References: <20170812125525.34044-1-luc.vanoostenryck@gmail.com>
 <CANeU7QmjFd17UTFGSe_FOR+0jTn+azzaHvwq_FtG6sSGL1sx+Q@mail.gmail.com> <CANeU7QmgTDZYP+NRH-b0581e5izaCXd9oGjA788UgOBEmhv8zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35969 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdHLOWd (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 12 Aug 2017 10:22:33 -0400
Received: by mail-oi0-f54.google.com with SMTP id g131so54418038oic.3
        for <linux-sparse@vger.kernel.org>; Sat, 12 Aug 2017 07:22:33 -0700 (PDT)
In-Reply-To: <CANeU7QmgTDZYP+NRH-b0581e5izaCXd9oGjA788UgOBEmhv8zg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Aug 12, 2017 at 4:04 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> There is also the other way to do it.
> Every time the CFG changed, set a changed flag.
> Stop CSE if there is no more change reached.

uh no.
It's exactly how it's already working now.
But it's exactly what is the problem when something
silly, caused by an internal bug, change at *each*
cycle and this it's what this patch avoid.

Of course, there is plenty of ways to do the same
or something similar or something which will have
the same result. This patch is just a very simple,
no non-sense way to do it.

-- Luc
