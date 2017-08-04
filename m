From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/4] mark pseudo users as deleted instead of removing them
Date: Fri, 4 Aug 2017 16:17:37 -0400
Message-ID: <CANeU7QkoXb-G3FQ9+iPx_WGN9x8jeao0wt--FYz8rb0ZvndHpg@mail.gmail.com>
References: <CANeU7QkRWygQB_dsD4o4omB-G_xtZZVLZP4-DgaK3iDMd=HB4w@mail.gmail.com>
 <20170804200915.56738-1-luc.vanoostenryck@gmail.com> <20170804200915.56738-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:36004 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751891AbdHDURi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 4 Aug 2017 16:17:38 -0400
Received: by mail-pf0-f182.google.com with SMTP id c28so11035906pfe.3
        for <linux-sparse@vger.kernel.org>; Fri, 04 Aug 2017 13:17:38 -0700 (PDT)
In-Reply-To: <20170804200915.56738-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Aug 4, 2017 at 4:09 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>         FOR_EACH_PTR(target->users, pu) {
> +               if (!pu)
> +                       continue;

Your previous patch looks fine.

Here in my previous email feed back I mean to include  this check into
FOR_EACH_PTR()
so you don't need touch every pseudo_user list looping every where.
Just do some thing like
       if (list->rm && list->list[__nr] == NULL)
              continue;

inside the FOR_EACH_PTR(). and REVERSE as well.

It will not have impact on other list because other list will not
have list->rm != 0.

With this change, the caller side of the change not needed.

Chris
