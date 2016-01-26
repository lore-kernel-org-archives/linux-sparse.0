From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 10/13] symbol: flag builtins constant_p, safe_p and
 warning as constexprs
Date: Tue, 26 Jan 2016 03:00:11 +0100
Message-ID: <20160126020010.GH46188@macpro.local>
References: <87twm1g1go.fsf@gmail.com>
 <87mvrtem8h.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34890 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbcAZCAO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Jan 2016 21:00:14 -0500
Received: by mail-wm0-f65.google.com with SMTP id 123so14686309wmz.2
        for <linux-sparse@vger.kernel.org>; Mon, 25 Jan 2016 18:00:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87mvrtem8h.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Jan 25, 2016 at 04:02:06PM +0100, Nicolai Stange wrote:
> Unconditionally flag the expressions
>   __builtin_constant_p(),
>   __builtin_safe_p(),
>   __builtin_warning()
> as being integer constant expressions.


Good! 

Luc
