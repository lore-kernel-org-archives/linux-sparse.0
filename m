From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 00/25] improve constexpr handling
Date: Fri, 11 Aug 2017 13:14:46 +0200
Message-ID: <20170811111445.ezaxfwbduktu4m2n@ltop.local>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkXi8+yi3RcY6a=WtKo9LgEgKi_CjpW-bEvHFhuu=FgVA@mail.gmail.com>
 <CAExDi1TFOoKTua0N6_w3EA14THS3fvON8URY_AeFc1vsPY17kg@mail.gmail.com>
 <CANeU7Q=YT8WJot7YjVgMG=-Pmes-yxfC695b=nLJT8nR_Xe=Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35305 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdHKLOt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 07:14:49 -0400
Received: by mail-wm0-f45.google.com with SMTP id m85so39377407wma.0
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 04:14:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=YT8WJot7YjVgMG=-Pmes-yxfC695b=nLJT8nR_Xe=Tg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Thu, Aug 10, 2017 at 09:24:49PM -0400, Christopher Li wrote:
> On Thu, Aug 10, 2017 at 6:00 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > It's many months ago so I may not remember the details correctly but ...
> >
> > The initial version Nicolai posted (or maybe it was the second) *had*
> > function to abstract the operations and it was, IMO, really not very readable
> 
> Ok. I can try to dig them out and see the original form.
> 
> > and I asked him to change to something simpler like simply using
> > X |= M or X &= ~M when possible.
> > It's what he did and it was, IMO, much more readable.
> >
> > Meanwhile, I also tried on my side to have some nice & cleaner bit
> > representation. It looked promising at first but was deceiving at the end.
> >
> > So, I think that this series is much more valuable upstreamed than waiting
> > for some hypothetical super clean abstract layer for those few bits.
> 
> Completely agree. I want to make them upstream after the release.
> No question about it. Even as it is is acceptable for after release.

Great! 

-- Luc
