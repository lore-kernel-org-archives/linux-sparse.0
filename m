From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] add __builtin functions for isinf_sign, isfinite and isnan
Date: Fri, 17 Nov 2017 07:02:39 +0800
Message-ID: <CANeU7Q=ivP59nwzyW-G16TwTNBP+D6iPa9R-Lch4d9PuscyxWA@mail.gmail.com>
References: <20171116212719.1217-1-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yb0-f172.google.com ([209.85.213.172]:45576 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934059AbdKPXCk (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Nov 2017 18:02:40 -0500
Received: by mail-yb0-f172.google.com with SMTP id i126so27849ybi.12
        for <linux-sparse@vger.kernel.org>; Thu, 16 Nov 2017 15:02:40 -0800 (PST)
In-Reply-To: <20171116212719.1217-1-logang@deltatee.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 17, 2017 at 5:27 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
> These bultins are defined by in gcc since 4.4. They are also now
> used by the isinf, isfinite and isnan macros. So using them with a
> newer gcc causes 'undefined identifier' errors.
>
> Add the builtin definitions and some validation checks for these
> functions.

Thanks for the patch.

> diff --git a/validation/builtin_inf.c b/validation/builtin_inf.c
> index 48546e4..0855ab0 100644
> --- a/validation/builtin_inf.c
> +++ b/validation/builtin_inf.c
> @@ -7,6 +7,14 @@ static long double li = __builtin_infl();
>  static double dn = __builtin_nan("");
>  static float fn = __builtin_nanf("");
>  static long double ln = __builtin_nanl("");
> +static int inf = __builtin_isinf_sign(0.0);
> +static int fin = __builtin_isfinite(0.0);
> +static int nan = __builtin_isnan(0.0);
> +
> +#include <math.h>

Can you remove the <math.h>?

For the validation test, it would be best to not depend on
system header file. You can use sparse -E to dig out the
related function call after the pre-process.

Other than that, it looks good.

I want to apply with the math.h removed.

Chris
