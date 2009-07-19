From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/5] Fix some "enum value 'SYM_...' not handled in
 switch" warnings
Date: Sun, 19 Jul 2009 07:01:26 -0700
Message-ID: <20090719140125.GA25417@feather>
References: <4A62338A.1060600@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:37212 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbZGSOUh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 19 Jul 2009 10:20:37 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 2253384765
	for <linux-sparse@vger.kernel.org>; Sun, 19 Jul 2009 16:08:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A62338A.1060600@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Jul 18, 2009 at 09:41:46PM +0100, Ramsay Jones wrote:
> These warnings were issued by gcc v3.4.4, but not by gcc v4.1.2.
> So I guess gcc probably found these warnings to be too noisy ...
[...]
> --- a/parse.c
> +++ b/parse.c
> @@ -2616,6 +2616,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>  			case SYM_ENUM:
>  			case SYM_RESTRICT:
>  				base_type->ident = ident;
> +			default:
> +				break;
>  			}

I don't think you want to add defaults like this just to avoid warnings.
Warnings like that can help when adding a new item to an enum, to find
the places where you need to extend the code to hand the new item.  And
since current GCC doesn't even issue the warning by default, it seems
even more unnecessary to add that default case.

- Josh Triplett
