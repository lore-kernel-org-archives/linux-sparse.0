From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 21/21] evaluation: treat comparsions between types as
 integer constexpr
Date: Tue, 15 Mar 2016 21:34:29 +0100
Message-ID: <20160315203428.GC2417@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <8737tdgn9n.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38496 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbcCOUec (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 16:34:32 -0400
Received: by mail-wm0-f41.google.com with SMTP id l68so43749064wml.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 13:34:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8737tdgn9n.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:47:16AM +0100, Nicolai Stange wrote:
> The expression parsing code builds an EXPR_COMPARE expression around two
> EXPR_TYPE expressions for __builtin_types_compatible_p().
> 
> The EXPR_TYPE expressions are tagged as being integer constant expressions
> in order to trick the generic comparison evaluation code into flagging the
> result as an integer constant expression again.
> 
> Avoid this trickery by making evaluate_compare() unconditionally tag a
> comparsion between types as an integer constant expression.

Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
