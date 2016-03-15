From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 06/21] expression: examine constness of conditionals
 at evaluation only
Date: Tue, 15 Mar 2016 18:11:37 +0100
Message-ID: <20160315171136.GE1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87vb69i2f9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:32807 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932351AbcCORLk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:11:40 -0400
Received: by mail-wm0-f49.google.com with SMTP id l68so154565233wml.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:11:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87vb69i2f9.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:34:34AM +0100, Nicolai Stange wrote:
> Move the whole calculation of conditional expressions' constness flags
> to the evaluation phase such that expressions like
> 
>   0 ? __builtin_choose_expr(0, 0, 0) : 0
>   0 ? 0 : __builtin_choose_expr(0, 0, 0)
> 
> can now be recognized as qualifying as integer constant expressions.
> 

Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
