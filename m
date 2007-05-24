From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: fun with ?:
Date: Thu, 24 May 2007 01:02:40 +0100
Message-ID: <20070524000240.GC4095@ftp.linux.org.uk>
References: <20070519025249.GZ4095@ftp.linux.org.uk> <4653633B.3000000@freedesktop.org> <20070522224619.GI4095@ftp.linux.org.uk> <46537BC1.9000808@freedesktop.org> <20070523000234.GJ4095@ftp.linux.org.uk> <20070523142544.GB2547@daikokuya.co.uk> <20070523143202.GY4095@ftp.linux.org.uk> <4654AF12.9040101@knosof.co.uk> <alpine.LFD.0.98.0705231456330.3890@woody.linux-foundation.org> <4654CE67.9070106@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:59404 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014AbXEXACo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 23 May 2007 20:02:44 -0400
Content-Disposition: inline
In-Reply-To: <4654CE67.9070106@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Neil Booth <neil@daikokuya.co.uk>, Josh Triplett <josh@freedesktop.org>, linux-sparse@vger.kernel.org

On Thu, May 24, 2007 at 12:29:43AM +0100, Derek M Jones wrote:

> It was intended as a probabilit statement (ok, I did not make that
> clear).  An expression containing n+n is more likely to overflow
> than one containing n-n.

Gimme a break.
	a) s/int/unsigned and run that through gcc; no change in behaviour
	b) no fscking way in hell *either* is acceptable for bitfield
width - definitely not with -std=c99 -pedantic.  Violates 6.6p6 and 6.7.2.1p3.
	c) what's happening is pretty obvious - the difference is not in
overflows, it's in expression tree structure (remember, + and - are
left-to-right).  gcc throws several cheap optimizations at the expression
and checks if it has come up with a constant.  Simple common factors are taken
out (n*m - n*m is seen as 0), common subexpressions are not recognized
((n+m)-(n+m) is not seen as constant).
	d) (c) is an exercise in software proctology - gcc has an obvious
bug in that area (mishandling recognition of integer constant expressions),
period.
