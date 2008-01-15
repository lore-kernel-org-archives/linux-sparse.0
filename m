From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] saner warnings for restricted types
Date: Tue, 15 Jan 2008 18:58:56 +0000
Message-ID: <20080115185856.GT27894@ZenIV.linux.org.uk>
References: <20080115165236.GS27894@ZenIV.linux.org.uk> <1200418572.17542.2.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35758 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbYAOS65 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 15 Jan 2008 13:58:57 -0500
Content-Disposition: inline
In-Reply-To: <1200418572.17542.2.camel@dv>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: linux-sparse@vger.kernel.org

On Tue, Jan 15, 2008 at 12:36:12PM -0500, Pavel Roskin wrote:
> On Tue, 2008-01-15 at 16:52 +0000, Al Viro wrote:
> >  	if (class & TYPE_RESTRICT) {
> > -		warning(expr->pos, "restricted degrades to integer");
> >  		if (class & TYPE_FOULED)
> >  			*ctype = unfoul(*ctype);
> > +		warning(expr->pos, "%sdegrades to integer",
> > +			show_typename(*ctype));
> 
> Missing space after "%s"?

No.  Try it and you'll see...  The way show_typename() (actually, the
stuff behind it) works you get a space after the damn thing.  What you'll
get is something like

kernel/power/main.c:242:2: warning: restricted suspend_state_t degrades to integer

Actually, if you look at the things like

fs/afs/fsclient.c:465:21: warning: incorrect type in assignment (different base types)
fs/afs/fsclient.c:465:21:    expected restricted __be32 [usertype] operation_ID
fs/afs/fsclient.c:465:21:    got int

you'll see that the last line is "fs/afs/fsclient.c:465:21:    got int \n" -
with whitespace in the end.  We could get rid of that, but it'll take more
massage and it's definitely a separate patch series.
