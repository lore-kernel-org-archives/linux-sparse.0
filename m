From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 12/21] evaluate: recognize address constants created
 through pointer arithmetic
Date: Tue, 15 Mar 2016 18:46:00 +0100
Message-ID: <20160315174559.GK1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <8760y9i269.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36634 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbcCORqD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:46:03 -0400
Received: by mail-wm0-f50.google.com with SMTP id l124so20407047wmf.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:46:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8760y9i269.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:39:58AM +0100, Nicolai Stange wrote:
> An address constant +/- an integer constant expression qualifies as an
> address constant again.
> Furthermore, the array-subscript operator "[]" may be used in the creation
> of address constant.
> 
> Handle both cases by making evaluate_ptr_add() check whether an integer
> constant expression is added to an address constant and tag the result as
> being an address constant again if so.
> 

Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
