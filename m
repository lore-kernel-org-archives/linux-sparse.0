From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] fix size of loaded bitfields
Date: Mon, 27 Feb 2017 16:22:32 +0800
Message-ID: <CANeU7Q=8-ohrRveh_YkF8iaVOVX9SFTgauogFBhjxLMY=XjUQA@mail.gmail.com>
References: <20170217024445.16163-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:37439 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbdB0IWe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Feb 2017 03:22:34 -0500
Received: by mail-it0-f45.google.com with SMTP id 203so60840710ith.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Feb 2017 00:22:33 -0800 (PST)
In-Reply-To: <20170217024445.16163-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Feb 17, 2017 at 10:44 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Loading a bitfield correctly take in account the offset
> of the bitfield inside the whole container integer.
> But truncating it to the width of the bitfield is not done
> or is done very implicitely (because the correct size is not lost).

> Fix this by adding the missing truncating cast.
> This will then gives something like:
>         get__bfu_a:
>                 cast.3      %r2 <- (32) %arg1
>                 cast.32     %r3 <- (3) %r2
>                 ret.32      %r3

The patch looks good. Applied to sparse-next.

> +       if (ad->bit_size != type_size(ad->source_type)) {
> +               new = cast_pseudo(ep, new, ad->source_type, ad->result_type);
> +       }

One minor nick pick, if there is only one line, there are no
braces needed.

Chris
