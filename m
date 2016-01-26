From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 05/13] expression: examine constness of conditionals
 at evaluation only
Date: Tue, 26 Jan 2016 02:16:30 +0100
Message-ID: <20160126011629.GC46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <878u3dg14i.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33059 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932318AbcAZBQd (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 20:16:33 -0500
Received: by mail-wm0-f67.google.com with SMTP id u188so14541532wmu.0
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 17:16:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <878u3dg14i.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 03:55:09PM +0100, Nicolai Stange wrote:
> Currently, the propagation of expressions' constness flags through
> conditional expressions is done in two steps:
> - Several flags are speculatively set at expression parsing time
> - and possibly cleared again at evaluation time.
> 
> Set aside this unfortunate split of code, the early propagation of
> constness flags is not able to recognize constant expressions such as
>   0 ? __builtin_choose_expr(0, 0, 0) : 0
>   0 ? 0 : __builtin_choose_expr(0, 0, 0)
> since the final expression to be thrown into the conditional
> expression is known only after evaluation.
> 
> Move the whole calculation of conditional expressions' constness flags
> to the evaluation phase.
> 
> Introduce support for tracking arithmetic constness propagation through
> conditional expressions.

Same comments about the description as for the previous patches.

Good otherwise.


Luc
