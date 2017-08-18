From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 15/29] add remove_use()
Date: Fri, 18 Aug 2017 16:51:48 -0400
Message-ID: <CANeU7Qk0orj2kFRacgTa=rCq1gYDkoCTjxB9QEQWcrkn_Wmmbw@mail.gmail.com>
References: <20170816153455.97693-1-luc.vanoostenryck@gmail.com> <20170816153455.97693-16-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35750 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbdHRUvt (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 16:51:49 -0400
Received: by mail-yw0-f181.google.com with SMTP id n83so37824246ywn.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 13:51:49 -0700 (PDT)
In-Reply-To: <20170816153455.97693-16-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Aug 16, 2017 at 11:34 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Add an helper to remove the usage of a pseudo, like kill_use()
> do but unlike kill_use(), without trying to kill (recursively!)
> the defining instruction if the usage drop to zero.
>
>
> +/*
> + * Like kill_use() but do not recursively kill instructions
> + * that become without users.
> + */
> +void remove_use(pseudo_t *usep)

remove_use() vs remove_usage() in the above code look a bit
too close to tell apart. This two have total different behavior
not reflecting in the name.

I was confused there for a second. That is before I notice the
subtle different between remove_use() vs remove_usage()

Chris
