From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] dissect: fix multidimensional array initializer
Date: Mon, 18 Dec 2006 13:50:51 -0800
Message-ID: <20061218215051.GB28336@chrisli.org>
References: <20061214213547.GA422@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rwcrmhc15.comcast.net ([216.148.227.155]:60784 "EHLO
	rwcrmhc15.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675AbWLRWGz (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 18 Dec 2006 17:06:55 -0500
Content-Disposition: inline
In-Reply-To: <20061214213547.GA422@tv-sign.ru>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

I did not test it myself, but it looks seasonable to me.

BTW, did you look at the show-parse series of function?
It is a good example of how to traverse the symbol tree.
I would love to see dissect using similar structure. 
 
Chris

On Fri, Dec 15, 2006 at 12:35:47AM +0300, Oleg Nesterov wrote:
> dissect can't parse initializers like
> 
> 	struct T { int i; } a[2][3] = { [0][0] = {123} };
> 
> , output is:
> 
> 	   1:8   s def  T
> 	   1:21  g def  a                                struct T [3][2]
> 	   1:21  g -w-  a                                struct T [3][2]
> 	T.c:1:37: warning: bad expr->type: 25
> 
> with this patch applied:
> 
> 	   1:8   s def  T
> 	   1:21  g def  a                                struct T [3][2]
> 	   1:21  g -w-  a                                struct T [3][2]
> 	   1:43  s -w-  T.i                              int
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- DS/dissect.c~	2006-04-20 03:03:33.000000000 +0400
> +++ DS/dissect.c	2006-04-20 03:03:42.000000000 +0400
> @@ -507,10 +507,13 @@ static struct symbol *do_initializer(str
>  	default:
>  		do_expression(u_lval(type), expr);
>  
> +	break; case EXPR_INDEX:
> +		do_initializer(base_type(type), expr->idx_expression);
> +
>  	break; case EXPR_INITIALIZER:
>  		m_addr = 0;
>  		FOR_EACH_PTR(expr->expr_list, m_expr)
> -			if(type->type == SYM_ARRAY) {
> +			if (type->type == SYM_ARRAY) {
>  				m_type = base_type(type);
>  				if (m_expr->type == EXPR_INDEX)
>  					m_expr = m_expr->idx_expression;
