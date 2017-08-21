From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix expansion of constant bitfield dereference
Date: Mon, 21 Aug 2017 08:26:52 -0400
Message-ID: <CANeU7Q=HgV-H0yRZ60n1A0uo79z+0F6mQEVxN8PQhQ_RQnB2NQ@mail.gmail.com>
References: <20170820221602.27852-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:33296 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751941AbdHUM0x (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 21 Aug 2017 08:26:53 -0400
Received: by mail-yw0-f195.google.com with SMTP id t188so546829ywb.0
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 05:26:53 -0700 (PDT)
In-Reply-To: <20170820221602.27852-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Sun, Aug 20, 2017 at 6:16 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> During the expansion of a dereference, it's if the initializer
> which corrrespond to the offset we're interested is a constant.
> In which case this dereference can be avoided and the value
> given in the initializer can be used instead.
>
> However, it's not enough to check for the offset since for bitfields
> several are placed at the same offset.
> Currently, the first initializer matching the offset is selected.
>
> Fix this by refusing such expansion if the constant value correspond
> to a bitfield.
>

With this applied, sparse still have a bug at did not match the
value to the bit field member, right? I saw on the other email
thread said the value always pick offset zero.

Should I apply this as patch format or wait for it show up in a
git pull request later?


> --- a/expand.c
> +++ b/expand.c
> @@ -644,6 +644,8 @@ static int expand_dereference(struct expression *expr)
>                 if (value) {
>                         /* FIXME! We should check that the size is right! */
>                         if (value->type == EXPR_VALUE) {
> +                               if (is_bitfield_type(value->ctype))
> +                                       return UNSAFE;

You might want to consider move this outside of the EXPR_VALUE.
I assume there is a bug in sparse matching the value to the member
wrong, it could happen to EXPR_FVALUE as well.

Chris
