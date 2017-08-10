From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 1/8] Remove single-store shortcut
Date: Thu, 10 Aug 2017 07:01:49 -0400
Message-ID: <CANeU7QkmmQOx90sZUsn+8BGCN8Jcz40_8xWBzGZvRYk0GuX=PA@mail.gmail.com>
References: <CACXZuxd30jwczag_GHW3cmqPcBybEi7jfwfku81vW2nHzo_kyA@mail.gmail.com>
 <20170807191205.86590-1-luc.vanoostenryck@gmail.com> <20170807191205.86590-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36025 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbdHJLBu (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 07:01:50 -0400
Received: by mail-yw0-f169.google.com with SMTP id u207so2272010ywc.3
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 04:01:50 -0700 (PDT)
In-Reply-To: <20170807191205.86590-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Aug 7, 2017 at 3:11 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Current sparse code doesn't handle very gracefully
> code with undefined pseudos. These can occurs,
> of course because the dev has forgot (or choose) to
> initialize them but they can also occurs when they
> are only set (and used) in a single path and not others
> or even worse when initilaizing a bitfield.
>
> The origin of the problme is the single store shortcut
> in simplify_one_symbol() which doesn't take in account
> the (absence of) dominance when loads exist without
> stores.

I have give it a bit more thinking. The right metal model is actually
consider the every uninitialized variable has an implicit
define at the entry block.

The reason this short cut is wrong is that, it is not  about
how many store we have (single vs multiple).  It is about
weather all the usage(load) has one single store
immediate dominates it. If it does, even exist of other stores,
this optimization can still be done.

The question would be if we have easy and quick way to
detect that all the load are immediate dominated by the
one single store. If that condition holds, we can still do the
"short-cut".

BTW, I consider this patch can separate out from the other
patch in this series meaning wise. The other patches are about
constant related transformations. This one is about proper SSA.
It can still be merge as one series. That part is fine.

Please let me know if you want to include this in the RC5.
Give me a proper git pull address. Topic branch is fine.

Thanks

Chris
