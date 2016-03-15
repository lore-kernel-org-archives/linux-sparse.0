From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 05/21] expression: examine constness of preops at
 evaluation only
Date: Tue, 15 Mar 2016 18:09:22 +0100
Message-ID: <20160315170921.GD1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87zivli2gt.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33868 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933150AbcCORJZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 13:09:25 -0400
Received: by mail-wm0-f43.google.com with SMTP id p65so154167953wmp.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 10:09:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87zivli2gt.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Mon, Feb 01, 2016 at 03:33:38AM +0100, Nicolai Stange wrote:
> Move the whole calculation of prefix expressions' constness flags to
> the evaluation phase such that expressions like
> 
>   -__builtin_choose_expr(0, 0, 0)
>   ~__builtin_choose_expr(0, 0, 0)
>   !__builtin_choose_expr(0, 0, 0)
> 
> can now be recognized as qualifying as integer constant expressions.


Fien for me.

Feel free to add
  Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
