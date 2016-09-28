From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: ignore __assume_aligned__ attribute
Date: Wed, 28 Sep 2016 11:17:09 -0700
Message-ID: <CANeU7QkqH3a8Mu6=vgL9AnDkSFJeqvhyzE6bE=pBY1OdpYMviA@mail.gmail.com>
References: <1474469088-25429-1-git-send-email-lrichard@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:36585 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbcI1SRL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 28 Sep 2016 14:17:11 -0400
Received: by mail-it0-f66.google.com with SMTP id n143so2274513ita.3
        for <linux-sparse@vger.kernel.org>; Wed, 28 Sep 2016 11:17:11 -0700 (PDT)
In-Reply-To: <1474469088-25429-1-git-send-email-lrichard@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Lance Richardson <lrichard@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Sep 21, 2016 at 7:44 AM, Lance Richardson <lrichard@redhat.com> wrote:
> The __assume_aligned__ attribute can be safely ignored, add it
> to the list of ignored attributes.

Thanks for the patch. Sorry for the delay. The change looks fine.

Can you add some test case of the  __assume_aligned__ attribute?
I want to see how it was used in your source code which cause the problem
for sparse.

We need some basic test case just in case we parse the attributes in the
future.

Thanks

Chris


>
> Signed-off-by: Lance Richardson <lrichard@redhat.com>
> ---
>  parse.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/parse.c b/parse.c
> index 98a31dc..2a1b57e 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -526,6 +526,8 @@ const char *ignored_attributes[] = {
>         "__always_inline__",
>         "artificial",
>         "__artificial__",
> +       "assume_aligned",
> +       "__assume_aligned__",
>         "bounded",
>         "__bounded__",
>         "cdecl",
> --
> 2.5.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
