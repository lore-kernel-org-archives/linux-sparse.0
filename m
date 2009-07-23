From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/5] Fix some "enum value 'SYM_...' not handled in
 switch" warnings
Date: Wed, 22 Jul 2009 21:42:42 -0700
Message-ID: <20090723044241.GA6472@feather>
References: <4A62338A.1060600@ramsay1.demon.co.uk>
 <20090719140125.GA25417@feather>
 <4A663005.5090009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:48865 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbZGWE6H (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 23 Jul 2009 00:58:07 -0400
Received: from relay2-v.mail.gandi.net (relay2-v.mail.gandi.net [217.70.178.76])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 2FFE885DCE
	for <linux-sparse@vger.kernel.org>; Thu, 23 Jul 2009 06:50:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A663005.5090009@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Tue, Jul 21, 2009 at 10:15:49PM +0100, Ramsay Jones wrote:
> Josh Triplett wrote:
> > On Sat, Jul 18, 2009 at 09:41:46PM +0100, Ramsay Jones wrote:
> >> These warnings were issued by gcc v3.4.4, but not by gcc v4.1.2.
> >> So I guess gcc probably found these warnings to be too noisy ...
> > [...]
> >> --- a/parse.c
> >> +++ b/parse.c
> >> @@ -2616,6 +2616,8 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
> >>  			case SYM_ENUM:
> >>  			case SYM_RESTRICT:
> >>  				base_type->ident = ident;
> >> +			default:
> >> +				break;
> >>  			}
> > 
> > I don't think you want to add defaults like this just to avoid warnings.
> > Warnings like that can help when adding a new item to an enum, to find
> > the places where you need to extend the code to hand the new item.  And
> > since current GCC doesn't even issue the warning by default, it seems
> > even more unnecessary to add that default case.
> > 
> 
> OK...
> 
> So, if I understand your argument, in order to make the best use of these
> warnings, then the correct change would look like the diff given below,
> and (for more up-to-date gcc) add -Wswitch-enum to CFLAGS (at least
> occasionally).
[...]
> diff --git a/parse.c b/parse.c
> index e5ad867..afe39c3 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -2616,6 +2616,23 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>  			case SYM_ENUM:
>  			case SYM_RESTRICT:
>  				base_type->ident = ident;
> +				break;
> +			case SYM_UNINITIALIZED:
> +			case SYM_PREPROCESSOR:
> +			case SYM_BASETYPE:
> +			case SYM_NODE:
> +			case SYM_PTR:
> +			case SYM_FN:
> +			case SYM_ARRAY:
> +			case SYM_TYPEDEF:
> +			case SYM_TYPEOF:
> +			case SYM_MEMBER:
> +			case SYM_BITFIELD:
> +			case SYM_LABEL:
> +			case SYM_FOULED:
> +			case SYM_KEYWORD:
> +			case SYM_BAD:
> +				break;

This represents exactly why more recent GCC defaults this warning to
off. ;)

No, I don't think writing the code this way helps.  I think it makes
more sense to leave the warning off and not bother placating older
versions of GCC.

- Josh Triplett
