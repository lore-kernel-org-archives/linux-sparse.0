From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Sun, 9 Jul 2017 12:26:40 +0200
Message-ID: <20170709102637.6pakvvwfduzulatl@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7Qktna3bNQ+kgVsULqwmze49wijZihA-Ea-weKcURmgL_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36290 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdGIK0o (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 9 Jul 2017 06:26:44 -0400
Received: by mail-wr0-f170.google.com with SMTP id c11so101337411wrc.3
        for <linux-sparse@vger.kernel.org>; Sun, 09 Jul 2017 03:26:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qktna3bNQ+kgVsULqwmze49wijZihA-Ea-weKcURmgL_Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

> diff --git a/flow.c b/flow.c
> index c7161d4..5d2f15a 100644
> --- a/flow.c
> +++ b/flow.c
> @@ -841,7 +841,7 @@ void kill_unreachable_bbs(struct entrypoint *ep)
>   } END_FOR_EACH_PTR(bb);
>   PACK_PTR_LIST(&ep->bbs);
> 
> - repeat_phase &= ~REPEAT_CFG_CLEANUP;
> + repeat_phase |=  REPEAT_CSE ;

It would be good to add a comment for why the '|= REPEAT_CSE' is needed here.

And not removing the REPEAT_CFG_CLEANUP is an error IMO.
At the end of the function the CFG *is* clean. If you don't
clear it here, then what is its meaning?

-- Luc
