From: Al Viro <viro@ftp.linux.org.uk>
Subject: [RFC] <op>= mishandling
Date: Fri, 24 Nov 2006 07:12:47 +0000
Message-ID: <20061124071247.GO3078@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:25041 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1756461AbWKXHMq
	(ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Fri, 24 Nov 2006 02:12:46 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1GnVEt-0003q9-AU
	for linux-sparse@vger.kernel.org; Fri, 24 Nov 2006 07:12:47 +0000
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

commit 5a627ec02342727b151712acc9c752a8e4f12da0
Author: Linus Torvalds <torvalds@ppc970.osdl.org>
Date:   Sat Nov 6 20:10:22 2004 -0700

    Don't do assignment replacement at type evaluation time.


was too optimistic.  Here's a trivial example of the things going
wrong with it:
	int x = 1;
	x /= 0.5;
that /= should be treated as
	int *tmp;
	(tmp = &x, *tmp = (int)((double)*tmp / 0.5);
IOW, we must end up with 2 being assigned to x.  There's no way in hell
for that to be done without conversion to real; current sparse ends up
with
	x /= 0;
which is obviously *not* what we want.

Another ugly example:
	int x = -1;
	int y = -1;
	x /= INT_MAX;
	y /= (unsigned int)INT_MAX;
Results of those assignments are obviously different - one is -1 / INT_MAX
(i.e. 0), another is (int)((unsigned int)-1/(unsigned int)INT_MAX), which
is going to be a small positive (most likely 2).

We lose the distinction (try test-linearize and you'll see it immediately).

AFAICS, the only sane way to deal with that is to bring back the old
logics at least as a fallback.  _Sometimes_ we can get away with the
current approach, but that depends both on types and on operation...

If the second argument gets converted to the type of the first one, we
are fine.  If not...
	* real types are involved => sorry, no.  (float)((long double)x + y)
might differ from x + (float)y and we have no business mangling it, whatever
the operation.  Even when we are mixing real and real.  When we have
integer <op> real, the situation is even worse (see above).
	* *IF* we assume 2's complement for signed integers and nice handling
of overflows, we can get away with it for +, -, *, &, |, ^.  / and % are
not safe (see above).
	* note that even when signedness is the same, we can't assume that
/ and % won't cause us any trouble.  x /= 1L<<32  is equivalent of x = 0,
not x /= 0...
	* when the second argument is not bigger than the first one, which is
smaller than int, we are OK with / and %.  However, I very much doubt that
it's worth the extra logics - that situation is rare as hell.

I'm fixing that crap right now; if somebody has objections against the
above - please, yell.
