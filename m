From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: extra 'make check' failures on 32bit Linux
Date: Mon, 27 Mar 2017 18:10:26 +0200
Message-ID: <CAExDi1TwkQj4JcmxqLkG868H2QDEr87=xYHKH0sMY=AXjrEb4A@mail.gmail.com>
References: <806988fb-6e3c-872b-d7ab-282336f67f73@ramsayjones.plus.com>
 <20170327010342.vd34svh3kee43qir@macpro.local> <444abf20-b5ef-664a-fed4-ebfd8969e1da@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36236 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdC0QK2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Mar 2017 12:10:28 -0400
Received: by mail-qk0-f196.google.com with SMTP id r142so4753470qke.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Mar 2017 09:10:27 -0700 (PDT)
In-Reply-To: <444abf20-b5ef-664a-fed4-ebfd8969e1da@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Mar 27, 2017 at 5:27 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:

> So, I looked in the debugger and 'bits_in_long' and 'bits_in_pointer'
> are set correctly, but __LONG_MAX__ is being printed with an LL suffix,
> so, this fixes it for me:
>
> $ git diff
> diff --git a/lib.c b/lib.c
> index 272d2c8..502c264 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -834,7 +834,7 @@ static void predefined_macros(void)
>         add_pre_buffer("#define __CHECKER__ 1\n");
>
>         val = (1ULL << (bits_in_long-1)) - 1;
> -       add_pre_buffer("#weak_define __LONG_MAX__ %#llxLL\n", val);
> +       add_pre_buffer("#weak_define __LONG_MAX__ %#llxL\n", val);
>         add_pre_buffer("#weak_define __SIZEOF_POINTER__ %d\n", bits_in_pointer/8);
>  }
>
> $
>
> Not a proper fix, but ...

Well, actually it is the proper fix as __LONG_MAX__ is supposed to be
a 'long' and not a 'long long'.

> Ah, I've just noticed you have sent some patches. ;-)
>
> I will take a look and let you know.

OK, thanks.
It should be OK as I new tested it on a 32bit machine but
another environment is always good for testing.

-- Luc
