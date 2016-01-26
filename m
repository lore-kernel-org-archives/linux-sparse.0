From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 11/13] evaluate: relax some constant expression rules
 for pointer expressions
Date: Tue, 26 Jan 2016 03:05:20 +0100
Message-ID: <20160126020519.GI46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87io2hem69.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34076 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbcAZCFX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 21:05:23 -0500
Received: by mail-wm0-f66.google.com with SMTP id b14so14693852wmb.1
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 18:05:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87io2hem69.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 04:03:26PM +0100, Nicolai Stange wrote:
> The official constraints on constant expressions [6.6] are insanely
> strict in that they do not allow some constructs commonly used in the
> wild.
> 
> Relax them by treating
> - address constants cast to different pointer type as address constants
>   again,
> - address constants cast to integer type as integer constant
>   expressions
> - conditional expressions whose true and false branches both yield
>   address constants as address constants,
> - and conditional expressions whose condition is an address constant
>   as an constant expression to the extent their true and false branches
>   allow.


> @@ -2783,14 +2792,30 @@ static struct symbol *evaluate_cast(struct expression *expr)
>  		/*
>  		 * Casts of integer literals to pointer type yield
>  		 * address constants [6.6(9)].
> +		 *
> +		 * As an extension, treat address constants cast to a
> +		 * different pointer type as adress constants again.

Typo: s/adress/address/


Good otherwise.

Luc
