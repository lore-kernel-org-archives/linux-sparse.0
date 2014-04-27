From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: How to fix: asm output is not an lvalue
Date: Sat, 26 Apr 2014 23:57:34 -0700
Message-ID: <20140427065734.GA19585@thin>
References: <20140426215705.GA20867@ravnborg.org>
 <CA+55aFx0QAPEDBEyb+fDsb+Asb-q_6tb7K=KMLP4o4DxncxSpg@mail.gmail.com>
 <20140427064803.GA31264@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46316 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbaD0G5m (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 27 Apr 2014 02:57:42 -0400
Content-Disposition: inline
In-Reply-To: <20140427064803.GA31264@ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Apr 27, 2014 at 08:48:04AM +0200, Sam Ravnborg wrote:
> On Sat, Apr 26, 2014 at 04:44:13PM -0700, Linus Torvalds wrote:
> > On Sat, Apr 26, 2014 at 2:57 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > Following code snippet generate these warnings:
> > > t.c:9:9: warning: asm output is not an lvalue
> > 
> > Yeah. That code snippet is pure and utter garbage.
> > 
> > Gcc has this totally insane extension that makes casts be lvalues.
> > It's stupid and horrid, and pointless to boot. So apparently gcc
> > accepts that crap.
> > 
> > But it is very much total crap.
> > 
> > Those casts to (USItype) are all pointless to begin with (since the
> > values are of that type already!) and they mean that the expression
> > isn't something you can assign to (lvalue). The fact that gcc accepts
> > code like that is an embarrassment.
> 
> Thanks.
> When I dropped the casts to the output values the warnings were gone.
> 
> Now the code is down to ~30 warnings - looks like this.
> math_32.c:371:17: warning: shift too big (4294967267) for type unsigned long

That one looks like a bug; that's just below 2**32 (4294967296), which
makes no sense as a shift.  Perhaps there's a precedence issue?

> math_32.c:428:21: warning: shift too big (63) for type unsigned long

That one probably needs a ULL somewhere.

> But this code is so full of macros that it is not funny :-(

Yeah, ugh.

- Josh Triplett
