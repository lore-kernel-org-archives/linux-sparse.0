From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: add built-in byte swap identifiers
Date: Mon, 18 Feb 2013 21:59:00 -0800
Message-ID: <CANeU7Q=W8zZEngeweCGDkEpPGJMrADFgnibQVUFvGBwsppVq=A@mail.gmail.com>
References: <20130218183629.d2a9238ac848758359582e28@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:34664 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755644Ab3BSF7C (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Feb 2013 00:59:02 -0500
Received: by mail-oa0-f48.google.com with SMTP id j1so6550136oag.35
        for <linux-sparse@vger.kernel.org>; Mon, 18 Feb 2013 21:59:01 -0800 (PST)
In-Reply-To: <20130218183629.d2a9238ac848758359582e28@freescale.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Feb 18, 2013 at 4:36 PM, Kim Phillips
<kim.phillips@freescale.com> wrote:
>
> which is what's advertised as the main sparse tree, here:
>
> https://sparse.wiki.kernel.org/index.php/Main_Page
>
>  lib.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/lib.c b/lib.c
> index 6bd10d3..4f69e11 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -727,6 +727,11 @@ void declare_builtin_functions(void)
>         add_pre_buffer("extern int __builtin_popcountl(unsigned long);\n");
>         add_pre_buffer("extern int __builtin_popcountll(unsigned long long);\n");
>
> +       /* And byte swaps.. */
> +       add_pre_buffer("extern unsigned short __builtin_bswap16(unsigned short);\n");
> +       add_pre_buffer("extern unsigned int __builtin_bswap32(unsigned int);\n");
> +       add_pre_buffer("extern unsigned long long __builtin_bswap64(unsigned long long);\n");
> +
>         /* And some random ones.. */

Looks good. Can you please add a test case for __buitin_bswap{16,32,64}?
You can look at "validations/" directory for the test case example.
To run the test case, use "make check".

Thanks

Chris
