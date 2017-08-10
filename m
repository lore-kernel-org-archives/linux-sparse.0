From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 00/25] improve constexpr handling
Date: Fri, 11 Aug 2017 00:00:54 +0200
Message-ID: <CAExDi1TFOoKTua0N6_w3EA14THS3fvON8URY_AeFc1vsPY17kg@mail.gmail.com>
References: <20170331014459.9351-1-luc.vanoostenryck@gmail.com> <CANeU7QkXi8+yi3RcY6a=WtKo9LgEgKi_CjpW-bEvHFhuu=FgVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34630 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752536AbdHJWAz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 18:00:55 -0400
Received: by mail-oi0-f49.google.com with SMTP id x3so19331058oia.1
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 15:00:55 -0700 (PDT)
In-Reply-To: <CANeU7QkXi8+yi3RcY6a=WtKo9LgEgKi_CjpW-bEvHFhuu=FgVA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Nicolai Stange <nicstange@gmail.com>

On Thu, Aug 10, 2017 at 2:36 PM, Christopher Li <sparse@chrisli.org> wrote:

> I would like the manipulate of the bits representation abstract as
> higher level function or macros. I have suspicious that bits
> representation can be simplify in the future. Wrap them into
> higher level function at the call site will be easier to read what
> is the intend for this operation.
>
> It also make the change of the underlying bit representation easier,
> that is if we do found a simpler representation.

It's many months ago so I may not remember the details correctly but ...

The initial version Nicolai posted (or maybe it was the second) *had*
function to abstract the operations and it was, IMO, really not very readable
and I asked him to change to something simpler like simply using
X |= M or X &= ~M when possible.
It's what he did and it was, IMO, much more readable.

Meanwhile, I also tried on my side to have some nice & cleaner bit
representation. It looked promising at first but was deceiving at the end.

So, I think that this series is much more valuable upstreamed than waiting
for some hypothetical super clean abstract layer for those few bits.
Of course, if you have some concrete set of patches making this better,
I would be glad to take a look at it and change my mind.
Otherwise, please consider it for upstreaming directly after the release
and improving the bit representation and the abstraction layer can always
be done later too.

-- Luc
