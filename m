From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 4/6] fix implicit zero initializer.
Date: Wed, 31 May 2017 23:41:32 -0700
Message-ID: <CANeU7Qnsadz4VYNDOwCk0x+8W9HH0zWXxD5qxcxuXVqd+ppDWA@mail.gmail.com>
References: <20170408211901.40507-1-luc.vanoostenryck@gmail.com> <20170408211901.40507-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:38268 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdFAGle (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 02:41:34 -0400
Received: by mail-it0-f54.google.com with SMTP id r63so25356004itc.1
        for <linux-sparse@vger.kernel.org>; Wed, 31 May 2017 23:41:33 -0700 (PDT)
In-Reply-To: <20170408211901.40507-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Apr 8, 2017 at 2:18 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> diff --git a/linearize.c b/linearize.c
> index 5c273a91d..f628f5a74 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -1635,6 +1635,21 @@ static pseudo_t linearize_one_symbol(struct entrypoint *ep, struct symbol *sym)
>
>         sym->initialized = 1;
>         ad.address = symbol_pseudo(ep, sym);
> +
> +       if (sym->initializer && !is_scalar_type(sym)) {
> +               // default zero initialization [6.7.9.21]
> +               // FIXME: this init the whole aggregate while
> +               // only the existing fields need to be initialized.
> +               // FIXME: this init the whole aggregate even if
> +               // all fields arelater  explicitely initialized.

Some very minor comment. The multi-line comment should be
written in the C type. /* ... */

Chris
