From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 04/21] expression: examine constness of binops and
 alike at evaluation only
Date: Tue, 15 Mar 2016 18:06:37 +0100
Message-ID: <20160315170636.GC1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <874mdtjh33.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37776 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934426AbcCORGl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:06:41 -0400
Received: by mail-wm0-f50.google.com with SMTP id p65so36229219wmp.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:06:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <874mdtjh33.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:32:32AM +0100, Nicolai Stange wrote:
> Move the whole calculation of binary operations', compare and logical
> expressions' constness flags to the evaluation phase such that expressions
> like
> 
>   0 + __builtin_choose_expr(0, 0, 0)
>   0 < __builtin_choose_expr(0, 0, 0)
>   0 && __builtin_choose_expr(0, 0, 0)
> 
> can now be recognized as qualifying as integer constant expressions.
> 

Shouldn't it be better to already include the '~' into the definition of
CONSTEXPR_FLAG_DECAY_CONSTS_MASK?

Otherwise it's fine for me.
Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
