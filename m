From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 0/2] fix bogus "crazy progammer"
Date: Sun, 18 Jun 2017 00:24:17 -0700
Message-ID: <CANeU7Q=keoffx75SxwPeS3UxWUKTxJ=LNPheqTncpgvNTDUP3Q@mail.gmail.com>
References: <20170616191844.86256-1-luc.vanoostenryck@gmail.com>
 <8132b29c-0bfc-9294-8040-a2f7271affd6@ramsayjones.plus.com>
 <20170617034449.6clvouwqxpfiujrb@ltop.local> <3c71421d-eb26-5268-7701-568d59e5b4d0@ramsayjones.plus.com>
 <20170618064340.czth3trqkb4tu5al@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:34576 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750970AbdFRHYS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 18 Jun 2017 03:24:18 -0400
Received: by mail-io0-f180.google.com with SMTP id i7so49131575ioe.1
        for <linux-sparse@vger.kernel.org>; Sun, 18 Jun 2017 00:24:18 -0700 (PDT)
In-Reply-To: <20170618064340.czth3trqkb4tu5al@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jun 17, 2017 at 11:43 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> For info, I also tested on some other platform, just for the fun
> and only running the testsuite. The results are:

Great you have got this issue fix.

I assume you want this fix merge for the -rc2 as well, right?

Chris
