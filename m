From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH] Handle ignored attribute malloc
Date: Thu, 25 Oct 2007 20:16:00 -0700
Message-ID: <70318cbf0710252016x5c41ac82o2456bfa5b392d0f4@mail.gmail.com>
References: <1193346769-18030-1-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:48566 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798AbXJZDQA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Oct 2007 23:16:00 -0400
Received: by rv-out-0910.google.com with SMTP id k20so662633rvb
        for <linux-sparse@vger.kernel.org>; Thu, 25 Oct 2007 20:16:00 -0700 (PDT)
In-Reply-To: <1193346769-18030-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Emil Medve <Emilian.Medve@freescale.com>
Cc: josh@freedesktop.org, linux-sparse@vger.kernel.org

Which kernel source code triggers this?

If nobody is using malloc_ident directly. You don't need to add it
to ident-list.h.

Having a test case in validations directory will be nice too.

Chris

On 10/25/07, Emil Medve <Emilian.Medve@freescale.com> wrote:
> This avoids error messages like this:
>
> error: attribute 'malloc': unknown attribute
>
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>
> Please copy me in replies as I'm not subscribed to the list
>
>  ident-list.h |    1 +
>  parse.c      |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/ident-list.h b/ident-list.h
> index b183eac..8fcd7de 100644
> --- a/ident-list.h
> +++ b/ident-list.h
> @@ -69,6 +69,7 @@ IDENT(model); IDENT(__model__);
>  IDENT(format_arg); IDENT(__format_arg__);
>  IDENT(nothrow); IDENT(__nothrow); IDENT(__nothrow__);
>  IDENT(__transparent_union__);
> +IDENT(malloc);
>  IDENT(__malloc__);
>  IDENT(nonnull); IDENT(__nonnull); IDENT(__nonnull__);
>  IDENT(constructor); IDENT(__constructor__);
> diff --git a/parse.c b/parse.c
> index 47b5204..a41939d 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -283,6 +283,7 @@ static struct init_keyword {
>         { "nothrow",    NS_KEYWORD,     .op = &ignore_attr_op },
>         { "__nothrow",  NS_KEYWORD,     .op = &ignore_attr_op },
>         { "__nothrow__",        NS_KEYWORD,     .op = &ignore_attr_op },
> +       { "malloc",     NS_KEYWORD,     .op = &ignore_attr_op },
>         { "__malloc__", NS_KEYWORD,     .op = &ignore_attr_op },
>         { "nonnull",    NS_KEYWORD,     .op = &ignore_attr_op },
>         { "__nonnull",  NS_KEYWORD,     .op = &ignore_attr_op },
> --
> 1.5.3.GIT
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
