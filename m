From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 12/13] expression, evaluate: support compound literals
 as address constants
Date: Tue, 26 Jan 2016 03:07:50 +0100
Message-ID: <20160126020749.GJ46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87egd5em4j.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34977 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbcAZCHx (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 21:07:53 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so14709939wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 18:07:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87egd5em4j.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 04:04:28PM +0100, Nicolai Stange wrote:
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


Good.

Luc 
