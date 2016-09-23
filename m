From: Lance Richardson <lrichard@redhat.com>
Subject: Re: [PATCH] dissect: s/mode_t/usage_t/ in report_member()
Date: Fri, 23 Sep 2016 17:05:17 -0400 (EDT)
Message-ID: <326478617.3496336.1474664717097.JavaMail.zimbra@redhat.com>
References: <20160211224710.GA4989@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:41205 "EHLO
        mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753235AbcIWVFU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 23 Sep 2016 17:05:20 -0400
In-Reply-To: <20160211224710.GA4989@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

> From: "Oleg Nesterov" <oleg@redhat.com>
> To: "Christopher Li" <sparse@chrisli.org>, "Josh Triplett" <josh@kernel.org>
> Cc: linux-sparse@vger.kernel.org
> Sent: Thursday, February 11, 2016 5:47:10 PM
> Subject: [PATCH] dissect: s/mode_t/usage_t/ in report_member()
> 
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
> @@ -130,7 +130,7 @@ static inline struct symbol *no_member(struct ident
> *name)
>  	return &sym;
>  }
>  
> -static struct symbol *report_member(mode_t mode, struct position *pos,
> +static struct symbol *report_member(usage_t mode, struct position *pos,
>  					struct symbol *type, struct symbol *mem)
>  {
>  	struct symbol *ret = mem->ctype.base_type;
> --
> 2.5.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Better late than never:

Acked-by: Lance Richardson <lrichard@redhat.com>
