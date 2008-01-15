From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] saner warnings for restricted types
Date: Tue, 15 Jan 2008 16:04:47 -0500
Message-ID: <1200431087.3457.0.camel@dv>
References: <20080115165236.GS27894@ZenIV.linux.org.uk>
	 <1200418572.17542.2.camel@dv>  <20080115185856.GT27894@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from c60.cesmail.net ([216.154.195.49]:63315 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752693AbYAOVEt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Jan 2008 16:04:49 -0500
In-Reply-To: <20080115185856.GT27894@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-sparse@vger.kernel.org


On Tue, 2008-01-15 at 18:58 +0000, Al Viro wrote:
> On Tue, Jan 15, 2008 at 12:36:12PM -0500, Pavel Roskin wrote:
> > On Tue, 2008-01-15 at 16:52 +0000, Al Viro wrote:
> > >  	if (class & TYPE_RESTRICT) {
> > > -		warning(expr->pos, "restricted degrades to integer");
> > >  		if (class & TYPE_FOULED)
> > >  			*ctype = unfoul(*ctype);
> > > +		warning(expr->pos, "%sdegrades to integer",
> > > +			show_typename(*ctype));
> > 
> > Missing space after "%s"?
> 
> No.  Try it and you'll see...

OK, just wanted to make sure.  Thanks for the explanation!

-- 
Regards,
Pavel Roskin
