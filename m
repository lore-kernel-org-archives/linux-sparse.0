From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 17/21] symbol: flag builtins constant_p, safe_p and
 warning as constexprs
Date: Tue, 15 Mar 2016 20:45:22 +0100
Message-ID: <20160315194521.GR1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87k2mpgnfa.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37870 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbcCOTpZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 15:45:25 -0400
Received: by mail-wm0-f50.google.com with SMTP id p65so42117536wmp.0
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 12:45:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87k2mpgnfa.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:43:53AM +0100, Nicolai Stange wrote:
> Unconditionally flag the expressions
>   __builtin_constant_p(),
>   __builtin_safe_p(),
>   __builtin_warning()
> as being integer constant expressions.
> 

Fine for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
