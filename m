From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/4] mark pseudo users as deleted instead of removing them
Date: Fri, 4 Aug 2017 16:48:40 -0400
Message-ID: <CANeU7QmwOOkmC1U+_Pf1EVJ01vN+_Venhh_4D=W=pU1P1j0q+Q@mail.gmail.com>
References: <CANeU7QkRWygQB_dsD4o4omB-G_xtZZVLZP4-DgaK3iDMd=HB4w@mail.gmail.com>
 <20170804200915.56738-1-luc.vanoostenryck@gmail.com> <20170804200915.56738-5-luc.vanoostenryck@gmail.com>
 <CANeU7QkoXb-G3FQ9+iPx_WGN9x8jeao0wt--FYz8rb0ZvndHpg@mail.gmail.com> <CAExDi1QbMcq+Npc+kFpadjj44i8rm3W3ccE=RhkRAgp98jtHSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:38154 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbdHDUsl (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 16:48:41 -0400
Received: by mail-pg0-f51.google.com with SMTP id l64so12072099pge.5
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 13:48:40 -0700 (PDT)
In-Reply-To: <CAExDi1QbMcq+Npc+kFpadjj44i8rm3W3ccE=RhkRAgp98jtHSw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 4, 2017 at 4:34 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> It will not have a functional impact but you will add this test
> (and code for both tests) for every other use of the list macros
> for which it is totally unneeded.
> Are you sure to really want that?

I am not sure we are on the same page. Only 2 macro need to be updated:
DO_FOR_EACH_PTR, DO_FOR_EACH_REVERSE.

Maybe DO_REPAIR(), DO_NEXT() and DO_REVERSE() if we are ambition.
It think it is fine without touch the last three also.

That is not too bad, is it?

Chris
