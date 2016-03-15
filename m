From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 19/21] expression, evaluate: support compound literals
 as address constants
Date: Tue, 15 Mar 2016 21:02:53 +0100
Message-ID: <20160315200252.GA2417@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87bn81gnco.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38064 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754412AbcCOUC5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 16:02:57 -0400
Received: by mail-wm0-f49.google.com with SMTP id l68so42684787wml.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 13:02:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87bn81gnco.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:45:27AM +0100, Nicolai Stange wrote:
> Toplevel compound literals have got static storage duration
> [6.5.2.5(6)].
> 
> This implies that
> 1. their addresses are address constants [6.6(9)] and
> 2. their initializers must contain constant expressions only
>    [6.5.2.5(3), 6.7.8(4)] .
> 
> Flag the anonymous symbol created at expression parsing time as having
> static storage duration if the compound literal occurs at top level
> scope.
> 
> Flag the whole expression as being an address constant at evaluation
> time if its corresponding anonymous symbol had been previously marked
> as having static storage duration.
> 

...

> diff --git a/validation/constexpr-compound-literal.c b/validation/constexpr-compound-literal.c
> --- /dev/null
> +++ b/validation/constexpr-compound-literal.c
> @@ -0,0 +1,19 @@
> +static int *a = &(int){ 1 };	// OK
> +static int *b = &(int){ *a };	// KO
> +
> +static void foo(void)
> +{
> +	int *b = &(int){ 1 };		// OK
> +	int *c = &(int){ *a };		// OK
> +	static int *d = &(int){ 1 };	// KO

Humm ... why is this last one different than the corresponding 
top level one @ line 1?

