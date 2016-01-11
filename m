From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH RFC 01/13] expression: introduce additional expression
 constness tracking flags
Date: Mon, 11 Jan 2016 18:54:31 +0100
Message-ID: <20160111175430.GC2972@macpro.local>
References: <87r3nzkct3.fsf@gmail.com>
 <20160109170328.GA8655@macpro.local>
 <87a8oewg2c.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33813 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933012AbcAKRyf (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 11 Jan 2016 12:54:35 -0500
Received: by mail-wm0-f65.google.com with SMTP id b14so27418152wmb.1
        for <linux-sparse@vger.kernel.org>; Mon, 11 Jan 2016 09:54:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87a8oewg2c.fsf@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nicolai Stange <nicstange@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Sat, Jan 09, 2016 at 11:20:27PM +0100, Nicolai Stange wrote:
> Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:
> >
> > Shouldn't the following be more explicit?
> > 	flag = expr_set_flag_mask(0, ...);
> > 	flag = expr_set_flag_mask(in_flag, ...);
> > 	flag = expr_clear_flag_mask(in_flag, ...);
> > Yes, I know, it would need to duplicate the expr->flags at almost all calls.
> 
> Admittedly, this looks way better.
> 
> I'll change that to
>   void expr_set_flag(unsigned *flag, ...);
> and likewise for the clearing guy.
> 
> >
> > Couldn't we get rid of those two function by separating the exclusive "bits"
> > from the "sets"?
> > Something like:
> > 	#define	__EXPR_FLAG_INT_CONST	(1 << 0)
> > 	#define	__EXPR_FLAG_FP_CONST	(1 << 1)
> > 	...
> > 	#define	EXPR_FLAG_INT_CONST	(__EXPR_FLAG_INT_CONST |
> > 					 __EXPR_FLAG_INT_CONST_EXPR |
> > 					 __EXPR_FLAG_ARITH_CONST)
> 
> No, this won't work since the "implied" bit masks are in general different for
> setting and clearing a flag.
> 
> For example, "integer constant" (i.e. integer literal) implies "integer
> constant expression", but "not a integer constant" does not imply "not a
> integer constant expression".

Yes, sure, but it could work with one set of such macro to add flags
and another one to clear them.
I think it would be more clear and would avoid the need to have the two
helper above.
Not that it is critical, though.


Yours,
Luc
