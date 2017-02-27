From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] use VOID instead of directly using &void_pseudo
Date: Mon, 27 Feb 2017 23:40:52 +0800
Message-ID: <CANeU7Q=VUj_deEkgopRXAEAsKtgkP3i_Kd6SzE15t+yjCse6Yg@mail.gmail.com>
References: <20170220104536.12105-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:33432 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751372AbdB0Plf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 10:41:35 -0500
Received: by mail-io0-f178.google.com with SMTP id g18so33801811ioe.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 07:40:54 -0800 (PST)
In-Reply-To: <20170220104536.12105-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Feb 20, 2017 at 6:45 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> diff --git a/linearize.c b/linearize.c
> index 99203d915..6908e9f57 100644
> --- a/linearize.c
> +++ b/linearize.c
> @@ -1862,7 +1862,7 @@ static pseudo_t linearize_return(struct entrypoint *ep, struct statement *stmt)
>         struct basic_block *active;
>         pseudo_t src = linearize_expression(ep, expr);
>         active = ep->active;
> -       if (active && src != &void_pseudo) {
> +       if (active && src != VOID) {

Looks good.  Can you add S-O-B for this?

Thanks

Chris
