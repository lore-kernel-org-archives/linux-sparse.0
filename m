From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] dissect: s/mode_t/usage_t/ in report_member()
Date: Wed, 2 Nov 2016 15:17:09 +0100
Message-ID: <20161102141708.GA9163@macpro.local>
References: <20160211224710.GA4989@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35981 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751075AbcKBORO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 10:17:14 -0400
Received: by mail-wm0-f65.google.com with SMTP id c17so3273623wmc.3
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 07:17:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160211224710.GA4989@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Thu, Feb 11, 2016 at 11:47:10PM +0100, Oleg Nesterov wrote:
> Cosmetic, fix the typo.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  dissect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/dissect.c b/dissect.c
> index 2d13d2a..67428ec 100644
> --- a/dissect.c
> +++ b/dissect.c
> @@ -130,7 +130,7 @@ static inline struct symbol *no_member(struct ident *name)
>  	return &sym;
>  }
>  
> -static struct symbol *report_member(mode_t mode, struct position *pos,
> +static struct symbol *report_member(usage_t mode, struct position *pos,
>  					struct symbol *type, struct symbol *mem)
>  {
>  	struct symbol *ret = mem->ctype.base_type;
> -- 

For what it's worth:
Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
