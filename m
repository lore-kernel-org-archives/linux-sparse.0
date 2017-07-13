From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] V2 move kill_unreachable_bbs to outer cse stage Was Re:
 [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Wed, 12 Jul 2017 23:31:57 -0700
Message-ID: <CANeU7QmiZZAow=poM2sN3dtyOmAtPLB5LH8Pj+u4cp7V=1VmkQ@mail.gmail.com>
References: <CANeU7QkCcx1d29megDn9bQ0g7rw04=ujsWCe_bN1Kc1NW_-NZw@mail.gmail.com>
 <20170709165157.w6jnjkwca7dwxj64@ltop.local> <CANeU7Qms0KKSWU0dyHomz1iEczdiYn_7SwsJZmPCSXDhsag0Tw@mail.gmail.com>
 <20170710070520.fzr3wqgaugkfocfo@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35213 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdGMGb7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 13 Jul 2017 02:31:59 -0400
Received: by mail-pf0-f173.google.com with SMTP id c73so24566027pfk.2
        for <linux-sparse@vger.kernel.org>; Wed, 12 Jul 2017 23:31:59 -0700 (PDT)
In-Reply-To: <20170710070520.fzr3wqgaugkfocfo@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Jul 10, 2017 at 12:05 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:>
> I have given a run of some of my tests I run here and there
> is indeed some changes.
> Most of these changes are obviously correct.
> Some are not obvious at all and would need to be investigated.
> Some look scary (and of course would need to be investigated too).

Haven't heard from you for a while.

Can you post some of your scary part of the generated code change?
I can take a look as well. I hope we can solve that with finding missing
optimization opportunity. e.g. Adding CSE flag some where.

Any way, now both nest loop related bug has some patch for review.

I will make a RC5 soon. I would love to get more of your feed back,
especially  the ep->bbs one. If any adjustment needs to make,
now it is the time.

Thanks

Chris
