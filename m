From: Christopher Li <sparse@chrisli.org>
Subject: Re: what is cooking in sparse-next-20170805
Date: Sat, 5 Aug 2017 09:51:28 -0400
Message-ID: <CANeU7Q=TjwwwNH4+iA=Qd-qPY8Kz0KmTNwtHQNstc8ERO5SZnA@mail.gmail.com>
References: <CANeU7Q=PetPO=LujGB9mk6RhzJz9aQivYNgx=_4Eht3XMrPFCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:38546 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdHENv3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 09:51:29 -0400
Received: by mail-pg0-f41.google.com with SMTP id l64so18086193pge.5
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 06:51:29 -0700 (PDT)
In-Reply-To: <CANeU7Q=PetPO=LujGB9mk6RhzJz9aQivYNgx=_4Eht3XMrPFCA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Sat, Aug 5, 2017 at 8:42 AM, Christopher Li <sparse@chrisli.org> wrote:
> diff -ruN linux-checker/rc4/drivers/auxdisplay/panel.sp
> linux-checker/exp/drivers/auxdisplay/panel.sp
> --- linux-checker/rc4/drivers/auxdisplay/panel.sp 2017-08-05
> 05:07:54.558438024 -0700
> +++ linux-checker/exp/drivers/auxdisplay/panel.sp 2017-08-05
> 04:56:45.285724297 -0700
> @@ -1 +0,0 @@
> -drivers/auxdisplay/panel.c:1402:17: warning: context imbalance in
> 'panel_scan_timer' - different lock contexts for basic block
> diff -ruN linux-checker/rc4/drivers/net/ethernet/chelsio/cxgb3/sge.sp
> linux-checker/exp/drivers/net/ethernet/chelsio/cxgb3/sge.sp
> --- linux-checker/rc4/drivers/net/ethernet/chelsio/cxgb3/sge.sp
> 2017-08-05 05:08:45.045911820 -0700
> +++ linux-checker/exp/drivers/net/ethernet/chelsio/cxgb3/sge.sp
> 2017-08-05 04:57:32.503081874 -0700
> @@ -13,4 +13,3 @@
>  drivers/net/ethernet/chelsio/cxgb3/sge.c:2371:47: warning: incorrect
> type in assignment (different base types)
>  drivers/net/ethernet/chelsio/cxgb3/sge.c:2371:47:    expected
> unsigned int [unsigned] [usertype] priority
>  drivers/net/ethernet/chelsio/cxgb3/sge.c:2371:47:    got restricted
> __be32 [assigned] [usertype] rss_lo
> -drivers/net/ethernet/chelsio/cxgb3/sge.c:2936:9: warning: context
> imbalance in 'sge_timer_rx' - different lock contexts for basic block

This different is actually trace back to this change, not by the recent
two series:

c7dd24480716c2bf853b63d462c3c8be84b78359
fix BB dependencies on phi-nodes

I some how did not catch it earlier.

Chris
