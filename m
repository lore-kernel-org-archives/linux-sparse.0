From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: How to fix: asm output is not an lvalue
Date: Sun, 27 Apr 2014 10:41:29 +0200
Message-ID: <20140427084129.GA10056@ravnborg.org>
References: <20140426215705.GA20867@ravnborg.org>
 <CA+55aFx0QAPEDBEyb+fDsb+Asb-q_6tb7K=KMLP4o4DxncxSpg@mail.gmail.com>
 <20140427064803.GA31264@ravnborg.org>
 <20140427065734.GA19585@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from asavdk3.altibox.net ([109.247.116.14]:34621 "EHLO
	asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753157AbaD0Ilp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 27 Apr 2014 04:41:45 -0400
Content-Disposition: inline
In-Reply-To: <20140427065734.GA19585@thin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Apr 26, 2014 at 11:57:34PM -0700, Josh Triplett wrote:
> On Sun, Apr 27, 2014 at 08:48:04AM +0200, Sam Ravnborg wrote:
> > On Sat, Apr 26, 2014 at 04:44:13PM -0700, Linus Torvalds wrote:
> > > On Sat, Apr 26, 2014 at 2:57 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> > > >
> > > > Following code snippet generate these warnings:
> > > > t.c:9:9: warning: asm output is not an lvalue
> > > 
> > > Yeah. That code snippet is pure and utter garbage.
> > > 
> > > Gcc has this totally insane extension that makes casts be lvalues.
> > > It's stupid and horrid, and pointless to boot. So apparently gcc
> > > accepts that crap.
> > > 
> > > But it is very much total crap.
> > > 
> > > Those casts to (USItype) are all pointless to begin with (since the
> > > values are of that type already!) and they mean that the expression
> > > isn't something you can assign to (lvalue). The fact that gcc accepts
> > > code like that is an embarrassment.
> > 
> > Thanks.
> > When I dropped the casts to the output values the warnings were gone.
> > 
> > Now the code is down to ~30 warnings - looks like this.
> > math_32.c:371:17: warning: shift too big (4294967267) for type unsigned long
> 
> That one looks like a bug; that's just below 2**32 (4294967296), which
> makes no sense as a shift.  Perhaps there's a precedence issue?

Deep down in some macro expansion I found the following:

$ cat t.c
void foo(void);
int x;
int y;

static void todo(void)
{

        if (3 < 32)
                foo();
        else
                x = y << (3 - 32);
}


This produces the same warning.
But the if expression is always true so the else part could be ignored.

This is line 52 in include/math/op-2.h in the kernel if someone
wants to take a look...
I have no test-suite for the softfloat stuff, so I am not going to touch this code...

	Sam
