From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/3] fix: add missing degenerate() for logical not
Date: Fri, 8 Dec 2017 09:49:22 +0800
Message-ID: <CANeU7QkxL73nNSqaQXu-jprQMXnZFMcD5WbFdmvf4di6N3oiRg@mail.gmail.com>
References: <20171207171613.34989-1-luc.vanoostenryck@gmail.com> <20171207171613.34989-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:39747 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbdLHBtX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Dec 2017 20:49:23 -0500
Received: by mail-yw0-f195.google.com with SMTP id y187so3736495ywg.6
        for <linux-sparse@vger.kernel.org>; Thu, 07 Dec 2017 17:49:23 -0800 (PST)
In-Reply-To: <20171207171613.34989-4-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Dec 8, 2017 at 1:16 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Expressions involving the logical-not '!' does not
> call degenerate().
>
> Since the result type is always 'int' and thus independent
> of the expression being negated, this has no effect on the
> type-checking but the linearization is wrong.
> For example, code like:
>         int foo(void)
>         {
>                 if (!arr) return 1;
>                 return 0;
>         }
> generates:
>         foo:
>                 load        %r6 <- 0[arr]
>                 seteq.32    %r7 <- VOID, $0
>                 ret.32      %r7
> The 'load' being, obviously wrong.
>
> Fix this by adding the missing degenerate().

Good catch. This series looks good to me.

Chris
