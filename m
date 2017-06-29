From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] make for-loop statement simpler
Date: Wed, 28 Jun 2017 17:18:18 -0700
Message-ID: <CANeU7Qm8Qjf--w-7dc1J5qXhORPoPduc859-tk0-75L8Gx5iww@mail.gmail.com>
References: <20170628204918.25853-1-luc.vanoostenryck@gmail.com> <20170628204918.25853-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:32792 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbdF2ASU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 28 Jun 2017 20:18:20 -0400
Received: by mail-io0-f193.google.com with SMTP id j200so6641234ioe.0
        for <linux-sparse@vger.kernel.org>; Wed, 28 Jun 2017 17:18:19 -0700 (PDT)
In-Reply-To: <20170628204918.25853-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Wed, Jun 28, 2017 at 1:49 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> The for-statement needs a lot of fields in struct statement, much
> more than any other statement. This is due to the complexity of
> the for-statement.
>
> However part of this complexity can be removed by processing the
> 'pre-' statement separately from the loop. This is equivalent to
> transform a single-statement for-loop like:
>         for (pre; cond; post)
>                 body
> into a compound statement like:
>         pre;
>         for (;cond; post)
>                 body;

Notice that the two are not exactly the same.

quote 6.8.5 3"The declaration part of a for statement shall only
declare identifiers for
objects having storage class auto or register."

However sparse already validate the for statement declaration in function
"validate_for_loop_decl()" so I think it is fine.

Chris
