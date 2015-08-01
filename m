From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 3/3 V3] Add Wall_off switch to disable errors and warnings
Date: Sat, 1 Aug 2015 14:59:38 +0200
Message-ID: <20150801125938.GA23735@ravnborg.org>
References: <1438216001-8862-4-git-send-email-tcamuso@redhat.com>
 <1438370879-21792-1-git-send-email-tcamuso@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:53152 "EHLO
	asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbbHANGn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 1 Aug 2015 09:06:43 -0400
Content-Disposition: inline
In-Reply-To: <1438370879-21792-1-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tony Camuso <tcamuso@redhat.com>
Cc: josh@joshtriplett.org, linux-sparse@vger.kernel.org, sparse@chrisli.org

> diff --git a/parse.c b/parse.c
> index 02275d8..d70dffb 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -2746,6 +2746,10 @@ struct token *external_declaration(struct token *token, struct symbol_list **lis
>  
>  	/* Just a type declaration? */
>  	if (!ident) {
> +
> +		if (Wall_off)
> +			return token->next;
> +
>  		warning(token->pos, "missing identifier in declaration");
>  		return expect(token, ';', "at the end of type declaration");

This is on the wrong level.
You need to silence sparse in the spare_error function.

Not on the level where you do the expect() - otherwise you would
have to sprinkle "if (Wall_off)" checks everywhere.

This was also a problem in v1 of the patch.

	Sam
