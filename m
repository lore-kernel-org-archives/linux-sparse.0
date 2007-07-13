From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/8] rewrite type_difference()
Date: Fri, 13 Jul 2007 11:16:43 -0700
Message-ID: <1184350603.2616.47.camel@josh-work.beaverton.ibm.com>
References: <E1I9PCp-0000FJ-5s@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:43080 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932862AbXGMSQw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Jul 2007 14:16:52 -0400
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com [9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6DIGpqj012515
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 14:16:51 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id l6DIGoVN255016
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 12:16:50 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l6DIGonm007244
	for <linux-sparse@vger.kernel.org>; Fri, 13 Jul 2007 12:16:50 -0600
In-Reply-To: <E1I9PCp-0000FJ-5s@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Fri, 2007-07-13 at 18:45 +0100, Al Viro wrote:
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -621,92 +621,145 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *c
> 
>  static void examine_fn_arguments(struct symbol *fn);
> 
> -const char * type_difference(struct symbol *target, struct symbol *source,
> -	unsigned long target_mod_ignore, unsigned long source_mod_ignore)
> +#define MOD_IGN (MOD_VOLATILE | MOD_CONST)
> +
> +const char *type_difference(struct ctype *c1, struct ctype *c2,
> +	unsigned long mod1, unsigned long mod2)
[...]
> --- a/symbol.h
> +++ b/symbol.h
> @@ -245,7 +245,7 @@ extern struct symbol_list *translation_unit_used_list;
> 
>  extern void access_symbol(struct symbol *);
> 
> -extern const char * type_difference(struct symbol *target, struct symbol *source,
> +extern const char * type_difference(struct ctype *c1, struct ctype *c2,
>  	unsigned long target_mod_ignore, unsigned long source_mod_ignore);

You didn't update the third and fourth arguments in this prototype.

- Josh Triplett
