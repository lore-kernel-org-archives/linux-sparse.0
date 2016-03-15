From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 08/21] expression, evaluate: add support for tagging
 address constants
Date: Tue, 15 Mar 2016 18:15:01 +0100
Message-ID: <20160315171500.GG1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87mvrli2cd.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34830 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934767AbcCORPE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:15:04 -0400
Received: by mail-wm0-f49.google.com with SMTP id l68so159307354wml.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:15:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87mvrli2cd.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:36:18AM +0100, Nicolai Stange wrote:
> Address constants [6.6(9)] constitute one of the types of constant
> expressions allowed in initializers [6.6(7)] for static storage
> duration objects [6.7.8(4)].
> 
> Introduce a new flag CONSTEXPR_ADDR_CONSTANT for tagging expressions
> which qualify as being an address constant.
> 
> Make sure not to carry over the address constant attribute from
> subexpressions for operators that never yield address constants, i.e.
> most arithmetic ones, logical ones etc.
> 

Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
