From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 5/5] avoid crash with sym->bb_target == NULL
Date: Sat, 29 Jul 2017 08:49:11 -0400
Message-ID: <CANeU7Qk3vRvme2Wms=vwD3fSBD+K-eK=jigS13wq42JVwBpk-g@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-6-luc.vanoostenryck@gmail.com> <CANeU7QnKA8bJihFUC_f=_gcWg27QOQWLxDXd+MO9aYg33g_TVg@mail.gmail.com>
 <CAExDi1RgcMd9e6mw6h-K3ERG6zd30hbv2Ka+7Ek8RJjLT0u2gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:38485 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753607AbdG2MtM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 08:49:12 -0400
Received: by mail-pg0-f53.google.com with SMTP id k190so55671136pgk.5
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 05:49:12 -0700 (PDT)
In-Reply-To: <CAExDi1RgcMd9e6mw6h-K3ERG6zd30hbv2Ka+7Ek8RJjLT0u2gg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Jul 29, 2017 at 8:30 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Yes, it's more informative but I have a later series which convert all these
> to calls to a function show_label() which then do the right thing.
> So, I prefer to leave like this for the moment.

That is of course fine. Let me know if you have updated series to pull from.

Chris
