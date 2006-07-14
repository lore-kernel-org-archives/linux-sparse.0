From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC PATCH] Fix -Wtypesign
Date: Thu, 13 Jul 2006 22:36:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607132232310.5623@g5.osdl.org>
References: <1152842178.480.26.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:26323 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161035AbWGNFgm (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 14 Jul 2006 01:36:42 -0400
In-Reply-To: <1152842178.480.26.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org



On Thu, 13 Jul 2006, Pavel Roskin wrote:
>
> Fix -Wtypesign
> 
> Run evaluate_symbol() before check_duplicates() so that the signedness
> of the token is known by the time the token is compared with other
> tokens.
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>
> ---
> 
>  evaluate.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/evaluate.c b/evaluate.c
> index 42005eb..2561f38 100644
> --- a/evaluate.c
> +++ b/evaluate.c
> @@ -2473,8 +2473,8 @@ void evaluate_symbol_list(struct symbol_
>  	struct symbol *sym;
>  
>  	FOR_EACH_PTR(list, sym) {
> -		check_duplicates(sym);
>  		evaluate_symbol(sym);
> +		check_duplicates(sym);


That, on the face of it, looks "Obviously Correct(tm)".

I'm wondering if I had some reason for doing them in what is obviously the 
wrong order, which worries me a bit, but quite frankly, the most likely 
reasons is just that it was a thinko.

(Long long ago, I did "check_duplicates()" from _within_ evaluation, 
which had serious recursion issues, so there's been confusion here 
before).

		Linus
