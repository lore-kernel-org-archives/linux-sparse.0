From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC,PATCH 4/4] add support for LLP64 arch
Date: Thu, 9 Feb 2017 05:24:01 +0800
Message-ID: <CANeU7QkYmA1opeNQTYjOUXs8hSn1oG3RumVtR094rb4w8KucEQ@mail.gmail.com>
References: <20170207200425.34189-1-luc.vanoostenryck@gmail.com> <20170207200425.34189-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:34815 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751851AbdBHVYH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 8 Feb 2017 16:24:07 -0500
Received: by mail-it0-f66.google.com with SMTP id o185so303751itb.1
        for <linux-sparse@vger.kernel.org>; Wed, 08 Feb 2017 13:24:07 -0800 (PST)
In-Reply-To: <20170207200425.34189-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

The patch as already apply in sparse-next.

On Wed, Feb 8, 2017 at 4:04 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> There was recently on the mailing list some questions
> and a need to support LLP64 model.
>
> This patch add is by adjusting a few size-related variables
> under the control of a new flag: -msize-llp64 (ugly name
> but we already have we have '-msize-long').

I am wondering how does gcc windows handle such situation.

Should we some flag some arch thing like "mingw64" which
turn on the LLP64 mode. If gcc has such a flag for cross compile
mingw, we should borrow that instead.

]> +               if (arch_m64 == ARCH_LP64) {
> +                       bits_in_long = 64;
> +                       max_int_alignment = 8;
> +                       size_t_ctype = &ulong_ctype;
> +                       ssize_t_ctype = &long_ctype;
> +                       add_pre_buffer("#weak_define __LP64__ 1\n");
> +                       add_pre_buffer("#weak_define _LP64 1\n");
> +               } else {

It works as it is. But we might want to test against arch_m64==ARCH_LLP64
just to make the code section clear what it was for.

Again, ff there is a new version of patch. I will replace this one in
sparse-next.

Chris
