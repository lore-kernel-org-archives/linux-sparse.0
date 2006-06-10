From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: segfault on switch() + bitwise combo
Date: Sat, 10 Jun 2006 22:59:33 +0400
Message-ID: <20060610185933.GC7268@martell.zuzino.mipt.ru>
References: <20060609151742.GA21428@martell.zuzino.mipt.ru> <Pine.LNX.4.64.0606101143360.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.190]:18414 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751675AbWFJS7O (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sat, 10 Jun 2006 14:59:14 -0400
Received: by nf-out-0910.google.com with SMTP id y38so668270nfb
        for <linux-sparse@vger.kernel.org>; Sat, 10 Jun 2006 11:59:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606101143360.5498@g5.osdl.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, Morten Welinder <terra@gnome.org>

On Sat, Jun 10, 2006 at 11:43:50AM -0700, Linus Torvalds wrote:
> On Fri, 9 Jun 2006, Alexey Dobriyan wrote:
> > It triggers by checking with -Wbitwise on drivers/net/wireless/ipw2100.c
> > and net/sctp/sm_make_chunk.c
>
> Perhaps something like this?

Looks like it works, thanks.

> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -359,7 +359,7 @@ static struct symbol *bad_expr_type(stru
>  		break;
>  	}
>
> -	return NULL;
> +	return expr->ctype = &bad_ctype;
>  }
>
>  static struct symbol *compatible_float_binop(struct expression **lp, struct expression **rp)
