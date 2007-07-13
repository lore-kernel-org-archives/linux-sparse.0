From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/8] clean up evaluate_sign()
Date: Fri, 13 Jul 2007 11:03:01 -0700
Message-ID: <1184349781.2616.39.camel@josh-work.beaverton.ibm.com>
References: <E1I9PC1-0000E0-4q@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:46012 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758969AbXGMSCv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 14:02:51 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6DI2o3E024024
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 14:02:50 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6DI2lNu201928
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 12:02:49 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6DI2lxK018346
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 12:02:47 -0600
In-Reply-To: <E1I9PC1-0000E0-4q@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Fri, 2007-07-13 at 18:44 +0100, Al Viro wrote:
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -1671,17 +1671,19 @@ static struct symbol *evaluate_postop(struct expression *expr)
>  static struct symbol *evaluate_sign(struct expression *expr)
>  {
>  	struct symbol *ctype = expr->unop->ctype;
> +	int class = classify_type(ctype, &ctype);
>  	if (expr->flags && !(expr->unop->flags & Int_const_expr))
>  		expr->flags = 0;
> -	if (is_int_type(ctype)) {
> -		struct symbol *rtype = rtype = integer_promotion(ctype);
> +	/* should be an arithmetic type */
> +	if (!(class & TYPE_NUM))
> +		return bad_expr_type(expr);
> +	if (!(class & (TYPE_FLOAT|TYPE_RESTRICT))) {
> +		struct symbol *rtype = integer_promotion(ctype);
>  		expr->unop = cast_to(expr->unop, rtype);
>  		ctype = rtype;
> -	} else if (is_float_type(ctype) && expr->op != '~') {
> -		/* no conversions needed */
> -	} else if (is_restricted_type(ctype) && !restricted_unop(expr->op, &ctype)) {
> +	} else if ((class & TYPE_FLOAT) && expr->op != '~') {
>  		/* no conversions needed */
> -	} else if (is_fouled_type(ctype) && !restricted_unop(expr->op, &ctype)) {
> +	} else if ((class & TYPE_RESTRICT) && !restricted_unop(expr->op, &ctype)) {
>  		/* no conversions needed */
>  	} else {
>  		return bad_expr_type(expr);

Most of this seems quite reasonable and obvious.  I noticed, though,
that this drops the handling for fouled types; did you do that
intentionally, and if so could you elaborate on why?

- Josh Triplett
