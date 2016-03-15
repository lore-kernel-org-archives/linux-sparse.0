From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v3 18/21] evaluate: relax some constant expression rules
 for pointer expressions
Date: Tue, 15 Mar 2016 20:44:37 +0100
Message-ID: <20160315194436.GQ1283@macpro.local>
References: <87lh75jh9l.fsf@gmail.com>
 <87fuxdgne1.fsf@gmail.com>
 <20160315174748.GO1283@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36281 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965804AbcCOTom (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Mar 2016 15:44:42 -0400
Received: by mail-wm0-f50.google.com with SMTP id l124so23984732wmf.1
        for <linux-sparse@vger.kernel.org>; Tue, 15 Mar 2016 12:44:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160315174748.GO1283@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

On Tue, Mar 15, 2016 at 06:47:49PM +0100, Luc Van Oostenryck wrote:
> On Mon, Feb 01, 2016 at 03:44:38AM +0100, Nicolai Stange wrote:
> > The official constraints on constant expressions [6.6] are insanely
> > strict in that they do not allow some constructs commonly used in the
> > wild.
> > 
> > Relax them by treating
> > - address constants cast to different pointer type as address constants
> >   again,
> > - address constants cast to arithmetic type as arithmetic constant
> >   expressions
> > - conditional expressions whose true and false branches both yield
> >   address constants as address constants,
> > - and conditional expressions whose condition is an address constant
> >   as an constant expression to the extent their true and false branches
> >   allow.
> > 
> 
> Fine for me.
> 
> Feel free to add
>   Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>


Sorry that wasn't for this patch
