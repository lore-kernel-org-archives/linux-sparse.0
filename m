From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 5/5] avoid crash with sym->bb_target == NULL
Date: Sat, 29 Jul 2017 14:30:08 +0200
Message-ID: <CAExDi1RgcMd9e6mw6h-K3ERG6zd30hbv2Ka+7Ek8RJjLT0u2gg@mail.gmail.com>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-6-luc.vanoostenryck@gmail.com> <CANeU7QnKA8bJihFUC_f=_gcWg27QOQWLxDXd+MO9aYg33g_TVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34315 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbdG2MaJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 29 Jul 2017 08:30:09 -0400
Received: by mail-qt0-f177.google.com with SMTP id s6so100700241qtc.1
        for <linux-sparse@vger.kernel.org>; Sat, 29 Jul 2017 05:30:08 -0700 (PDT)
In-Reply-To: <CANeU7QnKA8bJihFUC_f=_gcWg27QOQWLxDXd+MO9aYg33g_TVg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jul 20, 2017 at 12:57 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Jul 6, 2017 at 3:19 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
>> +                       sym = expr->symbol;
>> +                       if (sym->bb_target)
>> +                               buf += sprintf(buf, ".L%u", sym->bb_target->nr);
> You chould do:
> bb = expr->symbol->target;
> if (bb)
>     buf +=  sprintf(buf, ".L%u", bb ? bb->nr);
> else
>     buf += sprintf(buf, ".L<invalid>");
>
> It is up to you.

Yes, it's more informative but I have a later series which convert all these
to calls to a function show_label() which then do the right thing.
So, I prefer to leave like this for the moment.

-- Luc
