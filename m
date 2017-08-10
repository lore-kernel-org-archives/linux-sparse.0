From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 1/8] Remove single-store shortcut
Date: Thu, 10 Aug 2017 14:26:31 +0200
Message-ID: <CAExDi1TGUP9TETWGYguiaa0yjLPhs81k7WakWSSzramJm8pRSg@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-2-luc.vanoostenryck@gmail.com>
 <CANeU7QkmmQOx90sZUsn+8BGCN8Jcz40_8xWBzGZvRYk0GuX=PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36720 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752740AbdHJM0c (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 08:26:32 -0400
Received: by mail-oi0-f45.google.com with SMTP id g131so4965418oic.3
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 05:26:32 -0700 (PDT)
In-Reply-To: <CANeU7QkmmQOx90sZUsn+8BGCN8Jcz40_8xWBzGZvRYk0GuX=PA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Aug 10, 2017 at 1:01 PM, Christopher Li <sparse@chrisli.org> wrote:
>
> The reason this short cut is wrong is that, it is not  about
> how many store we have (single vs multiple).  It is about
> weather all the usage(load) has one single store
> immediate dominates it. If it does, even exist of other stores,
> this optimization can still be done.

More exactly, this shortcut is wrong because it is based on
the assumption that if there is a single store, then this store
must necessary dominates all the loads.
This assumption is, of course, wrong when the var is not
explicitly defined.

> The question would be if we have easy and quick way to
> detect that all the load are immediate dominated by the
> one single store.

That's what the general case does.

> If that condition holds, we can still do the "short-cut".

Only for limited special cases. It's not worth, forget about it.

Anyway, it's very temporary because the code still put the
phi-nodes at wrong places.
This simplify_one_symbol() is replaced by the new SSA construction
branch.

Believe it or not but this placement of phi-nodes is a much bigger
issue than those undefined vars. For example, on the kernel,
this patch has exactly zero (visible) effect. But every non-trivial
piece of code is plainly very wrong because of those bad phi-nodes.

> BTW, I consider this patch can separate out from the other
> patch in this series meaning wise.

Yes, it's what I said :"this patch and the preceding one
(because it's needed for the test case)".

> Please let me know if you want to include this in the RC5.
> Give me a proper git pull address. Topic branch is fine.

Yes, I'll do later.
(if you want just for testing, please take the ref in the cover letter
and drop the top patches. Unless comments from you, I don't
have the intention to change something to these two patches)

Regards,
-- Luc
