From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 1/2] Allow casting to a restricted type if
 !restricted_value
Date: Fri, 17 Feb 2017 21:23:40 +0100
Message-ID: <20170217175847.mq6mgml47cagxcah@macbook.local>
References: <e8e65c94-4d07-b20e-1bdb-30c7a8d1108f@solarflare.com>
 <1d8e35fa-643b-afa4-8089-f5a945a50eef@solarflare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34854 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932655AbdBQUXp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 17 Feb 2017 15:23:45 -0500
Received: by mail-wm0-f67.google.com with SMTP id u63so4368140wmu.2
        for <linux-sparse@vger.kernel.org>; Fri, 17 Feb 2017 12:23:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1d8e35fa-643b-afa4-8089-f5a945a50eef@solarflare.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Edward Cree <ecree@solarflare.com>
Cc: linux-sparse@vger.kernel.org

On Fri, Feb 17, 2017 at 03:11:15PM +0000, Edward Cree wrote:
> If the operand of a cast to a restricted type is an unrestricted value,
>  the cast should not produce a warning, since an equivalent implied cast
>  (e.g. in an initialiser) would not do so.
> 
> Signed-off-by: Edward Cree <ecree@solarflare.com>
> ---
>  evaluate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index e350c0c..8e855b1 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -2771,7 +2771,7 @@ static struct symbol *evaluate_cast(struct expression *expr)
>                 t2 = unfoul(t2);
> 
>         if (t1 != t2) {
> -               if (class1 & TYPE_RESTRICT)
> +               if ((class1 & TYPE_RESTRICT) && restricted_value(target, t1))
>                         warning(expr->pos, "cast to %s",
>                                 show_typename(t1));
>                 if (class2 & TYPE_RESTRICT)

I'm fine with this.

Just the 't1' in restricted_value() that should probably be 't2'
(as can be seen on the warnings, just below t1 is the destination type
and t2 is the origin type) but since this argument is not used anyway
and the semantic of this not defined, it won't matter at all.
Maybe best to use NULL.

Also, I think it would be best to squash the two patches together.

(And I think you will need to resend it from another email address
because of the notice automatically added to your emails).

Luc
