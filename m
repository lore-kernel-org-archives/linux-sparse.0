From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 04/13] expression: examine constness of preops at
 evaluation only
Date: Tue, 26 Jan 2016 02:10:18 +0100
Message-ID: <20160126011017.GB46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87d1spg171.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35799 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932404AbcAZBKX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 20:10:23 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so14535232wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 17:10:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87d1spg171.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 03:53:38PM +0100, Nicolai Stange wrote:
> Currently, the propagation of expressions' constness flags through
> prefix expressions is done in two steps:
> - Several flags are speculatively set at expression parsing time
> - and possibly cleared again at evaluation time.
> 
> Set aside this unfortunate split of code, the early propagation of
> constness flags is not able to recognize constant expressions such as
>   -__builtin_choose_expr(0, 0, 0)
>   ~__builtin_choose_expr(0, 0, 0)
>   !__builtin_choose_expr(0, 0, 0)
> since the final expression to be thrown into the prefix expression is
> known only after evaluation.
> 
> Move the whole calculation of prefix expressions' constness flags to
> the evaluation phase.
> 
> Introduce support for tracking arithmetic constness propagation through
> prefix expressions.

What about replacing the whole description with something::
	Move the whole calculation of prefix expressions' constness flags to
	the evaluation phase so that we can now recognize constant expressions
	such as
	      -__builtin_choose_expr(0, 0, 0)
	      ~__builtin_choose_expr(0, 0, 0)
	      !__builtin_choose_expr(0, 0, 0)

	and adding further explanation after this, if really needed?


Luc
