From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 22/29] sssa: add seal_gotos() needed to seal BBs targeted
 by gotos
Date: Fri, 18 Aug 2017 17:26:29 -0400
Message-ID: <CANeU7Q=ZKeodQSv9AJd=Je-9+WMNn0yaNMzSciKQ5Rkb7ogjZw@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com> <20170816153455.97693-23-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33560 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751695AbdHRV0a (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 17:26:30 -0400
Received: by mail-yw0-f176.google.com with SMTP id p68so66072599ywg.0
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 14:26:30 -0700 (PDT)
In-Reply-To: <20170816153455.97693-23-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> +void seal_gotos(struct entrypoint *ep)
> +{
> +       struct basic_block *bb;
> +
> +       FOR_EACH_PTR(ep->bbs, bb) {
> +               if (bb->sealed)
> +                       continue;
> +               if (bb->unsealable)
> +                       bb->unsealable = 0;
> +               seal_bb(bb);
> +       } END_FOR_EACH_PTR(bb);
> +
> +       // cleanup these fields as they are aliased to ::needs & ::defines
> +       FOR_EACH_PTR(ep->bbs, bb) {
> +               bb->sealed = bb->unsealable = 0;

I think if you want bb->needs and bb->define to zero.
Best directly assign bb->needs && bb->defines to zero;

I am not sure C stander how to deal with the unused bit field
parts. If I recall correctly a lot of bit-field related stuff are implementation
define. So setting bb->sealed and bb->unsealable might not be enough
to make bb->needs zero.

Chris
