From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] add support for __int128
Date: Tue, 7 Feb 2017 10:34:30 +0800
Message-ID: <CANeU7Qk88LOkmwa3KFSawO+HH=tJyEQi-rOKxkofdDDb-3xb+w@mail.gmail.com>
References: <20161209230311.36024-1-luc.vanoostenryck@gmail.com> <20161209230311.36024-3-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:35462 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752068AbdBGCeg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Feb 2017 21:34:36 -0500
Received: by mail-it0-f68.google.com with SMTP id 203so10999788ith.2
        for <linux-sparse@vger.kernel.org>; Mon, 06 Feb 2017 18:34:36 -0800 (PST)
In-Reply-To: <20161209230311.36024-3-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Dec 10, 2016 at 7:03 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> There is already support for __int128_t & __uint128_t but not yet
> for GCC's __int128.
>
> This patch add support for it and a couple of test cases.
>
> Note: it's slightly more tricky that it look because contrary to
> '__int128_t', '__int128' is not an exact type (it can still receive
> the 'unsigned' or 'signed' specifier).
>
> @@ -1496,6 +1504,8 @@ static struct token *declaration_specifiers(struct token *token, struct decl_sta
>                         }
>                         seen |= s->op->set;
>                         class += s->op->class;
> +                       if (s->op->set & Set_Int128)
> +                               size = 2;
>                         if (s->op->type & KW_SHORT) {
>                                 size = -1;
>                         } else if (s->op->type & KW_LONG && size++) {

This patch is already applied in sparse-next.
But I have a question regarding the "size = 2;" Is the number 2 a magic
number?

Chris
