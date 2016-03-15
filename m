From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 03/21] expression: examine constness of casts at
 evaluation only
Date: Tue, 15 Mar 2016 21:43:19 +0100
Message-ID: <20160315204318.GD2417@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <878u35jh4c.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35755 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965874AbcCOUnX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 16:43:23 -0400
Received: by mail-wm0-f45.google.com with SMTP id l68so165515994wml.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 13:43:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <878u35jh4c.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:31:47AM +0100, Nicolai Stange wrote:
> Move the whole calculation of cast expressions' constness flags to the
> evaluation phase such that expressions like
> 
>   (int)__builtin_choose_expr(0, 0, 0)
> 
> can now be recognized as qualifying as integer constant expressions.
> 

Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
