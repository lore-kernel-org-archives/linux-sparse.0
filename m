From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 07/21] expression: add support for tagging arithmetic
 constant expressions
Date: Tue, 15 Mar 2016 18:13:00 +0100
Message-ID: <20160315171259.GF1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87r3gxi2ds.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33038 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965132AbcCORNp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:13:45 -0400
Received: by mail-wm0-f46.google.com with SMTP id l68so154645139wml.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:13:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87r3gxi2ds.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:35:27AM +0100, Nicolai Stange wrote:
> Arithmetic constant expressions may be either of (6.6(8)):
> - integer constant expressions
> - floating point constants
> or any arithmetic expression build up from them.
> Furthermore, casts with arithmetic destination types preserve arithmetic
> constness.
> 
> Arithmetic constant expressions may be used as initializers for objects of
> static storage duration.
> 
> Introduce a new constexpr_flag CONSTEXPR_FLAG_ARITH_CONST_EXPR.
> 
> Modify CONSTEXPR_FLAG_INT_CONST_EXPR_SET_MASK and
> CONSTEXPR_FLAG_FP_CONST_SET_MASK to also include that new bit.
> Thus, whenever an integer constant expression or a floating point constant
> is recognized, it is automatically tagged as an arithmetic constant
> expression.
> 
> Note that everything has already been set up such that the new
> CONSTEXPR_FLAG_ARITH_CONST_EXPR flag propagates nicely from subexpressions
> to parent expressions at evaluation.
> 

Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
