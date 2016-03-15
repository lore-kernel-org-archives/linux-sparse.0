From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 13/21] evaluate: recognize members of static compound
 objects as address constants
Date: Tue, 15 Mar 2016 18:46:31 +0100
Message-ID: <20160315174629.GL1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <871t8xi251.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34468 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbcCORqe (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:46:34 -0400
Received: by mail-wm0-f44.google.com with SMTP id p65so155599417wmp.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:46:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <871t8xi251.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:40:42AM +0100, Nicolai Stange wrote:
> According to 6.6(9), the member access operators "." and "->" may be used
> in the creation of address constants.
> 
> Uses of both operators amount to the creation of EXPR_DEREF expressions
> which are eventually fed into evaluate_offset() at evaluation.
> 
> Make evaluate_offset() propagate any address constant flag of the object
> containing the referenced member to the newly created pointer addition
> expression.
> 

Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
