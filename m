From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/8] integer_promotions() can't get SYM_NODE
Date: Fri, 13 Jul 2007 11:04:58 -0700
Message-ID: <1184349898.2616.42.camel@josh-work.beaverton.ibm.com>
References: <E1I9PCB-0000EF-51@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:59478 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757013AbXGMSEp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 14:04:45 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id l6DHxBIB020027
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 13:59:11 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6DI4iwN202508
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 12:04:44 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6DI4hPQ013397
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 12:04:44 -0600
In-Reply-To: <E1I9PCB-0000EF-51@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Fri, 2007-07-13 at 18:44 +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  evaluate.c |    9 ++-------
>  1 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index 7669c9a..88435da 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -98,17 +98,12 @@ static struct symbol *evaluate_string(struct expression *expr)
>  	return sym;
>  }
> 
> +/* type has come from classify_type and is an integer type */
>  static inline struct symbol *integer_promotion(struct symbol *type)
>  {
>  	struct symbol *orig_type = type;
>  	unsigned long mod =  type->ctype.modifiers;
> -	int width;
> -
> -	if (type->type == SYM_NODE)
> -		type = type->ctype.base_type;
> -	if (type->type == SYM_ENUM)
> -		type = type->ctype.base_type;
> -	width = type->bit_size;
> +	int width = type->bit_size;
> 
>  	/*
>  	 * Bitfields always promote to the base type,

In addition to SYM_NODE as mentioned in the commit message, this also
removes SYM_ENUM as classify_type handles that too.  I'll append that to
the commit message.

- Josh Triplett
