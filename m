From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/5] add helper handle_simple_switch()
Date: Wed, 31 May 2017 23:15:52 -0700
Message-ID: <CANeU7Qkrmkbb6s9k2Jj_mF95g8bwdqJ5-HqabU3_NZ_ozfj1tA@mail.gmail.com>
References: <20170412083703.11552-1-luc.vanoostenryck@gmail.com> <20170412083703.11552-4-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36612 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdFAGPy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Jun 2017 02:15:54 -0400
Received: by mail-it0-f65.google.com with SMTP id i206so4019877ita.3
        for <linux-sparse@vger.kernel.org>; Wed, 31 May 2017 23:15:53 -0700 (PDT)
In-Reply-To: <20170412083703.11552-4-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

I have some very minor comment.

On Wed, Apr 12, 2017 at 1:37 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  lib.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/lib.c b/lib.c
> index 8c9c36bd5..1d21a2fb7 100644
> --- a/lib.c
> +++ b/lib.c
> @@ -454,6 +454,25 @@ static void handle_arch_finalize(void)
>  }
>
>
> +static int handle_simple_switch(const char *arg, const char *name, int *flag)
> +{
> +       int val = 1;
> +
> +       // Prefixe "no-" mean to turn flag off.
> +       if (strncmp(arg, "no-", 3) == 0) {

You don't need to compare to zero. This can be written as:
 if (!strncmp(arg, "no-", 3)) {

That is how most of the strcmp done in sparse.

> +       if (strcmp(arg, name) == 0) {
> +               *flag = val;
> +               return 1;
> +       }

Same here.

Chris
