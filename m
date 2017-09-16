From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: sparse with 4.10?
Date: Sat, 16 Sep 2017 16:33:45 +0200
Message-ID: <20170916143343.p32j3uw5rvk4hxp5@ltop.local>
References: <CAHmME9o--jumLrBbRn63ewKOE49+uYJ9B8V5FocptdwZ5Kd9Fw@mail.gmail.com>
 <CAMHZB6G2bQ9SUQLHxxmz0t5Cue73i+-U8bONyq0WMk_gikvyQg@mail.gmail.com>
 <CAHmME9qu6p344M_VnubGtRYvbM7+w4kDmHGJG_PZvLK0kaheOw@mail.gmail.com>
 <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:49128 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751253AbdIPOdt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 16 Sep 2017 10:33:49 -0400
Received: by mail-wm0-f51.google.com with SMTP id r68so13788770wmg.3
        for <linux-sparse@vger.kernel.org>; Sat, 16 Sep 2017 07:33:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHmME9o02YNvfqV3RFofJE8FXwRaUACzq03TBADSYc74E02iBg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Sep 16, 2017 at 02:25:18PM +0200, Jason A. Donenfeld wrote:
> Hey guys,
> 
> Sorry for the delay. I finally produced an extremely minimal test case
> that can reproduce this bug. Please see the attached tarball. Hit
> make, and you'll see the error:
> 
> ./include/linux/mm.h:1766:47: warning: unknown expression (14 0)
> ./include/linux/mm.h:1767:16: warning: call with no type!


Thanks, I can now reproduce this.

It's quite strange.

It's related to the fact that you include mm.h via the '-include' flag.
If you include it with '#include' (as it should be), there is no problem.
Same when trying with the result of the preprocessing.
But all three should have the same effect.

The error message itself has somethng to do with the type 'pmd_t'
but again I don't see anything wrong there and I suppose it's because
of the point above.

I'll need to investigate this a bit more.

-- Luc Van Oostenryck
